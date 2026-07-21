--Q1.Show patient_id, first_name, last_name, and attending doctor's specialty.
--Show only the patients who has a diagnosis as 'Epilepsy' and the doctor's first name is 'Lisa'
--Check patients, admissions, and doctors tables for required information.

select
  p.patient_id,
  p.first_name,
  p.last_name,
  d.specialty
from patients p
  join admissions ad on p.patient_id = ad.patient_id
  join doctors d on ad.attending_doctor_id = d.doctor_id
  
  where ad.diagnosis= 'Epilepsy' and d.first_name= 'Lisa' ;
  ;
--Q2. All patients who have gone through admissions, can see their medical documents on our site. Those patients are given a temporary password after their first admission. Show the patient_id and temp_password.
--The password must be the following, in order:
--1. patient_id
--2. the numerical length of patient's last_name
--3. year of patient's birth_date
select distinct
  p.patient_id,
  concat(
    p.patient_id,
    len(p.last_name),
    year(p.birth_date)
  )
from patients p
  join admissions ad on p.patient_id = ad.patient_id;
--Q3.


