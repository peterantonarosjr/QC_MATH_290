/*Creating the homework_submission table with 
 * - a primary key constraint on the id field called pk_homework_submission
 * - a foreign key constraint on the homework_id field called fk_homework_id referencing the id field in the homework table
 * */
create table homework_submission(
"id" bigint, 
student_id bigint, 
homework_id bigint, 
primary key ("id"),
constraint 
"fk_homework" foreign key (homework_id) references homework(id)
);
