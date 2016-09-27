➜  ~  cd /Users/qingyun/Desktop/Code1605/Code/网络数据--Demo/20160729 
➜  20160729  sqlite3 test.db
SQLite version 3.8.10.2 2015-05-20 18:17:19
Enter ".help" for usage hints.
sqlite> sqlite> CREATE TABLE IF NOT EXISTS Students(ID integer,Name text,Age intsqlite> CREATE TABLE IF NOT EXISTS Students(ID integer,Name text,Age integer);
sqlite>  .tables
   ...> ;
Error: near ".": syntax error
sqlite> .tables;
Error: unknown command or invalid arguments:  "tables;". Enter ".help" for help
sqlite> .tables;
Error: unknown command or invalid arguments:  "tables;". Enter ".help" for help
sqlite>  .tables;
Error: near ".": syntax error
sqlite> .schema;
Error: unknown command or invalid arguments:  "schema;". Enter ".help" for help
sqlite> .schema;
Error: unknown command or invalid arguments:  "schema;". Enter ".help" for help
sqlite> .schema
CREATE TABLE Students(ID integer,Name text,Age integer);
sqlite> .schema Students
CREATE TABLE Students(ID integer,Name text,Age integer);
sqlite> CREATE TABLE IF NOT EXISTS Teachers(ID integer,Name text,Age integer);
sqlite> .schema;
Error: unknown command or invalid arguments:  "schema;". Enter ".help" for help
sqlite> .schema
CREATE TABLE Students(ID integer,Name text,Age integer);
CREATE TABLE Teachers(ID integer,Name text,Age integer);
sqlite> insert into Students(ID,Name,Age) values(1001,'学生1',20);
sqlite> select * from Students
   ...> ;
1001|学生1|20
sqlite> .headers on
sqlite> ;
sqlite> select * from Students;
ID|Name|Age
1001|学生1|20
sqlite> insert into Students(ID,Name,Age) values(1002,'学生2',21);
sqlite> insert into Students(ID,Name,Age) values(1003,'学生3',22);
sqlite> insert into Students(ID,Name,Age) values(1004,'学生4',20);
sqlite> select * from Students;
ID|Name|Age
1001|学生1|20
1002|学生2|21
1003|学生3|22
1004|学生4|20
sqlite> insert into Students(Name) values('学生5');
sqlite> select * from Students;
ID|Name|Age
1001|学生1|20
1002|学生2|21
1003|学生3|22
1004|学生4|20
|学生5|
sqlite> insert into Students(Name) values('学生5',20);
Error: 2 values for 1 columns
sqlite> update Students set ID=1005,Age=21 where Name='学生5'
   ...> ;
sqlite> select * from Students;
ID|Name|Age
1001|学生1|20
1002|学生2|21
1003|学生3|22
1004|学生4|20
1005|学生5|21
sqlite> update Students set Age=19;
sqlite> select * from Students;
ID|Name|Age
1001|学生1|19
1002|学生2|19
1003|学生3|19
1004|学生4|19
1005|学生5|19
sqlite> select * from Students where id=1004;
ID|Name|Age
1004|学生4|19
sqlite> select Name,Age from Students where id=1004;
Name|Age
学生4|19
sqlite> select count(*) from Students where id=1004;
count(*)
1
sqlite> select count(*) as total from Students where id=1004;
total
1
sqlite> select * from Students order by ID DESC
   ...> ;
ID|Name|Age
1005|学生5|19
1004|学生4|19
1003|学生3|19
1002|学生2|19
1001|学生1|19
sqlite> select * from Students order by ID asc
   ...> ;
ID|Name|Age
1001|学生1|19
1002|学生2|19
1003|学生3|19
1004|学生4|19
1005|学生5|19
sqlite> insert into Students(ID,Name,Age) values(1004,'学生16',20);
sqlite> select * from Student order by ID DESC,Name ASC;
Error: no such table: Student
sqlite> select * from Students order by ID DESC,Name ASC;
ID|Name|Age
1005|学生5|19
1004|学生16|20
1004|学生4|19
1003|学生3|19
1002|学生2|19
1001|学生1|19
sqlite> select * from Students order by ID DESC,Age ASC;
ID|Name|Age
1005|学生5|19
1004|学生4|19
1004|学生16|20
1003|学生3|19
1002|学生2|19
1001|学生1|19
sqlite> select * from Students order by ID DESC,Age ASC limit 2,2;
ID|Name|Age
1004|学生16|20
1003|学生3|19
sqlite> select * from Students order by ID DESC,Age ASC limit 1,2;
ID|Name|Age
1004|学生4|19
1004|学生16|20
sqlite> select * from Students order by ID DESC,Age ASC limit 1,3;
ID|Name|Age
1004|学生4|19
1004|学生16|20
1003|学生3|19
sqlite> insert into Students(Name) values('学生5',20);