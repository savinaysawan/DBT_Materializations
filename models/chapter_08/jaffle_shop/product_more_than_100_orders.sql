{{config(
  materialized='table',
  alias='product_more_than_100_orders'
)
}}

SELECT 
    p.name, 
    COUNT(i.id) AS item_count,
    'product_more_than_100_orders' as created_by,
    current_timestamp as created_date_time  
FROM {{ source('RAW_DATA','jaffle_shop_products')}} p
JOIN {{ source('RAW_DATA','jaffle_shop_items')}}  i 
ON p.sku = i.sku
GROUP BY p.name
HAVING COUNT(i.id) > 100