/*
WITH ROLLUP 
항목별 합계에 대한 전체 합계 구하기
(소계, 합계)
*/

ORACLE에서는 GROUP BY ROLLUP(컬럼1, 컬럼2) 형식으로 사용했다면,
MySQL에서는 GROUP BY 컬럼1, 컬럼2 WITH ROLLUP 형식으로 사용한다.


SELECT
    SUBSTR(LOGIN_DT, 1, 8) YYYYMMDD, -- 월
    SUBSTR(LOGIN_DT, 9, 2) TIME, -- 시간
    COUNT(DISTINCT ACCOUNT_ID) CNT
FROM LOGIN_8MONTH
WHERE SUBSTR(LOGIN_DT, 1, 8) LIKE '202308%'
GROUP BY SUBSTR(LOGIN_DT, 1, 8), SUBSTR(LOGIN_DT, 9, 2) WITH ROLLUP
ORDER BY YYYYMMDD, TIME;



8월 전체 ACCOUNT_ID 집계, 8월 일자별 집계(8/1, 8/2 ...), 8월 일자별 시간별 집계(8/1 00시 집계, 01시 집계 ... 23시 집계
시간별, 일자별, 전체로 소계 및 집계
GROUP BY 순서에 따라 집계되는 결과도 달라진다.
	

