-- -----------------TEST QUERY------------------------


call insert_student(0, 'Nischal', 'Khetan', 22, 'F', 8.80, 2024, 100000, 8865482311, 'nischal@gmail.com', 5, 4);  
call insert_student(0, 'Abhunav', 'Tiwari', 21, 'M', 7.80, 2023, 300000, 8865782311, 'nischal@gmail.com', 6, 2); 
call insert_student(0, 'Rahul', 'A', 24, 'M', 8.20, 2024, 200000, 8865482311, 'nischal@gmail.com', 7, 5);
call insert_student(0, 'Gorav', 'B', 20, 'F', 6.80, 2023, 600000, 8865482311, 'nischal@gmail.com', 1, 6);  
call insert_student(0, 'Rahul', 'A', 24, 'M', 8.20, 2024, 200000, 8865482311, 'nischal@gmail.com', 7, 5);
call insert_student(0, 'Gorav', 'B', 20, 'F', 6.80, 2023, 600000, 8865482311, 'nischal@gmail.com', 1, 6);  
call insert_student(0, 'Aviral', 'C', 21, 'M', 8.20, 2024, 200000, 8865482311, 'nischal@gmail.com', 9, 5);
call insert_student(0, 'Gupta', 'D', 22, 'O', 9.20, 2023, 50000, 8865482311, 'nischal@gmail.com', 1, 3);  
call insert_student(0, 'Ravi', 'A', 19, 'M', 8.20, 2024, 200000, 8865482311, 'nischal@gmail.com', 13, 7);
call insert_student(0, 'Ram', 'G', 24, 'O', 6.80, 2023, 600000, 8865482311, 'nischal@gmail.com', 8, 6);  
call insert_student(0, 'Sharma', 'D', 22, 'M', 9.20, 2023, 50000, 8865482311, 'nischal@gmail.com', 1, 3);  

select * from student; 


START TRANSACTION;
LOCK TABLE contact WRITE; 
LOCK TABLE address WRITE;
LOCK TABLE donor WRITE;
LOCK TABLE criteria WRITE;
LOCK TABLE scholarship WRITE;
call insert_sch (0, 'Pose Scholarship', 190000, 14,11);
commit;
UNLOCK TABLES;
