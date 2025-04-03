{{config(
  materialized='table',
  alias='raw_orders_data_tbl'
)
}}
 
SELECT 
ORDER_ID,	
ORDER_DATE,	
SHIP_DATE,	
SHIP_MODE,	
CUSTOMER_ID,	
PRODUCT_ID,	
ORDER_COST_PRICE,	
ORDER_SELLING_PRICE
FROM
{{ source('RAW_DATA','RAW_ORDERS')}} 
