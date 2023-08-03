-- 리트 코드 문제
-- https://leetcode.com/problems/restaurant-growth/

주의 1) 
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

  

주의 2)
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



  ------------------------------------------------------------------------------------------------------------
  

-- IN, ALL, SOME, ANY
-- ALL, SOME, ANY는 컬럼값 안 쓴다.


EXISTS에 대해 배워보자.
EXISTS는 존재 여부만 확인하는 것이고 따로 필터링을 하지는 않는다.

  
SELECT *
FROM LOVATIONS L
WHERE EXISTS (SELECT 1 -- 존재 여부 확인
              FROM WAREHOUSES W
              WHERE L.LOCATION_ID = W.LOCATION_ID) -- 일치 조건

 
SELECT *
FROM LOVATIONS L
WHERE EXISTS (SELECT 1 -- 존재 여부 확인
              FROM WAREHOUSES W
              WHERE W.LOCATION_ID = 5) -- 일치 조건 
                                       -- WHERE 1 = 1 과 똑같은 결과가 나온다.
                                       -- WHERE W.LOCATION_ID = 100일 경우, 아무 것도 출력하지 않는다. -> WHERE 1 = 0 과 똑같은 결과가 나온다.
-- LOCATION_ID가 5인 데이터만 출력되는 거라고 생각할 수 있겠지만 단지 존재 여부만 확인할 뿐, 존재 여부가 참이면 해당 테이블을 모두 출력한다.

서브쿼리에 메인쿼리의 테이블을 가져오면 상관 서브쿼리. (예: WHERE L.LOCATION_ID = W.LOCATION_ID)
가져오지 않고 = 을 사용한다면 비상관 서브쿼리. (예: WHERE W.LOCATION_ID = 5)
보통 EXISTS는 상관 서브쿼리에서 주로 사용한다.
IN하고 비슷하다. 다만 차이점은?
EXISTS는 위에서부터 읽는 게 편하다. 단지 존재 여부만 확인 하는 것이기 때문에! IN은 서브쿼리부터 읽어야 함.


  
SELECT *
FROM REGIONS R 
WHERE EXISTS (SELECT 1   -- 존재 여부 확인
                FROM COUNTRIES C
            WHERE R.REGION_ID = C.REGION_ID); -- 일치 조건
            
--서브쿼리에 메인쿼리의 테이블을 가져오면 상관 서브쿼리
--상관 서브쿼리에서 EXISTS를 보통 써요.

SELECT *
FROM REGIONS
WHERE REGION_ID IN (SELECT REGION_ID
                    FROM COUNTRIES);




