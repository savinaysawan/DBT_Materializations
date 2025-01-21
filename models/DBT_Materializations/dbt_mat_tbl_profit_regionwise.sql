{{config(
  materialized='table',
  alias='PROFIT_REGIONWISE_TBL'
)
}}

WITH RAW_DATA_JOIN AS (
    SELECT
        p.CATEGORY,
        c.SEGMENT,
        c.COUNTRY,
        c.STATE,
        o.ORDER_COST_PRICE,
        o.ORDER_SELLING_PRICE,
        o.ORDER_SELLING_PRICE - o.ORDER_COST_PRICE AS PROFIT
    FROM {{ source('RAW_DATA','RAW_ORDERS')}} o
        
    INNER JOIN 
        {{ source('RAW_DATA','RAW_CUSTOMERS')}} c
        ON o.CUSTOMER_ID = c.CUSTOMERID
    INNER JOIN 
        {{ source('RAW_DATA','RAW_PRODUCTS')}} p
        ON o.PRODUCT_ID = p.PRODUCTID
)
SELECT
    COUNTRY,
    STATE,
    SUM(PROFIT) AS REGION_PROFIT
FROM RAW_DATA_JOIN
GROUP BY 
    COUNTRY, STATE
ORDER BY 
    REGION_PROFIT DESC
