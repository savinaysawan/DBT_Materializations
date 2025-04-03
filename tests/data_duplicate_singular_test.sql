select 
customerid , count(*)
from {{ source('RAW_DATA', 'RAW_CUSTOMERS') }}
group by customerid
having count(*)>1