-- CONCAT: 문자열 합치기
SELECT 
    FIRST_NAME,
    LAST_NAME,
    CONCAT(FIRST_NAME, LAST_NAME) AS NAME 
FROM EMPLOYEES;


-- || 사용하여 문자열 합치기
-- " " 큰따옴표는 오류 발생, 사이에 띄어쓰기 있을 때 큰 따옴표 사용
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME 
FROM EMPLOYEES;


-- SUBSTR: 문자열 자르기
SELECT 
    TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') AS ORDER_DATE,
    SUBSTR(ORDER_DATE, 1, 4) AS 주문년도,
    SUBSTR(ORDER_DATE, 6, 2) AS 주문월, -- 6번째부터 2글자 가져오기
    SUBSTR(ORDER_DATE, 9, 2) AS 주문일
FROM ORDERS;


-- TO_CHAR: 숫자나 날짜를 문자열로 변환
-- TO_NUMBER: 문자열을 숫자로 변환
-- TO_DATE: 문자열을 날짜로 변환


SELECT 
    TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') AS ORDER_DATE,
    EXTRACT(YEAR FROM ORDER_DATE) AS 주문년도, -- 필요한 부분 추출
    EXTRACT(MONTH FROM ORDER_DATE) AS 주문월,
    EXTRACT(DAY FROM ORDER_DATE) AS 주문일
FROM ORDERS;


SELECT
    CATEGORY_ID, -- 무조건! 그룹바이한 카테고리를 먼저 써야한다
    ROUND(AVG(STANDARD_COST), 2) AS AVG_COST,
    ROUND(AVG(LIST_PRICE), 2) AS AVG_PRICE
FROM PRODUCTS
GROUP BY CATEGORY_ID
HAVING AVG(STANDARD_COST) > 1000
AND AVG(LIST_PRICE) > 1400
ORDER BY CATEGORY_ID; -- 보통 그룹바이한 카테고리를 오더바이 한다
