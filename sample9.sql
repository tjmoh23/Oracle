-- CASE WHEN 조건절 사용하기
SELECT QUANTITY,
    CASE 
    WHEN QUANTITY < 50 THEN '50미만'
    WHEN QUANTITY BETWEEN 50 AND 100 THEN '50 이하 100 이상'
    ELSE '100 초과' END AS QUANTITY_GROUP
FROM ORDER_ITEMS
ORDER BY QUANTITY ASC;


-- 정규 표현식
SELECT STATE
FROM LOCATIONS
WHERE REGEXP_LIKE(STATE, '^[sbo]', 'i')
-- ^: 시작 패턴 (예) '^[sbo]'
-- $: 끝나는 패턴 (예) '[sbo]$'
-- 'i': 대소문자 무시 / 쓰지 않는다면 대소문자 구분한다
-- [ ]: 문자 하나씩 고려 / 쓰지 않는다면 하나의 문자열로 본다 (예)'^[South]' / '^South'
-- 두 개의 조건을 만족하고 싶다면 AND 절로 써야 한다! 한번에 쓸 수 있는데 다른 조건이 필요함
