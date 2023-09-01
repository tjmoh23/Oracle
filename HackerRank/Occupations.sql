-- 행과 열 바꾸는 PIVOT 활용
-- 직업 아래에 이름이 표시되도록 직업 열을 피봇
-- 알파벳순으로 정렬


SELECT
    MIN(CASE WHEN OCCUPATION = 'Doctor' THEN NAME ELSE NULL END),
    MIN(CASE WHEN OCCUPATION = 'Professor' THEN NAME ELSE NULL END),
    MIN(CASE WHEN OCCUPATION = 'Singer' THEN NAME ELSE NULL END),
    MIN(CASE WHEN OCCUPATION = 'Actor' THEN NAME ELSE NULL END)
FROM(
        SELECT
            OCCUPATION, NAME, 
            ROW_NUMBER() OVER(PARTITION BY OCCUPATION
                              ORDER BY NAME) AS NB
        FROM OCCUPATIONS
    )
GROUP BY NB
ORDER BY NB;


-- 문제 출처: https://www.hackerrank.com/challenges/occupations/problem?isFullScreen=true
