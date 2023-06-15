SELECT TOP (1000) [id]
      ,[date]
      ,[store_nbr]
      ,[item_nbr]
      ,[unit_sales]
      ,[onpromotion]
  FROM [portfolio].[dbo].[sales]

  --- EDA -----------------------------------------------

  --- ON PROMOTION OPTIONS
  SELECT DISTINCT onpromotion
  FROM dbo.sales

  --- SHOW HOW MANY YEARS OF DATA ARE AVAILABLE
  SELECT DISTINCT LEFT(date, 4)
  FROM dbo.sales
  

  --- OUTPUT FOR VISUALIZATION --------------------------
 
  --- FILTER 1 YEAR AND 25 STORES
  SELECT [id]
      ,[date]
      ,[store_nbr]
      ,[item_nbr]
      ,[unit_sales]
  
  INTO sales_rec
  FROM [portfolio].[dbo].[sales]

  WHERE LEFT(date, 4) = 2017
  AND store_nbr <= 25

  --- REPLACE ID
  ALTER TABLE sales_rec 
  DROP COLUMN id;

  ALTER TABLE sales_rec 
  ADD id INT IDENTITY(1,1)


  --- INSERT STORES AND PRODUCTS INFO
  SELECT sales_rec.id
      ,sales_rec.date
      ,sales_rec.store_nbr
      ,sales_rec.item_nbr
      ,sales_rec.unit_sales

	  ,stores.city
	  ,items.family

  INTO sales_viz
  FROM sales_rec
  
  LEFT JOIN stores on sales_rec.store_nbr = stores.store_nbr
  LEFT JOIN items on sales_rec.item_nbr = items.item_nbr

  ---- CHECK OUTPUT ------------------------------------

  SELECT TOP 50 *
  FROM sales_viz;
  

  --- TOTAL NUMBER OF ROWS
  SELECT FORMAT(COUNT(id),'0,#')
  FROM sales_rec;

  SELECT FORMAT(COUNT(id),'0,#')
  FROM sales_viz;

  --- FAMILIES AND CITIES SALES
  SELECT family,city,
  FORMAT(SUM(unit_sales),'0,#') AS 'sum_sales'

  FROM sales_viz
  
  GROUP BY family,city
  ORDER BY family,sum_sales
