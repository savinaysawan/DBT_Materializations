{% macro test_age_in_range(model, column_name) %}
  with cte_validation as (
    select
      count(*) as invalid_ages_count
    from {{ model }}
    where {{ column_name }} is not null
    and ({{ column_name }} < 18 or {{ column_name }} > 100)
  )
  select
    *  -- This will return rows if there are invalid ages, which will cause a failure
  from cte_validation
  where invalid_ages_count > 0  -- If there are invalid ages, this will result in a failure
{% endmacro %}
