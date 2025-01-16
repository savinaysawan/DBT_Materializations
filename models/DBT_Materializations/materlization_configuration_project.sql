 SELECT * ,
'raw_customers_vw' as snf_created_by 
 FROM {{ source('RAW_DATA','RAW_CUSTOMERS')}}