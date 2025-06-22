{{config(
  materialized='table',
  alias='storewise_orders_tbl'
)
}}
SELECT 
    s.name AS store_name, 
    COUNT(o.id) AS order_count,
    'storewise_orders_tbl' as created_by,
    current_timestamp as created_date_time    
FROM {{ source('RAW_DATA','jaffle_shop_orders')}}  o
JOIN {{ source('RAW_DATA','jaffle_shop_stores')}}   s 
ON o.store_id = s.id
GROUP BY s.name
