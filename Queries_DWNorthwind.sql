/* Q1. Cual es el producto mas vendido en 1996? */
select P.ProductName
from DWNorthwind.dbo.DimProduct P
where P.ProductID IN (
	select top 1 with ties F.ProductID
	from  DWNorthwind.dbo.FactSales F
	where year(F.orderDate) = 1996
	group by F.ProductID
	order by count(F.ProductID) desc
);

/* Q2. Cual es el total de ventas (dinero) en 1996? */
select sum(F.total)
from DWNorthwind.dbo.FactSales F
where year(F.orderDate) = 1996

/* Q3. Cual es el total de ventas(dinero) en 1997? */
select sum(F.total)
from DWNorthwind.dbo.FactSales F
where year(F.orderDate) = 1997

/* Q4. Cual es el total de ventas en todos los a�os incluidos en la DB? */
select sum(F.total)
from DWNorthwind.dbo.FactSales F

/* Q5. Cual region tuvo mas ventas (dinero) en 1997? */


/* Q6. Para la respuesta de Q5 (region), cual es el estado (si es USA) o pais (region diferente a USA) que mas vendio en 1997? */


/* Q7. Cual es el total de ventas en total (todos los a�os) organizado por Region, Estado y/o pais? */