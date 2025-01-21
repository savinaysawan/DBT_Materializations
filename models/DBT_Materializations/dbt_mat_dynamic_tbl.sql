{{
config(
    materialized = 'dynamic_table',
    snowflake_warehouse = 'COMPUTE_WH',
    target_lag = '5 minute',
    on_configuration_change = 'apply'
)
}}

WITH EmployeeDetails AS (
    SELECT 
        e.Employee_ID,
        e.Name AS Employee_Name,
        d.Department_Name,
        e.Position,
        e.Salary,
        e.Hire_Date
    FROM {{ source('RAW_DATA','EMPLOYEES')}} e
    INNER JOIN {{ source('RAW_DATA','DEPARTMENTS')}} d
    ON e.Department_ID = d.Department_ID
),

DepartmentSalary AS (
    SELECT 
        Department_Name,
        SUM(Salary) AS Total_Salary,
        COUNT(Employee_ID) AS Total_Employees
    FROM EmployeeDetails
    GROUP BY Department_Name
)

SELECT 
    ed.Employee_Name,
    ed.Position,
    ed.Salary,
    ed.Hire_Date,
    ed.Department_Name,
    ds.Total_Salary,
    ds.Total_Employees,
    current_timestamp as snf_updated_date
FROM EmployeeDetails ed
INNER JOIN DepartmentSalary ds
ON ed.Department_Name = ds.Department_Name
ORDER BY ed.Department_Name, ed.Salary DESC

