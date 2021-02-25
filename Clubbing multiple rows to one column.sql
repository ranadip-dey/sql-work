--CONVERT MULTIPLE ROWS INTO A SINGLE COLUMN
--REPLACE "EMP" WITH YOUR TABLE NAME

SELECT REPLACE(
        (select EName AS 'data()'  from EMP for xml path(''))
         , ' ', ', ') 

--DISPLAY MASTER VALUES 
SELECT DISTINCT job, REPLACE(
        (select EName AS 'data()'  from EMP i where i.job=o.job for xml path(''))
         , ' ', ', ') 
FROM emp o
ORDER BY job
