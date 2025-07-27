{{config(
  materialized='table',
  alias='customer_total_spending'
)
}}

SELECT 
    c.name, 
    SUM(o.order_total) AS total_spent,
    'customer_details_based_on_spending' as created_by,
    current_timestamp as created_date_time
FROM {{ source('RAW_DATA','jaffle_shop_customers')}}  c
JOIN {{ source('RAW_DATA','jaffle_shop_orders')}}  o 
ON c.id = o.customer
GROUP BY c.name
ORDER BY total_spent DESC