/* Q1. Cual es el producto mas vendido en 1996? */
select p.ProductName
from Lab0_NorthwindDB.dbo.Products p
where p.ProductID in 
	(select top 1 with ties od.ProductID
	from Lab0_NorthwindDB.dbo.[Order Details] od, Lab0_NorthwindDB.dbo.Orders o
	where o.OrderID=od.OrderID and year(o.OrderDate)=1996
	group by od.ProductID
	order by count(od.ProductID) desc);

/* Q2. Cual es el total de ventas (dinero) en 1996? */


/* Q3. Cual es el total de ventas(dinero) en 1997? */


/* Q4. Cual es el total de ventas en todos los años incluidos en la DB? */


/* Q5. Cual region tuvo mas ventas (dinero) en 1997? */


/* Q6. Para la respuesta de Q5 (region), cual es el estado (si es USA) o pais (region diferente a USA) que mas vendio en 1997? */


/* Q7. Cual es el total de ventas en total (todos los años) organizado por Region, Estado y/o pais? */