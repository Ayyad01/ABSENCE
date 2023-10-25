use ABSENCE
select ID 
from ABSENCE..Absenteeism_at_work
group by ID
having COUNT(*) > 1;
-- So I don't  have replicates in the Primary key of the data I provided
select * from ABSENCE..Absenteeism_at_work
where ISNULL(ID,ID) = '';
-- i  DON'T HAVE NULL VALUES AS I  KNOW  FROM THE  BEGINGING
--checking the tables in the  database  I have 
select  * from ABSENCE..Reasons
where Reason = '';
--I don't have null values here too
select  Number 
from ABSENCE..Reasons
group by Number
having COUNT(*)> 1;
-- I don't  have replicates  in the  Number column primary  key of the  table 
-- checking  the other  last table  provided from the data I have
select *  from ABSENCE..compensation
where comp_hr = ''; -- Don't have  null values in here
-- checking the  duplicates in the  ID column
select ID 
from ABSENCE..compensation
group by ID
having  COUNT(*) > 1; 
-- I  don't  have replicates here in  the data provided 
                                    -- So let's start our  analysis  on the data of the three tables
--Create join table
select * from ABSENCE..Absenteeism_at_work a
left  join  ABSENCE..compensation b
on a.ID=b.ID
 -- joining  the  reason table too
select * from ABSENCE..Absenteeism_at_work  a
left join ABSENCE..Reasons r
on 
a.Reason_for_absence = r.Number;

--- Find  the  healthist employees for  the  bonus
select * from ABSENCE..Absenteeism_at_work
where Social_drinker = 0 and Social_smoker = 0 
and Body_mass_index < 52 and Absenteeism_time_in_hours < (select AVG(Absenteeism_time_in_hours)  from ABSENCE..Absenteeism_at_work);


--- compensation rate increase for the  non-smokers 
select COUNT(*) as nonsmokersnum from ABSENCE..Absenteeism_at_work
where Social_smoker = 0;
-- Optimizing this query 

--Create join table



 select
 a.ID,
 r.Reason,
 Month_of_absence,
 Body_mass_index,
 case 
 when Body_mass_index < 18.5 then 'UnderWeight'
 when Body_mass_index between 18.5 and 25 then 'Healthy Weight'
 when Body_mass_index between 25 and 30 then 'OverWeight'
 else 'Unkown' end as BMI_Category
 ,
 case 
 when Month_of_absence in (12,1,2) then 'Winter'
 when Month_of_absence in (3,4,5) then 'Spring'
 when Month_of_absence in (6,7,8) then 'Summer'
 when Month_of_absence in (9,10,11) then 'Fall'
 else 'Unkown' end as Season_names,
 Day_of_the_week, Seasons, Age, Work_load_Average_day, Pet, Disciplinary_failure, Absenteeism_time_in_hours, Son, Social_drinker ,Social_smoker , Education ,Transportation_expense
 
 from ABSENCE..Absenteeism_at_work a
 left  join  ABSENCE..compensation b
 on a.ID=b.ID
 left join ABSENCE..Reasons r
 on 
 a.Reason_for_absence = r.Number

