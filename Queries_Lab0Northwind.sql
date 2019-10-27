/* Q1. Cual es el producto mas vendido en 1996? */
select p.ProductName
from Lab0_NorthwindDB.dbo.Products p
where p.ProductID in 
	(select top 1 with ties od.ProductID
	from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o
	where o.OrderID=od.OrderID and year(o.OrderDate)=1996
	group by od.ProductID
	order by sum(od.Quantity) desc);

/* Q2. Cual es el total de ventas (dinero) en 1996? */
select sum(od.UnitPrice*od.Quantity*(1-od.discount)) as TotalVentas1996
from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o
where od.OrderID = o.OrderID and year(o.OrderDate) = 1996

/* Q3. Cual es el total de ventas(dinero) en 1997? */
select sum(od.UnitPrice*od.Quantity*(1-od.discount)) as TotalVentas1997
from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o
where od.OrderID = o.OrderID and year(o.OrderDate) = 1997

/* Q4. Cual es el total de ventas en todos los a�os incluidos en la DB? */
select sum(od.UnitPrice*od.Quantity*(1-od.discount)) as TotalVentas
from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o
where od.OrderID = o.OrderID

/* Q5. Cual region tuvo mas ventas (dinero) en 1997? */
select top 1 with ties e.region as Region, sum(od.UnitPrice*od.Quantity*(1-od.discount)) as TotalVentas1997
from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o, Lab0_NorthwindDB.dbo.Employees e
where od.OrderID = o.OrderID and o.EmployeeID = e.EmployeeID and year(o.OrderDate) = 1997
group by e.Region
order by sum(od.UnitPrice*od.Quantity*(1-od.discount)) desc;

/* Q6. Para la respuesta de Q5 (region), cual es el estado (si es USA) o pais (region diferente a USA) que mas vendio en 1997? */
select top(1) with ties T.Place as 'Country or USA State', T.Sales
from (
  select e.Region as 'Place', sum(od.UnitPrice*od.Quantity*(1-od.discount)) as 'Sales'
  from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o, Lab0_NorthwindDB.dbo.Employees e
  where od.OrderID = o.OrderID and o.EmployeeID = e.EmployeeID and year(o.OrderDate) = 1997 and e.country = 'USA'
  group by e.Region
  union
  select e.Country as 'Place', sum(od.UnitPrice*od.Quantity*(1-od.discount)) as 'Sales'
  from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o, Lab0_NorthwindDB.dbo.Employees e
  where od.OrderID = o.OrderID and o.EmployeeID = e.EmployeeID and year(o.OrderDate) = 1997 and e.country != 'USA'
  group by e.Country
) as T
order by T.Sales desc

/* Q7. Cual es el total de ventas en total (todos los a�os) organizado por Region, Estado y/o pais? */
select e.region as Region, sum(od.UnitPrice*od.Quantity*(1-od.discount)) as TotalVentas
from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o, Lab0_NorthwindDB.dbo.Employees e
where od.OrderID = o.OrderID and o.EmployeeID = e.EmployeeID
group by e.Region
