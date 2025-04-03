{{ config(
    materialized='table',
    database='TRANSFORM_DB',
    alias='TBL_NULL_VALUE_IND'
) 
}}

select   
    ID,
    FIRSTNAME,
    LASTNAME,
    GENDER,
    SALARY,
    HIREDATE,
    {{ null_test_macro('EMPLOYEES', 'GENDER') }}
FROM 
    {{ source('RAW_DATA', 'EMPLOYEES') }}