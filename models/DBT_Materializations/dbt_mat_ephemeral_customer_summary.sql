{{ config(
    materialized='ephemeral',
    alias='customer_summary_tbl'
    ) 
}}

SELECT
    e.customer_id,
    e.total_orders,
    r.country
FROM {{ ref('dbt_materializations_ephemeral_orders') }} AS e
JOIN {{ source('RAW_DATA','RAW_CUSTOMERS')}} AS r
ON e.customer_id = r.customer_id
