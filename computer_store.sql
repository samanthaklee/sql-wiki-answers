INSERT INTO Manufacturers(Code,Name) VALUES(1,'Sony');
INSERT INTO Manufacturers(Code,Name) VALUES(2,'Creative Labs');
INSERT INTO Manufacturers(Code,Name) VALUES(3,'Hewlett-Packard');
INSERT INTO Manufacturers(Code,Name) VALUES(4,'Iomega');
INSERT INTO Manufacturers(Code,Name) VALUES(5,'Fujitsu');
INSERT INTO Manufacturers(Code,Name) VALUES(6,'Winchester');

INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(1,'Hard drive',240,5);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(2,'Memory',120,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(3,'ZIP drive',150,4);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(4,'Floppy disk',5,6);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(5,'Monitor',240,1);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(6,'DVD drive',180,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(7,'CD drive',90,2);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(8,'Printer',270,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(9,'Toner cartridge',66,3);
INSERT INTO Products(Code,Name,Price,Manufacturer) VALUES(10,'DVD burner',180,2);

-- 1. Select the names of all products in the store

Select name from Products;

-- 2. Select the names and the prices of all the products in the store.

select name, prices from products;

-- 3. Select the name of the products with a price less than or equal to $200.

select name from Products
where price <= 200;

-- 4. Select all the products with a price between $60 and $120.

select * from Products
where price between 60 and 120;

-- 5. Select the name and price in cents (i.e., the price must be multiplied by 100).

select name, price * 100 cents
from products;

-- 6. Compute the average price of all the products.

select avg(price) from products;

-- 7. Compute the average price of all products with manufacturer code equal to 2.

select avg(price)
from products p
where manufacturer = 2;

-- 8. Compute the number of products with a price larger than or equal to $180.

select count(*)
from Products
where price >= 180;

-- 9. Select the name and price of all products with a price larger than or equal to $180, and sort first by price (in descending order), and then by name (in ascending order).

select name, price
from products
where price >= 180
order by price desc, name asc;

-- 10. Select all the data from the products, including all the data for each product's manufacturer.

select * from products
inner join manufacturer on products.manufacturer = manufacturer.code;

-- 11. Select the product name, price, and manufacturer name of all the products.

select p.name product_name, price, m.name manufacturer_names
from products p
inner join manufacturer m on p.manufacturer = m.code;

-- 12. Select the average price of each manufacturer's products, showing only the manufacturer's code.

select avg(price), manufacturer
from Products
group by 2;

-- 13. Select the average price of each manufacturer's products, showing the manufacturer's name.

select m.name manufacturer_name, avg(price)
from Products p
left join manufacturer m on p.manufacturer = m.code
group by 1;

-- 14. Select the names of manufacturer whose products have an average price larger than or equal to $150.

select m.name
from Products p
left join manufacturer m on p.manufacturer = manufacturer.code
group by 1
having avg(price) >= 150;

-- 15. Select the name and price of the cheapest product.

select name, price
from products
order by price asc
limit 1;

--also acceptable but will select two if there are duplicates
select name, price
from Products
where price = (select min(price) from products);

-- 16. Select the name of each manufacturer along with the name and price of its most expensive product.

select p.name product_name, p.price, manufacturer.name manufacturer_name
from products
left join manufacturer m on p.manufacturer = m.code
  and p.price = (select max(price) from products p
                where p.manufacturer = m.code);


-- 17. Add a new product: Loudspeakers, $70, manufacturer 2.

insert into products( code, name, price, manufacturer)
  values (11, 'Loudspeakers', 70, 2);

-- 18. Update the name of product 8 to "Laser Printer".

update products
  set name = 'Laser Printer'
  where code = 8;

-- 19. Apply a 10% discount to all products.

update products
  set price = price * 0.9

-- 20. Apply a 10% discount to all products with a price larger than or equal to $120.

update products
  set price = price * 0.9
  where price >= 120
