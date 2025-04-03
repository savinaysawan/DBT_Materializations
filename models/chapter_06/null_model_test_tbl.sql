{{config(
  materialized='table',
  alias='null_model_test_tbl'
)
}}
 
SELECT 
ID,
NAME,
AGE,
CITY
FROM
{{ source('RAW_DATA','SIMPLE_DATA_NULL_TBL')}} 