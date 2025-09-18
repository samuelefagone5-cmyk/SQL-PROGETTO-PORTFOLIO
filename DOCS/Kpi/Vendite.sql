WITH params AS (
  SELECT DATE('2017-01-01') AS start_date,
         DATE('2018-01-01') AS end_date
),
valid_orders AS (
  SELECT o.order_id
  FROM orders o, params p
  WHERE DATE(o.order_purchase_timestamp) >= p.start_date
    AND DATE(o.order_purchase_timestamp) <  p.end_date
    AND o.order_status IN ('delivered','invoiced','shipped','approved')
),
items AS (
  SELECT
    oi.order_id,
    CASE WHEN oi.price > 0 THEN oi.price ELSE 0 END AS item_price,
    CASE
      WHEN oi.freight_value IS NULL OR oi.freight_value < 0 THEN 0
      ELSE oi.freight_value
    END AS freight_value
  FROM order_items oi
  JOIN valid_orders vo ON vo.order_id = oi.order_id
),
items_agg AS (
  SELECT
    ROUND(SUM(item_price), 2)                 AS gmv_items,
    ROUND(SUM(item_price + freight_value), 2) AS gmv_plus_freight,
    COUNT(*)                                  AS items_sold,
    COUNT(DISTINCT order_id)                  AS orders
  FROM items
),
payments_by_order AS (
  SELECT
    op.order_id,
    SUM(CASE WHEN op.payment_value >= 0 THEN op.payment_value ELSE 0 END) AS payment_total
  FROM order_payments op
  GROUP BY op.order_id
),
payments_agg AS (
  SELECT
    ROUND(SUM(COALESCE(p.payment_total, 0)), 2) AS revenue_collected
  FROM valid_orders vo
  LEFT JOIN payments_by_order p ON p.order_id = vo.order_id
)
SELECT
  i.gmv_items,
  i.gmv_plus_freight,
  p.revenue_collected,
  i.orders,
  i.items_sold
FROM items_agg i
CROSS JOIN payments_agg p;



