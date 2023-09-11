-- 삼각형 종류 나누기

SELECT
    CASE
    WHEN A+B <= C THEN 'Not A Triangle'
    WHEN A=B AND B=C AND C=A THEN 'Equilateral'
    WHEN A!=B AND B!=C AND C!=A THEN 'Scalene'
    ELSE 'Isosceles' END
FROM TRIANGLES;

-- 문제 출처: https://www.hackerrank.com/challenges/what-type-of-triangle/problem?isFullScreen=true
