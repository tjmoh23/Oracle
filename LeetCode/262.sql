-- 조건별로 집계를 구하고 싶을 경우, CASE문을 활용해보자!

SELECT
      REQUEST_AT AS Day,
      ROUND(SUM(TOTAL)/COUNT(TOTAL), 2) AS "Cancellation Rate" -- 사이에 띄어쓰기 있을 경우 큰 따옴표로 별칭을 감싸줘야 한다.
FROM(
      SELECT 
            ID, REQUEST_AT,
            CASE
            WHEN STATUS LIKE 'cancelled%' THEN 1
            ELSE 0 END AS TOTAL
      FROM TRIPS
      WHERE CLIENT_ID IN (
                  SELECT USERS_ID
                  FROM USERS
                  WHERE BANNED <> 'Yes' )
      AND DRIVER_ID IN(
                  SELECT USERS_ID
                  FROM USERS
                  WHERE BANNED <> 'Yes' )
      AND REQUEST_AT BETWEEN '2013-10-01' AND '2013-10-03' )
GROUP BY REQUEST_AT


추가로,
  
CASE
WHEN STATUS LIKE 'cancelled%' THEN 1
ELSE NULL END AS TOTAL
-- 로 CASE문을 사용할 경우, 바깥 SELECT문에서 집계할 때 ROUND(COUNT(TOTAL)/COUNT(ID), 2)로 사용할 수도 있다.
-- ★COUNT(컬럼)은 NULL을 카운팅 하지 않는다.★
-- ★COUNT(*)은 NULL을 포함하여 모든 행의 개수를 센다.★


-- IN 대신 NOT IN을 사용하여 WHERE절 조건을 정할 수도 있다. 
-- 같지 않다: <> 또는 != 


-- 문제 출처: https://leetcode.com/problems/trips-and-users/description/
