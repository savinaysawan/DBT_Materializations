{{ config(
    materialized='incremental',
    alias='order_profit_analysis',
    unique_key='order_id',
    incremental_strategy='merge'
) }}

    SELECT
        o.ORDER_ID,
        o.ORDER_DATE,
        o.SHIP_DATE,
        o.SHIP_MODE,
        o.CUSTOMER_ID,
        o.PRODUCT_ID,
        o.ORDER_COST_PRICE,
        o.ORDER_SELLING_PRICE,
        (o.ORDER_SELLING_PRICE - o.ORDER_COST_PRICE) AS PROFIT,
       (o.ORDER_SELLING_PRICE - o.ORDER_COST_PRICE) / NULLIF(o.ORDER_SELLING_PRICE, 0) AS MARGIN,
        c.CUSTOMERNAME,
        c.SEGMENT,
        c.COUNTRY,
        c.STATE,
        p.PRODUCTNAME,
        p.SUBCATEGORY,
        p.CATEGORY,
    'order_profit_analysis' as created_by,
     current_timestamp as created_date_time,
    'order_profit_analysis' as updated_by,
    current_timestamp as updated_date_time        
    FROM {{ source('RAW_DATA', 'RAW_ORDERS') }} o
    LEFT JOIN {{ source('RAW_DATA', 'RAW_CUSTOMERS') }} c
        ON o.CUSTOMER_ID = c.CUSTOMERID
    LEFT JOIN {{ source('RAW_DATA', 'RAW_PRODUCTS') }} p
        ON o.PRODUCT_ID = p.PRODUCTID
