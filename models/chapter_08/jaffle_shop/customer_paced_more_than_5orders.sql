{{config(
  materialized='table',
  alias='customer_placed_more_than_5orders'
)
}}

SELECT 
    c.name, 
    COUNT(o.id) AS order_count,
    'product_more_than_100_orders' as created_by,
    current_timestamp as created_date_time 
FROM {{ source('RAW_DATA','jaffle_shop_customers')}} c
JOIN {{ source('RAW_DATA','jaffle_shop_orders')}} o 
ON c.id = o.customer
GROUP BY c.name
HAVING COUNT(o.id) > 5