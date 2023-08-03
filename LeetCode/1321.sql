처음 내 풀이(오답)
SELECT
    VISITED_ON,
    SUM(AMOUNT) OVER(ORDER BY VISITED_ON
                     ROWS 6 PRECEDING) AS AMOUNT,
    ROUND(SUM(AMOUNT) OVER(ORDER BY VISITED_ON
                     ROWS 6 PRECEDING)/7, 2) AS AVERAGE_AMOUNT                      
FROM(
    SELECT
        TO_CHAR(VISITED_ON, 'YYYY-MM-DD') AS VISITED_ON,
        SUM(AMOUNT) AS AMOUNT
    FROM CUSTOMER
    GROUP BY TO_CHAR(VISITED_ON, 'YYYY-MM-DD')
    ORDER BY VISITED_ON
    )
ORDER BY VISITED_ON



주의 오답 1) 
SELECT
    VISITED_ON,
    SUM_AMOUNT AS AMOUNT,
    ROUND(SUM_AMOUNT / 7, 2) AS AVERAGE_AMOUNT
FROM (
    SELECT
        VISITED_ON,
        SUM(AMOUNT) OVER(ORDER BY VISITED_ON
                        ROWS 6 PRECEDING) AS SUM_AMOUNT
    FROM (
        SELECT
            VISITED_ON,
            SUM(AMOUNT) AS AMOUNT
        FROM CUSTOMER
        GROUP BY VISITED_ON -- 여기서 TO_CHAR로 먼저 형태를 바꾸면 안 된다.
        ORDER BY VISITED_ON
    )
)
WHERE ROWNUM >= 7 -- ROWNUM = 7 안 된다. ROWNUM >= 7 안 된다! ! !

  

주의 오답 2)
SELECT
    TO_CHAR(VISITED_ON, 'YYYY-MM-DD') AS VISITED_ON,
    SUM_AMOUNT AS AMOUNT,
    ROUND(SUM_AMOUNT / 7, 2) AS AVERAGE_AMOUNT
FROM (
    SELECT
        VISITED_ON,
        SUM(AMOUNT) OVER(ORDER BY VISITED_ON
                        ROWS 6 PRECEDING) AS SUM_AMOUNT, -- 주의할 부분
        ROW_NUMBER() OVER(ORDER BY VISITED_ON) AS RN  -- 주의할 부분
    FROM (
        SELECT
            VISITED_ON,
            SUM(AMOUNT) AS AMOUNT
        FROM CUSTOMER
        GROUP BY VISITED_ON
        ORDER BY VISITED_ON
    )
)
WHERE RN >= 7  -- 주의할 부분

-- 예시에서 답은 맞지만 반례가 있으므로 오류다.
-- VISITED_ON이 연속적인 날짜가 아니라 비어있는 날짜가 있을 경우를 고려해야 한다.
-- 따라서 바로 위의 행 6개의 누적합을 가져오는 것이 아니라 6일 전까지의 누적합을 표현해야 한다.



정답)
SELECT
    TO_CHAR(VISITED_ON, 'YYYY-MM-DD') AS VISITED_ON,
    SUM_AMOUNT AS AMOUNT,
    ROUND(SUM_AMOUNT / 7, 2) AS AVERAGE_AMOUNT
FROM (
    SELECT
        VISITED_ON,
        MIN(VISITED_ON) OVER() AS FIRST_DATE,  -- 주의할 부분: 6일 전을 표시해줘야 하기 때문에
        SUM(AMOUNT) OVER(ORDER BY VISITED_ON 
                        RANGE INTERVAL '6' DAY PRECEDING) AS SUM_AMOUNT  -- 주의할 부분: DATETIME형식에서만 INTERVAL 사용 가능
    FROM (
        SELECT
            VISITED_ON,
            SUM(AMOUNT) AS AMOUNT
        FROM CUSTOMER
        GROUP BY VISITED_ON  -- 주의할 부분
        ORDER BY VISITED_ON
    )
)
WHERE VISITED_ON - FIRST_DATE >= 6  -- 주의할 부분

-- RANGE: 값을 보고 범위에 해당하는 행만 참여시킨다.
-- RANGE INTERVAL '6' DAY PRECEDING
-- INTERVAL은 DATETIME형식에서만 사용한다.

-- 만약 숫자(양)를 세고 싶다면 INTERVAL은 뺀다 


-- 문제 출처: https://leetcode.com/problems/restaurant-growth/
