--Show the ProductName, CompanyName, CategoryName from the products, suppliers, and categories table

SELECT
  products.product_name,
  suppliers.company_name,
  categories.category_name
FROM categories
  join products on categories.category_id = products.category_id
  join suppliers on products.supplier_id = suppliers.supplier_id
