{% macro null_test_macro(table, column) %}
    {% set sql_statement %}
       
            case when {{ column }} is null then 'Y' 
                 else 'N'
            end as {{ column }}_null_indicator
    {% endset %}

    {{ return(sql_statement) }}
{% endmacro %}