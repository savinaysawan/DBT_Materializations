{{config(
  materialized='table',
  alias='email_test_tbl_model'
)
}}
 
SELECT 
ID,
NAME,
AGE,
EMAIL
FROM
{{ source('RAW_DATA','EMAIL_TEST_TBL')}} 
