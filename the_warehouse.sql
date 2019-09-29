CREATE TABLE Warehouses (
  Code INTEGER PRIMARY KEY NOT NULL,
  Location TEXT NOT NULL ,
  Capacity INTEGER NOT NULL
);

CREATE TABLE Boxes (
  Code TEXT PRIMARY KEY NOT NULL,
  Contents TEXT NOT NULL ,
  Value REAL NOT NULL ,
  Warehouse INTEGER NOT NULL,
  CONSTRAINT fk_Warehouses_Code FOREIGN KEY (Warehouse) REFERENCES Warehouses(Code)
);

INSERT INTO Warehouses(Code,Location,Capacity) VALUES(1,'Chicago',3);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(2,'Chicago',4);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(3,'New York',7);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(4,'Los Angeles',2);
INSERT INTO Warehouses(Code,Location,Capacity) VALUES(5,'San Francisco',8);

INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('0MN7','Rocks',180,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4H8P','Rocks',250,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('4RT3','Scissors',190,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('7G3H','Rocks',200,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8JN6','Papers',75,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('8Y6U','Papers',50,3);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('9J6F','Papers',175,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('LL08','Rocks',140,4);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P0H6','Scissors',125,1);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('P2T6','Scissors',150,2);
INSERT INTO Boxes(Code,Contents,Value,Warehouse) VALUES('TU55','Papers',90,5);


-- 1. Select all warehouses.

select * from Warehouses;

-- 2. Select all boxes with a value larger than $150.

select * from Boxes
wehere value > 150;

-- 3. Select all distinct contents in all the boxes.

select distinct * from Boxes;

-- 4. Select the average value of all the boxes.

select avg(Value) from Boxes;

-- 5. Select the warehouse code and the average value of the boxes in each warehouse.

select warehouse, avg(values)
from Boxes
group by 1;

-- 6. Same as previous exercise, but select only those warehouses where the average value of the boxes is greater than 150.

Select warehouse, avg(values)
from boxes
group by 1
having avg(values) > 150;

-- 7. Select the code of each box, along with the name of the city the box is located in.

select b.code, w.Location
from Boxes b
inner join warehouses w on b.warehouse = w.code;

-- 8. Select the warehouse codes, along with the number of boxes in each warehouse. Optionally, take into account that some warehouses are empty (i.e., the box count should show up as zero, instead of omitting the warehouse from the result).

select warehouse, count(*)
from boxes
group by warehouse;

--considering empty warehouses
select w.code, count(b.code)
from Warehouses w
left join boxes b on w.code = b.warehouses
group by 1;

-- 9. Select the codes of all warehouses that are saturated (a warehouse is saturated if the number of boxes in it is larger than the warehouse's capacity).

select w.code
from warehouses w
where capacity < (
  select count(*) from boxes where warehouse = w.code
);

select w.code
from warehouses w
join boxes b on w.code = b.warehouse
group by w.code
having count(b.code) > w.capacity;


-- 10. Select the codes of all the boxes located in Chicago.

select b.code from boxes b
inner join warehouses w on b.warehouse = c.code
where w.location = 'Chicago'

-- 11. Create a new warehouse in New York with a capacity for 3 boxes.

insert into warehouse(location, capacity)
  values ('New York', 3);

-- 12. Create a new box, with code "H5RT", containing "Papers" with a value of $200, and located in warehouse 2.

insert into boxes
  values('H5RT', 'Papers', 200, 2);

-- 13. Reduce the value of all boxes by 15%.

update boxes
  set value = value * 0.85;

-- 14. Apply a 20% value reduction to boxes with a value larger than the average value of all the boxes.
--
-- Attention: this solution doesn't work with MySQL 5.0.67: ERROR 1093 (HY000): You can't specify target table 'Boxes' for update in FROM clause

update Boxes
  set value = value * 0.8
  where value > (select avg(value) from (select * from boxes) as x);

-- 15. Remove all boxes with a value lower than $100.

delete Boxes
  where value < 100;

-- 16. Remove all boxes from saturated warehouses.
--
-- Attention: this solution doesn't work with MySQL 5.0.67: ERROR 1093 (HY000): You can't specify target table 'Boxes' for update in FROM clause

delete from boxes where warehouse in (
  select code from warehouses w
  where capacity < (select count(*) from boxes b where b.warehouse = w.code)
);
