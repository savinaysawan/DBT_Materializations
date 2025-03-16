{% macro alter_table_macro(table_name) %}
    {% set ddl_statement %}
        ALTER TABLE  {{ table_name }} ADD COLUMN ZIP_CODE NUMBER(20)
    {% endset %}

    {{ run_query(ddl_statement) }}
{% endmacro %}
