{{config(
  materialized='view',
  alias='total_revenue_from_orders'
)
}}

SELECT 
    SUM(order_total) AS total_revenue,
    'total_revenue_from_orders' as created_by,
    current_timestamp as created_date_time
FROM  {{ source('RAW_DATA','jaffle_shop_orders')}} 
