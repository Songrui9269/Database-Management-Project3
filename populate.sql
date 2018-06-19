rem EE 562 Project 3
rem Songrui Li
rem LI884



alter session set NLS_DATE_FORMAT = 'MM/DD/YYYY';

-- Step #1: populate patient_chart table using a procedure

--1
begin

pop_patient_chart_table('Jackson','01/01/2005');

end;
/
--2
begin

pop_patient_chart_table('Liam','01/19/2005');

end;
/
--3
begin

pop_patient_chart_table('Michael','01/10/2005');

end;
/
--4
begin

pop_patient_chart_table('Bob','02/01/2005');

end;
/
--5
begin

pop_patient_chart_table('John','02/21/2005');

end;
/
--6
begin

pop_patient_chart_table('Ryan','03/17/2005');

end;
/
--7
begin

pop_patient_chart_table('Isaac','03/30/2005');

end;
/
--8
begin

pop_patient_chart_table('Tyler','04/01/2005');

end;
/
--9
begin

pop_patient_chart_table('Alex','04/15/2005');

end;
/
--10
begin

pop_patient_chart_table('Ali','05/05/2005');

end;
/
--11
begin

pop_patient_chart_table('Bob','05/22/2005');

end;
/
--12
begin

pop_patient_chart_table('Jordan','06/09/2005');

end;
/
--13
begin

pop_patient_chart_table('Asher','06/01/2005');

end;
/
--14
--begin

--pop_patient_chart_table('Tryndamere','07/08/2005');

--end;
--/
--15
--begin

--pop_patient_chart_table('Jarvan','08/08/2005');

--end;
--/
--16
--begin

--pop_patient_chart_table('Garen','08/28/2005');

--end;
--/
--17
--begin

--pop_patient_chart_table('Talon','09/09/2005');

--end;
--/
--18
--begin

--pop_patient_chart_table('Sona','09/14/2005');

--end;
--/
--19
--begin

--pop_patient_chart_table('Ahri','09/28/2005');

--end;
--/
--20
--begin

--pop_patient_chart_table('Blitz','10/30/2005');

--end;
--/


--insert data to Patient_Input table
--insert into Patient_Input values('Annie','01/01/2005','Cardiac');
--insert into Patient_Input values('Amumu','02/10/2005','General');
--insert into Patient_Input values('Tristana','01/19/2005','Neuro');
--insert into Patient_Input values('Galio','02/17/2005','General');
--insert into Patient_Input values('Fiora','03/01/2005','Neuro');
--insert into Patient_Input values('Diana','03/21/2005','Cardiac');
--insert into Patient_Input values('Diana','05/03/2005','General');
--insert into Patient_Input values('Riven','04/03/2005','Neuro');
--insert into Patient_Input values('Irelia','04/16/2005','General');
--insert into Patient_Input values('Poppy','05/01/2005','General');
--insert into Patient_Input values('Veigar','05/15/2005','Cardiac');
--insert into Patient_Input values('Vayne','06/02/2005','Cardiac');
--insert into Patient_Input values('Vayne','07/11/2005','Neuro');
--insert into Patient_Input values('Vayne','07/18/2005','General');
--insert into Patient_Input values('Yasuo','06/14/2005','Cardiac');
--insert into Patient_Input values('Zed','06/08/2005','General');
--insert into Patient_Input values('Tryndamere','07/19/2005','Neuro');
--insert into Patient_Input values('Jarvan','09/29/2005','Neuro');
--insert into Patient_Input values('Garen','10/01/2005','Cardiac');
--insert into Patient_Input values('Talon','09/22/2005','General');
--insert into Patient_Input values('Talon','11/04/2005','Cardiac');
--insert into Patient_Input values('Sona','10/26/2005','General');
--insert into Patient_Input values('Ahri','11/02/2005','General');
--insert into Patient_Input values('Blitz','12/11/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Jackson','01/01/2005','General');
INSERT INTO PATIENT_INPUT VALUES ('Liam','01/01/2005','Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Michael','01/01/2005','Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Bob','01/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('John','01/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Ryan','01/01/2005','General');
INSERT INTO PATIENT_INPUT VALUES ('Isaac','01/01/2005','Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Tyler','01/01/2005','Neuro');
INSERT INTO PATIENT_INPUT VALUES ('Alex','01/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Ali','01/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Bob','02/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Bob','04/23/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Bob','05/03/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Jordan','11/01/2005','Cardiac');
INSERT INTO PATIENT_INPUT VALUES ('Asher','11/01/2005','Cardiac');

-- Step #2 Use procedure populate_db to populate the General_Ward table.

exec populate_db

