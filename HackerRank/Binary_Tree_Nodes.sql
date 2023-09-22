-- 트리 노드 문제

select
    n,
    case
    when n not in (select p
                   from bst
                   where p is not null) then 'Leaf'
    when p is null then 'Root'
    else 'Inner'
    end 
from bst
order by n;

-- 문제 출처: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true
