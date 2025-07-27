{{config(
  materialized='table',
  alias='profit_margin_productwise_tbl'
)
}}
SELECT
  p.name AS product_name,
  p.price,
  s.cost AS supply_cost,
  (p.price - s.cost) AS profit_margin,
  'profit_margin_productwise' as created_by,
  current_timestamp as created_date_time 
FROM {{ source('RAW_DATA','jaffle_shop_products')}} p
JOIN {{ source('RAW_DATA','jaffle_shop_supplies')}}  s 
ON p.sku = s.sku