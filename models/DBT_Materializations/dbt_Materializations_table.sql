{{config(
  materialized='table',
  alias='CATEGORYWISE_PROFIT_TBL'
)
}}
 WITH CTE_DATA AS 
 (
SELECT 
    p.CATEGORY,
    p.SUBCATEGORY,
    SUM(ORD.ORDER_SELLING_PRICE - ORD.ORDER_COST_PRICE) AS TOTAL_PROFIT,
    'DBT_TBL_MAT_JOB' as snf_created_by
 
    FROM {{ source('RAW_DATA','RAW_ORDERS')}} ORD
JOIN 
     {{ source('RAW_DATA','RAW_PRODUCTS')}} p
ON 
    ORD.PRODUCT_ID = p.PRODUCTID
GROUP BY 
    p.CATEGORY, p.SUBCATEGORY
ORDER BY 
    TOTAL_PROFIT DESC
 )

 SELECT * FROM CTE_DATA