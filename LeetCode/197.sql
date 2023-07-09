SELECT ID
FROM
(
    SELECT 
        ID, RECORDDATE, TEMPERATURE,
        LAG(RECORDDATE) OVER(ORDER BY RECORDDATE) AS PRE_DATE,
        LAG(TEMPERATURE) OVER(ORDER BY RECORDDATE) AS PRE_TEM
    FROM WEATHER
)
WHERE PRE_TEM < TEMPERATURE
AND RECORDDATE = PRE_DATE + 1;

-- 온도 조건 외에 날짜가 연속적이어야 하는 조건이 추가로 들어가야 한다..
-- 문제 출처: https://leetcode.com/problems/rising-temperature/description/
