{% macro update_customerid() %}
    -- This macro updates the CUSTOMERID for matches records in the given table
    update TRANSFORM_DB.RAW_SCH.AVERAGE_ORDER_VALUE_TBL
    set CUSTOMERID = 'PC-20024'
    where CUSTOMERID = 'PC-19000'  -- You can adjust the WHERE condition based on requirements

{% endmacro %}