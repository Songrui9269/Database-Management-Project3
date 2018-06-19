rem EE 562 Project 3
rem Songrui Li
rem LI884


alter session set NLS_DATE_forMAT = 'MM/DD/YYYY';
set serveroutput on;

@createtable
@tgr
@populate
@query

exec pop_patient_chart_table;
exec populate_db;
exec pop_Dr_Schedule;
exec pop_Surgeon_Schedule;


select * from Patient_input;
select * from Patient_Chart;

select * from General_Ward;
select * from Screening_Ward;
select * from Pre_Surgery_Ward;
select * from Post_Surgery_Ward;

select* from Dr_Schedule;
select* from Surgeon_Schedule;

exec DBMS_OUTPUT.PUT_LinE ('Verify schedules '||fun_verSched);


create TABLE COMPLETE_PATIENT_SCHEDULE
(
NAME	VARCHAR2(20),
G_AD DATE,
s_AD DATE,
PRE_AD DATE,
POST_AD		DATE,
DISCHARGE	DATE
);

DECLARE
v_g_admission_date		date;
v_s_admission_date		date;
v_pre_admission_date	date;
v_post_admission_date	date;
v_discharge_date		date;

begin
DBMS_OUTPUT.put_line (RPAD('Name', 10)||RPAD('G_ad', 15)||RPAD('s_ad',15)||
RPAD('Pre_ad',15)||RPAD('Post_ad',15)||RPAD('Discharge',15));
	
for patient_rec in (select * from General_ward order by G_Admission_Date, patient_name)
	LOOP
	v_g_admission_date:=patient_rec.g_admission_date;
	select s_admission_date into v_s_admission_date from Screening_WARD 
		where patient_name = patient_rec.patient_name and s_admission_date = 
		(
			select Min(s_admission_date) from Screening_WARD 
			where patient_name = patient_rec.patient_name and s_admission_date >  patient_rec.g_admission_date
		);
	select pre_admission_date into v_pre_admission_date from Pre_Surgery_Ward
	where patient_name = patient_rec.patient_name and pre_admission_date = 
		(
			select Min(pre_admission_date) from Pre_Surgery_Ward 
			where patient_name = patient_rec.patient_name and pre_admission_date >  patient_rec.g_admission_date
		);
	select post_admission_date, discharge_date into v_post_admission_date,v_discharge_date from POST_SURGERY_WARD
	where patient_name = patient_rec.patient_name and post_admission_date = 
		(
			select Min(post_admission_date) from post_surgery_ward 
			where patient_name = patient_rec.patient_name and post_admission_date >  patient_rec.g_admission_date
		);

	if v_pre_admission_date > v_post_admission_date then
		DBMS_OUTPUT.put_line (RPAD(patient_rec.patient_name, 10)||RPAD(v_g_admission_date, 15)||RPAD(v_s_admission_date,15)
			||RPAD('Skip',15)||RPAD(v_post_admission_date,15)||RPAD(v_discharge_date,25));
		insert into COMPLETE_PATIENT_SCHEDULE values(patient_rec.patient_name,v_g_admission_date,v_s_admission_date,
				NULL,v_post_admission_date,v_discharge_date);
	else
		DBMS_OUTPUT.put_line (RPAD(patient_rec.patient_name, 10)||RPAD(v_g_admission_date, 15)||RPAD(v_s_admission_date,15)
			||RPAD(v_pre_admission_date,15)||RPAD(v_post_admission_date,15)||RPAD(v_discharge_date,25));
		insert into COMPLETE_PATIENT_SCHEDULE values(patient_rec.patient_name,v_g_admission_date,v_s_admission_date,
				v_pre_admission_date,v_post_admission_date,v_discharge_date);
	end if;
	end loop;
end;
/



create view Patient_Surgery_view as 
select p.Patient_Name, p.Post_Admission_Date, s.Name
from POST_SURGERY_WARD p, Surgeon_Schedule s
where p.Post_Admission_Date=Surgery_Date and p.Patient_Type='Cardiac' and (s.Name='Dr.Gower' OR s.Name='Dr.Charles')
union
select p.Patient_Name, p.Post_Admission_Date, s.Name
from POST_SURGERY_WARD p, Surgeon_Schedule s
where p.Post_Admission_Date=Surgery_Date and p.Patient_Type='Neuro' and (s.Name='Dr.Taylor' OR s.Name='Dr.Rutherford')
union
select p.Patient_Name, p.Post_Admission_Date, s.Name
from POST_SURGERY_WARD p, Surgeon_Schedule s
where p.Post_Admission_Date=Surgery_Date and p.Patient_Type='General' and (s.Name='Dr.Smith' OR s.Name='Dr.Richards')
union
select p.Patient_Name, p.Post_Admission_Date+2, s.Name
from POST_SURGERY_WARD p, Surgeon_Schedule s
where p.Scount=2 and p.Post_Admission_Date+2=Surgery_Date and p.Patient_Type='Cardiac' and (s.Name='Dr.Gower' OR s.Name='Dr.Charles')
union
select p.Patient_Name, p.Post_Admission_Date+2, s.Name
from POST_SURGERY_WARD p, Surgeon_Schedule s
where p.Scount=2 and p.Post_Admission_Date+2=Surgery_Date and p.Patient_Type='Neuro' and (s.Name='Dr.Taylor' OR s.Name='Dr.Rutherford')
;


select* from Patient_Surgery_view;
