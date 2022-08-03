-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydbs
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydbs` DEFAULT CHARACTER SET utf8 ;
USE `mydbs` ;

-- -----------------------------------------------------
-- Table `mydbs`.`address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`address` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`address` (
  `address_ID` INT NOT NULL AUTO_INCREMENT,
  `city` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`address_ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`college`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`college` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`college` (
  `college_id` INT NOT NULL
  auto_increment,
  `college_name` VARCHAR(45) NOT NULL,
  `Tier` DECIMAL(1,0) check (Tier in (1,2,3) ) NOT NULL,
  `college_type` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`college_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`contact`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`contact` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`contact` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `phone_number` DECIMAL(10,0) NULL DEFAULT NULL,
  `mail_id` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`ID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`criteria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`criteria` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`criteria` (
  `criteria_id` INT NOT NULL AUTO_INCREMENT,
  `min_age` INT NULL DEFAULT NULL,
  `max_age` INT NULL DEFAULT NULL,
  `gender` VARCHAR(1) NULL DEFAULT NULL,
  `min_cgpa` DECIMAL(4,2) NULL DEFAULT NULL,
  `grad_year` DECIMAL(4,0) NULL DEFAULT NULL,
  `college_type` VARCHAR(45) NULL DEFAULT NULL,
  `college_tier` DECIMAL(1,0) NULL DEFAULT NULL,
  `Max_income` INT NULL DEFAULT NULL,
  PRIMARY KEY (`criteria_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`donor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`donor` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`donor` (
  `donor_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `contact_ID` INT NULL DEFAULT NULL,
  `address_ID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`donor_id`),
  INDEX `fk_Donor_contact1_idx` (`contact_ID` ASC) VISIBLE,
  INDEX `fk_Donor_address1_idx` (`address_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Donor_address1`
    FOREIGN KEY (`address_ID`)
    REFERENCES `mydbs`.`address` (`address_ID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Donor_contact1`
    FOREIGN KEY (`contact_ID`)
    REFERENCES `mydbs`.`contact` (`ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`scholarship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`scholarship` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`scholarship` (
  `sch_ID` INT NOT NULL AUTO_INCREMENT,
  `sch_name` VARCHAR(45) NULL DEFAULT NULL,
  `amount` INT NOT NULL,
  `criteria_id` INT NOT NULL,
  `donor_id` INT NOT NULL,
  PRIMARY KEY (`sch_ID`),
  INDEX `fk_scholarship_criteria1_idx` (`criteria_id` ASC) VISIBLE,
  INDEX `fk_scholarship_Donor1_idx` (`donor_id` ASC) VISIBLE,
  CONSTRAINT `fk_scholarship_criteria1`
    FOREIGN KEY (`criteria_id`)
    REFERENCES `mydbs`.`criteria` (`criteria_id`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_scholarship_Donor1`
    FOREIGN KEY (`donor_id`)
    REFERENCES `mydbs`.`donor` (`donor_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `mydbs`.`student`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`student` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`student` (
  `student_ID` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NULL DEFAULT NULL,
  `last_name` VARCHAR(45) NULL DEFAULT NULL,
  `Age` INT NULL DEFAULT NULL,
  `gender` VARCHAR(1) check (gender in ('M','F','O') ) NOT NULL,
  `CGPA` DECIMAL(4,2) NOT NULL,
  `graduation_year` DECIMAL(4,0) NOT NULL,
  `family_income` INT NOT NULL,
  `phone_number` DECIMAL(10,0) NULL DEFAULT NULL,
  `mail_id` VARCHAR(45) NULL DEFAULT NULL,
  `college_id` INT NOT NULL,
  `address_ID` INT NOT NULL,
  PRIMARY KEY (`student_ID`),
  INDEX `fk_student_college_idx` (`college_id` ASC) VISIBLE,
  INDEX `fk_student_address1_idx` (`address_ID` ASC) VISIBLE,
  CONSTRAINT `fk_student_address1`
    FOREIGN KEY (`address_ID`)
    REFERENCES `mydbs`.`address` (`address_ID`),
  CONSTRAINT `fk_student_college`
    FOREIGN KEY (`college_id`)
    REFERENCES `mydbs`.`college` (`college_id`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;




-- -----------------------------------------------------
-- Table `mydbs`.`student_has_scholarship`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `mydbs`.`student_has_scholarship` ;

CREATE TABLE IF NOT EXISTS `mydbs`.`student_has_scholarship` (
  `student_student_ID` INT NOT NULL,
  `scholarship_sch_ID` INT NOT NULL,
  PRIMARY KEY (`student_student_ID`, `scholarship_sch_ID`),
  INDEX `fk_student_has_scholarship_scholarship1_idx` (`scholarship_sch_ID` ASC) VISIBLE,
  INDEX `fk_student_has_scholarship_student1_idx` (`student_student_ID` ASC) VISIBLE,
  CONSTRAINT `fk_student_has_scholarship_scholarship1`
    FOREIGN KEY (`scholarship_sch_ID`)
    REFERENCES `mydbs`.`scholarship` (`sch_ID`)
    ON UPDATE CASCADE,
  CONSTRAINT `fk_student_has_scholarship_student1`
    FOREIGN KEY (`student_student_ID`)
    REFERENCES `mydbs`.`student` (`student_ID`)
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

use mydbs;
SHOW TABLES


-- --------------------------------------------------------------------------------
-------- Procedures to insert data into tables ------------------------------------ 





DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_address (IN ID int , IN city  varchar(45))
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting address'
  begin 
 insert into mydbs.address(address_ID , city)
 values(ID , city );
 end$$
 DELIMITER ;
 

 
 DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_college (IN ID int , IN college_name varchar(45) , in tier numeric(1,0) , in college_type varchar(45))
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting college'
  begin 
 insert into mydbs.college( college_id , college_name , Tier,  college_type)
 values(ID , college_name , tier , college_type );
 end$$
 DELIMITER ;
 

 
 DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_criteria (IN ID int ,in min_age int , in max_age int , in gender varchar(1) , in min_cgpa numeric(4,2) , in grad_year numeric(4,0)
       ,in college_type varchar(45) , in tier numeric(1,0) , in max_income int )
 
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting criteria'
  begin 
 insert into mydbs.criteria( criteria_id , min_age ,max_age , gender, min_cgpa, grad_year , college_type, college_tier, Max_income )
 values(ID ,min_age , max_age , gender ,min_cgpa, grad_year , college_type, tier, max_income  );
 end$$
 DELIMITER ;
 

 
  DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_student (IN ID int ,in first_name varchar(45), in last_name varchar(45), in age int  , in student_gender varchar(1) , in cgpa numeric(4,2) , in graduation_year numeric(4,0)
       ,in family_income int, in phone_no numeric(10,0), in mail_id varchar(45), in college_id int, in address_id int )
 
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting student'
  begin 
 insert into mydbs.student( student_ID , first_name, last_name , Age, gender, CGPA, graduation_year , family_income, phone_number, mail_id, college_id, address_id )
 values(ID ,first_name , last_name ,age, student_gender ,cgpa, graduation_year , family_income, phone_no, mail_id, college_id, address_id   );
 
 call student_check;
DELETE from student;
 
 end$$
 DELIMITER ; 
 
 
DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
student_check ()
reads sql data
 deterministic
 sql security invoker
 comment 'checking eligible scholarships'
  begin 
  create view stu_info as
 select *  from student natural join college;
  select sch_ID, sch_name, amount
 from scholarship 
 Natural Join criteria  a 
 inner join stu_info b
 on (a.min_age is NULL or (b.Age >= a.min_age and b.Age <=a.max_Age)) and (a.gender is NULL or a.gender = b.gender) and(a.min_cgpa is NULL or b.CGPA >= a.min_cgpa) 
 and (a.max_income is NULL or b.family_income <= a.max_income)  and (a.college_tier is NULL or b.Tier <= a.college_tier )
 and (a.grad_year is NULL or b.graduation_year <= a.grad_year )  and (a.college_type is NULL or b.college_type = a.college_type)
 order by sch_ID; 
 
 DROP VIEW stu_info;
  end$$
 DELIMITER ; 



 



   DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_contact (IN ID int , IN phone numeric (10,0) , in mail_id varchar(45) )
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting contact'
  begin 
 insert into mydbs.contact( ID , phone_number , mail_id)
 values(ID , phone , mail_id );
 end$$
 DELIMITER ;
 
   DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_donor (IN ID int , IN name_donor varchar(45) , in contact_id int, in address_id int )
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting donor'
  begin 
 insert into mydbs.donor( donor_id , name, contact_id , address_id)
 values(ID , name_donor , contact_id, address_id );
 end$$
 DELIMITER ;
 
 
 
DELIMITER $$ 
CREATE DEFINER=`abhinav`@`localhost`  procedure 
 insert_sch (IN ID int , IN name_sch varchar(45) ,in amt int, in criteria_id int, in donor_id int )
 reads sql data
 deterministic
 sql security invoker
 comment 'inserting scholarship'
  begin 
 -- LOCK TABLE scholarship READ;  
 insert into mydbs.scholarship( sch_ID , sch_name, amount, criteria_id , donor_id)
 values(ID , name_sch , amt, criteria_id, donor_id );
 -- UNLOCK TABLES;
 end$$
 DELIMITER ;
 
call insert_address (0, 'delhi');
call insert_address (0, 'mumbai');
call insert_address (0, 'agra');
call insert_address (0, 'noida');
call insert_address (0, 'sikar');
call insert_address (0, 'udaipur');
call insert_address (0, 'pune');
call insert_address (0, 'trichy');
call insert_address (0, 'lachung');
call insert_address (0, 'thane');
call insert_address (0, 'gurgaon');
call insert_address (0, 'ajmer');
call insert_address (0, 'jhunjunu');
call insert_address (0, 'gangtok');
call insert_address (0, 'shimla');
call insert_address (0, 'manali');
call insert_address (0, 'srinagar');
call insert_address (0, 'Jammu');

select * from address ;
 
 
call insert_college (0, 'BITS', 1, 'Private');
call insert_college (0, 'VIT', 3, 'Private');
call insert_college (0, 'SRM', 3, 'Private');
call insert_college (0, 'IIT Delhi', 1, 'Government');
call insert_college (0, 'NIT Jaipur', 2, 'Government');
call insert_college (0, 'IIT Mumbai', 1, 'Government');
call insert_college (0, 'MIT Pune', 3, 'Private');
call insert_college (0, 'UIT Engineering', 3, 'Private');
call insert_college (0, 'IIT Kanpur', 1, 'Government');
call insert_college (0, 'IIIT Jaipur', 1, 'Government');
call insert_college (0, 'Anna University', 2, 'Private');
call insert_college (0, 'NIT Warangal', 2, 'Government');
call insert_college (0, 'Manipal University', 3, 'Private');
call insert_college (0, 'IIT Roorkee', 1, 'Government');
call insert_college (0, 'Symbiosis Pune', 3, 'Private');
call insert_college (0, 'IIT Bhilai', 1, 'Government');
call insert_college (0, 'IIT Mandhi', 1, 'Government');
call insert_college (0, 'NIT Trichy', 2, 'Government');
call insert_college (0, 'NIT Surat', 2, 'Government');
call insert_college (0, 'Ramhiya College', 2, 'Private');

SELECT	* From college;

call insert_contact (0, 8824175486,  'mailaddress1@gmail1.com'); 
call insert_contact (0, 8724175484,  'mailaddress1@gmail2.com'); 
call insert_contact (0, 8922175483,  'mailaddress1@gmail3.com'); 
call insert_contact (0, 9224375482,  'mailaddress1@gmail4.com'); 
call insert_contact (0, 8624475487,  'mailaddress1@gmail5.com'); 
call insert_contact (0, 9324575469,  'mailaddress1@gmail6.com'); 
call insert_contact (0, 7224675488,  'mailaddress1@gmail7.com'); 
call insert_contact (0, 7724175486,  'mailaddress1@gmail8.com'); 
call insert_contact (0, 6924175487,  'mailaddress1@gmail9.com'); 
call insert_contact (0, 9224175486,  'mailaddress1@gmail10.com'); 
call insert_contact (0, 9024175486,  'mailaddress1@gmail12.com'); 
call insert_contact (0, 9624175485,  'mailaddress1@gmail13.com'); 
call insert_contact (0, 9724175484,  'mailaddress1@gmail14.com'); 
call insert_contact (0, 9824175483,  'mailaddress1@gmail15.com'); 
call insert_contact (0, 9124175483,  'mailaddress1@gmail16.com'); 
call insert_contact (0, 8924175482,  'mailaddress1@gmail17.com'); 
call insert_contact (0, 9924175481,  'mailaddress1@gmail18.com'); 
call insert_contact (0, 6724175482,  'mailaddress1@gmail19.com'); 
call insert_contact (0, 9824175483,  'mailaddress1@gmail20.com'); 
call insert_contact (0, 9824134483,  'mailaddress1@gmail21.com'); 


 
 SELECT	* From contact;





call insert_criteria (0, 15, 25,'F',8.00, 2024, 'Government', 2, 600000 );
call insert_criteria (0, 20, 35,'M',7.50, 2026, 'Private', 1, 400000 );
call insert_criteria (0, 18, 28,'F',9.00, 2023, 'Government', 3, 500000 );
call insert_criteria (0, 15, 23,'M',8.20, 2024, 'Private', 3, 450000 );
call insert_criteria (0, 21, 25,'O',8.50, 2025, 'Government', 1, 800000 );
call insert_criteria (0, 18, 25,'F',8.25, 2026, 'Private', 2, 1100000 );
call insert_criteria (0, 16, 27,'F',7.25, 2024, 'Government', 1, 400000 );
call insert_criteria (0, 18, 26,'M',7.50, 2023, 'Private', 3, 450000 );
call insert_criteria (0, 15, 24,'F',6.50, 2023, 'Government', 2, 650000 );
call insert_criteria (0, 16, 25,'M',8.30, 2026, 'Private', 2, 700000 );
call insert_criteria (0, 21, 30,'O',9.00, 2025, 'Government', 1, 800000 );
call insert_criteria (0, 20, 25,'M',8.15, 2025, 'Private', 2, 220000 );
call insert_criteria (0, 16, 25,'F',6.20, 2024, 'Government', 3, 250000 );
call insert_criteria (0, 18, 27,'F',5.50, 2024, 'Private', 2, 400000 );
call insert_criteria (0, 18, 25,'M',7.80, 2023, 'Government', 2, 600000 );
call insert_criteria (0, 20, 30,'F',8.10, 2022, 'Private', 1, 1000000 );
call insert_criteria (0, 18, 25,'M', 6.00, 2025, 'Private', 2, 1200000 );
call insert_criteria (0, 18, 25,null,7.80, NULL, NULL, NULL, 600000 );
call insert_criteria (0, NULL, 30,NULL,8.10, 2022, 'Private', 3, 1000000 );
call insert_criteria (0, 18, 25,NULL, 6.00, 2025, NULL, 2, 1200000 );

select * from criteria;




call insert_donor (0, 'Mr. Rahul', 1, 4);
call insert_donor (0, 'Mr. Anil', 4, 1);
call insert_donor (0, 'Mrs. Sangeeta', 3, 6);
call insert_donor (0, 'Mr. Rohan', 5, 7);
call insert_donor (0, 'Mr. Josh', 8, 9);
call insert_donor (0, 'Mr. David', 7, 2);
call insert_donor (0, 'Mr. Kumar', 6, 5);
call insert_donor (0, 'Mr. Birla', 10, 8);
call insert_donor (0, 'Mr. Mukesh', 9, 4);
call insert_donor (0, 'Mr. White', 14, 12);
call insert_donor (0, 'Mr. Michael', 15, 2);
call insert_donor (0, 'Mrs. Amii', 13, 8);
call insert_donor (0, 'Ms. Juhi', 12, 3);
call insert_donor (0, 'Mr. Yash A', 11, 5);
call insert_donor (0, 'Mr. James Clear', 17, 14);
call insert_donor (0, 'Mr. Shuvansh', 14, 17);
call insert_donor (0, 'Mr. Paulo', 16, 1);
call insert_donor (0, 'Mr. Kamboj', 8, 6);
call insert_donor (0, 'Mr. Aggarwall ', 2, 8);

select * from donor;


call insert_sch (0, 'Merit', 300000, 4,1);
call insert_sch (0, 'MCN Grant', 200000, 1,7);
call insert_sch (0, 'Aid Fund', 250000, 2,8);
call insert_sch (0, 'FullBright', 350000, 3,10);

call insert_sch (0, 'Musk Student Aid', 100000, 5,12);
call insert_sch (0, 'SAF Scholarship', 50000, 6,11);
call insert_sch (0, 'DHRCC Fund', 20000, 7,3);
call insert_sch (0, 'Hope Scholarship', 80000, 8,1);
call insert_sch (0, 'Excelsior Scholarship', 100000, 9,6);
call insert_sch (0, 'Pepsi Help Fund', 150000, 10,8);
call insert_sch (0, 'Millennium Scholars', 200000, 12,3);
call insert_sch (0, 'Gilman Scholarship', 500000,11,6);
call insert_sch (0, 'Gandhi Foundation', 10000, 13,16);
call insert_sch (0, 'Inspire Scholarships', 5000, 14,10);
call insert_sch (0, 'KVPY', 10000, 10,1);
call insert_sch (0, 'King Fund', 280000, 15,9);
call insert_sch (0, 'Dell Scholarship', 320000, 16,8);
call insert_sch (0, 'Marshall Scholarship', 310000, 17,3);
call insert_sch (0, 'Bright Futures Scholarship', 200000, 18,10);
call insert_sch (0, 'Rhodes Foundation', 500000, 19,15);
call insert_sch (0, 'TEACH Scholarship', 100000, 18,13);
call insert_sch (0, 'Alger Scholarship', 150000, 11,12);
call insert_sch (0, 'Singapur University Grant', 320000, 3,8);
call insert_sch (0, 'Stars Scholarship', 220000, 8,7);
call insert_sch (0, 'US Presidential Program', 30000, 20,6);
call insert_sch (0, 'Patel Memorial Fund', 180000, 17,2);
call insert_sch (0, 'Bose Scholarship', 70000, 16,10);
call insert_sch (0, 'Newton Foundation', 50000, 14,16);
call insert_sch (0, 'Posse Scholarship', 90000, 15,11);

select * from scholarship;

-- DROP TABLE `mydbs`.`student_has_scholarship`;
-- DROP TABLE `mydbs`.`scholarship`;
-- DROP TABLE `mydbs`.`student`;
-- DROP TABLE `mydbs`.`donor`;
-- DROP TABLE `mydbs`.`address`;
-- DROP TABLE `mydbs`.`college`;
-- DROP TABLE `mydbs`.`contact`;
-- DROP TABLE `mydbs`.`criteria`;
-- DROP DATABASE `mydbs`; 







