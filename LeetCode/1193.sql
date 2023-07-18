SELECT 
  TO_CHAR(TRANS_DATE, 'YYYY-MM') AS MONTH, 
  T.COUNTRY,
  COUNT(T.ID) AS TRANS_COUNT,
  COUNT(A.ID) AS APPROVED_COUNT,
  NVL(SUM(T.AMOUNT), 0) AS TRANS_TOTAL_AMOUNT,
  NVL(SUM(A.AMOUNT), 0) AS APPROVED_TOTAL_AMOUNT
FROM TRANSACTIONS T,
  (SELECT ID, AMOUNT
  FROM TRANSACTIONS
  WHERE STATE = 'approved') A
WHERE T.ID = A.ID(+)
GROUP BY TO_CHAR(TRANS_DATE, 'YYYY-MM'), T.COUNTRY


-- 인라인뷰 사용하여 문제 풀기
-- 따옴표 안에 대소문자 구분하기
-- SUM 함수는 뭐라도 나와야 하기 때문에 값이 없으면 NULL을 출력한다 (저번에 MAX 궁금증 생각하면 됨)
-- 따라서, NULL이라면 0을 출력하고 NVL을 써줘야 한다.

--문제 출처: https://leetcode.com/problems/monthly-transactions-i/
