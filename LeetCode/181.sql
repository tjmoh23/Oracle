-- 문제 출처: https://leetcode.com/problems/employees-earning-more-than-their-managers/

SELECT E1.NAME AS EMPLOYEE
FROM EMPLOYEE E1, EMPLOYEE E2
WHERE E1.MANAGERID = E2.ID
AND E1.SALARY > E2.SALARY
