
-- Store-wise : Brand Sales [2016-2017]
SELECT  b.brand_name,  st.store_name , 
sum(o.quantity) AS Total_Units_Sold,
count(DISTINCT o.order_id) AS Total_Orders ,
sum((o.list_price - o.discount) * o.quantity) AS Total_Revenue,
sum(o.discount * o.quantity) AS Total_Discount,
round(avg(( o.list_price -  o.discount) * o.quantity ),2) AS Average_Revenue , 
st.city , st.state
FROM products p 
JOIN order_items o 
	ON o.product_id = p.product_id
JOIN orders a
	ON a.order_id = o.order_id
JOIN stores st
	ON st.store_id = a.store_id
JOIN brands b
	ON b.brand_id = p.brand_id
WHERE a.order_date >= '2016-01-01' AND a.order_date <= '2017-12-31'
GROUP BY  st.store_name , st.city , st.state , b.brand_name
ORDER BY st.store_name, Total_Units_Sold DESC;

-- Store-wise : Brand Sales [2018]
SELECT  b.brand_name,  st.store_name , 
sum(o.quantity) AS Total_Units_Sold,
count(DISTINCT o.order_id) AS Total_Orders ,
sum((o.list_price - o.discount) * o.quantity) AS Total_Revenue,
sum(o.discount * o.quantity) AS Total_Discount,
round(avg(( o.list_price -  o.discount) * o.quantity ),2) AS Average_Revenue ,
st.city , st.state
FROM products p 
JOIN order_items o 
	ON o.product_id = p.product_id
JOIN orders a
	ON a.order_id = o.order_id
JOIN stores st
	ON st.store_id = a.store_id
JOIN brands b
	ON b.brand_id = p.brand_id
WHERE a.order_date >= '2018-01-01' AND a.order_date <= '2018-12-28'
GROUP BY  st.store_name , st.city , st.state , b.brand_name
ORDER BY st.store_name, Total_Units_Sold DESC;

-- Top 10-Cities 
SELECT  c.city , round(avg( a.quantity * ( a.list_price - a.discount)),2) AS Average_Revenue , 
sum(a.quantity) AS Total_Units_Sold ,
round(sum( a.quantity * ( a.list_price - a.discount)),2) AS Total_Revenue,
count(DISTINCT o.order_id) AS Total_Orders ,
round(sum(a.quantity *  a.discount),2) AS Total_Discount , c.state
FROM orders o
JOIN order_items a
	ON o.order_id = a.order_id 
JOIN customers c 
	ON c.customer_id = o.customer_id
GROUP BY  c.city , c.state
ORDER BY Total_Units_Sold DESC
LIMIT 10;

--  Least Performing Cities 
SELECT  c.city , round(avg( a.quantity * (a.list_price - a.discount)),2) AS Average_Revenue , 
sum(a.quantity) AS Total_Units_Sold ,
round(sum( a.quantity * ( a.list_price - a.discount)),2) AS Total_Revenue,
count(DISTINCT o.order_id) AS Total_Orders ,
round(sum(a.quantity * a.discount),2) AS Total_Discount , c.state
FROM orders o
JOIN order_items a
	ON o.order_id = a.order_id 
JOIN customers c 
	ON c.customer_id = o.customer_id
GROUP BY  c.city , c.state
ORDER BY Total_Units_Sold ASC
LIMIT 10;

-- Top 10 Best-selling Products [2016-2017]
SELECT b.brand_name, p.product_name ,
round(avg( a.quantity * ( a.list_price - a.discount)),2) AS Average_Revenue , 
sum(a.quantity) AS Total_Units_Sold ,
round(sum( a.quantity * ( a.list_price - a.discount)),2) AS Total_Revenue,
count(DISTINCT o.order_id) AS Total_Orders ,
round(sum(a.quantity *  a.discount),2) AS Total_Discount
FROM products p 
JOIN order_items a
	ON p.product_id = a.product_id
JOIN brands b
	ON b.brand_id = p.brand_id
JOIN orders o 
	 ON a.order_id = o.order_id
WHERE o.order_date >= '2016-01-01' AND o.order_date <= '2017-12-31'
GROUP BY p.product_name , b.brand_name
ORDER BY Total_Units_Sold DESC 
LIMIT 10;

-- Top 10 Best-selling Products [2018]
SELECT b.brand_name, p.product_name ,
round(avg( a.quantity * ( a.list_price -  a.discount)),2) AS Average_Revenue , 
sum(a.quantity) AS Total_Units_Sold ,
round(sum( a.quantity * ( a.list_price - a.discount)),2) AS Total_Revenue,
count(DISTINCT o.order_id) AS Total_Orders ,
round(sum(a.quantity  * a.discount),2) AS Total_Discount
FROM products p 
JOIN order_items a
	ON p.product_id = a.product_id
JOIN brands b
	ON b.brand_id = p.brand_id
JOIN orders o 
	 ON a.order_id = o.order_id
WHERE o.order_date >= '2018-01-01' AND o.order_date <= '2018-12-28'
GROUP BY p.product_name , b.brand_name
ORDER BY Total_Units_Sold DESC 
LIMIT 10;


-- Store Analysis (Orders, Revenue , Discount) [2016-2017]
SELECT st.store_id , st.store_name , 
count(DISTINCT o.order_id) AS Total_Orders ,
sum(o.quantity * (o.list_price - o.discount)) as Total_Revenue,
sum(o.quantity * o.discount) as Total_Discount,
sum(o.quantity) AS Total_Units_Sold,
round(avg( o.quantity * ( o.list_price -  o.discount)),2) AS Average_Revenue ,
st.city , st.state 
from stores st
JOIN orders a
	ON st.store_id = a.store_id 
JOIN order_items o
	ON o.order_id = a.order_id
WHERE a.order_date >= '2016-01-01' AND a.order_date <= '2017-12-31'
GROUP BY st.store_id , st.store_name , st.city , st.state
ORDER BY Total_Revenue DESC;

-- Store Analysis (Orders, Revenue , Discount) [2018]
SELECT st.store_id , st.store_name , 
count(DISTINCT o.order_id) AS Total_Orders ,
sum(o.quantity * (o.list_price - o.discount)) as Total_Revenue,
sum(o.quantity * o.discount) as Total_Discount,
sum(o.quantity) AS Total_Units_Sold,
round(avg( o.quantity * ( o.list_price -  o.discount)),2) AS Average_Revenue ,
st.city , st.state 
from stores st
JOIN orders a
	ON st.store_id = a.store_id 
JOIN order_items o
	ON o.order_id = a.order_id
WHERE a.order_date >= '2018-01-01' AND a.order_date <= '2018-12-28'
GROUP BY st.store_id , st.store_name , st.city , st.state
ORDER BY Total_Revenue DESC;

-- Top 10 Performing Months by Revenue
SELECT 
date_format(d.order_date, '%Y') AS Year_,
date_format(d.order_date, '%b') AS Month_,
count(DISTINCT o.order_id) AS Total_Orders,
sum((o.list_price - o.discount) * o.quantity) AS Total_Revenue,
sum(o.quantity) AS Total_Units_Sold, 
sum(o.discount * o.quantity) AS Total_Discount
FROM orders d
JOIN order_items o
	ON o.order_id = d.order_id
GROUP BY Year_ , Month_
ORDER BY  Total_Revenue DESC
LIMIT 10;

-- 2016-2017 Sales Analysis by Brand
SELECT b.brand_name , 
round(avg( a.quantity * ( a.list_price - a.discount)),2) AS Average_Revenue , 
sum(a.quantity) AS Total_Units_Sold ,
round(sum( a.quantity * ( a.list_price - a.discount)),2) AS Total_Revenue,
count(DISTINCT a.order_id) AS Total_Orders ,
round(sum(a.quantity * a.discount),2) AS Total_Discount
FROM order_items a
JOIN products p
	ON p.product_id = a.product_id
JOIN brands b
	ON p.brand_id = b.brand_id
JOIN orders o
	ON o.order_id = a.order_id
WHERE o.order_date >= '2016-01-01' AND o.order_date <= '2017-12-31'
GROUP BY b.brand_name
ORDER BY Total_Revenue DESC;

-- Past 1-year Sales Analysis by Brand
SELECT b.brand_name , 
sum(o.quantity) AS Total_Units_Sold,
count(DISTINCT o.order_id) AS Total_Orders ,
sum((o.list_price - o.discount) * o.quantity) AS Total_Revenue,
sum(o.discount * o.quantity) AS Total_Discount,
round(avg( o.quantity * (o.list_price - o.discount)),2) AS Average_Revenue 
FROM order_items o
JOIN products p
	ON p.product_id = o.product_id
JOIN brands b
	ON p.brand_id = b.brand_id
JOIN orders a
	ON a.order_id = o.order_id
WHERE a.order_date >= '2018-01-01' AND a.order_date <= '2018-12-28'
GROUP BY b.brand_name
ORDER BY Total_Revenue DESC;

-- Metrics 
SELECT 
YEAR(a.order_date) as Year_,
sum(o.quantity) AS Total_Units_Sold,
count(DISTINCT o.order_id) AS Total_Orders ,
sum((o.list_price - o.discount) * o.quantity) AS Total_Revenue,
sum(o.discount * o.quantity) AS Total_Discount,
round(avg( o.quantity * o.list_price * (1- o.discount)),2) AS Average_Revenue ,
round(sum(o.discount*o.quantity)/sum(o.quantity),2) AS Average_Discount_Per_Unit
FROM order_items o
JOIN orders a
ON o.order_id = a.order_id
GROUP BY YEAR(a.order_date)
ORDER BY Year_;
