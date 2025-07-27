{{ config(
    materialized='incremental',
    alias='order_details_status_tbl_02',
    unique_key='order_id',
    merge_update_columns= ['updated_by','updated_date_time','status']
) }}

SELECT
    order_id, 	 
    customer_id, 	 
    order_date, 	 
    update_at as updated_at,   	 
    status,    	 
    total_amount,
    'order_details_status_tbl_02' as created_by,
     current_timestamp as created_date_time,
    'order_details_status_tbl_02' as updated_by,
    current_timestamp as updated_date_time        
FROM {{ source('RAW_DATA', 'RAW_ORDER_INC_02') }} 
