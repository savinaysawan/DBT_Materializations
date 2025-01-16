{{config(
  materialized='view'
)
}}

SELECT * ,
'raw_orders_vw' as snf_created_by 
FROM {{ source('RAW_DATA','RAW_ORDERS')}}