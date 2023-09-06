-- 길이가 가장 짧은 도시명과 가장 긴 도시명 구하기
-- 하나의 쿼리에서 출력물을 나타내야 하는 줄 알았는데 문제 제일 밑에 두 개의 쿼리를 사용해서 풀어도 된다고 했다. 
-- 즉 UNION을 할 필요가 없다는 말..

-- 내 풀이
SELECT 
    CITY, LEN
FROM (
        SELECT
            CITY,
            LENGTH(CITY) AS LEN,
            ROW_NUMBER() OVER(ORDER BY LENGTH(CITY), CITY) AS RANK
        FROM STATION
    )
WHERE RANK = 1
UNION -- UNION 없어도 된다.
SELECT
    CITY, LEN
FROM(
        SELECT
            CITY, 
            LENGTH(CITY) AS LEN,
            ROW_NUMBER() OVER(ORDER BY LENGTH(CITY) DESC, CITY) AS RANK
        FROM STATION
    )
WHERE RANK = 1;



-- 다른 풀이
-- ROWNUM을 사용하여 정렬값에서 1개만 출력하는 방법도 있다.
SELECT
    CITY, LEN
FROM (
        SELECT
            CITY, LENGTH(CITY) LEN
        FROM STATION
        ORDER BY LEN, CITY
    )
WHERE ROWNUM = 1
;

SELECT
    CITY, LEN
FROM (
        SELECT
            CITY, LENGTH(CITY) LEN
        FROM STATION
        ORDER BY LEN DESC, CITY
    )
WHERE ROWNUM = 1
;


-- 문제 출처: https://www.hackerrank.com/challenges/weather-observation-station-5/problem?isFullScreen=true
