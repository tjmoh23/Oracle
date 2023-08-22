-- 내 풀이

SELECT
  USER_ID,
  ROUND(NVL(CFM/TOTAL, 0), 2) AS CONFIRMATION_RATE
FROM(
    SELECT
      USER_ID,
      COUNT(ACTION) AS TOTAL,
      SUM(ACTIONS) AS CFM
    FROM(
        SELECT 
          S.USER_ID,
          CASE 
          WHEN ACTION = 'timeout' THEN 0
          WHEN ACTION = 'confirmed' THEN 1
          ELSE NULL END AS ACTIONS,
          ACTION
        FROM CONFIRMATIONS C, SIGNUPS S
        WHERE S.USER_ID = C.USER_ID(+)
      ) 
    GROUP BY USER_ID
  )


-- 다른 풀이 -> 더 간단하게 풀 수 있다 ! ! !

SELECT
    S.USER_ID,
    ROUND(AVG(CASE WHEN ACTION = 'confirmed' THEN 1 ELSE 0 END), 2) AS CONFIRMATION_RATE
FROM SIGNUPS S, CONFIRMATIONS C
WHERE S.USER_ID = C.USER_ID(+)
GROUP BY S.USER_ID

-- 문제 출처: https://leetcode.com/problems/confirmation-rate/description/
