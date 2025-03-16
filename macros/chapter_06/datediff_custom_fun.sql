{% macro datediff_custom_fun(date_01, date_02) %}
    {% set sql_statement %}
        round(datediff(second, {{ date_01 }}, {{ date_02 }}) / 60, 2)
    {% endset %}

    {{ return(sql_statement) }}
{% endmacro %}