{{config(
  materialized='incremental',
  alias='CUSTOMER_ORDERS_TBL_UNIQUE',
  unique_key='ORDER_ID'
)
}}

SELECT 
OrderID as ORDER_ID, 
CustomerID as CUSTOMER_ID,
ProductID as PRODUCT_ID, 
OrderDate as ORDER_DATE, 
OrderAmount as ORDER_AMOUNT, 
Status as STATUS,
'DBT_MODEL' as TABLE_CREATED_BY,
current_timestamp as TABLE_CREATED_TIME,
'DBT_MODEL' as TABLE_MODIFIED_BY,
current_timestamp as TABLE_MODIFIED_TIME
FROM {{ source('RAW_DATA','CUSTOMER_ORDERS')}}
