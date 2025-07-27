{{ config(
    materialized='incremental',
    alias='order_details_status_tbl',
    unique_key='order_id',
    merge_exclude_columns = ['created_by','created_date_time']
) }}

SELECT
    order_id, 	 
    customer_id, 	 
    order_date, 	 
    update_at as updated_at,   	 
    status,    	 
    total_amount,
    'order_details_status_tbl' as created_by,
     current_timestamp as created_date_time,
    'order_details_status_tbl' as updated_by,
    current_timestamp as updated_date_time        
FROM {{ source('RAW_DATA', 'RAW_ORDER_INC') }} 
