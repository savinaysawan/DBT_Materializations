{{config(
  materialized='table',
  alias='raw_customers_data_tbl'
)
}}
 
SELECT 
customerid,
customername,
segment,
country,
state
FROM
{{ source('RAW_DATA','RAW_CUSTOMERS')}} 
