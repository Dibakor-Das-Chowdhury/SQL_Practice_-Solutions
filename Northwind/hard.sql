--Q1. Show the employee's first_name and last_name, a "num_orders" column with a count of the orders taken, and a column called "Shipped" that displays "On Time" if the order shipped_date is less or equal to the required_date, "Late" if the order shipped late, "Not Shipped" if shipped_date is null.
--Order by employee last_name, then by first_name, and then descending by number of orders.

select
  employees.first_name,
  employees.last_name,
  count(*) as Num_orders,
  case
    when orders.shipped_date is null then 'Not shipped'
    when orders.shipped_date <= orders.required_date then 'On time'
    else 'Late'
  end as shipped
from employees
  join orders on employees.employee_id = orders.employee_id
group by
  employees.first_name,
  employees.last_name,
  employees.employee_id,
  shipped
order by
  employees.last_name asc,
  employees.first_name asc,
  Num_orders desc;
