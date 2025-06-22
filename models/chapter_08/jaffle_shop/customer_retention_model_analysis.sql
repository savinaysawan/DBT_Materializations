{{config(
  materialized='table',
  alias='customer_retention_model_analysis'
)
}}
WITH customer_order_history AS (
    SELECT
        c.id AS customer_id,
        c.name AS customer_name,
        COUNT(o.id) AS total_orders,
        MAX(o.ordered_at) AS last_order_date,
        MIN(o.ordered_at) AS first_order_date,
        DATEDIFF('day', MIN(o.ordered_at), MAX(o.ordered_at)) AS order_span_days,
        DATEDIFF('day', MAX(o.ordered_at), CURRENT_DATE) AS days_since_last_order
    FROM {{ source('RAW_DATA','jaffle_shop_customers')}} c
    JOIN {{ source('RAW_DATA','jaffle_shop_orders')}}   o 
    ON c.id = o.customer
    GROUP BY c.id, c.name
)
, customer_product_store_mix AS (
    SELECT
        o.customer,
        COUNT(DISTINCT p.type) AS distinct_product_types,
        COUNT(DISTINCT o.store_id) AS store_loyalty_count
    FROM {{ source('RAW_DATA','jaffle_shop_orders')}}  o
    JOIN {{ source('RAW_DATA','jaffle_shop_items')}}  i ON o.id = i.order_id
    JOIN {{ source('RAW_DATA','jaffle_shop_products')}}  p ON i.sku = p.sku
    GROUP BY o.customer
)
SELECT
    coh.customer_id,
    coh.customer_name,
    coh.total_orders,
    coh.order_span_days,
    coh.days_since_last_order,
    cp.distinct_product_types,
    cp.store_loyalty_count,
    CASE
        WHEN coh.days_since_last_order > 90 AND coh.total_orders <= 2 THEN 'High Risk'
        WHEN coh.days_since_last_order BETWEEN 30 AND 90 THEN 'Medium Risk'
        ELSE 'Low Risk'
    END AS retention_risk
FROM customer_order_history coh
JOIN customer_product_store_mix cp ON coh.customer_id = cp.customer
ORDER BY retention_risk DESC