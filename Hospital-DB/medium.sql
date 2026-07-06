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

--Q8.Show patient_id, diagnosis from admissions. Find patients admitted multiple times for the same diagnosis.
--Tricky, we have to know how the groupby clause for the two columns work?
select patient_id, diagnosis from admissions group by patient_id, diagnosis having count (*) >1;

--Q9.Show the city and the total number of patients in the city. Order from most to least patients and then by city name ascending
select city, count(patient_id) as num_patients 
from patients group by city order by count(patient_id) desc, city asc; 

--Q10.Show first name, last name and role of every person that is either patient or doctor. The roles are either "Patient" or "Doctor"
select first_name, last_name, 'Patient' as role from patients
union all 
select first_name, last_name, 'Doctor' as role from doctors;

--Q11.

--Q12.

