-- Database Creation- New Wheels

-- Creating Tables

i) Temp_t

-- This is temp_t table which is designed by importing quartely CSV files of New
Wheels
-- DDL Scripts for Temp_t table
CREATE TABLE TEMP_T
(
SHIPPER_ID INTEGER,
SHIPPER_NAME VARCHAR(50),
SHIPPER_CONTACT_DETAILS VARCHAR(30),
PRODUCT_ID INTEGER,
VEHICLE_MAKER VARCHAR(60),
VEHICLE_MODEL VARCHAR(60),
VEHICLE_COLOR VARCHAR(60),
VEHICLE_MODEL_YEAR INTEGER,
VEHICLE_PRICE DECIMAL(14,2),
ǪUANTITY INTEGER,
DISCOUNT DECIMAL(4,2),
CUSTOMER_ID VARCHAR(25),
CUSTOMER_NAME VARCHAR(25),
GENDER VARCHAR(15),
JOB_TITLE VARCHAR(50),
PHONE_NUMBER VARCHAR(20),
EMAIL_ADDRESS VARCHAR(50),
CITY VARCHAR(25),
COUNTRY VARCHAR(40),
STATE VARCHAR(40),
CUSTOMER_ADDRESS VARCHAR(50),
ORDER_DATE DATE,
ORDER_ID VARCHAR(25),
SHIP_DATE DATE,
SHIP_MODE VARCHAR(25),
SHIPPING VARCHAR(30),
POSTAL_CODE INTEGER,
CREDIT_CARD_TYPE VARCHAR(40),
CREDIT_CARD_NUMBER BIGINT,
CUSTOMER_FEEDBACK VARCHAR(20),
ǪUARTER_NUMBER INTEGER
);

ii) vehicles_t

-- This is main table which is designed by importing fields from temp_t table
-- DDL Scripts for vehicles_t table
CREATE TABLE VEHICLES_T
(
SHIPPER_ID INTEGER,
SHIPPER_NAME VARCHAR(50),
SHIPPER_CONTACT_DETAILS VARCHAR(30),
PRODUCT_ID INTEGER,
VEHICLE_MAKER VARCHAR(60),
VEHICLE_MODEL VARCHAR(60),
VEHICLE_COLOR VARCHAR(60),
VEHICLE_MODEL_YEAR INTEGER,
VEHICLE_PRICE DECIMAL(14,2),
ǪUANTITY INTEGER,
DISCOUNT DECIMAL(4,2),
CUSTOMER_ID VARCHAR(25),
CUSTOMER_NAME VARCHAR(25),
GENDER VARCHAR(15),
JOB_TITLE VARCHAR(50),
PHONE_NUMBER VARCHAR(20),
EMAIL_ADDRESS VARCHAR(50),
CITY VARCHAR(25),
COUNTRY VARCHAR(40),
STATE VARCHAR(40),
CUSTOMER_ADDRESS VARCHAR(50),
ORDER_DATE DATE,
ORDER_ID VARCHAR(25),
SHIP_DATE DATE,
SHIP_MODE VARCHAR(25),
SHIPPING VARCHAR(30),
POSTAL_CODE INTEGER,
CREDIT_CARD_TYPE VARCHAR(40),
CREDIT_CARD_NUMBER BIGINT,
CUSTOMER_FEEDBACK VARCHAR(20),
ǪUARTER_NUMBER INTEGER
);

iii) order_t

-- Table structure for table `order`
-- This is a order_t table. The DDL Scripts are as below
CREATE TABLE ORDER_T
(
ORDER_ID VARCHAR(25),
CUSTOMER_ID VARCHAR(25),
SHIPPER_ID INTEGER,
PRODUCT_ID INTEGER,
ǪUANTITY INTEGER,
VEHICLE_PRICE DECIMAL(10,2),
ORDER_DATE DATE,
SHIP_DATE DATE,
DISCOUNT DECIMAL(4,2),
SHIP_MODE VARCHAR(25),
SHIPPING VARCHAR(30),

CUSTOMER_FEEDBACK VARCHAR(20),
ǪUARTER_NUMBER INTEGER
);

iv) customer_t

-- Table structure for table `customer`
-- This is a customer_t table. The DDL Scripts are as below
CREATE TABLE CUSTOMER_T
(
CUSTOMER_ID VARCHAR(25),
CUSTOMER_NAME VARCHAR(25),
GENDER VARCHAR(15),
JOB_TITLE VARCHAR(50),
PHONE_NUMBER VARCHAR(20),
EMAIL_ADDRESS VARCHAR(50),
CITY VARCHAR(25),
COUNTRY VARCHAR(40),
STATE VARCHAR(40),
CUSTOMER_ADDRESS VARCHAR(50),
POSTAL_CODE INTEGER,
CREDIT_CARD_TYPE VARCHAR(40),
CREDIT_CARD_NUMBER BIGINT
);

v) product_t

-- Table structure for table `product`
-- This is a product_t table. The DDL Scripts are as below
CREATE TABLE PRODUCT_T
(
PRODUCT_ID INTEGER,
VEHICLE_MAKER VARCHAR(60),
VEHICLE_MODEL VARCHAR(60),
VEHICLE_COLOR VARCHAR(60),
VEHICLE_MODEL_YEAR INTEGER,
VEHICLE_PRICE DECIMAL(14,2)
);

vi) shipper_t

-- Table structure for table `shipper`
-- This is a shipper_t table. The DDL Scripts are as below
CREATE TABLE SHIPPER_T
(
SHIPPER_ID INTEGER,
SHIPPER_NAME VARCHAR(50),
SHIPPER_CONTACT_DETAILS VARCHAR(30)
);
/

-- Creating Store Procedures

i) customer_p

-- This is customer_p store procedure which is designed by importing data from
vehicles_t table into customer_t table

DELIMITER $$
CREATE PROCEDURE customer_p()
BEGIN
INSERT INTO customer_t (
CUSTOMER_ID,
CUSTOMER_NAME,
GENDER,
JOB_TITLE,
PHONE_NUMBER,
EMAIL_ADDRESS,
CITY,
COUNTRY,
STATE,

CUSTOMER_ADDRESS,
POSTAL_CODE,
CREDIT_CARD_TYPE,
CREDIT_CARD_NUMBER
)
SELECT DISTINCT
CUSTOMER_ID,
CUSTOMER_NAME,
GENDER,
JOB_TITLE,
PHONE_NUMBER,
EMAIL_ADDRESS,
CITY,
COUNTRY,
STATE,
CUSTOMER_ADDRESS,
POSTAL_CODE,
CREDIT_CARD_TYPE,
CREDIT_CARD_NUMBER
FROM vehicles_t;
END;
call customer_p() ;

ii) vehicles_p

-- This is vehicles_p store procedure which is designed by importing data from
temp_t table into vehicles_t table

DELIMITER $$
CREATE PROCEDURE vehicles_p()
BEGIN
INSERT INTO vehicles_t (
SHIPPER_ID,
SHIPPER_NAME,
SHIPPER_CONTACT_DETAILS,
PRODUCT_ID,
VEHICLE_MAKER,
VEHICLE_MODEL,
VEHICLE_COLOR,
VEHICLE_MODEL_YEAR,
VEHICLE_PRICE,
ǪUANTITY,
DISCOUNT,
CUSTOMER_ID,
CUSTOMER_NAME,
GENDER,
JOB_TITLE,
PHONE_NUMBER,
EMAIL_ADDRESS,
CITY,
COUNTRY,
STATE,
CUSTOMER_ADDRESS,
ORDER_DATE,
ORDER_ID,
SHIP_DATE,
SHIP_MODE,
SHIPPING,

POSTAL_CODE,
CREDIT_CARD_TYPE,
CREDIT_CARD_NUMBER,
CUSTOMER_FEEDBACK,
ǪUARTER_NUMBER
)
SELECT DISTINCT
SHIPPER_ID,
SHIPPER_NAME,
SHIPPER_CONTACT_DETAILS,
PRODUCT_ID,
VEHICLE_MAKER,
VEHICLE_MODEL,
VEHICLE_COLOR,
VEHICLE_MODEL_YEAR,
VEHICLE_PRICE,
ǪUANTITY,
DISCOUNT,
CUSTOMER_ID,
CUSTOMER_NAME,
GENDER,
JOB_TITLE,
PHONE_NUMBER,
EMAIL_ADDRESS,
CITY,
COUNTRY,
STATE,
CUSTOMER_ADDRESS,
ORDER_DATE,
ORDER_ID,
SHIP_DATE,
SHIP_MODE,
SHIPPING,
POSTAL_CODE,
CREDIT_CARD_TYPE,
CREDIT_CARD_NUMBER,
CUSTOMER_FEEDBACK,
ǪUARTER_NUMBER
FROM temp_t;
END;
call vehicles_p() ;

iii) order_p

-- This is order_p store procedure which is designed by importing data from
vehicles_t table into order_t table

DELIMITER $$
CREATE PROCEDURE order_p()
BEGIN
INSERT INTO order_t (
ORDER_ID,
CUSTOMER_ID,
SHIPPER_ID,
PRODUCT_ID,
ǪUANTITY,
VEHICLE_PRICE,
ORDER_DATE,

SHIP_DATE,
DISCOUNT,
SHIP_MODE,
SHIPPING,
CUSTOMER_FEEDBACK,
ǪUARTER_NUMBER
)
SELECT DISTINCT
ORDER_ID,
CUSTOMER_ID,
SHIPPER_ID,
PRODUCT_ID,
ǪUANTITY,
VEHICLE_PRICE,
ORDER_DATE,
SHIP_DATE,
DISCOUNT,
SHIP_MODE,
SHIPPING,
CUSTOMER_FEEDBACK,
ǪUARTER_NUMBER
FROM vehicles_t;
END;
call order_p() ;

iv) product_p

-- This is product_p store procedure which is designed by importing data from
vehicles_t table into product_t table

DELIMITER $$
CREATE PROCEDURE product_p()
BEGIN
INSERT INTO product_t (
PRODUCT_ID,
VEHICLE_MAKER,
VEHICLE_MODEL,
VEHICLE_COLOR,
VEHICLE_MODEL_YEAR,
VEHICLE_PRICE
)
SELECT DISTINCT
PRODUCT_ID,
VEHICLE_MAKER,
VEHICLE_MODEL,
VEHICLE_COLOR,
VEHICLE_MODEL_YEAR,
VEHICLE_PRICE
FROM vehicles_t;
END;
call product_p() ;

v) shipper_p

-- This is shipper_p store procedure which is designed by importing data from
vehicles_t table into shipper_t table

DELIMITER $$
CREATE PROCEDURE shipper_p()
BEGIN
INSERT INTO shipper_t (
SHIPPER_ID,
SHIPPER_NAME,
SHIPPER_CONTACT_DETAILS
)
SELECT DISTINCT
SHIPPER_ID,
SHIPPER_NAME,
SHIPPER_CONTACT_DETAILS
FROM vehicles_t;
END;
call shipper_p() ;
/

-- Creating Views

i) veh_ord_cust_v

-- This is first view veh_ord_cust_v

CREATE VIEW veh_ord_cust_v as(
SELECT CT.CUSTOMER_ID,
CUSTOMER_NAME,
CITY,
STATE,
CREDIT_CARD_TYPE,
ORDER_ID,
SHIPPER_ID,
PRODUCT_ID,
ǪUANTITY,
VEHICLE_PRICE,
ORDER_DATE,
SHIP_DATE,
DISCOUNT,
CUSTOMER_FEEDBACK,
ǪUARTER_NUMBER
FROM customer_t CT
JOIN order_t ST
ON CT.CUSTOMER_ID = ST.CUSTOMER_ID)

ii) veh_prod_cust_v

-- This is the second view veh_prod_cust_v

CREATE VIEW veh_prod_cust_v as(
SELECT CT.CUSTOMER_ID,
CUSTOMER_NAME,
CREDIT_CARD_TYPE,
STATE,
ORDER_ID,
CUSTOMER_FEEDBACK,
VT.PRODUCT_ID,

VEHICLE_MAKER,
VEHICLE_MODEL,
VEHICLE_COLOR,
VEHICLE_MODEL_YEAR
FROM customer_t CT
JOIN order_t ST
ON CT.CUSTOMER_ID = ST.CUSTOMER_ID
JOIN product_t VT
ON ST.PRODUCT_ID = VT.PRODUCT_ID)
/
