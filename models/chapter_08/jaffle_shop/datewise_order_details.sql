{{config(
  materialized='table',
  alias='datewise_order_details'
)
}}

SELECT 
    DATE(ordered_at) AS order_date, 
    COUNT(*) AS order_count,
    'datewise_order_details' as created_by,
    current_timestamp as created_date_time   
FROM {{ source('RAW_DATA','jaffle_shop_orders')}} 
GROUP BY DATE(ordered_at)
ORDER BY order_count DESC