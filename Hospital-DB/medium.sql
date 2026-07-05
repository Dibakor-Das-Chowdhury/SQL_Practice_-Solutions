--Q1.Show unique birth years from patients and order them by ascending
select distinct year(birth_date) from patients order by year(birth_date) asc;

--Q2.Show unique first names from the patients table that occur only occurs once in the list.
--For example, if two or more people are named 'John' in the first_name column then don't include their name in the output list. If only 1 person is named 'Leo' then include them in the output.
select first_name from patients group by first_name having count(*)=1;

--Q3.Show patient_id and first_name from patients where their first_name start and ends with 's' and is at least 6 characters long.
select patient_id,first_name from patients where first_name like ('s____%s');

--Q4.Show patient_id, first_name, last_name from patients whos diagnosis is 'Dementia'.
--Primary diagnosis is stored in the admissions table.
select
p.patient_id,p.first_name,p.last_name
from patients p 
  inner join admissions ad on p.patient_id = ad.patient_id
where ad.diagnosis = 'Dementia';

--Q5.Display every patient's first_name. Order the list by the length of each name and then by alphabetically.
-- This question is a bit different need to think to solve.
select first_name from patients order by len(first_name), first_name asc;

--Q6.Show the total amount of male patients and the total amount of female patients in the patients table.
--Display the two results in the same row.
--This is a subquery topic
select (select count(*) from patients where gender='M') as male_count, count (*)  from patients where gender='F';

--Q7.Show first and last name, allergies from patients which have allergies to either 'Penicillin' or 'Morphine'. Show results ordered ascending by allergies then by first_name then by last_name.
select first_name,last_name,allergies from patients where allergies in('Penicillin','Morphine') order by allergies,first_name,last_name;

--Q8.
--Q9.
--Q10.
--Q11.
--Q12.

