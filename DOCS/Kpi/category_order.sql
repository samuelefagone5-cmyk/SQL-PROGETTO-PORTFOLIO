WITH params AS (
  SELECT date('2017-01-01') AS start_date,
         date('2018-01-01') AS end_date        
),
valid_orders AS (
SELECT o.order_id
FROM orders o, params p
WHERE date(o.order_purchase_timestamp) >= p.start_date
AND date(o.order_purchase_timestamp) <  p.end_date
AND o.order_status = 'delivered'
AND o.order_delivered_customer_date IS NOT NULL
),
items AS (
SELECT
vo.order_id,
COALESCE(NULLIF(TRIM(pr.product_category_name), ''), '(unknown)') AS category,
oi.price AS item_price,
COALESCE(oi.freight_value, 0) AS freight_value
FROM valid_orders vo
JOIN order_items oi ON oi.order_id = vo.order_id
JOIN products pr    ON pr.product_id = oi.product_id
WHERE oi.price IS NOT NULL
AND oi.price > 0
AND (oi.freight_value IS NULL OR oi.freight_value >= 0)
AND (oi.freight_value IS NULL OR oi.freight_value <= oi.price * 3)
)
SELECT category,
ROUND(SUM(item_price), 2) AS net_gmv,           
ROUND(SUM(item_price + freight_value), 2) AS gmv_plus_freight,  
COUNT(*) AS items_sold,        
COUNT(DISTINCT order_id) AS orders             
FROM items
GROUP BY category
ORDER BY net_gmv DESC;



