/*

ISNULL 함수
ISNULL(컬럼명, NULL인 경우 대체값) 

*/

SELECT 
  COL,
  ISNULL(COL, 'SQL') -- COL값이 NULL일 경우 SQL로 대체
FROM SAMPLE_TABLE


-- WHERE절에서 사용
SELECT 
  COL
FROM SAMPLE_TABLE
WHERE ISNULL(COL, 'SQL') = 'SQL'   -- NULL값의 컬럼을 조회하고 싶을 때 


/*

IIF 함수
오라클의 NVL2와 비슷한 기능

*/

SELECT
  IIF(COL IS NULL, 'SQL', 'PYTHON') -- COL값이 NULL일 경우, SQL 출력하고 NULL이 아닐 경우 PYTHON 출력
FROM SAMPLE_TABLE
