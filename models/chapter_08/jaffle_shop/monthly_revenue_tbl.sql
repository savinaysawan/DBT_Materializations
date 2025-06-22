{{config(
  materialized='table',
  alias='monthly_revenue_tbl'
)
}}
SELECT 
    DATE_TRUNC('month', ordered_at) AS month, 
    SUM(order_total) AS monthly_revenue,
    'monthly_revenue_tbl' as created_by,
    current_timestamp as created_date_time  
FROM {{ source('RAW_DATA','jaffle_shop_orders')}}  
WHERE ordered_at >= CURRENT_DATE - INTERVAL '12 months'
GROUP BY DATE_TRUNC('month', ordered_at)
ORDER BY month