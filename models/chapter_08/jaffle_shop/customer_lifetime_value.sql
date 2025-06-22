{{config(
  materialized='table',
  alias='customer_lifetime_value_tbl'
)
}}

WITH customer_orders AS (
  SELECT
    customer,
    COUNT(*) AS total_orders,
    SUM(order_total) AS lifetime_value,
    AVG(order_total) AS avg_order_value
  FROM {{ source('RAW_DATA','jaffle_shop_orders')}}
  GROUP BY customer
)
SELECT
  c.name,
  co.total_orders,
  co.lifetime_value,
  co.avg_order_value,
  'customer_lifetime_value' as created_by,
  current_timestamp as created_date_time 
FROM customer_orders co
JOIN {{ source('RAW_DATA','jaffle_shop_customers')}}  c ON co.customer = c.id
ORDER BY co.lifetime_value DESC