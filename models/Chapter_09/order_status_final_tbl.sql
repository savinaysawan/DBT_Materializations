  {{
    config(
      materialized='incremental',
      unique_key='order_id',
      merge_exclude_columns ='snowflake_created_dt'
    )
  }}

select 
*,
current_timestamp as snowflake_created_dt,
current_timestamp as snowflake_updated_dt
FROM {{ ref('order_snapshot_data_tbl') }}
WHERE dbt_valid_to IS NULL  -- active record only 

