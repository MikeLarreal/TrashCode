      *  SQLCLI_H -- Header file including the prototypes and definitions
      *      used when calling the SQL CLI APIs.
      *
      *   This does not need to be compiled, it should be included in your
      *   programs by coding the /COPY directive.
      *
      /if defined(SQLCLI_H_DEFINED)
      /eof
      /endif
      /define SQLCLI_H_DEFINED

      *
      * General purpose constants
      *
     D SQL_FALSE       C                   0
     D SQL_TRUE        C                   1
     D SQL_NTS         C                   -3
     D SQL_SQLSTATE_SIZE...
     D                 C                   5
     D SQL_MAX_MESSAGE_LENGTH...
     D                 C                   512
     D SQL_MAX_OPTION_STRING_LENGTH...
     D                 C                   128

      *
      * Templates for SQL data types
      *
     D SQLSMALLINT     s              5I 0 based(Template)
     D SQLUSMALLINT    s              5U 0 based(Template)
     D SQLUINTEGER     s             10U 0 based(Template)
     D SQLDOUBLE       s              8F   based(Template)
     D SQLREAL         s              4F   based(Template)
     D SQLINTEGER      s             10I 0 based(Template)
     D SQLHENV         s             10I 0 based(Template)
     D SQLHDBC         s             10I 0 based(Template)
     D SQLHSTMT        s             10I 0 based(Template)
     D SQLHDESC        s             10I 0 based(Template)
     D SQLHANDLE       s             10I 0 based(Template)
     D SQLRETURN       s                   like(SQLINTEGER) based(Template)
     D SFLOAT          s              4F   based(Template)
     D SQLPOINTER      s               *   based(Template)
     D SQLHWND         s               *   based(Template)

      *
      * null values
      *
     D SQL_NULL_HENV   C                   0
     D SQL_NULL_HDBC   C                   0
     D SQL_NULL_HSTMT  C                   0

      *
      * data types for SQLGetCol() and friends
      *
     D SQL_CHAR        C                   1
     D SQL_NUMERIC     C                   2
     D SQL_DECIMAL     C                   3
     D SQL_INTEGER     C                   4
     D SQL_SMALLINT    C                   5
     D SQL_FLOAT       C                   6
     D SQL_REAL        C                   7
     D SQL_DOUBLE      C                   8
     D SQL_DATETIME    C                   9
     D SQL_VARCHAR     C                   12
     D SQL_BLOB        C                   13
     D SQL_CLOB        C                   14
     D SQL_DBCLOB      C                   15
     D SQL_DATALINK    C                   16
     D SQL_WCHAR       C                   17
     D SQL_WUARCHAR    C                   18
     D SQL_BIGINT      C                   19
     D SQL_BLOB_LOCATOR...
     D                 C                   20
     D SQL_CLOB_LOCATOR...
     D                 C                   21
     D SQL_DBCLOB_LOCATOR...
     D                 C                   22
     D SQL_UTF8_CHAR...
     D                 C                   23
     D SQL_GRAPHIC     C                   95
     D SQL_VARGRAPHIC  C                   96
     D SQL_BINARY      C                   97
     D SQL_VARBINARY   C                   98
     D SQL_DATE        C                   91
     D SQL_TYPE_DATE   C                   91
     D SQL_TIME        C                   92
     D SQL_TYPE_TIME   C                   92
     D SQL_TIMESTAMP   C                   93
     D SQL_TYPE_TIMESTAMP...
     D                 C                   93
     D SQL_ALL_TYPES   C                   0
     D SQL_DEFAULT     C                   99
     D SQL_ARD_TYPE    C                   -99

      *
      * return values
      *
     D SQL_SUCCESS     c                   0
     D SQL_SUCCESS_WITH_INFO...
     D                 c                   1
     D SQL_NO_DATA_FOUND...
     D                 c                   100
     D SQL_NEED_DATA...
     D                 c                   99
     D SQL_NO_DATA...
     D                 c                   100
     D SQL_ERROR       c                   -1
     D SQL_INVALID_HANDLE...
     D                 c                   -2
     D SQL_STILL_EXECUTING...
     D                 c                   2

      *
      * values for SQLFreeStmt
      *
     D SQL_CLOSE       c                   0
     D SQL_DROP        c                   1
     D SQL_UNBIND      c                   2
     D SQL_RESET_PARAMS...
     D                 c                   3

      *
      * Connection attributes
      *
     D SQL_ATTR_AUTOCOMMIT...
     D                 c                   10003
     D SQL_ATTR_COMMIT...
     D                 c                   0
     D SQL_ATTR_DATE_FMT...
     D                 c                   10020
     D SQL_ATTR_DATE_SEP...
     D                 c                   10021
     D SQL_ATTR_DBC_DEFAULT_LIB...
     D                 c                   10005
     D SQL_ATTR_DBC_SYS_NAMING...

     D                 c                   10004
     D SQL_ATTR_DECIMAL_SEP...
     D                 c                   10024
     D SQL_ATTR_EXTENDED_COL_INFO...
     D                 c                   10019
     D SQL_ATTR_TIME_FMT...
     D                 c                   10022
     D SQL_ATTR_TIME_SEP...
     D                 c                   10023
     D SQL_SAVEPOINT_NAME...
     D                 c                   10028
     D SQL_2ND_LEVEL_TEXT...
     D                 c                   10027

      *
      * SQL_ATTR_COMMIT values:
      *
     D SQL_TXN_NO_COMMIT...
     D                 c                   1
     D SQL_TXN_READ_UNCOMMITTED...
     D                 c                   2
     D SQL_TXN_READ_COMMITTED...
     D                 c                   3
     D SQL_TXN_REPEATABLE_READ...
     D                 c                   4
     D SQL_TXN_SERIALIZABLE...
     D                 c                   5

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocEnv(): Allocate an environment for SQL and return
      *                an environment handle
      *
      *        phenv = (output) environment handle
      *
      * Returns SQL_SUCCESS or SQL_ERROR
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocEnv     PR                  ExtProc('SQLAllocEnv')
     D                                     like(SQLRETURN)
     D   phenv                             like(SQLHENV)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocConnect(): Allocate a connection handle
      *
      *     henv = (input) environment to allocate in
      *    phdbc = (output) new connection handle
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SqlAllocConnect...
     D                 PR                  ExtProc('SQLAllocConnect')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   phdbc                             like(SQLHDBC)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLAllocStmt(): Allocate a new SQL statement handle
      *
      *    hdbc = (input) handle to database connection
      *  phstmt = (output) new statement handle
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLAllocStmt    PR                  ExtProc('SQLAllocStmt')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    phstmt                           like(SQLHSTMT)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLBindCol(): Bind column to application variable
      *
      *      hstmt = (input) statement handle
      *       icol = (input) column number to bind
      *     fCType = (input) application data type for column
      *   rgbValue = (output) pointer to variable where data is placed
      * cbValueMax = (input) max size of variable (in bytes or DBCS chars))
      *   pcbValue = (output) number of bytes returned
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindCol      PR                  ExtProc('SQLBindCol')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    icol                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    cbValueMax                       like(SQLINTEGER) value
     D    pcbValue                         like(SQLINTEGER) options(*omit)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetParam(): Set Parameter
      *
      *      hstmt = (input) statement handle
      *       ipar = (input) parameter marker number to bind
      *     fCType = (input) application data type for column
      *   fSqlType = (input) SQL data type for column
      *   fSqlType = (input) SQL data type for column
      * cbParamDef = (input) precision of corresponding param marker
      *    ibScale = (input) scale of parm marker (decimal places)
      *   rgbValue = (i/o)   pointer to variable for data
      *                        or SQL_NULL_DATA if no data.
      *   pcbValue = (input) length of data, or SQL_NTS, or zero
      *                        or *OMIT if no data
      *
      * Returns SQL_SUCCESS, SQL_ERROR or SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLBindParam    PR                  ExtProc('SQLBindParam')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    ipar                             like(SQLSMALLINT) value
     D    fCType                           like(SQLSMALLINT) value
     D    fSqlType                         like(SQLSMALLINT) value
     D    cbParamDef                       like(SQLINTEGER) value
     D    ibScale                          like(SQLSMALLINT) value
     D    rgbValue                         like(SQLPOINTER) value
     D    pcbValue                         like(SQLINTEGER) const
     d                                     options(*omit)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLConnect(): Connect to a data source
      *
      *       hdbc = (input) connection handle
      *      szDSN = (input) Data source name to connect to
      *      cbDSN = (input) length of szDSN parameter
      *      szUID = (input) Autorization name (UserID)
      *      cbUID = (input) Length of szUID parameter
      *  szAuthStr = (input) Autorization name (UserID)
      *  cbAuthStr = (input) Length of szUID parameter
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLConnect      PR                  Extproc('SQLConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    szDSN                        *   value options(*string)
     D    cbDSN                            like(SQLSMALLINT) value
     D    szUID                        *   value options(*string)
     D    cbUID                            like(SQLSMALLINT) value
     D    szAuthStr                    *   value options(*string)
     D    cbAuthStr                        like(SQLSMALLINT) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLDisconnect(): Disconnect from a data source
      *
      *  hdbc = (input) database connection handle to disconnect
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLDisconnect   PR                  Extproc('SQLDisconnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      *  SQLExecDirect(): Execute an SQL Statement Directly
      *
      *     hstmt = (input) handle of SQL Statement
      *  szSqlStr = (input) SQL statement to execute
      *  cbSqlStr = (input) length of SQL statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecDirect...
     D                 PR                  Extproc('SQLExecDirect')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLExecute(): Execute a prepared statement
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLExecute      PR                  Extproc('SQLExecute')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFetch(): Fetch next row from result set
      *
      *     hstmt = (input) handle of prepared SQL Statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND  (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFetch        PR                  Extproc('SQLFetch')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeConnect(): Free SQL connection handle
      *
      *     hdbc = (input) handle of data source connection
      *                   that has already been disconnected
      *                   by SQLDisconnect()
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeConnect  PR                  Extproc('SQLFreeConnect')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeEnv(): Free Environment Handle
      *              (SQLFreeConnect needs to be called first)
      *
      *     henv = (input) environment handle to free up
      *
      * Returns SQL_SUCCESS,
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeEnv      PR                  Extproc('SQLFreeEnv')
     D                                     like(SQLRETURN)
     D    henv                             like(SQLHENV) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLFreeStmt(): Free or Reset an SQL Statement Handle
      *
      *    hstmt = (input) statement handle to free or reset
      *  fOption = (input) option to perform, the values are:
      *              SQL_CLOSE  = Close a cursor
      *              SQL_DROP   = Drop a statement handle/free resources
      *              SQL_UNBIND = unbind columns from variables
      *              SQL_RESET_PARAMS = Reset parameters
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLFreeStmt     PR                  Extproc('SQLFreeStmt')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    fOption                          like(SQLSMALLINT) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLGetCol(): Gets a column from a fetched row
      *
      *     hstmt  = (input) statement handle of fetch
      *      icol  = (input) column number to get
      *    fCType  = (input) application (not database) data type
      *                      of column identified by icol
      *                      (SQL_CHAR, SQL_VARCHAR, etc...)
      *   rgbValue = (input) pointer to memory (variable) where the
      *                      retrieved column data will be stored
      * cbValueMax = (input) maximum size of data to return
      *                        for DECIMAL or NUMERIC, this is
      *                        (precision * 256) + scale.
      *                        For anything else, it's bytes.
      *   pcbValue = (output) size of data available in database
      *                        or, amount remaining if fetching in pieces
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *         SQL_NO_DATA_FOUND (also indicates end of result set)
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLGetCol       PR                  ExtProc('SQLGetCol')
     D                                     like(SQLRETURN)
     D   hstmt                             like(SQLHSTMT) value
     D   icol                              like(SQLSMALLINT) value
     D   fCType                            like(SQLSMALLINT) value
     D   rgbValue                          like(SQLPOINTER) value
     D   cbValueMax                        like(SQLINTEGER) value
     D   pcbValue                          like(SQLINTEGER) options(*omit)

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLPrepare(): Prepare an SQL statement to be executed
      *               one or more times.
      *
      *    hstmt = (input) statement handle to prepare into
      * szSqlStr = (input) SQL Statement to prepare
      * cbSqlStr = (input) length of SQL statement
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLPrepare      PR                  Extproc('SQLPrepare')
     D                                     like(SQLRETURN)
     D    hstmt                            like(SQLHSTMT) value
     D    szSqlStr                     *   value options(*string)
     D    cbSqlStr                         like(SQLINTEGER) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLSetConnectAttr(): Set connection attributes
      *
      *    hdbc = (input) connection handle to set attributes of
      *   fAttr = (input) Attribute to set
      *  vParam = (input) pointer to new attribute value
      *    sLen = (input) length of new attribute value
      *
      * Returns SQL_SUCCESS,
      *         SQL_SUCCESS_WITH_INFO
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLSetConnectAttr...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLPOINTER) value
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrI...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                           like(SQLINTEGER) const
     D    sLen                             like(SQLINTEGER) value
     D SQLSetConnectAttrS...
     D                 PR                  Extproc('SQLSetConnectAttr')
     D                                     like(SQLRETURN)
     D    hdbc                             like(SQLHDBC) value
     D    fAttr                            like(SQLINTEGER) value
     D    vParam                  32767A   options(*varsize) const
     D    sLen                             like(SQLINTEGER) value

      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * SQLError(): Retrieve Error Information
      *
      *        henv = (input) environment handle
      *        hdbc = (input) database connection handle
      *                       (or SQL_NULL_HDBC)
      *       hstmt = (input) statement handle (or SQL_NULL_HSTMT)
      *  szSqlState = (output) SQL State (null-terminated)
      * pfNativeErr = (output) Native error code
      *  szErrorMsg = (output) Message text of error message
      * cbErrMsgMax = (input) max size of szErrorMsg parameter
      * pcbErrorMsg = (output) total bytes available for err msg.
      *
      * Returns SQL_SUCCESS,
      *         SQL_NO_DATA_FOUND
      *         SQL_ERROR
      *         SQL_INVALID_HANDLE
      *+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     D SQLError        PR                  extproc('SQLError')
     D                                     like(SQLRETURN)
     D   henv                              like(SQLHENV) value
     D   hdbc                              like(SQLHDBC) value
     D   hstmt                             like(SQLHSTMT) value
     D   szSqlState                   6A   options(*omit)
     D   pfNativeErr                       like(SQLINTEGER)
     D                                     options(*omit)
     D   szErrorMsg                 513A   options(*varsize: *omit)
     D   cbErrMsgMax                       like(SQLSMALLINT) value
     D   pcbErrorMsg                       like(SQLSMALLINT)
     D                                     options(*omit)
