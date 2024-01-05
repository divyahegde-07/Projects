create table Drugs
(ID varchar(5),
Name varchar(15),
Dosage_in_mg numeric(4,0),
Stock_in_1K_packets numeric(4,0),
Storage_Requirement varchar(25),
Shelf_life_in_months numeric(4,0),
Price_per_packet numeric(4,0),
primary key (ID)
);

INSERT INTO Drugs
VALUES
('D001','omeprazole',300,5,'Cold',15),
('D002','Aspirin',600,20,'Room Temperature',24),
('D003','cimetidine',500,25,'Cold',10),
('D004','Acetaminophen',300,22,'Room Temperature',8),
('D005','lansoprazole',400,13,'Cold',6),
('D006','Fluticasone',500,8,'Room Temperature',16),
('D007','bisacodyl',1000,2,'Room Temperature',12),
('D008','Pseudoephedrine',450,14,'Cold',24),
('D009','Pepto Bismol',350,1,'Room Temperature',24),
('D010','Loratadine',275,2,'Room Temperature',10),
('D011','Dramamine',600,0,'Cold',20),
('D012','Prednisone',500,28,'Cold',14),
('D013','triamcinolone',700,15,'Cold',5);


create table Chemicals
(Chemical_Id varchar(5),
Chemical_Name varchar(50),
Quantity_1k numeric(4,0),
Volatility tinyint(1),
Temp_req_in_C numeric(4,0),
Shelf_life_in_months numeric(4,0),
primary key (Chemical_Id)
);

INSERT INTO Chemicals
VALUES
('C001','acetylsalicylic acid',10,0,5,12.5),
('C002','hypromellose',25,0,0,16),
('C003','mannitol',5,0,0,20),
('C004','N-(4-hydroxyphenyl)acetamide',2,1,-20,1),
('C005','povidone',20,0,-15,16.5),
('C006','benzimidazole',10,1,-25,2),
('C007','titanium dioxide',1,0,5,24),
('C008','magnesium carbonate',5,1,-20,0.1),
('C009','polyethylene glycol',15,0,5,20),
('C010', 'hydroxypropyl cellulose',20,0,-10,6),
('C011','fluticasone propylate',25,1,-20,5),
('C012','magnesium stearate',20,1,-25,1),
('C013','Pseudoephedrine hydrochloride',12,0,-10,11),
('C014','Loratadine',23,0,-5,9),
('C015','bismuth subsalicylate',23,0,2,7),
('C016','silicon dioxide',45,1,-10,4),
('C017','prednisolone',1,0,-4,10),
('C018','dimenhydrinate',12,0,0,12),
('C019','lactose',23,0,4,5),
('C020','Glycerin',18,0,-7,18),
('C021','Isopropyl Palmitate',30,0,8,24);


create table Approvals
(Drug_ID varchar(5) PRIMARY KEY,
Drug_Name varchar(15),
Lab_Approval varchar(14),
Legal_Permit varchar(14),
Foreign Key (Drug_ID) REFERENCES Drugs(ID)
ON DELETE CASCADE
);

INSERT INTO Approvals
VALUES
('D001','omeprazole','Yes','Pending'),
('D002','Aspirin','Yes','No'),
('D003','cimetidine','Pending','Pending'),
('D004','Acetaminophen','No','No'),
('D005','lansoprazole','Yes','Yes'),
('D006','Fluticasone','Yes','Yes'),
('D007','bisacodyl','Yes','Yes'),
('D008','Pseudoephedrine','Pending','No'),
('D009','Pepto Bismol','Yes','Yes'),
('D010','Loratadine','No','No'),
('D011','Dramamine','Yes','Pending'),
('D012','Prednisone','Yes','No'),
('D013','triamcinolone','Pending','Pending');


create table Chemical_in_Drug
(Drug_ID varchar(5),
Chemical_Id varchar(15),
Quantity numeric(4,0),
Foreign Key (Drug_ID) REFERENCES Drugs(ID)
ON DELETE CASCADE,
Foreign Key (Chemical_Id) REFERENCES Chemicals(Chemical_Id)
ON DELETE CASCADE,
primary key (Chemical_Id, Drug_ID)
);

INSERT INTO Chemical_in_Drug
VALUES
('D001','C002',1),
('D001','C001',2),
('D001','C009',1),
('D002','C003',2),
('D002','C011',2),
('D003','C001',1),
('D003','C009',1),
('D004','C004',3),
('D004','C007',1),
('D004','C008',1),
('D005','C005',5),
('D005','C001',1),
('D006','C006',1),
('D006','C010',1),
('D006','C011',4),
('D007','C010',1),
('D007','C012',2),
('D008','C012',2),
('D008','C008',3),
('D008','C003',1),
('D009','C001',1),
('D009','C003',1),
('D010','C002',5),
('D010','C004',3),
('D010','C005',2),
('D011','C009',1),
('D011','C002',3),
('D012','C008',2),
('D012','C002',1),
('D013','C007',5),
('D013','C010',1),
('D013','C001',1);


create table Vendor
(Vendor_ID varchar(5),
Name varchar(50),
Location varchar(25),
Permit varchar(5),
Average_shipping_time_in_days numeric(4,0),
primary key (Vendor_ID)
);

INSERT INTO Vendor
VALUES
("V001", "The Chemical Company", "Boston, MA", "Yes", 2),
("V002", "Supply Masters", "Los Angeles, CA", "Yes", 4),
("V003", "Chemicals Everyday", "Boston, MA", "No", 1),
("V004", "PharmaPlus", "New York, NY", "Yes", 2),
("V005", "ChemKing & Co.", "Seattle, WA", "Yes", 5),
("V006", "Chem On Wheels", "Dallas, TX", "Yes",7),
("V007", "Pharma By The Bay", "Miami, FL", "No",3),
("V008", "Evergreen Suppliers Ltd.", "Columbus, OH", "Yes",8),
("V009", "Pick Your Pharma", "Seattle, WA", "Yes",1),
("V010", "Supply It All", "San Jose, CA", "No",2),
("V011", "Chemical Brothers & Co.", "Detroit, MI", "No",7),
("V012", "Supply & Sale", "Chicago, IL", "Yes",4);


create table Distributor
(Distributor_ID varchar(5),
Name varchar(50),
Location varchar(25),
Permit varchar(5),
primary key (Distributor_ID)
);

INSERT INTO Distributor
VALUES
("B001", "CSV", "CA", "Yes"),
("B002", "Discounted Medicines Mart", "NC", "Yes"),
("B003", "Genes Inc.", "NY", "Yes"),
("B004", "MedKing", "AK", "Yes"),
("B005", "MakeMeWell", "MA", "No"),
("B006", "Mediclu Health", "OH", "Yes"),
("B007", "Pharma Goodwill", "MI", "Yes"),
("B008", "Smith and Smooth", "WA", "No"),
("B009", "OneStop Drugs", "CA", "Yes"),
("B010", "Apollo", "TX", "Yes"),
("B011", "Rapid Meds", "FL", "Yes"),
("B012", "Fast Drugs", "CO", "Yes"),
("B013", "FixMe Inc.", "CA", "Yes");


create table Shipper
(Shipper_ID varchar(5),
Name varchar(50),
primary key (Shipper_ID)
);

INSERT INTO Shipper
VALUES
("S001", "FedUp"),
("S002", "FastEx"),
("S003", "Black Rock Shipping"),
("S004", "EasyPort Shipping"),
("S005", "Scotties"),
("S006", "Just Ship It"),
("S007", "The Pirates"),
("S008", "Cooper Shipping"),
("S009", "Giant Shipping"),
("S010", "Shell Logistics");


create table Orders
(ID varchar(5) PRIMARY KEY,
Date DATE,
Total_in_1k$ numeric(4,0),
Recipient_ID varchar(6)
);

INSERT INTO Orders
VALUES
('OD014','2020-08-23',12,'B001'),
('OD024','2020-06-15',10,'B001'),
('OD015','2020-06-20',15,'B002'),
('OD011','2020-07-04',11,'B003'),
('OD027','2020-09-15',8,'B003'),
('OD012','2020-07-21',14,'B004'),
('OD019','2020-05-02',7,'B004'),
('OD017','2020-05-24',8,'B005'),
('OD021','2020-05-18',12,'B005'),
('OD013','2020-05-21',17,'B007'),
('OD026','2020-06-16',9,'B007'),
('OD016','2020-04-12',10,'B008'),
('OD018','2020-04-01',9,'B009'),
('OD023','2020-12-23',15,'B010'),
('OD020','2020-08-12',10,'B011'),
('OD001','2020-04-05',10,'V001'),
('OD006','2020-06-21',3,'V001'),
('OD003','2020-05-21',20,'V002'),
('OD004','2020-06-15',5,'V003'),
('OD010','2020-08-15',7,'V004'),
('OD002','2020-04-12',14,'V005'),
('OD005','2020-06-21',13,'V006'),
('OD007','2020-06-30',10,'V007'),
('OD008','2020-07-04',15,'V008'),
('OD025','2020-11-21',15,'V009'),
('OD009','2020-07-23',25,'V010'),
('OD022','2020-09-15',12,'V012');


create table Vendor_Inventory
(Vendor_ID varchar(5),
Chemical_ID varchar(5),
Price_per_packet numeric(4,0),
foreign key (Vendor_ID) REFERENCES Vendor(Vendor_ID)
ON DELETE CASCADE
);

INSERT INTO Vendor_Inventory
VALUES
("V001", "C002", 3),
("V001", "C020", 5),
("V002", "C009", 2),
("V002", "C011", 1),
("V003", "C005", 5),
("V003", "C009", 2),
("V004", "C001", 6),
("V004", "C006", 5),
("V004", "C012", 4),
("V004", "C019", 4),
("V005", "C003", 4),
("V005", "C004", 10),
("V006", "C007", 7),
("V006", "C008", 10),
("V007", "C001", 7),
("V007", "C003", 2),
("V008", "C007", 8),
("V008", "C010", 8),
("V009", "C014", 7),
("V009", "C015", 9),
("V010", "C014", 9),
("V010", "C017", 3),
("V010", "C020", 4),
("V011", "C008", 11),
("V011", "C013", 3),
("V011", "C016", 3),
("V011", "C018", 1),
("V012", "C001", 6),
("V012", "C002", 3),
("V012", "C021", 3);


create table Ships
(Order_ID varchar(5),
Shipper_ID varchar(5),
ETA_in_days numeric(2,0),
Shipping_charges numeric(3,0),
Tracking_num varchar(6),
foreign key (Shipper_ID) REFERENCES Shipper(Shipper_ID),
foreign key (Order_ID) REFERENCES Orders(ID));

INSERT INTO Ships
VALUES
("OD001", "S002", 8, 5, "T00001"),
("OD002", "S001", 4, 2, "T00002"),
("OD003", "S003", 3, 3, "T00003"),
("OD004", "S004", 3, 4, "T00004"),
("OD005", "S004", 6, 1, "T00005"),
("OD006", "S004", 7, 1, "T00006"),
("OD007", "S005", 12, 1, "T00007"),
("OD008", "S010", 10, 3, "T00008"),
("OD009", "S009", 1, 5, "T00009"),
("OD010", "S008", 2, 2, "T00010"),
("OD011", "S005", 8, 4, "T00011"),
("OD012", "S002", 7, 5, "T00012"),
("OD013", "S001", 3, 6, "T00013"),
("OD014", "S003", 1, 2, "T00014"),
("OD015", "S009", 9, 6, "T00015"),
("OD016", "S007", 6, 7, "T00016"),
("OD017", "S006", 2, 2, "T00017"),
("OD018", "S006", 3, 3, "T00018"),
("OD019", "S010", 5, 2, "T00019"),
("OD020", "S005", 6, 1, "T00020"),
("OD021", "S003", 1, 1, "T00021"),
("OD022", "S010", 12, 1, "T00022"),
("OD023", "S004", 18, 12, "T00023"),
("OD024", "S006", 12, 1, "T00024"),
("OD025", "S003", 3, 1, "T00025"),
("OD026", "S002", 1, 1, "T00026"),
("OD027", "S001", 1, 1, "T00027");


create table Chemicals_in_Order
(Order_ID varchar(5),
Chemical_ID varchar(5),
Quantity_1k_packets numeric(4,0),
Total_price numeric(10,0),
foreign key (Order_ID) REFERENCES Orders(ID)
ON DELETE CASCADE,
foreign key (Chemical_ID) REFERENCES Chemicals(Chemical_ID)
ON DELETE CASCADE
);

INSERT INTO Chemicals_in_Order
VALUES
("OD001", "C002", 20, 60000),
("OD001", "C020", 12, 60000),
("OD006", "C020", 6, 30000),
("OD003", "C011", 10, 10000),
("OD004", "C005", 17, 85000),
("OD004", "C009", 12, 24000),
("OD010", "C006", 10, 50000),
("OD010", "C001", 10, 60000),
("OD010", "C019", 10, 40000),
("OD002", "C004", 15, 150000),
("OD005", "C008", 9, 90000),
("OD007", "C003", 7, 14000),
("OD008", "C007", 5, 40000),
("OD008", "C010", 15, 120000),
("OD005", "C015", 20, 180000),
("OD009", "C020", 12, 40000),
("OD002", "C001", 15, 90000),
("OD002", "C002", 8, 24000),
("OD002", "C021", 12, 36000);


create table Drugs_in_Orders
(Order_ID varchar(5) PRIMARY KEY,
Drugs_ID varchar(5),
Quantity_in_1k$ numeric(4,0),
Total_Price numeric(10,0),
Foreign Key (Order_ID) REFERENCES Orders(ID)
ON DELETE CASCADE,
Foreign Key (Drugs_ID) REFERENCES Drugs(ID)
ON DELETE CASCADE
);

INSERT INTO Drugs_in_Orders
VALUES
('OD014','D004',5,10000),
('OD014','D013',3,36000),
('OD024','D011',12,180000),
('OD015','D002',10,80000),
('OD011','D013',7,84000),
('OD027','D010',1,13000),
('OD012','D006',5,45000),
('OD019','D003',15,150000),
('OD019','D005',2,30000),
('OD019','D008',5,35000),
('OD017','D004',7,14000),
('OD021','D001',3,15000),
('OD013','D005',5,75000),
('OD026','D008',4,28000),
('OD026','D004',6,12000),
('OD026','D003',2,20000),
('OD026','D012',5,45000),
('OD016','D001',2,10000),
('OD016','D012',10,90000),
('OD018','D009',1,1000),
('OD023','D002',6,48000),
('OD020','D012',9,81000);


DELIMITER //
CREATE PROCEDURE get_chemicals_in_drug(
  IN Drug_name varchar(15)
)
BEGIN
SELECT c.Chemical_Id, c.Chemical_Name, c.Stock_1k_packets, cid.Quantity as "Mix in parts"
FROM Drugs AS d
JOIN Chemical_in_Drug AS cid
ON d.ID = cid.Drug_ID
JOIN Chemicals AS c
ON c.Chemical_ID = cid.Chemical_ID
WHERE d.name = Drug_name;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE low_chemical_stock ()
BEGIN
SELECT *
FROM Chemicals
WHERE Stock_1K_packets < 5;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE low_drug_stock (
	IN drug_name varchar(50),
    IN quantity numeric(4,0)
)
BEGIN
SELECT 
CASE
	WHEN(SELECT Stock_in_1K_packets
		 FROM Drugs
		 WHERE Name = drug_name
         LIMIT 1) >= quantity THEN 1
	ELSE 0
END;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE create_order(
  IN orderId varchar(5),
  IN orderDate Date,
  IN totalValue numeric(6,0),
  IN userId varchar(5)
)
BEGIN
INSERT INTO Orders
VALUES
(orderId, orderDate, totalValue, userId);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE push_drugs_in_order(
  IN orderId varchar(5),
  IN drugId varchar(5),
  IN quantity numeric(4,0),
  IN totalprice numeric(10,0)
)
BEGIN
INSERT INTO Drugs_in_Orders
VALUES
(orderId, drugId, quantity, totalprice);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE push_chemicals_in_order(
  IN orderId varchar(5),
  IN chemId varchar(5),
  IN quantity numeric(4,0),
  IN totalprice numeric(10,0)
)
BEGIN
INSERT INTO Chemicals_in_Orders
VALUES
(orderId, chemId, quantity, totalprice);
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_distributor_value(
  IN start_date Date,
  IN end_date Date,
  OUT Sales_Value numeric(5,0)
)
BEGIN
SELECT SUM(o.Total_in_1k$) INTO Sales_Value
FROM Orders AS o
WHERE o.Recipient_ID LIKE "B%" AND o.Date >= start_date AND o.Date <= end_date;
END //
DELIMITER ;


DELIMITER //
CREATE PROCEDURE get_vendor_value(
  IN start_date Date,
  IN end_date Date,
  OUT Purchase_Value numeric(5,0)
)
BEGIN
SELECT SUM(o.Total_in_1k$) INTO Purchase_Value
FROM Orders AS o
WHERE o.Recipient_ID LIKE "V%" AND o.Date >= start_date AND o.Date <= end_date;
END //
DELIMITER ;


CREATE VIEW approvals_for_board AS
SELECT Drug_ID, Drug_Name, Lab_Approval
FROM Approvals
WHERE Legal_Permit IN ('Yes','Pending') ;


CREATE VIEW top_drug_sales AS
SELECT d.ID AS "ID", d.Name AS "Name", dio.Total_Price AS "Order_Price"
FROM Drugs as d
JOIN (SELECT do.Drugs_ID, do.Total_Price
	  FROM Drugs_in_Orders AS do
      ORDER BY Total_Price DESC
      LIMIT 5) as dio
ON dio.Drugs_ID = d.ID;


DELIMITER $$
CREATE FUNCTION get_fastest_vendor (
chemicalName varchar(25)
)
RETURNS varchar(5)
DETERMINISTIC
BEGIN
	declare vendorID varchar(5);

	SELECT  v.Vendor_ID INTO vendorID
    FROM Chemicals as c
    JOIN Vendor_Inventory as VI
    ON VI.Chemical_Id = c.Chemical_Id
    JOIN Vendor as v
    ON VI.Vendor_ID = v.Vendor_ID
    WHERE c.Chemical_Name = chemicalName
    ORDER BY v.Average_Shipping_Time_in_days
    LIMIT 1;

    RETURN vendorID;

END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION get_cheapest_vendor (
chemicalName varchar(25)
)
RETURNS varchar(5)
DETERMINISTIC
BEGIN
	declare vendorID varchar(5);

	SELECT  VI.Vendor_ID INTO vendorID
    FROM Chemicals as c
    JOIN Vendor_Inventory as VI
    ON VI.Chemical_Id = c.Chemical_Id
    WHERE c.Chemical_Name = chemicalName
    ORDER BY VI.Price_per_packet
    LIMIT 1;

    RETURN vendorID;

END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION get_Tracking_details (
orderID varchar(5)
)
RETURNS varchar(100)
DETERMINISTIC
BEGIN
	declare trackingDeets varchar(100);

	SELECT CONCAT('Shipper Name: ', sh.Name, ' ETA in days: ', s.ETA_in_days,' Tracking Number: ',Tracking_num) INTO trackingDeets
    FROM Ships as s
    JOIN Shipper as sh
    ON sh.ID = s.Shipper_ID
    WHERE s.Order_ID = orderID;

    RETURN trackingDeets;

END $$
DELIMITER ;


DELIMITER $$
CREATE FUNCTION get_profits(
start_date Date,
end_date Date
)
RETURNS INT
DETERMINISTIC
BEGIN
	declare profits INT;

  CALL get_distributor_value(start_date, end_date, @sales);
  CALL get_vendor_value(start_date, end_date, @purchase);
  
	SELECT @sales-@purchase INTO profits;
    
  RETURN profits;

END $$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER update_chemical_stock AFTER INSERT ON Chemicals_in_Order 
FOR EACH ROW  
BEGIN  
  UPDATE Chemicals
  SET Stock_1k_packets = Stock_1k_packets + NEW.Quantity_1k_packets
  WHERE Chemicals.Chemical_ID = NEW.Chemical_ID;
END$$
DELIMITER ;


DELIMITER $$
CREATE TRIGGER update_drugs_stock AFTER INSERT ON Drugs_in_Orders
FOR EACH ROW
BEGIN
	UPDATE Drugs
    SET Stock_in_1K_packets = Stock_in_1K_packets - NEW.Quantity_in_1k$
    WHERE ID = NEW.Drugs_ID;
END$$ 
DELIMITER ;