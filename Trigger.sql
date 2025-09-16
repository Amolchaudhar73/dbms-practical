Trigger :-1
 
create or replace trigger backup
before update or delete on clientmaster
for each row
begin
insert into auditt values(:old.srno,:old.name,:old.address);
end;
/

Trigger:-2
create or replace trigger errortrigger
before delete or update on auditt
begin
if rtrim(upper(To_char(sysdate,'day')))='WEDNESDAY' then
RAISE_APPLICATION_ERROR(-200000,'cannot perform delete or upadte operation');
end if;
end;
/


output:-
SQL*Plus: Release 21.0.0.0.0 - Production on Wed Sep 10 14:50:10 2025
Version 21.3.0.0.0

Copyright (c) 1982, 2021, Oracle.  All rights reserved.

Enter user-name: system
Enter password:
Last Successful login time: Wed Sep 10 2025 14:38:32 +05:30

Connected to:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0

SQL> create table clientmaster(srno int, name varchar(20), address varchar(20));

Table created.

SQL> create table audit as select * from clientmaster;
create table audit as select * from clientmaster
             *
ERROR at line 1:
ORA-00903: invalid table name


SQL> create table auditt as select * from clientmaster;

Table created.

SQL> desc clientmaster;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SRNO                                               NUMBER(38)
 NAME                                               VARCHAR2(20)
 ADDRESS                                            VARCHAR2(20)

SQL> desc auditt;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SRNO                                               NUMBER(38)
 NAME                                               VARCHAR2(20)
 ADDRESS                                            VARCHAR2(20)


SQL> INSERT INTO auditt (srno, name, address)
  2
SQL> insert into clientmaster(srno, name, address) values(101,'mohan','pune');

1 row created.

SQL> insert into clientmaster(srno, name, address) values(102,'jayesh','delhi');

1 row created.

SQL> desc clientmaster;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SRNO                                               NUMBER(38)
 NAME                                               VARCHAR2(20)
 ADDRESS                                            VARCHAR2(20)

SQL> select * from clientmaster;

      SRNO NAME                 ADDRESS
---------- -------------------- --------------------
       101 mohan                pune
       102 jayesh               delhi

SQL> select * from auditt;

no rows selected

SQL> @ c:\dbms\trigger.sql

Trigger created.

SQL> update clientmaster set name='Amol' where srno=101;

1 row updated.

SQL> select * from auditt;

      SRNO NAME                 ADDRESS
---------- -------------------- --------------------
       101 Amol                pune

SQL> delete from clientmaster;

2 rows deleted.

SQL> select * from auditt;

      SRNO NAME                 ADDRESS
---------- -------------------- --------------------
       101 mohan                pune
       101 manas                pune
       102 jayesh               delhi

SQL> select * from clientmaster;

no rows selected

SQL> insert into clientmaster(srno, name, address) values(101,'mohan','pune');

1 row created.

SQL> insert into clientmaster(srno, name, address) values(102,'rohan','pune');

1 row created.



SQL> @ c:\dbms\trigger2.sql

Warning: Trigger created with compilation errors.

SQL> @ c:\dbms\trigger2.sql

Trigger created.

SQL>  update clientmaster set name='AMol' where srno=101;

1 row updated.

SQL>  update auditt set name='amol' where srno=101;
 update auditt set name='amol' where srno=101
        *
ERROR at line 1:
ORA-21000: error number argument to raise_application_error of -200000 is out
of range
ORA-06512: at "SYSTEM.ERRORTRIGGER", line 3
ORA-04088: error during execution of trigger 'SYSTEM.ERRORTRIGGER'


SQL> delete from auditt;
delete from auditt
            *
ERROR at line 1:
ORA-21000: error number argument to raise_application_error of -200000 is out
of range
ORA-06512: at "SYSTEM.ERRORTRIGGER", line 3
ORA-04088: error during execution of trigger 'SYSTEM.ERRORTRIGGER'


SQL>