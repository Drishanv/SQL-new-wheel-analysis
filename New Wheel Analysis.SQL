use vehdb;

-- [Q1] What is the distribution of customers across states?

SELECT STATE, COUNT(CUSTOMER_ID) as TOTAL_CUSTOMERS
FROM customer_t
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

-- [Q2] What is the average rating in each quarter?

-- Conditions are Very Bad is 1, Bad is 2, Okay is 3, Good is 4, Very Good is 5.

CASE WHEN CUSTOMER_FEEDBACK = "Very Bad" THEN 1
WHEN CUSTOMER_FEEDBACK = "Bad" THEN 2
WHEN CUSTOMER_FEEDBACK = "Okay" THEN 3
WHEN CUSTOMER_FEEDBACK = "Good" THEN 4
WHEN CUSTOMER_FEEDBACK = "Very Good" THEN 5
END AS CUSTOMER_RATINGS
FROM veh_ord_cust_v)
SELECT ǪUARTER_NUMBER, avg(CUSTOMER_RATINGS) as AVG_RATINGS
FROM RATINGS
GROUP BY 1
ORDER BY 2 Desc;

-- [Q3] Are customers getting more dissatisfied over time?

WITH CUST_FEEDBACK as
(SELECT ǪUARTER_NUMBER,
SUM(CASE WHEN CUSTOMER_FEEDBACK = "Very Bad" THEN 1 ELSE 0 END) as Very_Bad,
SUM(CASE WHEN CUSTOMER_FEEDBACK = "Bad" THEN 1 ELSE 0 END) as Bad,
SUM(CASE WHEN CUSTOMER_FEEDBACK = "Okay" THEN 1 ELSE 0 END) as Okay,
SUM(CASE WHEN CUSTOMER_FEEDBACK = "Good" THEN 1 ELSE 0 END) as Good,
SUM(CASE WHEN CUSTOMER_FEEDBACK = "Very Good" THEN 1 ELSE 0 END) as
Very_Good,
COUNT(CUSTOMER_FEEDBACK) as TOTAL_FEEDBACKS
FROM veh_ord_cust_v
GROUP BY 1)
SELECT ǪUARTER_NUMBER,
(Very_Bad/TOTAL_FEEDBACKS)*100 Very_Bad_per,
(Bad/TOTAL_FEEDBACKS)*100 Bad_per,
(Okay/TOTAL_FEEDBACKS)*100 Okay_per,
(Good/TOTAL_FEEDBACKS)*100 Good_per,
(Very_Good/TOTAL_FEEDBACKS)*100 Very_Good_per
FROM CUST_FEEDBACK
ORDER BY 1;

-- [Q4] Which are the top 5 vehicle makers preferred by the customer?

SELECT VEHICLE_MAKER , COUNT(CUSTOMER_ID) as TOTAL_CUSTOMERS
FROM veh_prod_cust_v
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- [Q5]What is the most preferred vehicle make in each state?

With STATE_VEH as
(SELECT STATE, VEHICLE_MAKER, count(CUSTOMER_ID) as TOTAL_CUST
from veh_prod_cust_v
group by 1,2
order by 1)
Select STATE, VEHICLE_MAKER,TOTAL_CUST,
RANK() OVER (
PARTITION BY state
ORDER BY total_cust DESC)
AS MY_RANK FROM STATE_VEH;

-- [Q6] What is the trend of number of orders by quarters?

SELECT ǪUARTER_NUMBER, COUNT(ORDER_ID) as TOTAL_ORDERS
FROM order_t
GROUP BY 1
ORDER BY 2 DESC;

-- [Q7] What is the quarter over quarter % change in revenue?

WITH QOQ as
(SELECT ǪUARTER_NUMBER, SUM((ǪUANTITY*VEHICLE_PRICE)DISCOUNT*(ǪUANTITY*VEHICLE_PRICE)) as TOTAL_REVENUE
FROM veh_ord_cust_v
GROUP BY 1)
SELECT ǪUARTER_NUMBER, 100*(LAG(TOTAL_REVENUE) OVER(ORDER BY ǪUARTER_NUMBER)TOTAL_REVENUE)/TOTAL_REVENUE as QUARTER_OVER_QUARTER_PER_CHANGE_IN_REVENUE
FROM QOQ;

-- [Q8] What is the trend of revenue and orders by quarters?

SELECT ǪUARTER_NUMBER, SUM((ǪUANTITY*VEHICLE_PRICE)DISCOUNT*(ǪUANTITY*VEHICLE_PRICE)) as TOTAL_REVENUE,
COUNT(ORDER_ID) as TOTAL_ORDERS
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 desc;

-- [Q9] What is the average discount offered for different types of credit cards?

SELECT CREDIT_CARD_TYPE, AVG(DISCOUNT) as AVG_DISCOUNT
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 DESC;

-- [Q10] What is the average time taken to ship the placed orders for each quarters?

SELECT ǪUARTER_NUMBER, AVG(DATEDIFF(SHIP_DATE,ORDER_DATE)) as AVG_TIME_TAKEN
FROM veh_ord_cust_v
GROUP BY 1
ORDER BY 2 DESC;
