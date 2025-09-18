WITH params AS (
  SELECT DATE('2017-01-01') AS start_date, DATE('2018-01-01') AS end_date
),
base_orders AS (
  SELECT o.order_id, o.customer_id
  FROM orders o, params p
  WHERE DATE(o.order_purchase_timestamp) >= p.start_date
    AND DATE(o.order_purchase_timestamp) <  p.end_date
    AND o.order_status='delivered'
    AND o.order_delivered_customer_date IS NOT NULL
),
per_cust AS (
  SELECT c.customer_unique_id, COUNT(DISTINCT b.order_id) AS n_orders
  FROM base_orders b JOIN customers c ON c.customer_id=b.customer_id
  GROUP BY c.customer_unique_id
)
SELECT
  ROUND(100.0 * SUM(CASE WHEN n_orders>=2 THEN 1 ELSE 0 END) / NULLIF(COUNT(*),0), 2) AS repeat_rate_pct,
  SUM(CASE WHEN n_orders>=2 THEN 1 ELSE 0 END) AS customers_2plus,
  COUNT(*) AS customers_total
FROM per_cust;