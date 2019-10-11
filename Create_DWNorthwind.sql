create database DWNorthwind

go

use DWNorthwind

create table DimCustomer (
	CustomerID nchar(5),
	CustomerName nvarchar (30),
	City nvarchar (15),
	Country nvarchar (15),
	Region nvarchar (15),
	primary key (CustomerID)
);

create table DimEmployee (
	EmployeeID int,
	Name nvarchar (30),
	City nvarchar (15),
	Country nvarchar (15),
	Region nvarchar (15),
	hiredate datetime,
	primary key (EmployeeID)
);

Create table DimTime (
	orderDate Datetime,
	primary key (orderDate)
);

create table DimProduct (
	ProductID int,
	ProductName nvarchar (40),
	categoryName nvarchar (15),
	supplierName nvarchar (30),
	pAddress nvarchar (60),
	city nvarchar (15),
	region nvarchar (15),
	postalCode nvarchar (10),
	country nvarchar (15),
	primary key (productID),
);

create table FactSales (
	ProductID int ,
	EmployeeID int ,
	CustomerID nchar(5) ,
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

