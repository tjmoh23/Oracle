-- 강력하고 나이가 많은 비사악한 지팡이를 구입하는 데에 필요한 최소 금 갈레온의 수
-- 나이와 파워가 같을 경우 가장 저렴한 지팡이 고르기 -> rank() over(partition by)로 구분 짓기

select
    id, age, coins_needed, power 
from(
        select  
            w.id, wp.age, w.coins_needed, w.power,
            rank() over(partition by wp.age, w.power 
                        order by w.coins_needed) as rank
        from wands w, wands_property wp
        where w.code = wp.code
        and wp.is_evil = 0
    )
where rank = 1
order by power desc, age desc;


-- 문제 출처: https://www.hackerrank.com/challenges/harry-potter-and-wands/problem?isFullScreen=true
