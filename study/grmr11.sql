/*
WITH ROLLUP 
항목별 소계 및 전체 합계 구하기

ORACLE에서는 GROUP BY ROLLUP(컬럼1, 컬럼2) 형식으로 사용했다면, MySQL에서는 GROUP BY 컬럼1, 컬럼2 WITH ROLLUP 형식으로 사용한다.
*/


/* 1. WITH ROLLUP 기본 */
	
SELECT
	직업, 
	나이,
	COUNT(*) AS UV
FROM 고객테이블
WHERE 나이 >= 20
GROUP BY 직업, 나이 WITH ROLLUP; -- 직업별 나이별 부분합 및 총합(소계, 합계)

	-> 1. 직업으로 분류 후, 직업별 나이에 따른 고객수
	   2. 해당 직업의 고객수
	   3. 전체 고객수




/* 2. GROUPING 함수 활용하기 
GROUPING 함수: 집계된 행의 NULL을 판단할 때 사용
	       실제 조회된 데이터의 NULL과 소계, 합계로 추가된 NULL은 GROUPING 함수만 구별이 가능하다.
	       소계, 합계는 1을 리턴하고 실제 데이터가 집계된 행(컬럼값이 NULL인 경우도)은 0을 리턴한다. 
	
합계 출력: GROUPING(직업) = 1
소계 제외: GROUPING(나이) = 0

※ 컬럼에 따라 다르게 활용 가능하다.
*/

	
-- 2-1. 소계 제거 방법
	
SELECT
	직업, 
	나이,
	COUNT(*) AS UV
FROM 고객테이블
WHERE 나이 >= 20
GROUP BY 직업, 나이 WITH ROLLUP -- 직업별 나이별 부분합 및 총합(소계, 합계)
HAVING GROUPING(나이) = 0; -- 나이에서 실제 데이터가 집계된 행만 출력함

	-> 1. 직업으로 분류 후, 직업별 나이에 따른 고객수


	
SELECT
	직업, 
	나이,
	COUNT(*) AS UV
FROM 고객테이블
WHERE 나이 >= 20
GROUP BY 직업, 나이 WITH ROLLUP -- 직업별 나이별 부분합 및 총합(소계, 합계)
HAVING GROUPING(나이) = 0 OR GROUPING(직업) = 1; -- 나이에서 실제 데이터가 집계된 행 출력, 직업의 합계 출력

	-> 1. 직업으로 분류 후, 직업별 나이에 따른 고객수
	   2. 전체 고객수


	

-- 2-2. 소계, 합계 텍스트 표시
방법 1)	
SELECT
	CASE 
	  WHEN GROUPING(직업) = 1 THEN '합계'
          ELSE 직업 END AS 직업,
	CASE
	  WHEN GROUPING(나이) = 1 THEN '소계'
          ELSE 나이 END AS 나이,
	COUNT(*) AS UV
FROM 고객테이블
WHERE 나이 >= 20
GROUP BY 직업, 나이 WITH ROLLUP; 

	-> 자리에 null 대신 소계, 합계 텍스트가 출력된다.


방법 2)
SELECT
	IF(GROUPING(직업) = 1, '합계', 직업) AS 직업,
	IF(GROUPING(나이) = 1, '소계', 나이) AS 나이,
	COUNT(*) AS UV
FROM 고객테이블
WHERE 나이 >= 20 
GROUP BY 직업, 나이 WITH ROLLUP; 

	-> CASE WHEN 구문 대신 IF로 더 간단하게 작성 가능하다.
