{{config(
  materialized='view'
)
}}

SELECT * ,
'raw_products_vw' as snf_created_by,
current_timestamp as snf_created_date
 FROM {{ source('RAW_DATA','RAW_PRODUCTS')}}