-- 연속으로 오는 3개의 행에서 100 미만의 숫자가 없으면 해당 행 출력하기

SELECT ID, VISIT_DATE, PEOPLE
FROM(
    SELECT 
        ID, TO_CHAR(VISIT_DATE, 'YYYY-MM-DD') AS VISIT_DATE,
        LAG(PEOPLE, 2) OVER(ORDER BY VISIT_DATE) AS PEOPLE1,
        LAG(PEOPLE, 1) OVER(ORDER BY VISIT_DATE) AS PEOPLE2,
        PEOPLE,
        LEAD(PEOPLE, 1) OVER(ORDER BY VISIT_DATE) AS PEOPLE3,
        LEAD(PEOPLE, 2) OVER(ORDER BY VISIT_DATE) AS PEOPLE4
    FROM STADIUM
    )
WHERE (PEOPLE1 >= 100 AND PEOPLE2 >= 100 AND PEOPLE >= 100)
OR (PEOPLE2 >= 100 AND PEOPLE >= 100 AND PEOPLE3 >= 100)
OR (PEOPLE >= 100 AND PEOPLE3 >= 100 AND PEOPLE4 >= 100)


-- WINDOW함수에서 LAG, LEAD는 ORDER BY 행대로 나열된 후에 값을 출력하기 때문에 꼭 ORDER BY 써줘야 한다!
-- HARD문제인데 스스로 풀었다 > <
-- 문제 출처: https://leetcode.com/problems/human-traffic-of-stadium/description/ 
