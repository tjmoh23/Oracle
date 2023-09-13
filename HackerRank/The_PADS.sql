-- 두 개의 결괏값 출력하기
-- 두 번째 결괏값 GROUP BY 사용해서 이런 형태로도 표현할 수 있다는 것 알아두자.

SELECT
    NAME||'('||SUBSTR(OCCUPATION, 1, 1)||')'
FROM OCCUPATIONS
ORDER BY NAME;


SELECT
    'There are a total of '||COUNT(OCCUPATION)||' '||LOWER(OCCUPATION)||'s.' -- ★ There are a total of [occupation_count] [occupation]s.
FROM OCCUPATIONS
GROUP BY OCCUPATION
ORDER BY COUNT(OCCUPATION), OCCUPATION;


-- 문제 출처: https://www.hackerrank.com/challenges/the-pads/problem?isFullScreen=true
