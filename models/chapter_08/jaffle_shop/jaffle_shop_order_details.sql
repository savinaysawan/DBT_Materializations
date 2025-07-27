{{config(
  materialized='table',
  alias='jaffle_shop_order_details_tbl'
)
}}
SELECT
    o.id AS order_id,
    o.ordered_at AS order_date,
    c.name AS customer_name,
    s.name AS store_name,
    p.name AS product_name,
    p.type AS product_type,
    p.price AS product_price,
    o.tax_paid,
    o.order_total,
    'jaffle_shop_order_details_tbl' as created_by,
    current_timestamp as created_date_time 
FROM
    {{ source('RAW_DATA','jaffle_shop_orders')}} o
JOIN {{ source('RAW_DATA','jaffle_shop_customers')}} c 
ON o.customer = c.id
JOIN {{ source('RAW_DATA','jaffle_shop_stores')}} s
ON o.store_id = s.id
JOIN {{ source('RAW_DATA','jaffle_shop_items')}} i 
ON o.id = i.order_id
JOIN {{ source('RAW_DATA','jaffle_shop_products')}} p 
ON i.sku = p.sku
ORDER BY o.id, i.id