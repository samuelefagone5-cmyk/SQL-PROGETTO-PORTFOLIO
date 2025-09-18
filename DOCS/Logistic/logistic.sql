SELECT strftime('%Y-%m', o.order_purchase_timestamp) AS ym,
       ROUND(AVG(julianday(o.order_delivered_customer_date)
                - julianday(o.order_purchase_timestamp)),2) AS avg_days,
       ROUND(100.0*AVG(CASE WHEN o.order_delivered_customer_date
                                <= o.order_estimated_delivery_date THEN 1 ELSE 0 END),2) AS on_time_pct
FROM orders o
WHERE DATE(o.order_purchase_timestamp)>='2017-01-01' AND DATE(o.order_purchase_timestamp)<'2018-01-01'
  AND o.order_status='delivered' AND o.order_delivered_customer_date IS NOT NULL
GROUP BY ym ORDER BY ym;


