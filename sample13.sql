-- 직접 만드신 문제 1
-- CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 대여기간(rental_period)을 반영한 CAR_ID 별 대여요금(rental_period * DAILY_FEE) 누적합 리스트(컬럼명 : CUMUL_SUM)를 추가하고 
-- CAR_ID, 대여기간, 일일 대여요금, 대여요금 누적합을 조회하는 SQL문을 작성해주세요.

SELECT 
    CAR_ID,
    RENTAL_PERIOD,
    DAILY_FEE,
    SUM(RENTAL_PERIOD*DAILY_FEE) OVER(PARTITION BY CAR_ID
                        ORDER BY HISTORY_ID
                        ROWS UNBOUNDED PRECEDING) AS CUMUL_SUM
FROM
(
    SELECT
    H.HISTORY_ID,
    H.CAR_ID,
    H.END_DATE - H.START_DATE + 1 AS RENTAL_PERIOD,
    C.DAILY_FEE
    FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H, CAR_RENTAL_COMPANY_CAR C
    WHERE H.CAR_ID = C.CAR_ID
)


-- 직접 만드신 문제 2
-- CAR_RENTAL_COMPANY_CAR 테이블과 CAR_RENTAL_COMPANY_RENTAL_HISTORY 테이블에서 고객이 가장 많이 렌트한 자동차 종류와 
-- 해당 자동차 종류의 옵션 리스트 중에서 후방카메라가 포함된 자동차의 옵션 리스트를 조회하는 쿼리를 작성해주세요. 최종 결과는 중복된 값이 없도록 해주세요.


-- 풀이 1)
SELECT DISTINCT CAR_TYPE, OPTIONS
FROM CAR_RENTAL_COMPANY_CAR
WHERE CAR_TYPE IN (
                    SELECT CAR_TYPE
                    FROM(
                            SELECT 
                                CAR_TYPE,
                                ROW_NUMBER() OVER(ORDER BY COUNT(HISTORY_ID) DESC) AS RANK
                            FROM CAR_RENTAL_COMPANY_RENTAL_HISTORY H, CAR_RENTAL_COMPANY_CAR C
                            WHERE H.CAR_ID = C.CAR_ID
                            GROUP BY CAR_TYPE )
                    WHERE RANK = 1 )
AND OPTIONS LIKE '%후방카메라%'


-- 풀이2) 상빈님 풀이
SELECT DISTINCT CAR_TYPE, OPTIONS
FROM CAR_RENTAL_COMPANY_CAR 
WHERE CAR_TYPE = (
    SELECT CAR_TYPE
    FROM (
        SELECT C.CAR_TYPE, COUNT(H.HISTORY_ID) AS CNT
        FROM CAR_RENTAL_COMPANY_CAR C, CAR_RENTAL_COMPANY_RENTAL_HISTORY H
        WHERE C.CAR_ID = H.CAR_ID
        GROUP BY C.CAR_TYPE
        ORDER BY CNT DESC
        FETCH FIRST 1 ROWS ONLY
    )
)
AND OPTIONS LIKE '%후방카메라%'



-- 문제 출처: https://school.programmers.co.kr/learn/courses/30/lessons/157341
