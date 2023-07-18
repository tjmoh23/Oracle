-- 풀이 1
SELECT
  PRODUCT_ID, 
  YEAR AS FIRST_YEAR, 
  QUANTITY, PRICE
FROM
  (
  SELECT
      PRODUCT_ID, YEAR, QUANTITY,
      RANK() OVER(PARTITION BY PRODUCT_ID
                  ORDER BY YEAR) AS RANK,
      PRICE
  FROM SALES
  )
WHERE RANK = 1


-- 풀이 2)
-- SALES를 WHERE절에서 한 번 더 불러오기 때문에 풀이 1보다는 성능이 떨어진다.
SELECT
FROM SALES
WHERE (PRODUCT_ID, YEAR) IN (SELECT PRODUCT_ID, MIN(YEAR)
                            FROM SALES
                            GROUP BY PRODUCT_ID



-- 문제에 SALES 테이블 외에 PRODUCT 테이블도 있는데 이건 사실 필요 없는 거다. 
-- 처음에 조인했었는데 그럴 필요가 없음
-- 출력 결과를 잘 보고 테이블을 붙이자! 단지 정보만 보여주는 테이블이고 필요하지 않을 수 있기 때문에 무작정 테이블 붙이지 말 것! 성능이 더 떨어진다.
-- 문제 출처: https://leetcode.com/problems/product-sales-analysis-iii/description/
