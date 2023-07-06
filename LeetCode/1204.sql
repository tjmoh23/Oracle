SELECT *
FROM
    (
        SELECT
        TURN, 
        PERSON_ID,
        PERSON_NAME,
        WEIGHT,
        SUM(WEIGHT) OVER(ORDER BY TURN
                        ROWS UNBOUNDED PRECEDING) AS TOTAL_WEIGHT
    FROM QUEUE
    )
WHERE TOTAL_WEIGHT <= 1000

-- 문제 출처: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/
