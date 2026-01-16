
### Querying
- In Daiquery, use macros to get accessible columns and use the right namespace

### Queries
#### Full query - ACL error
```sql
SELECT 
    job_family_name, 
    job_level, 
    COUNT(employee_id) AS employee_count
FROM 
    hr.d_employee_plus
WHERE 
    job_family_name IN ('Product Management')
GROUP BY 
    job_family_name, 
    job_level
ORDER BY 
    job_family_name, 
    job_level;
```

#### Query with macro
```sql
SELECT <EXCLUDE_INACCESSIBLE_ACLS:hr.d_employee_plus>
FROM 
    hr.d_employee_plus
WHERE 
    job_family_name IN ('Product Management')
GROUP BY 
    job_family_name, 
    job_level
ORDER BY 
    job_family_name, 
    job_level;
```
Error: `[Object not found]: Table not found; databaseName='infrastructure', tableName='hr'`


```sql
SELECT <ALL_ACCESSIBLE_COLUMNS:hr.d_employee_plus>
    *
FROM 
    hr.d_employee_plus
```
Error: `metastore_NoSuchObjectException: [Object not found]: Table not found; databaseName='infrastructure', tableName='hr.d_employee_plus' (EntID: 1:hr.d_employee_plus:infrastructure)`

```sql
SELECT <ALL_ACCESSIBLE_COLUMNS:hr . d_employee_plus>
    job_family_name, 
    job_level, 
    COUNT(employee_id) AS employee_count
FROM 
    hr.d_employee_plus
WHERE 
    job_family_name IN ('Product Management')
GROUP BY 
    job_family_name, 
    job_level
ORDER BY 
    job_family_name, 
    job_level;
```
