{{config(
  materialized='table',
  alias='repeated_customer_tbl'
)
}}
WITH customer_order_times AS (
  SELECT
    customer,
    ordered_at,
    LAG(ordered_at) OVER (PARTITION BY customer ORDER BY ordered_at) AS previous_order
  FROM     {{ source('RAW_DATA','jaffle_shop_orders')}}
)
SELECT DISTINCT 
    c.name,
    'repeated_customer_tbl' as created_by,
    current_timestamp as created_date_time 
FROM customer_order_times cot
JOIN     {{ source('RAW_DATA','jaffle_shop_customers')}} c ON cot.customer = c.id
WHERE cot.previous_order IS NOT NULL
  AND cot.ordered_at <= cot.previous_order + INTERVAL '7 days'