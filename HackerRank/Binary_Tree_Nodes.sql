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


-- 처음에 in절에서 is not null 조건을 넣지 않고 쿼리를 실행했을 때 오류가 생겼다.
-- in절에서 사용하는 컬럼에 null값이 존재하기 때문에 해커랭크에서 ~no response on stdout~ 오류가 발생한 것임
-- in/not in, exists/not exists를 사용할 때는 해당 조건에 null이 포함되지 않도록 해야하는 것인가..!
/*
select *
from bst
where n = null
*/ 
-- 에서도 같은 오류가 발생했다. in은 =과 or을 같이 쓴 연산자이기 때문이라고 한다.
-- 또 추가로 exists랑 in과 다른 게, exists는 하나라도 앞에서 일치하는 게 나오면 그때 exists문을 통해 종료해버려서, 뒤쪽에 null이 있더라도 오류가 나지 않을 수 있다고 한다.

-- in, exists를 사용할 때는 null값을 잘 생각하자 ! ! !

-- 문제 출처: https://www.hackerrank.com/challenges/binary-search-tree-1/problem?isFullScreen=true
