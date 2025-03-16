{{config(
  materialized='table',
  alias='RAW_ORDER_DELIVERY_DETAILS_TBL'
)
}}
 
 SELECT 
    c.STATE,
    c.CUSTOMERID,
    c.CUSTOMERNAME,
    ord.ship_date,
    ord.order_date,
    {{ datediff_custom_fun('ord.order_date','ord.ship_date') }} as delivery_time
FROM
    {{ source('RAW_DATA','RAW_CUSTOMERS')}} c
JOIN 
    {{ source('RAW_DATA','RAW_ORDERS')}}  ord
    ON c.CUSTOMERID = ord.CUSTOMER_ID
GROUP BY 
    c.STATE, c.CUSTOMERID, c.CUSTOMERNAME,ord.ship_date,
    ord.order_date
ORDER BY 
    c.STATE, delivery_time DESC