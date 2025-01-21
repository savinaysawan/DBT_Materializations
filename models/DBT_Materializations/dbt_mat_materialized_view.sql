{{
config(
    materialized = 'dynamic_table',
    snowflake_warehouse = 'COMPUTE_WH',
    target_lag = 'downstream',
    on_configuration_change = 'apply'
)
}}

SELECT 
    ord.ORDER_ID,
    cust.CUSTOMERNAME,
    prd.CATEGORY,
    ord.ORDER_DATE,
    ord.SHIP_DATE,
    DATEDIFF(DAY,ord.ORDER_DATE,ord.SHIP_DATE) AS DELIVERY_DAY_REQUIRED,
    current_timestamp as snf_updated_date
FROM 
     {{ source('RAW_DATA','RAW_ORDERS')}} ord
JOIN 
 {{ source('RAW_DATA','RAW_CUSTOMERS')}} cust
ON 
    ord.CUSTOMER_ID = cust.CUSTOMERID
JOIN 
    {{ source('RAW_DATA','RAW_PRODUCTS')}} prd
ON 
    ord.PRODUCT_ID = prd.PRODUCTID
WHERE 
    ord.SHIP_DATE > ord.ORDER_DATE
ORDER BY 
    DELIVERY_DAY_REQUIRED DESC