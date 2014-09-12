      * This sample program reads the results of the WORKDAYS stored
      * procedure and prints them to a program-described print file.
      * 
      *                                  Scott Klement, May 11, 2006
      *
      *  To Compile:
      *     CRTBNDRPG READDAYS SRCFILE(xxx/QRPGLESRC) DBGVIEW(*LIST)
      *
      * 
     H DFTACTGRP(*NO)

     FQSYSPRT   O    F  132        PRINTER

      /copy SQLCLI_H

     D env             s                   like(SQLHENV)
     D conn            s                   like(SQLHDBC)
     D stmt            s                   like(SQLHSTMT)

     D date            s             10A
     D name            s              9A   varying

      /free
           SQLAllocEnv(env);
           SQLAllocConnect(env: conn);

           SQLSetConnectAttrI( conn
                             : SQL_ATTR_DBC_SYS_NAMING
                             : SQL_TRUE
                             : %size(SQLINTEGER) );

           SQLConnect( conn
                     : '*LOCAL'
                     : SQL_NTS
                     : *NULL
                     : SQL_NTS
                     : *NULL
                     : SQL_NTS );

           SQLAllocStmt( conn : stmt );

           SQLExecDirect( stmt
                        : 'CALL MYLIB/WORKDAYS'
                        : SQL_NTS );

           SQLBindCol( stmt
                     : 1
                     : SQL_CHAR
                     : %addr(Date)
                     : %size(Date)
                     : *omit );

           SQLBindCol( stmt
                     : 2
                     : SQL_VARCHAR
                     : %addr(Name)
                     : %size(Name)-2
                     : *omit );

          dow SQLFetch( stmt ) = SQL_SUCCESS;
             except;
          enddo;

          SQLFreeStmt( stmt : SQL_DROP );
          SQLDisconnect( conn );
          SQLFreeConnect( conn );
          SQLFreeEnv( env );

          *inlr = *on;
      /end-free

     OQSYSPRT   E
     O                       Date                10
     O                       Name                20
