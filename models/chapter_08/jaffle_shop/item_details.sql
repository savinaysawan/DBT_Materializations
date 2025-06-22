{{config(
  materialized='table',
  alias='item_details_tbl'
)
}}
SELECT 
    i.id AS item_id, 
    p.name AS product_name, 
    p.price,
    'item_details_tbl' as created_by,
    current_timestamp as created_date_time   
FROM {{ source('RAW_DATA','jaffle_shop_items')}}  i
JOIN {{ source('RAW_DATA','jaffle_shop_products')}}  p 
ON i.sku = p.sku