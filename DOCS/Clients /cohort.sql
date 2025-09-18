WITH params AS (
  SELECT DATE('2017-01-01') AS start_date, DATE('2018-01-01') AS end_date
),
base_orders AS (
  SELECT o.order_id, o.customer_id,
         STRFTIME('%Y-%m', o.order_purchase_timestamp) AS ym
  FROM orders o, params p
  WHERE DATE(o.order_purchase_timestamp) >= p.start_date
    AND DATE(o.order_purchase_timestamp) <  p.end_date
    AND o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
),
labels AS (
  SELECT c.customer_unique_id,
         MIN(STRFTIME('%Y-%m', o.order_purchase_timestamp)) AS cohort_ym
  FROM orders o
  JOIN customers c ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
  GROUP BY c.customer_unique_id
),
active AS (  
  SELECT o.ym, c.customer_unique_id
  FROM base_orders o
  JOIN customers c ON c.customer_id = o.customer_id
  GROUP BY o.ym, c.customer_unique_id
),
cohort_2017 AS ( 
  SELECT * FROM labels WHERE cohort_ym BETWEEN '2017-01' AND '2017-12'
),
cohort_size AS (
  SELECT cohort_ym, COUNT(*) AS n_customers
  FROM cohort_2017
  GROUP BY cohort_ym
)
SELECT 
  cs.cohort_ym,
  a.ym AS month_ym,
  COUNT(DISTINCT a.customer_unique_id)                                    AS active_customers,
  ROUND(100.0 * COUNT(DISTINCT a.customer_unique_id) / cs.n_customers, 2) AS retention_pct
FROM cohort_size cs
JOIN cohort_2017 c ON c.cohort_ym = cs.cohort_ym
JOIN active a      ON a.customer_unique_id = c.customer_unique_id
WHERE a.ym >= cs.cohort_ym
GROUP BY cs.cohort_ym, a.ym
ORDER BY cs.cohort_ym, a.ym;

