/* Q1. Cual es el producto mas vendido en 1996? */
select P.ProductName
from DWNorthwind.dbo.DimProduct P
where P.ProductID IN (
	select top 1 with ties F.ProductID
	from  DWNorthwind.dbo.FactSales F
	where year(F.orderDate) = 1996
	group by F.ProductID
	order by sum(F.Quantity) desc
);

/* Q2. Cual es el total de ventas (dinero) en 1996? */
select sum(F.total) as TotalVentas1996
from DWNorthwind.dbo.FactSales F
where year(F.orderDate) = 1996

/* Q3. Cual es el total de ventas(dinero) en 1997? */
select sum(F.total) as TotalVentas1997
from DWNorthwind.dbo.FactSales F
where year(F.orderDate) = 1997

/* Q4. Cual es el total de ventas en todos los a�os incluidos en la DB? */
select sum(F.total) as TotalVentas
from DWNorthwind.dbo.FactSales F

/* Q5. Cual region tuvo mas ventas (dinero) en 1997? */
select top(1) E.Region, sum(F.Total) as 'Sales'
from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997
group by E.Region
order by [Sales] desc;

/* Q6. Para la respuesta de Q5 (region), cual es el estado (si es USA) o pais (region diferente a USA) que mas vendio en 1997? */
-- Opcion 1
declare @country varchar(15);
select top(1) @country=T.Country
from (select top(1) E.Country, E.Region 
  from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
  where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997
  group by E.Country, E.Region
  order by sum(F.total) desc) as T;

if @country = 'USA'
begin
  select top(1) E.Region, sum(F.Total) as 'Sales'
  from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
  where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997
  group by E.Region
  order by [Sales] desc;
end
else
begin
  select top(1) E.Country, sum(F.Total) as 'Sales'
  from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
  where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997
  group by E.Country
  order by [Sales] desc;
end

-- Opcion 2
select top(1) T.Places as 'Country or USA State', T.Sales
from (
  select top(1) E.Region as 'Places', sum(F.Total) as 'Sales'
  from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
  where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997 and E.country = 'USA'
  group by E.Region
  order by [Sales] desc
  union
  select top(1) E.Country as 'Places', sum(F.Total) as 'Sales'
  from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
  where E.EmployeeID = F.EmployeeID and year(F.OrderDate) = 1997 and E.Country != 'USA'
  group by E.Country
  order by [Sales] desc
) as T


/* Q7. Cual es el total de ventas en total (todos los a�os) organizado por Region, Estado y/o pais? */

--Ventas por pais
select E.Country, sum(F.Total) as 'Sales'
from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
where E.EmployeeID = F.EmployeeID
group by E.Country
union
--Ventas por region/estado
select E.Region, sum(F.Total) as 'Sales'
from DWNorthwind.dbo.DimEmployee E, DWNorthwind.dbo.FactSales F
where E.EmployeeID = F.EmployeeID
group by E.Region
