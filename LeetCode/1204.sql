SELECT PERSON_NAME
FROM(
    SELECT 
        PERSON_NAME, SUM,
        RANK() OVER(ORDER BY SUM DESC) AS RANK
    FROM
        (
        SELECT 
            PERSON_NAME, WEIGHT, TURN,
            SUM(WEIGHT) OVER(ORDER BY TURN
                            ROWS UNBOUNDED PRECEDING) AS SUM
        FROM QUEUE
        ORDER BY TURN
        )
    WHERE SUM <= 1000)
WHERE RANK = 1

-- 1000을 초과하기 직전까지의 테이블은 구했는데 거기서 가장 최대값인 존시나를 어떻게 뽑아내야할지 어려웠음 ㅜㅜ 
-- 윈도우 함수 사용해서 RANK컬럼 만들고 인라인 뷰로 한 번 더 만들어서 조건절로 뽑아냈다.
-- 문제 출처: https://leetcode.com/problems/last-person-to-fit-in-the-bus/description/
