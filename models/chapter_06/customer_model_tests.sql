{{config(
  materialized='table',
  alias='customer_model_tests'
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
where segment='Consumer'
