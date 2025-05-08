{{config(
  materialized='table',
  alias='raw_customer_detail_texas_tbl',
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
{{ ref('customer_detail_tbl') }}
where state='Texas'