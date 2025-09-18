WITH params AS (
  SELECT DATE('2017-01-01') AS start_date, DATE('2018-01-01') AS end_date
),
base AS (
  SELECT o.order_id
  FROM orders o, params p
  WHERE DATE(o.order_purchase_timestamp) >= p.start_date
    AND DATE(o.order_purchase_timestamp) <  p.end_date
    AND o.order_status = 'delivered'
    AND o.order_delivered_customer_date IS NOT NULL
),
items AS (
  SELECT
    oi.order_id,
    CASE WHEN oi.price > 0 THEN oi.price ELSE 0 END AS item_price,
    CASE WHEN oi.freight_value IS NULL OR oi.freight_value < 0
         THEN 0 ELSE oi.freight_value END          AS freight_value
  FROM order_items oi
  JOIN base b ON b.order_id = oi.order_id
),
tot AS (
  SELECT order_id, SUM(item_price + freight_value) AS gross
  FROM items
  GROUP BY order_id
),
pay AS (
  SELECT op.order_id,
         SUM(CASE WHEN op.payment_value >= 0 THEN op.payment_value ELSE 0 END) AS paid
  FROM order_payments op
  GROUP BY op.order_id
)
SELECT
  ROUND(100.0 * SUM(COALESCE(p.paid,0)) / NULLIF(SUM(t.gross),0), 2) AS payment_capture_pct
FROM base b
JOIN tot t ON t.order_id = b.order_id
LEFT JOIN pay p ON p.order_id = b.order_id;

