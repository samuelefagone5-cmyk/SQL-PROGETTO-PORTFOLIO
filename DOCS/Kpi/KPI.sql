WITH valid_orders AS (
SELECT *
FROM orders
WHERE date(order_purchase_timestamp) BETWEEN date('2017-01-01') AND date('2018-01-01')
AND order_status IN ('delivered','invoiced','shipped','approved')
),
base AS (
SELECT
COUNT(DISTINCT o.order_id) AS orders,
COUNT(*) AS items,
SUM(oi.price) AS sum_price,
SUM(COALESCE(op.payment_value, 0)) AS sum_payments
FROM valid_orders o
JOIN order_items oi ON oi.order_id = o.order_id
LEFT JOIN order_payments op ON op.order_id = o.order_id
)
SELECT
ROUND(1.0 * sum_payments / NULLIF(orders, 0), 2) AS aov_atv,
ROUND(1.0 * sum_price   / NULLIF(items,  0), 2) AS asp,
ROUND(1.0 * items       / NULLIF(orders, 0), 2) AS upt
FROM base;

