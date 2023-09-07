-- 정렬 시, 각 이름의 마지막 세 문자 순으로 정렬하기
-- SUBSTR()를 ORDER BY에서도 쓸 수 있구나!

SELECT
    NAME
FROM STUDENTS
WHERE MARKS > 75
ORDER BY SUBSTR(NAME, -3), ID;

-- 문제 출처: https://www.hackerrank.com/challenges/more-than-75-marks/problem?isFullScreen=true
