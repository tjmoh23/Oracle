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
WHERE TOTAL_WEIGHT <= 1000;

-- 1000을 초과하기 직전까지의 테이블은 구했는데 거기서 가장 최대값인 존시나를 어떻게 뽑아내야할지 모르겠음 ㅜㅜ 
-- 문제 출처: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/
