{{config(
  materialized='table',
  alias='generic_test_range_value'
)
}}
 
SELECT 
ID,
NAME,
AGE,
EMAIL
FROM
{{ source('RAW_DATA','EMAIL_TEST_TBL')}} 