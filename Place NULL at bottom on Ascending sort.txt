--====================================================
--How to show NULL at bottom in ascending sort on sal 
--====================================================

SELECT * FROM emp
ORDER BY (CASE WHEN sal IS NULL THEN 1 ELSE 0 END), sal