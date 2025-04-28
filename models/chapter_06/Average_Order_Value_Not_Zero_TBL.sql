{{config(
  materialized='table',
  alias='AVERAGE_ORDER_VALUE_NOT_ZERO_TBL'
)
}}
 
 SELECT 
    STATE,
    CUSTOMERID,
    CUSTOMERNAME,
     AVG_ORDER_VALUE
FROM {{ ref('Average_Order_Value')}}
where AVG_ORDER_VALUE > 0