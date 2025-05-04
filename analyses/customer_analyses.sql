SELECT 
customerid,
customername,
segment,
country,
state
FROM
{{ source('RAW_DATA','RAW_CUSTOMERS')}} 
where state='Texas'
