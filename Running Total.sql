--==========================
--         RUNNING TOTAL
--==========================
SELECT deptno, sal, SUM(sal) OVER(PARTITION BY deptno ORDER BY empno) AS runningTotal FROM emp
ORDER BY deptno
