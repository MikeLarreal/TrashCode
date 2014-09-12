// Java program to read the result set from the WORKDAYS stored
// procedure and print it to standard output.
//                                    Scott Klement, May 11, 2006
//
//  To compile (from the iSeries, use QShell, from other platforms,
//              use a command prompt)
//      javac weeklist.java
//
//  To run:
//      java weeklist klemscot bigboy
//
//  (replace klemscot with your userid, and bigboy with your password)
//       

import java.sql.*;

public class weeklist
{

    public static void main (String[] parameters)
    {
        Connection connection   = null;
 
        if (parameters.length != 2) {
            System.out.println("ERROR: must pass UserId and Password");
            return;
        }

        String userid = parameters[0];
        String passwd = parameters[1];

        String url = "jdbc:as400://as400.example.com;naming=system";

        try {
            DriverManager.registerDriver(
               new com.ibm.as400.access.AS400JDBCDriver());

            connection = DriverManager.getConnection(url, userid, passwd);
            Statement stmt = connection.createStatement ();
            ResultSet rs = stmt.executeQuery ("CALL MYLIB/WORKDAYS");

            while (rs.next ()) {
                String weekDate = rs.getString(1);
                String dayName  = rs.getString(2);
                System.out.println (weekDate + " " + dayName);
            }
        }

        catch (Exception e) {
            System.out.println ();
            System.out.println ("ERROR: " + e.getMessage());
        }

        finally {
            try {
                if (connection != null)
                    connection.close ();
            }
            catch (SQLException e) {
                // Error is ignored.
            }
        }

        System.exit (0);
    }
}
