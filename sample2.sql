ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD (DAY) HH24:MI:SS'
-- DAY를 지우면 요일은 없어진다

SELECT SYSDATE
FROM DUAL;


ALTER SESSION SET NLS_LANGUAGE = 'ENGLISH' 
-- 'KOREAN' 으로 바꾸면 오류 메시지 한글로 뜬다

SELECT MANAGER_ID, COUN(*) C -- 오류 내보기
FROM EMPLOYEES
GROUP BY MANAGER_ID;


단일행 함수
CONCAT(문자열 합치기)
SUBSTR(문자열 자르기)
LENGTH(문자열 길이)
TRIM(문자열/공백 제거)


-- LENGTH(문자열 길이)
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES;

SELECT NAME, LENGTH(NAME) AS LEN
FROM(
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM EMPLOYEES) T;


-- TRIM(문자열/공백 제거)
SELECT  
    TRIM(LEADING 'A' FROM 'AAB   ') AS C1, -- A 제거하고 공백 제거
    TRIM(LEADING FROM 'AAB   ') AS C2, -- 앞에서부터 공백 제거
    TRIM(TRAILING 'B' FROM 'AAB   ') AS C3, -- B 제거하고 공백 제거
    TRIM(TRAILING FROM 'AAB   ') AS C4, -- 뒤에서부터 공백 제거
    TRIM(BOTH 'A' FROM 'AAB   ') AS C5, -- 양쪽에서 공백 제거
    TRIM(BOTH FROM 'AAB   ') AS C6,
    TRIM('A' FROM 'AAB   ') AS C7, -- BOTH와 똑같다(defalut값)
    TRIM('AAB   ') AS C8
FROM DUAL;


단일행 함수는
문자형 함수 : CONCAT, SUBSTR, LENGTH,TRIM
변환 함수 : TO_CHAR, TO_NUMBER, TO_DATE
NULL 함수 : NVL, NVL2, COALESCE


-- 널값 채우기(NVL)
SELECT 
    ADDRESS,
    POSTAL_CODE,
    CITY,
    NVL(STATE, 'No Data') AS STATE -- 널값 'No Data'로 채우기 
FROM LOCATIONS;


SELECT
    NVL2(1, 2, 3) AS A1, -- 첫 번째 값이 널이 아니면 두 번째 값 넣기
    NVL2(NULL, 2, 3) AS A2 -- 첫 번째 값이 널이면 세 번째 값 넣기
FROM DUAL;


-- 처음으로 널이 아닌 값 반환(COALESCE 함수)
SELECT
    COALESCE(1, 2, 3) AS A1,
    COALESCE(NULL, 2, 3) AS A2,
    COALESCE(NULL, NULL, 3) AS A3
FROM DUAL; -- 하나의 행으로 반환



다중행 함수: 여러 행의 그룹에 대해 적용되는 함수
- 집계 함수
 COUNT, SUM, AVG, MAX, MIN
GROUP BT와 함께 쓴다

- 고급 집계 함수
 ROLLUP, CUBE, GROUPING SETS
 
- 윈도우 함수

GROUP BY 규칙
GROUP BY 한 컬럼 외에는 다른 컬럼이 SELECT 절에 올 수 없다
SELECT 절에는 GROUP BY 한 컬럼 + 집계함수
집계함수는 여러 개 쓰는 것이 가능하다


SELECT 
    PRODUCT_ID, 
    ROUND(AVG(QUANTITY), 2) AS AVG_QUANTITY,
    AVG(UNIT_PRICE),
    MAX(QUANTITY),
    MIN(QUANTITY) -- 이렇게 집계함수는 SELECT 절에 올 수 있다
FROM ORDER_ITEMS
GROUP BY PRODUCT_ID
ORDER BY PRODUCT_ID;


-- JOIN
기본키: 테이블에 있는 모든 행들을 식별할 수 있는 컬럼
예) 학번

기본키 제약 조건
1. NOT NULL
    기본키라고 하면, 반드시 값을 가져야 한다
2. 중복값 X
    학번과 같은 고유값은 중복이 있으면 안 되겠지요
제약 조건을 만족하는 컬럼이 한 테이블에 두 개 이상이라면
둘 중에 좀 더 적합한 것 하나를 픽해야 한다

기본키로 잡는 것을 피해야 하는 컬럼
1. 이름(동명이인)
2. 변경 가능성이 있는 컬럼(주소, 전화번호)
    기본키는 자주 바뀌지 않는 것으로 해야한다
3. 컬럼값이 긴 컬럼(주민등록번호)

기본키로 잡으면 좋은 컬럼
- ID(고유 번호, 영구 불변, 컬럼값이 짧음)


DESCRIBE REGIONS; -- 기본키 찾기: NOT NULL 중 최적 컬럼 고른다
DESCRIBE PRODUCTS;
DESCRIBE EMPLOYEES;
-- PK: 기본키
-- FK: 외래키

-- 기본값 설정하기 위해 중복값 확인
SELECT HIRE_DATE, COUNT(*) AS C
FROM EMPLOYEES
GROUP BY HIRE_DATE;
-- 기본값이 두 개일 수도 있다. 


두 테이블을 조인하기 위해서는 외래키가 필요하다
JOIN 규칙
1. 자식 테이블은 부모 테이블로부터 기본키를 상속받는다
    자식 테이블 입장에서는 상속받은 키를 외래키라고 한다

조인 조건
ON 부모테이블.기본키 = 자식테이블.외래키
(자식테이블.외래키 = 부모테이블.기본키)

SELECT *
FROM COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID; 
-- 조인된 테이블에서는 REGION_ID 컬럼이 중복이므로 기본키로 사용할 수 없다

SELECT *
FROM LOCATIONS L, COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID;
-- 2개 테이블을 조인할 때는 1개의 외래키 필요
-- 3개 테이블을 조인할 때는 2개의 외래키 필요

즉, N개의 테이블을 조인할 때는 N-1개의 외래키가 필요하다
외래키로 사용된 컬럼은 조인된 테이블에서는 더이상 기본키로 사용할 수 없다

SELECT *
FROM WAREHOUSES W, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID
AND L.LOCATION_ID = W.LOCATION_ID
ORDER BY W.WAREHOUSE_ID;

[정리]
외래키의 행 개수만큼 행이 만들어진다
조인조건에 쓰인 외래키 컬럼은 조인된 테이블에서 기본키로 쓸 수 없다
외래키로 안 쓰인 컬럼 중에서 다시 기본키를 잡아야 한다

