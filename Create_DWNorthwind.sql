create database DWNorthwind

go

use DWNorthwind

create table DimCustomer (
	CustomerID char(5),
	CustomerName varchar (30),
	City varchar (15),
	Country varchar (15),
	Region varchar (15),
	primary key (CustomerID)
);

create table DimEmployee (
	EmployeeID int,
	Name varchar (30),
	City varchar (15),
	Country varchar (15),
	Region varchar (15),
	hiredate datetime,
	primary key (EmployeeID)
);

Create table DimTime (
	orderDate Datetime,
	primary key (orderDate)
);

create table DimProduct (
	ProductID int,
	ProductName varchar (40),
	categoryName varchar (15),
	supplierName varchar (30),
	pAddress varchar (60),
	city varchar (15),
	region varchar (15),
	postalCode varchar (10),
	country varchar (15),
	primary key (productID),
);

create table FactSales (
	ProductID int ,
	EmployeeID int ,
	CustomerID char(5) ,
	orderDate datetime ,
	OrderID int,
	Quantity smallint,
	unitPrice money,
	discountPercent real,
	discountAmount money,
	total money,
	primary key (ProductID, EmployeeID, CustomerID, orderDate),
	foreign key (ProductID) references dbo.DimProduct(productID),
	foreign key (EmployeeID) references dbo.DimEmployee(employeeID),
	foreign key (CustomerID) references dbo.DimCustomer(CustomerID),
	foreign key (orderDate) references dbo.DimTime(orderDate)
);

