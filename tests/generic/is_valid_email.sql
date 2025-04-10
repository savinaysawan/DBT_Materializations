{% test is_valid_email(model, column_name) %}

with validation as (

    select
        {{ column_name }} as email

    from {{ model }}

),

email_validation_cte as 
(
select 
  CASE
    WHEN email REGEXP '^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$' THEN 'Valid'
    ELSE 'Invalid'
  END AS email_validation
from validation
),

validation_errors as (
select
  email_validation
from email_validation_cte
where email_validation='Invalid'
)

select *
from validation_errors

{% endtest %}