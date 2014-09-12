It eventually happens to every developer. You write a stored procedure to return one or more sophisticated result sets to a Java or .NET client. Everyone is (temporarily) happy. Eventually, a need arises for an RPG or COBOL program to execute this stored procedure and process the result set(s). But, alas, high level language programs have no way to open and process a result set (except when using the cumbersome CLI API).
Phooey, that means we'll need to duplicate the stored procedure code in an RPG friendly manner! But wait, here comes DB2 for i 7.1 to the long-anticipated rescue! There are new SQL language features that allow this amazing feat to be done.
Let's get right to the heart of the matter. How does one process stored procedure result sets from an embedded SQL program? Consider the following simple stored procedure that returns two result sets (a product list and a customer list):

CREATE OR REPLACE PROCEDURE sp_Lists
LANGUAGE SQL
RESULT SETS 2
BEGIN

 DECLARE ProductList CURSOR FOR
  SELECT ProductId,Name || 
         '('||ProductNumber||')' AS Description
    FROM Product
ORDER BY Name
FOR READ ONLY;

 DECLARE CustomerList CURSOR FOR
  SELECT C.CustomerId,S.Name
    FROM Customer C
    JOIN Store S ON S.CustomerId=C.CustomerId 
   WHERE C.CustomerType='S'
FOR READ ONLY;

OPEN ProductList;

OPEN CustomerList;

END;

And here's an RPG program that will execute the procedure, open the result sets as cursors, and block fetch the first 500 rows from each cursor into data structure arrays:

 // Section A
 // SQL Pre-compiler will convert these definitions to 20I 0
DrsProducts       S                   SQLTYPE(RESULT_SET_LOCATOR)
DrsCustomers      S                   SQLTYPE(RESULT_SET_LOCATOR)

  // These data structures are used for block fetching data from cursors
DdsProducts       DS                  Qualified Dim(500)
D  ProductId                    10I 0
D  ProductName                  50    Varying

DdsCustomers      DS                  Qualified Dim(500)
D  CustomerId                   10I 0
D  CustomerName                 50    Varying

  /Free
     // Section B
    // Invoke procedure that has two result sets
    Exec SQL
        CALL sp_Lists;

     // Section C
    // Associate a "locator" variable with each result set from the
    // procedure.  A locator variable is like a pointer that keeps
    // an RPG reference to the actual result sets.
    //
    // NOTES:
    // Procedure name can be a variable
    // A SPECIFIC PROCEDURE name can be coded as well
    Exec SQL
        ASSOCIATE RESULT SET LOCATORS
        (:rsProducts, :rsCustomers) 
        WITH PROCEDURE sp_Lists;

    // Create cursors from result sets
    Exec SQL
        ALLOCATE Products CURSOR
        FOR RESULT SET :rsProducts;
    Exec SQL
        ALLOCATE Customers CURSOR
        FOR RESULT SET :rsCustomers;

     // Section D
    // Read from cursor using block fetch
    // (Cursor doesn't need to be explicitly opened)
    Exec SQL
        FETCH Products FOR 500 ROWS INTO :dsProducts;
    Exec SQL
        CLOSE Products;
    // Repeat for 2nd result set
    Exec SQL
        FETCH Customers FOR 500 ROWS INTO :dsCustomers;
    Exec SQL
        CLOSE Customers;

    *InLR=*On;
    Return;
 /End-Free
 
I have four special sections highlighted in the program that detail specifics:
Section A--Declare variables as special RESULT SET LOCATORS.
Each result set that needs to be processed within an RPG program must have a specific "handle" or "pointer" defined in order to maintain a reference to the cursor that is under the control of the database engine. The SQLTYPE keyword is only valid in embedded SQL programs and is used to define a variable as a specified SQL type. (This keyword is used in cases where RPG has no direct data type equivalent to an SQL data type.) RESULT_SET_LOCATOR is a special DB2 data type specifically used for the special case of referencing a result set as a cursor in a HLL program.
Section B--This recognizable code simply invokes the stored procedure.
Section C--This code marries the stored procedure and HLL worlds together. The ASSOCIATE RESULT SET LOCATORS statement is called to give RPG the "handles" or "references" to the result sets that the stored procedure is expected to return. Notice the variables specified here match those defined in Section A.
Next, the ALLOCATE CURSOR statement is used as a quasi-cursor declaration statement. This statement uses the newly retrieved result set "locator" variable to make a result set available as a local cursor. This statement is executed twice--once for each result set left open by the stored procedure.
Section D--Process and close the cursors.
Once the result sets have been "allocated" as cursors, they can be used like a normal cursor within the program. When ALLOCATE CURSOR is used, an explicit OPEN cursor statement is not required (because technically the stored procedure itself opens the cursor). So at this point, the program continues on with fetching the data. In this case, instead of looping through the rows I just dumped the first 500 rows into a data structure array using a block fetch.
Notice that there are no options such as SCROLL and SENSITIVE specified on the ALLOCATE CURSOR statement. This is because ALLOCATE CURSOR simply accepts how the cursor is defined in the stored procedure. If a stored procedure opens a cursor that is scrollable and updateable, the RPG program can scroll through and update the cursor (once it has been allocated).
And of course you'll want to add appropriate error handling code to your RPG program.
The ASSOCIATE LOCATORS and ALLOCATE CURSOR statements are only allowed in embedded SQL programs. Unfortunately, they cannot be used in an SQL routine that utilizes the SQL programming language (which would've come in handy). I have not seen a need to use the FREE LOCATOR statement (used for cleaning up LOB locator references) to free the RESULT_SET_LOCATOR data types. Once the cursor has been closed the resources should be released by the database engine.
A great new feature in DB2 for i 7.1, the ability to do row based processing on a stored procedure result set, allows HLL embedded SQL programs to take advantage of a powerful and oft-used stored procedure feature.