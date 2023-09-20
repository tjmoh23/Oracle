-- 연속적으로 이루어진 기간의 시작과 끝 날짜 출력하기
-- 조인의 다양한 활용

select
    start_date, end_date
from(
        select
            start_date,
            row_number() over(order by start_date) as rs
        from(
                select start_date
                from projects 
            ) sd,
            (
                select end_date
                from projects) ed
        where sd.start_date = ed.end_date(+)
        and ed.end_date is null
    ) sr,
    (
        select
            end_date,
            row_number() over(order by end_date) as re
        from(
                select start_date
                from projects 
            ) sd,
            (
                select end_date
                from projects) ed
        where sd.start_date(+) = ed.end_date
        and start_date is null
    ) er
where sr.rs = er.re
order by end_date - start_date, start_date;



-- 문제 출처: https://www.hackerrank.com/challenges/sql-projects/problem?isFullScreen=true
