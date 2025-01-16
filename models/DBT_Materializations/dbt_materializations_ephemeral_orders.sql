{{ config(
    materialized='ephemeral'
    ) 
}}
SELECT
    customer_id,
    COUNT(order_id) AS total_orders
FROM FROM {{ source('RAW_DATA','RAW_ORDERS')}}
GROUP BY customer_id
