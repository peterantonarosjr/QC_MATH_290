/* This is the begin if a comment section.
This is a create table statement which will create a table called 
class_roaster in the database called qcmath290 and  schema valled public.
On line 17 the first column definition begins: each column has a name and an associated data type.
When a data type is assigned domain integrity will ensure that only valid values will be accepted in the column. 
The table also has a constraint associated with it in line 27.
This is the PRIMARY KEY constraint that enforces referential integrity mentioned during class.
When the PRIMARY KEY constraint is invoked during the CREATE or the ALTER statmenets the RDBMS engine will ensure that all values in the associated column are unique.
This is the end of a comment section.
*/

create table qcmath290.public.class_roster (
 "id" bigint
,"name" varchar
,"last_name" varchar
,"first_name" varchar
,"passion" varchar
,"link_to_interest" varchar
,"email_address" varchar
,"github_handle" varchar
,"goodreads_link" varchar
,"operating_system" varchar
,"coding_buddy_name" varchar
,"group_id" integer
,constraint "id" primary key ("id")
);
