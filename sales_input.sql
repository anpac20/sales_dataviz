
--- SALES
CREATE TABLE sales(
    id nvarchar(20),
    date date,
    store_nbr tinyint,
	item_nbr int,
	unit_sales float,
	onpromotion nvarchar(10)
)

BULK INSERT dbo.sales
 FROM 'C:\Users\neto_\OneDrive\Documentos\Portfolio\SALES\sales.csv'
WITH ( DATAFILETYPE = 'char',
 FIELDTERMINATOR = ',',
 FIRSTROW = 2,
   ROWTERMINATOR = '0x0a')


--- STORES

--- ITEMS