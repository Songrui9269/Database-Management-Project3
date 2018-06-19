rem EE 562 Project 3
rem Songrui Li
rem LI884



--step #0: drop all the tables, procedure first.

drop table general_ward;
drop table screening_ward;
drop table pre_surgery_ward;
drop table post_surgery_ward;
drop table Patient_Chart;
drop table DR_Schedule;
drop table Surgeon_Schedule;
drop table Patient_Input;

drop procedure pop_patient_chart_table;
drop procedure populate_db;



-- Step #1: create general_ward table.

create table general_ward
(
	Patient_Name varchar2(30),
	G_Admission_Date date,
	Patient_Type varchar2(10)
);


-- Step #2: create screening_ward table.

create table screening_ward
(
	Patient_Name varchar2(30),
	S_Admission_Date date,
	Bed_No number,
	Patient_Type varchar2(10)
);

-- Step #3: create pre_surgery_ward table

create table pre_surgery_ward
(
	Patient_Name varchar2(30),
	Pre_Admission_Date date,
	Bed_No number,
	Patient_Type varchar2(10)
);

-- Step #4: create post_surgery_ward table

create table post_surgery_ward
(
	Patient_Name varchar2(30),
	Post_Admission_Date date,
	Discharge_Date date,
	Scount number,
	Patient_Type varchar2(10)
);

-- Step #5: create patient_chart table

create table Patient_Chart
(
	Patient_Name varchar2(30),
	Pdate date,
	Temperature number,
	BP number
);

-- Step #6: create dr_schedule table

create table DR_Schedule
(
	Name varchar2(30),
	Ward varchar2(20),
	Duty_Date date
);

-- Step #7: create surgeon_schedule table

create table Surgeon_Schedule
(
	Name varchar2(30),
	Surgery_Date date
);

-- Step #8: create patient_input table

create table Patient_Input
(
	Patient_Name varchar2(30),
	General_ward_admission_date date,
	Patient_Type varchar2(10)
);


--rule #1: change the date format

alter session set NLS_DATE_FORMAT = 'MM:DD:YYYY';

--rule #2: patient_type can be Cardiac, Neuro or General.

alter table general_ward add constraint CHK_Patient_Type check (Patient_Type in ('Cardiac','Neuro','General'));






