{% macro upd_custid() %}
    {% set ddl_statement %}
		update TRANSFORM_DB.RAW_SCH.AVERAGE_ORDER_VALUE_TBL
		set CUSTOMERID = 'PC-20024'
		where CUSTOMERID = 'PC-19000'
    {% endset %}

    {{ run_query(ddl_statement) }}
{% endmacro %}