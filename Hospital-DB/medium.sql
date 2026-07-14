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

--Q11. Show all allergies ordered by popularity. Remove NULL values from query.
select allergies, count (*) as total_diagnosis from patients group by allergies having allergies is not null order by count(*) desc;

--Q12.Show all patients' first_name, last_name, and birth_date who were born in the 1970s decade. Sort the list starting from the earliest birth_date.
select first_name,last_name,birth_date from patients where year(birth_date) between 1970 and 1979 order by birth_date asc;

--Q13.We want to display each patient's full name in a single column. Their last_name in all upper letters must appear first, then first_name in all lower case letters. Separate the last_name and first_name with a comma. Order the list by the first_name in decending order
--EX: SMITH,jane
select concat(upper(last_name),',',lower(first_name)) as new_name_format from patients  order by first_name  desc;

--Q14. Show the province_id(s), sum of height; where the total sum of its patient's height is greater than or equal to 7,000.
select province_id, sum(height) as sum_height from patients group by province_id having sum(height)>=7000;

--Q15.Show the difference between the largest weight and smallest weight for patients with the last name 'Maroni'
select (max(weight)-min(weight)) as weight_delta  from patients where last_name='Maroni';

--Q16.Show all of the days of the month (1-31) and how many admission_dates occurred on that day. Sort by the day with most admissions to least admissions.
select day(admission_date) as day_number, count(*) as number_of_admissions from admissions group by day(admission_date) order by count(*) desc;

--Q17. Show all columns for patient_id 542's most recent admission_date.
select * from admissions group by patient_id having patient_id=542 and admission_date=max(admission_date);

--Q18.Show patient_id, attending_doctor_id, and diagnosis for admissions that match one of the two criteria:
--This is a critical question...so need to think about this questions
-- patient_id is an odd number and attending_doctor_id is either 1, 5, or 19.
-- attending_doctor_id contains a 2 and the length of patient_id is 3 characters.
SELECT
  patient_id,
  attending_doctor_id,
  diagnosis
FROM admissions
where
  (patient_id % 2 !=0
  and attending_doctor_id in ('1', '5', '19'))
  or 
  ( attending_doctor_id like ('%2%') and len(patient_id)=3);

--Q19. Show first_name, last_name, and the total number of admissions attended for each doctor.
--Every admission has been attended by a doctor.
select
  doctors.first_name,
  doctors.last_name,
  count(*)
from admissions
  join doctors on admissions.attending_doctor_id = doctors.doctor_id
group by doctors.doctor_id;

--Q20. For each doctor, display their id, full name, and the first and last admission date they attended.
select
  doctors.doctor_id,
  concat(doctors.first_name, ' ',doctors.last_name),
  min(admissions.admission_date) as first_admission_date,
  max(admissions.admission_date) as last_admission_date
from doctors
  Join admissions on doctors.doctor_id = admissions.attending_doctor_id
group by doctors.doctor_id;

--Q21.Display the total amount of patients for each province. Order by descending.
select
  province_names.province_name as province_name,
  count(patients.patient_id) as patient_count
from patients
  join province_names on patients.province_id = province_names.province_id
group by province_names.province_id
order by count(patients.patient_id) desc;

--Q22.For every admission, display the patient's full name, their admission diagnosis, and their doctor's full name who diagnosed their problem.
select
  concat(
    patients.first_name,
    ' ',
    patients.last_name
  ) as patient_name,
  admissions.diagnosis,
  concat(
    doctors.first_name,
    ' ',
    doctors.last_name
  ) as doctor_name
from patients
  join admissions on patients.patient_id = admissions.patient_id
  join doctors on doctors.doctor_id = admissions.attending_doctor_id;

--Q23. Display the first name, last name and number of duplicate patients based on their first name and last name.
--Ex: A patient with an identical name can be considered a duplicate.
select
  first_name,
  last_name,
  count(*) as num_of_duplicates
from patients
group by
  first_name,
  last_name
  having count(*)>1;

--Q24.Display patient's full name,
--height in the units feet rounded to 1 decimal,
--weight in the unit pounds rounded to 0 decimals,
--birth_date,
--gender non abbreviated.
--Convert CM to feet by dividing by 30.48.
--Convert KG to pounds by multiplying by 2.205.

select
  concat(first_name, ' ', last_name) as first_name,
  round(height / 30.4, 1),
  round(weight * 2.205, 0),
  birth_date,
  case
    when gender = 'M' then 'MALE'
    WHEN gender = 'F' then 'FEMALE'
    else 'No gender found'
  end
from patients;

--Q25.Show patient_id, first_name, last_name from patients whose does not have any records in the admissions table. (Their patient_id does not exist in any admissions.patient_id rows.)
select
  patient_id,
  first_name,
  last_name
from patients
where patient_id not in (
    select patient_id
    from admissions
  );
