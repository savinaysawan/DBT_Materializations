{{config(
  materialized='table',
  alias='check_age_threshold_value_test'
)
}}
 
SELECT 
ID,
NAME,
AGE,
EMAIL
FROM
{{ source('RAW_DATA','EMAIL_TEST_TBL')}} 