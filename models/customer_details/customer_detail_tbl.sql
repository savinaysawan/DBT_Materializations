{{config(
  materialized='table',
  alias='raw_customer_detail_tbl',
  unique_key='customerid'
)
}}

select 
customerid,
customername,
segment,
country,
state
FROM
{{ source('RAW_DATA','RAW_CUSTOMERS')}} 