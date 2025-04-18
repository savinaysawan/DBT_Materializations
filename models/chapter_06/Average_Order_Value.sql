{{config(
  materialized='table',
  alias='AVERAGE_ORDER_VALUE_TBL'
)
}}
 
 SELECT 
    c.STATE,
    c.CUSTOMERID,
    c.CUSTOMERNAME,
    AVG(o.ORDER_SELLING_PRICE - o.ORDER_COST_PRICE) AS AVG_ORDER_VALUE
FROM
    {{ source('RAW_DATA','RAW_CUSTOMERS')}} c
JOIN 
    {{ source('RAW_DATA','RAW_ORDERS')}}  o
    ON c.CUSTOMERID = o.CUSTOMER_ID
GROUP BY 
    c.STATE, c.CUSTOMERID, c.CUSTOMERNAME
ORDER BY 
    c.STATE, AVG_ORDER_VALUE DESC