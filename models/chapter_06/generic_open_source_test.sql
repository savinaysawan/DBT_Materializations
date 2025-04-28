{{config(
  materialized='table',
  alias='generic_open_source_test'
)
}}
 
SELECT 
ID,
NAME,
AGE,
EMAIL
FROM
{{ source('RAW_DATA','EMAIL_TEST_TBL')}} 