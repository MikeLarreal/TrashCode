      *  This is an SQL stored procedure that calculates the next 10
      *  work days (Monday-Friday) and returns them as a result set.
      * 
      *                                  Scott Klement, May 11, 2006
      *
      *  To Compile:
      *     CRTSQLRPGI WORKDAYS SRCFILE(xxx/QRPGLESRC) DBGVIEW(*SOURCE)
      *
      * 
     H DFTACTGRP(*NO)

     D GetDOW          PR             9A   varying
     D   myDate                        D   const

     D count           s             10I 0
     D DayList         ds                  occurs(100)
     D   Date                        10A
     D   Name                         9A   varying

     D x               s             10I 0
     D dayname         s              9A   varying
     D NextDate        s               D   datfmt(*ISO)

      /free

          //  This gets the next 10 work days.
          //  (For this example, work days are days from
          //    Monday - Friday)

          Count = 0;
          NextDate = d'2006-05-11';

          for x = 1 to 10;

             dou  dayname<>'Saturday'
                 and dayname<>'Sunday';
                NextDate = NextDate + %days(1);
                dayname = GetDOW(NextDate);
             enddo;

             %occur(DayList) = x;
             Date = %char(NextDate:*ISO);
             Name = dayname;
             Count = Count + 1;

          endfor;

      /end-free

     C/exec sql Set Result Sets Array :DAYLIST for :COUNT Rows
     C/end-exec

     c                   eval      *inlr = *on
     c                   return


      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
      * GetDOW(): Get the day of the week for a given date
      *++++++++++++++++++++++++++++++++++++++++++++++++++++++++
     P GetDOW          B
     D GetDOW          PI             9A   varying
     D   myDate                        D   const
     D SUN             c                   const(d'2006-01-01')
     D days            s             10I 0
     D dowk            s             10I 0
      /free
          days = %diff(myDate: SUN: *DAYS);
          dowk = %rem(days: 7);

          select;
          when dowk = 0;
            return 'Sunday';
          when dowk = 1;
            return 'Monday';
          when dowk = 2;
            return 'Tuesday';
          when dowk = 3;
            return 'Wednesday';
          when dowk = 4;
            return 'Thursday';
          when dowk = 5;
            return 'Friday';
          when dowk = 6;
            return 'Saturday';
          endsl;

      /end-free
     P                 E

