-- GROUP BY는 최종 결괏값
-- WINDOW는 중간 결괏값, 행마다 계산된다(누적)
-- GROUP BY는 하나의 그룹 당 하나의 집계 결괏값(최종 결괏값)만 반환. 파티션으로 쪼갠 다음 모든 행에 대해서  하나의 값씩 반환
-- OVER가 있다면 WINDOW 함수라는 뜻이고, OVER문 안에 순서 대로 들어 간다
-- WINDOW 함수는 SELECT문에 사용한다


-- GROUP BY
SELECT ORDER_ID, SUM(QUANTITY) AS TOTAL_QUANTITY
FROM ORDER_ITEMS
GROUP BY ORDER_ID
ORDER BY ORDER_ID; -- 하나의 그룹당 하나의 집계 결괏값(최종 결괏값)만 반환


-- WINDOW 함수
SELECT
    ORDER_ID, 
    QUANTITY,
    SUM(QUANTITY) OVER(PARTITION BY ORDER_ID
                        ORDER BY QUANTITY
                        ROWS UNBOUNDED PRECEDING) AS CUME_SUM -- UNBOUNDED: 처음부터 해당 행까지의 누적 합(기본값)
FROM ORDER_ITEMS;
 

SELECT
    ORDER_ID,
    QUANTITY,
    SUM(QUANTITY) OVER(PARTITION BY ORDER_ID
                        ORDER BY QUANTITY 
                        ROWS 1 PRECENDING) AS CUME_SUM 
                        -- 1은 선행하는 바로 위의 행부터 해당 행까지의 누적 합
                        -- 2는 선행하는 두 번째 행부터 해당 행까지 누적 합
                        -- 이때 ORDER BY를 쓰고 싶지 않다면 ROWS문도 모두 지워야 출력 가능
FROM ORDER_ITEMS;


SELECT
    ORDER_ID,
    QUANTITY,
    SUM(QUANTITY) OVER(PARTITION BY ORDER_ID
                        ORDER BY QUANTITY
                        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING) AS CUME_SUM_QAUNTITY
                        -- 해당 행의 이전 행, 다음 행까지 함께 더하
FROM ORDER_ITEMS;


-- ※ WINDOW 함수는 GROUP BY와 다르게 GROUP BY한 컬럼 외에, 다른 컬럼을 SELECT 문에 넣을 수 있다!
-- -> 집계된 하나의 결괏값만 출력되는 GROUP BY와는 다르게 모든 행이 다 출력되기 때문에..
-- -> 프로그래머스 Lv3 GROUP BY 관련 문제에서 헷갈렸던 부분 참고



-- 순위 함수
-- RANK: 공동 순위 인정, 다음 순위가 연속된 숫자가 아니다
-- DENSE_RANK: 공동 순위 인정, 다음 순위가 연속된 숫자이다
-- ROW_NUMBER: 공동 순위 인정하지 않는다. 순위를 나타는 것이 아닌 단순한 순서 나열 
-- 순위 함수() -> 괄호 안에 무조건 아무것도 쓰지 않는다.
SELECT 
        MANAGER_ID, COUNT(*),
        RANK() OVER(ORDER BY COUNT(*) DESC) AS RANK -- 높은 순서 대로 순위 부여
FROM EMPLOYEES
GROUP BY MANAGER_ID;


-- MANAGER_ID별로 RANK가 1인 각각의 값들을 가져오기
SELECT *
FROM(
      SELECT
          MANAGER_ID, JOB_TITLE,
          COUNT(*),
          ROW_NUMBER() OVER(PARTITION BY MANAGER_ID
                      ORDER BY COUNT(*) DESC) AS RANK
      FROM EMPLOYEES
      GROUP BY MANAGER_ID, JOB_TITLE
  )
WHERE RANK = 1;



-- LAG, LEAD 함수(얘도 윈도우 함수임)
SELECT
    ORDER_DATE,
    LAG(ORDER_DATE, 1) OVER(ORDER BY ORDER_DATE) AS PRE_DATE
                        -- ORDER BY 무조건 사용해야 한다. 먼저 정렬을 한 후, 그 기준으로 값을 가져오는 거임
                        -- LAG: 이전 값 가져오기(1이 기본값)
FROM ORDERS;


SELECT
  PRODUCT_ID, QUANTITY,
  LAG(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID
                            ORDER BY QUANTITY DESC) AS PRE_QUAN1, -- 바로 이전 값 가져오기. 없으면 0으로 채운다
  LAG(QUANTITY, 2, 0) OVER(PARTITION BY PRODUCT_ID
                            ORDER BY QUANTITY DESC) AS PRE_QUAN2, -- 앞에 두 번째 행까지 가져오기. 없으면 0으로 채운다
  LEAD(QUANTITY, 1, 0) OVER(PARTITION BY PRODUCT_ID
                            ORDER BY QUANTITY DESC) AS NEXT_QUAN -- 바로 뒤에 값 가져오기, 없으면 0으로 채운
FROM INVENTORIES;
