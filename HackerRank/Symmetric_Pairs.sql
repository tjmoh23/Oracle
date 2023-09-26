select
    a_x, a_y
from(
        select
            arnum, a.x as a_x, a.y as a_y, 
            brnum, b.x as b_x, b.y as b_y
        from(
                select
                    row_number() over(order by x) arnum,
                    x, y
                from functions
            ) a, (
                select 
                    row_number() over(order by x) brnum,
                    x, y
                from functions            
            ) b
        where a.x = b.y
)
where arnum != brnum
and a_y = b_x
and a_y >= a_x
order by a_x
;



-- 문제 출처: https://www.hackerrank.com/challenges/symmetric-pairs/problem?isFullScreen=true
