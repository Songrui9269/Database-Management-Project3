rem EE 562 Project 3
rem Songrui Li
rem LI884

set serveroutput on;
alter session set NLS_DATE_FORMAT = 'MM/DD/YYYY';

--create a procedure called pop_patient_chart_table to populate that table

create or replace procedure pop_patient_chart_table(patientName in varchar2, patientDate in date)

is
d date;
rnt pls_integer;
rnbp pls_integer;
t number;
bp number;

begin
	d:= patientDate;
	for i in 1.. 60 
	loop
	rnt := dbms_random.value(0,10);
	rnbp := dbms_random.value(0,7);
	t:=94+rnt;
	bp:=10*rnbp+90;
	d:=d+1;
	insert into patient_chart values(patientName,d,t,bp);	
	end loop;

end;
/


--create a procedure called populate_db to populate the General_Ward table

create or replace procedure populate_db

is
pName varchar2(30);
genwaradmDate date;
pType varchar2(10);

cursor cur1 is 
	select *
	from patient_input;

begin

open cur1;
loop
fetch cur1 into pName, genwaradmDate, pType;
exit when cur1%notfound;
insert into General_Ward values(pName, genwaradmDate, pType);
end loop;
close cur1;


end;
/

--create a procedure that populate the Dr_Schedule table

create or replace procedure pop_Dr_Schedule

is
oriDate date:='01/01/2005';

begin


for w in 1 .. 52 loop

	for d in 0 .. 7 loop
		
		if d=0
		then
		insert into Dr_Schedule values('James','General_Ward',oriDate);
		insert into Dr_Schedule values('Robert','Screening_Ward',oriDate);
		insert into Dr_Schedule values('Mike','Pre_Surgery_Ward',oriDate);
		insert into Dr_Schedule values('Adams','Post_Surgery_Ward',oriDate);
		insert into Dr_Schedule values('Tracey','Surgery',oriDate);

		elsif d=1
		then
		insert into Dr_Schedule values('James','General_Ward',oriDate+1);
		insert into Dr_Schedule values('Robert','Screening_Ward',oriDate+1);
		insert into Dr_Schedule values('Mike','Pre_Surgery_Ward',oriDate+1);
		insert into Dr_Schedule values('Adams','Post_Surgery_Ward',oriDate+1);
		insert into Dr_Schedule values('Tracey','Surgery',oriDate+1);
		insert into Dr_Schedule values('Rick','Surgery',oriDate+1);
		elsif d=2
		then
		insert into Dr_Schedule values('Robert','General_Ward',oriDate+2);
		insert into Dr_Schedule values('Mike','Screening_Ward',oriDate+2);
		insert into Dr_Schedule values('Adams','Pre_Surgery_Ward',oriDate+2);
		insert into Dr_Schedule values('Tracey','Post_Surgery_Ward',oriDate+2);
		insert into Dr_Schedule values('Rick','Surgery',oriDate+2);
		elsif d=3
		then
		insert into Dr_Schedule values('Mike','General_Ward',oriDate+3);
		insert into Dr_Schedule values('Adams','Screening_Ward',oriDate+3);
		insert into Dr_Schedule values('Tracey','Pre_Surgery_Ward',oriDate+3);
		insert into Dr_Schedule values('Rick','Post_Surgery_Ward',oriDate+3);
		insert into Dr_Schedule values('James','Surgery',oriDate+3);
		elsif d=4
		then
		insert into Dr_Schedule values('Adams','General_Ward',oriDate+4);
		insert into Dr_Schedule values('Tracey','Screening_Ward',oriDate+4);
		insert into Dr_Schedule values('Rick','Pre_Surgery_Ward',oriDate+4);
		insert into Dr_Schedule values('James','Post_Surgery_Ward',oriDate+4);
		insert into Dr_Schedule values('Robert','Surgery',oriDate+4);
		
		elsif d=5
		then
		insert into Dr_Schedule values('Tracey','General_Ward',oriDate+5);
		insert into Dr_Schedule values('Rick','Screening_Ward',oriDate+5);
		insert into Dr_Schedule values('James','Pre_Surgery_Ward',oriDate+5);
		insert into Dr_Schedule values('Robert','Post_Surgery_Ward',oriDate+5);
		insert into Dr_Schedule values('Mike','Surgery',oriDate+5);
		elsif d=6
		then
		insert into Dr_Schedule values('Rick','General_Ward',oriDate+6);
		insert into Dr_Schedule values('James','Screening_Ward',oriDate+6);
		insert into Dr_Schedule values('Robert','Pre_Surgery_Ward',oriDate+6);
		insert into Dr_Schedule values('Mike','Post_Surgery_Ward',oriDate+6);
		insert into Dr_Schedule values('Adams','Surgery',oriDate+6);
	

		end if;
	
	end loop;
oriDate:=oriDate+7;
end loop;
insert into Dr_Schedule values('James','General_Ward',oriDate);
insert into Dr_Schedule values('Robert','Screening_Ward',oriDate);
insert into Dr_Schedule values('Mike','Pre_Surgery_Ward',oriDate);
insert into Dr_Schedule values('Adams','Post_Surgery_Ward',oriDate);
insert into Dr_Schedule values('Tracey','Surgery',oriDate);

end;
/

--create a procedure that populate the Surgeon_Schedule table
create or replace procedure pop_Surgeon_Schedule

is

oriDate date:='01/01/2005';

begin


for w in 1 .. 52 loop

	for d in 0 .. 6 loop
		
		if d=0
		then
		insert into Surgeon_Schedule values('Dr.Richards',oriDate);
		insert into Surgeon_Schedule values('Dr.Gower',oriDate);
		insert into Surgeon_Schedule values('Dr.Rutherford',oriDate);
		elsif d=1
		then
		insert into Surgeon_Schedule values('Dr.Smith',oriDate+1);
		insert into Surgeon_Schedule values('Dr.Charles',oriDate+1);
		insert into Surgeon_Schedule values('Dr.Taylor',oriDate+1);
		
		elsif d=2
		then
		insert into Surgeon_Schedule values('Dr.Smith',oriDate+2);
		insert into Surgeon_Schedule values('Dr.Charles',oriDate+2);
		insert into Surgeon_Schedule values('Dr.Taylor',oriDate+2);
		
		elsif d=3
		then
		insert into Surgeon_Schedule values('Dr.Richards',oriDate+3);
		insert into Surgeon_Schedule values('Dr.Gower',oriDate+3);
		insert into Surgeon_Schedule values('Dr.Rutherford',oriDate+3);
		elsif d=4
		then
		insert into Surgeon_Schedule values('Dr.Richards',oriDate+4);
		insert into Surgeon_Schedule values('Dr.Gower',oriDate+4);
		insert into Surgeon_Schedule values('Dr.Rutherford',oriDate+4);
		elsif d=5
		then
		insert into Surgeon_Schedule values('Dr.Smith',oriDate+5);
		insert into Surgeon_Schedule values('Dr.Charles',oriDate+5);
		insert into Surgeon_Schedule values('Dr.Taylor',oriDate+5);
		elsif d=6
		then
		insert into Surgeon_Schedule values('Dr.Richards',oriDate+6);
		insert into Surgeon_Schedule values('Dr.Gower',oriDate+6);
		insert into Surgeon_Schedule values('Dr.Rutherford',oriDate+6);

		end if;
	
	end loop;
oriDate:=oriDate+7;
end loop;

insert into Surgeon_Schedule values('Dr.Richards',oriDate);
insert into Surgeon_Schedule values('Dr.Gower',oriDate);
insert into Surgeon_Schedule values('Dr.Rutherford',oriDate);
end;
/


-- create trigger #1 trg_gen
create or replace trigger trg_gen
after insert on General_Ward 
for each row

declare
--pName varchar2(30);
a1 number;
a2 number;
bNum number;
d1 date;
d2 date;
d3 date;

begin
	select MAX(S_Admission_Date) into d3
	from Screening_Ward;

	if d3<:new.G_Admission_Date+3 or d3 is null
	then d3:=:new.G_Admission_Date+3;
	end if;
	
	begin
	with preT as (select Patient_Name, Pre_Admission_Date+2, Patient_Type from Pre_Surgery_Ward)
	select COUNT(*), MIN(d1) into a1, d1
	from	(
		(select p.Patient_Name, p.Post_Admission_Date as d1, p.Patient_Type
		from Post_Surgery_Ward p)
		minus
		(select *
		from preT))
	where d1> d3;
	exception
	when no_data_found then
	d1:=null;
	end;
	

	begin
	select COUNT(*), MIN(p.Pre_Admission_Date) into a2, d2
	from Pre_Surgery_Ward p
	where p.Pre_Admission_Date>d3;
	exception
	when no_data_found then
	d2:=null;
	end;
	

	if a1+a2<5--not full
	then
	bNum:=find_bNum_trg1(d3);
	insert into Screening_Ward values(:new.Patient_Name, d3, bNum, :new.Patient_Type);
	elsif a1+a2>=5--full
	then
		if d1>d2 or d1 is null
		then
		bNum:=find_bNum_trg1(d2);
		
		insert into Screening_Ward values(:new.Patient_Name, d2, bNum, :new.Patient_Type);

		elsif d2>=d1 or d2 is null
		then
		bNum:=find_bNum_trg1(d1);
		
		insert into Screening_Ward values(:new.Patient_Name, d1, bNum, :new.Patient_Type);
		
		
		end if;
	end if;

	

end;
/


--create trigger #2 trg_scr
create or replace trigger trg_scr
after insert on Screening_Ward
for each row

declare 

a1 number;
a2 number;
a3 number;
a4 number:=0;
a5 number;
d1 date;
d2 date;
d3 date;


begin
	select MAX(Pre_Admission_Date) into d3
	from Pre_Surgery_Ward;
	if d3<:new.S_Admission_Date+3 or d3 is null
	then d3:=:new.S_Admission_Date+3;
	end if;

	select COUNT(*), MIN(p.Post_Admission_Date) into a1,d2
	from Post_Surgery_Ward p
	where p.Post_Admission_Date> d3;
	
	declare
	cursor cur1 is
	select p1.Pdate, p1.Temperature, p1.BP
	from Patient_Chart p1
	where p1.Pdate<=d2 
	and p1.Pdate> =:new.S_Admission_Date 
	and p1.Patient_Name= :new.Patient_Name
	order by p1.Pdate;

	begin
	open cur1;
	loop
	fetch cur1 into d1,a2,a3;
	exit when cur1%notfound or a4=4;	
	if a2>=97 and a2<=100 and a3>=110 and a3<=140
	then	
	a4:=a4+1;
	else
	a4:=0;

	end if;
	end loop;
	close cur1;
	end;

	
	if a1=4 and a4<4
	then 
	a5:= find_bNum_trg2(d2);	
	insert into Pre_Surgery_Ward values (:new.Patient_Name,d2,a5,:new.Patient_Type);
	elsif a1=4 and a4=4
	then insert into Post_Surgery_Ward values (:new.Patient_Name,d1,null,1,:new.Patient_Type);
	elsif a1<4
	then
	a5:=find_bNum_trg2(d3);
	insert into Pre_Surgery_Ward values (:new.Patient_Name,d3,a5,:new.Patient_Type);

	end if;
	


end;
/


--create trigger #3 trg_post
create or replace trigger trg_post
before insert on Post_Surgery_Ward
for each row

declare
a1 number;
a2 number;
a3 number:=0;
a4 number;
a5 number:=0;
pName varchar2(30);
pName2 varchar2(30);


cursor cur1 is
	select p.Patient_Name, p.Temperature, p.BP
	from Patient_Chart p
	where p.Patient_Name=:new.Patient_Name
	and p.Pdate<:new.Post_Admission_Date+2 
	and p.Pdate>=:new.Post_Admission_Date;

cursor cur2 is
	select p.Patient_Name, p.BP
	from Patient_Chart p
	where p.Patient_Name=:new.Patient_Name
	and p.Pdate<:new.Post_Admission_Date+2 
	and p.Pdate>=:new.Post_Admission_Date ;

oriDate date :=:new.Post_Admission_Date;

begin

open cur1;
loop
fetch cur1 into pName, a1, a2;
exit when cur1%notfound;
if a1>=97 and a1<=100 and a2>110 and a2<=140
then a3:=a3+1;

end if;
end loop;
close cur1;


open cur2;
loop
fetch cur2 into pName2, a4;
exit when cur2%notfound;
if a4>=110 and a4<=140
then a5:=a5+1;

end if;
end loop;
close cur2;


	if :new.Patient_Type='General'
	then 
	:new.Discharge_Date:=oriDate+2;

	elsif :new.Patient_Type='Neuro'
	then
		if a3=2
		then
		:new.Discharge_Date:=oriDate+2;

		elsif a3<2
		then
		:new.Discharge_Date:=oriDate+4;
		:new.Scount:=2;

		
		end if;
	elsif :new.Patient_Type='Cardiac'
	then
		if a5=2
		then
		:new.Discharge_Date:=:new.Post_Admission_Date+2;
	
		elsif a5<2
		then
		:new.Discharge_Date:=:new.Post_Admission_Date+4;
		:new.Scount:=2;
		

		end if;
	end if;
end;
/


-- trigger trg-pre
create or replace trigger trg_pre
after insert on pre_surgery_ward
for each row

begin
	insert into post_surgery_ward values (:new.Patient_Name, :new.Pre_Admission_Date+2,NULL,1,:new.Patient_Type);

END;
/


--create function find_bNum_trg1
create or replace function find_bNum_trg1
(oriDate in date)
return number

is

Type bArray is varray(5) of number;

bNum bArray;

cursor cur1 is 
	
	with preT as (select Patient_Name, Pre_Admission_Date+2, Patient_Type from Pre_Surgery_Ward)
	select a.pName
	from	((select p.Patient_Name as pName, p.Post_Admission_Date as d1, P.Patient_Type
		 from Post_Surgery_Ward p)	
	  	 minus
		(select *
		from preT))a
	where a.d1> oriDate
	union
	select p1.Patient_Name
	from Pre_Surgery_Ward p1
	where p1.Pre_Admission_Date>oriDate;

pName1 varchar2(30);
a1 number;
bNum2 number;



begin
bNum:=bArray(1,2,3,4,5);
a1:=1;

open cur1;

loop 
	fetch cur1 into pName1;
	exit when cur1%notfound;
	select Bed_No into bNum2
	from Screening_Ward
	where Patient_Name=pName1 
	and S_Admission_Date=(select MAX(S_Admission_Date) 
			      from Screening_Ward 
			      where Patient_Name=pName1);
	bNum(bNum2):=0;
end loop;
close cur1;

loop
exit when bNum(a1)!=0;
a1:=a1+1;
end loop;

return bNum(a1);

	
end;
/


--create function find_bNum_trg2
create or replace function find_bNum_trg2
(oriDate2 in date)
return number

is

Type bArray2 is varray(4) of number;

bNum2 bArray2;

cursor cur2 is 
	
	select p.Patient_Name
	from Post_Surgery_Ward p
	where p.Post_Admission_Date>oriDate2;

pName2 varchar2(30);
a2 number;
bNum4 number;



begin
bNum2:=bArray2(1,2,3,4);
a2:=1;

open cur2;

loop 
	fetch cur2 into pName2;
	exit when cur2%notfound;
	select Bed_No into bNum4
	from Pre_Surgery_Ward
	where Patient_Name=pName2 
	and Pre_Admission_Date=(select MAX(Pre_Admission_Date) 
				from Pre_Surgery_Ward 
				where Patient_Name=pName2);
	bNum2(bNum4):=0;
end loop;
close cur2;

loop
exit when bNum2(a2)!=0;
a2:=a2+1;
end loop;

return bNum2(a2);

	
end;
/





--create function verify schedule

create or replace function fun_verSched
return number 
is valid number;
a1 number;
a2 number;
a3 number;
a4 number;
a5 number;
a6 number;
a7 number;
a8 number;
d1 date;


begin

	for d in 1..365 loop
		a1 := MOD( d, 7 );
		d1 := to_date('01/01/2005', 'MM/DD/YYYY') + d;		
	
		for sur1 in (select Name 
			     from Surgeon_Schedule 
			     where Surgery_Date = d1)
		loop
			if (sur1.Name = 'Dr.Gower' or sur1.Name = 'Dr.Charles' ) then
			a3 := 1;
			end if;
			if (sur1.Name = 'Dr.Rutherford' or sur1.Name = 'Dr.Taylor') then
			a4 := 1;
			end if;
		end loop;
		if (a3 = 0) then
		dbms_output.put_line('The schedule of surgeon is not available, Cardiac surgeon is not available on '|| d1);
		return(a3);
		end if;
		if (a4 = 0) then
		dbms_output.put_line('The schedule of surgeon is not available, Neuro surgeon is not available on '|| d1);
		return(a4);
		end if;

		select COUNT(Name) into a6 
		from Dr_Schedule 
		where Duty_Date = d1 
		and Ward = 'General_Ward';

		if (a6 != 1) then
		dbms_output.put_line('The schedule of doctor is not available, General_Ward is not available on '|| d1);
		return(0);
		end if;

		select COUNT(Name) into a6 
		from Dr_Schedule 
		where Duty_Date = d1 
		and Ward = 'Screening_Ward';

		if (a6 != 1) then
		dbms_output.put_line('The schedule of doctor is not available, Screening_Ward is not available on '|| d1);
		return(0);
		end if;

		select COUNT(Name) into a6 
		from Dr_Schedule 
		where Duty_Date = d1 
		and Ward = 'Pre_Surgery_Ward';

		if (a6 != 1) then
		dbms_output.put_line('The schedule of doctor is not available, Pre_Surgery_Ward is not available on '|| d1);
		return(0);
		end if;

		select COUNT(Name) into a6 
		from Dr_Schedule 
		where Duty_Date = d1 
		and Ward = 'Post_Surgery_Ward';

		if (a6 != 1) then
		dbms_output.put_line('The schedule of doctor is not available, Post_Surgery_Ward is not available on '|| d1);
		return(0);
		end if;
		
	end loop;
		
		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01/01/2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01/07/2005', 'MM/DD/YYYY') 
		and Name = 'James';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, James is not available on 6 days of a week ');
		return(0);
		end if;

		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01-01-2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01-07-2005', 'MM/DD/YYYY') 
		and Name = 'Robert';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, Robert is not available on 6 days of a week');
		return(0);
		end if;

		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01-01-2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01-07-2005', 'MM/DD/YYYY') 
		and Name = 'Mike';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, Mike is not available on 6 days of a week');
		return(0);
		end if;

		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01-01-2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01-07-2005', 'MM/DD/YYYY') 
		and Name = 'Adams';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, Adams is not available on 6 days of a week');
		return(0);
		end if;

		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01-01-2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01-07-2005', 'MM/DD/YYYY') 
		and Name = 'Tracey';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, Tracey is not available on 6 days of a week');
		return(0);
		end if;

		select COUNT(*) into a7 
		from Dr_Schedule 
		where Duty_Date >= to_date('01-01-2005', 'MM/DD/YYYY') 
		and Duty_Date <= to_date('01-07-2005', 'MM/DD/YYYY') 
		and Name = 'Rick';

		if (a7 != 6) then
		dbms_output.put_line('The schedule of doctor is not available, Rick is not available on 6 days of a week');
		return(0);
		end if;

		
		for i in 3..9 loop
		d1 := to_date('01/01/2005', 'MM/DD/YYYY') + i;
		select COUNT(distinct Name) into a8 
		from (select * 
		      from Dr_Schedule 
		      where Ward = 'General_Ward' 
		      and Duty_Date <= d1 
		      and Duty_Date >=d1-2 
		      order by Duty_Date);

		if (a8 = 1) then
		dbms_output.put_line('The schedule of doctor is not available, General_Ward is currently not available.');
		return(0);
		end if;

		select COUNT(distinct Name) into a8 
		from (select * 
		      from Dr_Schedule 
		      where Duty_Date >=d1-2 
		      and Duty_Date <= d1 
 		      and Ward = 'Screening_Ward' 
 		      order by Duty_Date);

		if (a8 = 1) then
		dbms_output.put_line('The schedule of doctor is not available, Screening Ward is currently not available.');
		return(0);
		end if;

		select COUNT(distinct Name) into a8 
		from (select * 
		      from Dr_Schedule 
		      where Duty_Date >=d1-2 
		      and Duty_Date <= d1 
      		      and Ward = 'Pre_Surgery_Ward' 
		      order by Duty_Date);

		if (a8 = 1) then
		dbms_output.put_line('The schedule of doctor is not available, Pre_Surgery_Ward is currently not available.');
		return(0);
		end if;

		select COUNT(distinct Name) into a8 
		from (select * 
	 	      from Dr_Schedule 
		      where Duty_Date >=d1-2 
		      and Duty_Date <= d1 
		      and Ward = 'Post_Surgery_Ward' 
		      order by Duty_Date);

		if (a8 = 1) then
		dbms_output.put_line('The schedule of doctor is not available, Post_Surgery_Ward is currently not available.');
		return(0);
		end if;

		select COUNT(distinct Name) into a8 
		from (select * 
		      from Dr_Schedule 
		      where Duty_Date >=d1-2 
 		      and Duty_Date <= d1 
		      and Ward = 'Surgery' 
		      order by Duty_Date);

		if (a8 = 1) then
		dbms_output.put_line('The schedule of doctor is not available, Surgery is currently not available.');
		return(0);
		end if;


		end loop;

	valid :=1;
return(valid);
end;
/




