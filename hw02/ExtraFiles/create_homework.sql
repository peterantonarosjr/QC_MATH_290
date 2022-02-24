/*Create the homework table with a primary key constraint on the id field called pk_homework*/
create table homework (
"id" bigint, 
"homework_name" varchar, 
"posted_date" timestamp, 
"due_date" timestamp, 
"homework_duration_minutes" bigint,
constraint "pk_homework" primary key ("id")
);
