D RS_LOC1         S                   SQLTYPE(RESULT_SET_LOCATOR)     
D RS_array        DS                  Qualified dim(500)              
D  Pr_name                       3A   inz                             
D  Pr_staff                      8  2 inz                             
                                                                      
 /free                                                                
  EXEC SQL CALL dbepgmr16.Getprojs('D21');                            
  EXEC SQL ASSOCIATE RESULT SET                                       
        LOCATORS (:RS_Loc1) WITH                                      
        PROCEDURE dbepgmr16.Getprojs;                                 
  EXEC SQL ALLOCATE C1 CURSOR FOR RESULT SET :RS_Loc1;                
  EXEC SQL FETCH NEXT FROM C1 FOR 6                                   
       ROWS INTO:RS_Array;                                            
  dsply %char(sqlcod);                                                
  dsply SQLSTT;                                                       
  EXEC SQL CLOSE C1;                                                  
    *INLR = *ON;
 /End-free   

CREATE PROCEDURE DBEPGMR16.GETPROJS ( 
  IN IDEP CHAR(3) ) 
  DYNAMIC RESULT SETS 1 
  LANGUAGE SQL 
  SPECIFIC DBEPGMR16.GETPROJS 
  NOT DETERMINISTIC 
  MODIFIES SQL DATA 
  CALLED ON NULL INPUT 
  SET OPTION  ALWBLK = *ALLREAD , 
  ALWCPYDTA = *OPTIMIZE , 
  COMMIT = *NONE , 
  DECRESULT = (31, 31, 00) , 
  DFTRDBCOL = DBEPGMR16 , 
  DYNDFTCOL = *NO , 
  DYNUSRPRF = *USER , 
  SRTSEQ = *HEX   
  BEGIN 
DECLARE CURSOR1 CURSOR WITH RETURN 
FOR SELECT PROJNAME , PRSTAFF 
FROM PROJECT 
WHERE DEPTNO = IDEP 
ORDER BY PROJNAME ; 
OPEN CURSOR1 ; 
END  ; 
  
GRANT ALTER , EXECUTE    