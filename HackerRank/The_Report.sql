-- 다른 방법 있는지 확인해보기
-- 특정 성적 이하의 학생 이름은 NULL로 표현

SELECT
    MN,
    CASE 
    WHEN MARKS BETWEEN 0 AND 9 THEN 1 
    WHEN MARKS BETWEEN 10 AND 19 THEN 2
    WHEN MARKS BETWEEN 20 AND 29 THEN 3
    WHEN MARKS BETWEEN 30 AND 39 THEN 4
    WHEN MARKS BETWEEN 40 AND 49 THEN 5
    WHEN MARKS BETWEEN 50 AND 59 THEN 6
    WHEN MARKS BETWEEN 60 AND 69 THEN 7
    WHEN MARKS BETWEEN 70 AND 79 THEN 8
    WHEN MARKS BETWEEN 80 AND 89 THEN 9
    ELSE 10 END AS GRADE,
    MARKS
FROM(
        SELECT
            NAME,
            MARKS,
            CASE WHEN MARKS >= 70 THEN NAME ELSE NULL END AS MN
        FROM STUDENTS
    )
ORDER BY GRADE DESC, NAME;



-- 일일이 case when 사용하지 않고 grades 테이블을 바로 조인할 수 있다.
-- 공통된 키가 없더라도 조인 가능!

-- 다른 풀이
select
    case 
    when marks >= 70 then name else null end as name,
    grade, marks
from(
        select
            s.name, g.grade, g.min_mark, s.marks, g.max_mark
        from students s, grades g
        where s.marks between g.min_mark and g.max_mark -- 조인을 이렇게도 할 수 있다 ★★★ !!!
    )
order by grade desc, name;

-- 문제 출처: https://www.hackerrank.com/challenges/the-report/problem?isFullScreen=true
