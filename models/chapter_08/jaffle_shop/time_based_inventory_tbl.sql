{{config(
  materialized='table',
  alias='time_based_inventory_tbl'
)
}}

WITH item_sales_time AS (
    SELECT
        p.type AS product_type,
        DATE_TRUNC('hour', o.ordered_at) AS sale_hour,
        COUNT(i.id) AS items_sold
    FROM {{ source('RAW_DATA','jaffle_shop_orders')}}  o
    JOIN {{ source('RAW_DATA','jaffle_shop_items')}}  i ON o.id = i.order_id
    JOIN {{ source('RAW_DATA','jaffle_shop_products')}}  p ON i.sku = p.sku
    GROUP BY p.type, DATE_TRUNC('hour', o.ordered_at)
),
peak_hours AS (
    SELECT
        product_type,
        sale_hour,
        items_sold,
        RANK() OVER (PARTITION BY product_type ORDER BY items_sold DESC) AS demand_rank
    FROM item_sales_time
)
SELECT 
    product_type,
    sale_hour,
    items_sold,
    demand_rank,
    'time_based_inventory_tbl' as created_by,
    current_timestamp as created_date_time
FROM peak_hours
WHERE demand_rank <= 3