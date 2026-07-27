--Q1. Show the provinces that has more patients identified as 'M' than 'F'. Must only show full province_name

select province_names.province_name
from patients
  join province_names on patients.province_id = province_names.province_id
group by province_names.province_name
having
  count(
    case
      when patients.gender = 'M' then 1
    end
  ) > count (
    case when patients.gender = 'F' then 1
    end
  );
