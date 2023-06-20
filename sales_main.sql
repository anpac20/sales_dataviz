SELECT TOP (1000) [id]
      ,[date]
      ,[store_nbr]
      ,[item_nbr]
      ,[unit_sales]
      ,[onpromotion]
  FROM [portfolio].[dbo].[sales]

  --- 1. EDA -----------------------------------------------

  --- 1.1 ON PROMOTION OPTIONS
  SELECT DISTINCT onpromotion
  FROM dbo.sales

  --- 1.2 SHOW HOW MANY YEARS OF DATA ARE AVAILABLE
  SELECT DISTINCT LEFT(date, 4)
  FROM dbo.sales
  

  --- 2. OUTPUT FOR VISUALIZATION --------------------------
 
  --- 2.1 FILTER 1 YEAR AND 10 STORES
  SELECT [id]
      ,[date]
      ,[store_nbr]
      ,[item_nbr]
      ,[unit_sales]
  
  INTO portfolio.dbo.sales_relev
  FROM [portfolio].[dbo].[sales]

  WHERE LEFT(date, 4) = 2017
  AND store_nbr <= 15;

  --- 2.2 REPLACE ID
  ALTER TABLE portfolio.dbo.sales_relev 
  DROP COLUMN id;

  ALTER TABLE portfolio.dbo.sales_relev 
  ADD id INT IDENTITY(1,1);


  --- 2.3 INSERT STORES AND PRODUCTS INFO
  SELECT sales_relev.id
      ,sales_relev.date
      ,sales_relev.store_nbr
      ,sales_relev.item_nbr
      ,sales_relev.unit_sales

	  ,stores.city
	  ,items.family

  INTO portfolio.dbo.sales_report_prod
  FROM portfolio.dbo.sales_relev
  
  LEFT JOIN portfolio.dbo.stores on sales_relev.store_nbr = portfolio.dbo.stores.store_nbr
  LEFT JOIN portfolio.dbo.items on sales_relev.item_nbr = portfolio.dbo.items.item_nbr;


  --- 2.4 GROUP BY CATEGORY (FAMILY) AND CITY

  SELECT date,
    city,
	family,
	SUM(unit_sales) AS sales_vol
	
  INTO portfolio.dbo.sales_report_cat	
  FROM portfolio.dbo.sales_report_prod

  GROUP BY date, city, family

  ORDER BY date, city, family, sales_vol 


  ---- 3. CHECK OUTPUT ------------------------------------

  SELECT TOP 50 *
  FROM portfolio.dbo.sales_report_cat;

  --- 3.1 cities
  SELECT DISTINCT(city)
  FROM portfolio.dbo.sales_report_cat
  

  --- 3.2 TOTAL NUMBER OF ROWS 
 
  SELECT FORMAT(COUNT(id),'0,#')
  FROM portfolio.dbo.sales_report_cat;


