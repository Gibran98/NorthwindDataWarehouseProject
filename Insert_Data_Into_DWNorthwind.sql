/* Ajuste de regiones en la base de datos e Suppliers, Employees y customers (que son los necesarios para la warehouse) */
update Lab0_NorthwindDB.dbo.Suppliers
set Region = 'Europe'
where Region is null and Country in ('Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Spain', 'Sweden', 'UK');

update Lab0_NorthwindDB.dbo.Suppliers
set Region = 'Asia'
where Region is null and Country in ('Japan', 'Singapore');

update Lab0_NorthwindDB.dbo.Suppliers
set Region = 'South America'
where Region is null and Country in ('Brazil');

update Lab0_NorthwindDB.dbo.Employees
set Region = 'Europe'
where Region is null and Country in ('Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Spain', 'Sweden', 'UK');

update Lab0_NorthwindDB.dbo.Customers
set Region = 'Europe'
where Region is null and Country in ('Denmark', 'Finland', 'France', 'Germany', 'Italy', 'Netherlands', 'Norway', 'Spain', 'Sweden', 'UK', 'Austria', 'Belgium', 'Poland', 'Portugal', 'Switzerland');

update Lab0_NorthwindDB.dbo.Customers
set Region = 'South America'
where Region is null and Country in ('Brazil', 'Argentina');

update Lab0_NorthwindDB.dbo.Customers
set Region = 'North America'
where Region is null and Country in ('Mexico');

/* Insertar datos a DimTime de Orders */
Insert into DWNorthwind.dbo.DimTime
	select distinct o.OrderDate
	from Lab0_NorthwindDB.dbo.Orders o;

/* Insertar datos a dimEmployee de Employee */
Insert into DWNorthwind.dbo.DimEmployee
	select e.EmployeeID, (e.FirstName + ' ' + e.LastName) as Name, e.City, e.Country, e.Region, e.HireDate
	from Lab0_NorthwindDB.dbo.Employees e;
	
/* Insertar datos a dimCustomer de Customer */
Insert into DWNorthwind.dbo.DimCustomer
	select c.CustomerID, c.ContactName, c.City, c.Country, c.Region
	from Lab0_NorthwindDB.dbo.Customers c;

/* Insertar datos a dimProduct de Products + Suppliers + Categories */ 
Insert into DWNorthwind.dbo.DimProduct
	select p.ProductID, p.ProductName, c.CategoryName, s.ContactName, s.Address, s.City, s.Region, s.PostalCode, s.Country
	from Lab0_NorthwindDB.dbo.Products p, Lab0_NorthwindDB.dbo.Suppliers s, Lab0_NorthwindDB.dbo.Categories c
	where p.CategoryID = c.CategoryID and p.SupplierID = s.SupplierID;

/* Insertar datos a factsTable juntando todas las dimensiones */
Insert into DWNorthwind.dbo.FactSales
select od.ProductID, o.EmployeeID, o.CustomerID, o.OrderDate , 
o.orderID, od.quantity, od.unitPrice, 
od.discount, 
od.unitPrice * od.quantity * od.discount as discountAmount, 
od.unitPrice * od.quantity * (1 - od.discount) as total 
from Lab0_NorthwindDB.dbo.Orders o, Lab0_NorthwindDB.dbo.[Order Details] od 
where o.OrderID = od.OrderID;
