{{config(
  materialized='table',
  alias='raw_customer_detail_pennsylvania_tbl',
  unique_key='customerid'
)
}}

select 
customerid,
customername,
segment,
country
FROM
{{ ref('customer_detail_tbl') }}
where state='Pennsylvania'