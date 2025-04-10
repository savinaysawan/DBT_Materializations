{% macro test_error_threshold_test_model(model, column_name) %}

WITH error_count AS (
    select
      count(*) as invalid_ages_count
    from {{ model }}
    where {{ column_name }} is not null
    and ({{ column_name }} < 18 or {{ column_name }} > 100)
)
, cte_test_percentage as
(
SELECT
    CASE
        WHEN (invalid_ages_count / (SELECT COUNT(*) FROM {{ model }})) * 100 > 10
        THEN 1 ELSE 0
    END AS test_result
FROM error_count
)
select * from cte_test_percentage
where test_result=1
{% endmacro %}