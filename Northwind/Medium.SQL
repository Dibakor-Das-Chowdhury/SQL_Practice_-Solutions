--Q1.Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table
SELECT
  products.product_name,
  suppliers.company_name,
  categories.category_name
FROM categories
  join products on categories.category_id = products.category_id
  join suppliers on products.supplier_id = suppliers.supplier_id

--Q2.Show the category_name and the average product unit price for each category rounded to 2 decimal places.
select
  categories.category_name,
  round (avg(products.unit_price), 2)
from categories
  join products on categories.category_id = products.category_id
group by categories.category_name;

--Q3.Show the total amount of orders for each year/month.

