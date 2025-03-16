{% macro create_table_macro(table_name) %}
    {% set ddl_statement %}
        CREATE TABLE  {{ table_name }}(
            CUSTOMERID VARCHAR(250),
            CUSTOMERNAME VARCHAR(250),
            SEGMENT VARCHAR(250),
            COUNTRY VARCHAR(250),
            STATE VARCHAR(250),
            MEASURE_CURRENCY VARCHAR(250)
        );
    {% endset %}

    {{ run_query(ddl_statement) }}
{% endmacro %}
