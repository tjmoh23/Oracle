중복 데이터 확인하는 방법
ALL: 중복 데이터 모두 출력(기본값)
DISTINCT: 중복 데이터를 1건으로 출력

SELECT SALESMAN_ID -- SALESMAN_ID 값 모두 출력
FROM ORDERS;

SELECT ALL SALESMAN_ID -- 기본값이므로 위 쿼리와 똑같이 출력
FROM ORDERS;

SELECT DISTINCT SALESMAN_ID
FROM ORDERS;


-- IN 연산자
SELECT REGION_NAME, COUNTRY_NAME
FROM REGIONS R, COUNTRIES C
WHERE R.REGION_ID = C.REGION_ID
AND REGION_NAME IN ('Asia', 'Europe')
/*
REGION_NAME = 'Asia' 
OR REGION_NAME = 'Europe'
*/
ORDER BY REGION_NAME;


-- 서브쿼리
서브쿼리 종류
- 스칼라 서브쿼리: SELECT 절에 쓰는 서브쿼리
- 인라인 뷰: FROM 절에 쓰는 서브쿼리
- 중첩 서브쿼리: WHERE 절에 쓰는 서브쿼리

중첩 서브쿼리
- 단일행 서브쿼리: 서브쿼리로 반환되는 결과가 하나. '=' 가능, IN 가능
- 다중행 서브쿼리: 서브쿼리로 반환되는 값이 여러 개. '=' 불가능, IN 가능

SELECT MANAGER_ID, COUNT(*) AS C
FROM EMPLOYEES
GROUP BY MANAGER_ID
ORDER BY MANAGER_ID; 


SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE MANAGER_ID = 3); -- 단일행 서브 쿼리('=' 사용)
                    

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE MANAGER_ID = 1); -- 다중행 서브 쿼리
       

문제) 제일 최근에 고용한 직원과 고용한지 제일 오래된 직원을 추출하는 쿼리
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME, LAST_NAME,
    EMAIL, PHONE, MANAGER_ID, 
    TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE,
    JOB_TITLE
FROM EMPLOYEES
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) 
                    FROM EMPLOYEES) /*가장 오래된 직원*/
OR HIRE_DATE = (SELECT MAX(HIRE_DATE)
                    FROM EMPLOYEES); /*가장 최근 고용된 직원*/
    -- 인라인 뷰를 써야 효율이 좋다
    -- 중첩 서브 쿼리는 성능이 안 좋다

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE
FROM (
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE,
    ROW_NUMBER() OVER(ORDER BY HIRE_DATE) MIN_DATE,
    ROW_NUMBER() OVER(ORDER BY HIRE_DATE DESC) MAX_DATE
FROM EMPLOYEES ) 
WHERE MIN_DATE = 1
OR MAX_DATE = 1
ORDER BY HIRE_DATE ASC; -- 중첩서브 쿼리를 사용하면 성능이 떨어지는 케이스


※ 메인 쿼리에 있는 쿼리와 서브쿼리에 있는 쿼리가 같으면 안 된다!


-- JOIN(조인)
SELECT *
FROM COUNTRIES C, REGIONS R -- ,로 나열하기
WHERE R.REGION_ID = C.REGION_ID; -- ★, 별칭 지정 필요


SELECT *
FROM COUNTRIES C JOIN REGIONS R -- JOIN으로 나열하기(디폴트 INNER JOIN)
ON R.REGION_ID = C.REGION_ID;


[INNER JOIN 의 특수한 조인]
-- NATURAL JOIN
부모테이블의 기본키와 자식테이블의 외래키의 컬럼명, 데이터 타입이 같으면 쓸 수 있는 조인 방법
조인 조건 없음, 별칭 지정 필요 없다
SELECT *
FROM REGIONS NATURAL JOIN COUNTRIES; -- '★ 쿼리'와 똑같은 결과물이 나온다


-- USING 절
SELECT *
FROM REGIONS JOIN COUNTRIES
USING (REGION_ID); -- 바로 위 쿼리와 '★ 쿼리'와 똑같은 결과물이 나온다, 별칭 지정 필요 없다


-- 3개 테이블 조인
SELECT
    R.REGION_NAME,
    C.COUNTRY_NAME,
    L.CITY, L.STATE
FROM REGIONS R, COUNTRIES C, LOCATIONS L
WHERE R.REGION_ID = C.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID


-- 네추럴 조인로 해보기
SELECT
    REGION_NAME,
    COUNTRY_NAME,
    CITY, STATE
FROM REGIONS NATURAL JOIN COUNTRIES NATURAL JOIN LOCATIONS;


-- USING 절로 해보기
SELECT *
FROM REGIONS JOIN COUNTRIES
USING (REGION_ID)
JOIN LOCATIONS
USING (COUNTRY_ID);


[정리]
NATURAL JOIN 과 USING 은 INNER JOIN 의 특수한 JOIN 이다

NATURAL JOIN
- 양쪽 테이블 간 컬럼명, 타입이 같은 키를 자동으로 조인(조인 조건이 없다)
- NATURAL JOIN 에 사용된 컬럼은 Alias를 쓰면 오류가 난다

USING
- 조인하는 컬럼은 양쪽 테이블 간 컬럼명, 타입이 같아야 한다
- 조인 조건으로 USING (공통된 컬럼)
- USING 절에 묶인 컬럼으로만 조인이 된다


조인을 쓰면 성능이 떨어지는 케이스
1. 조인을 하면서 DISTINCT 를 써야하는 케이스
 DISTINCT 는 성능이 안 좋아지게 하는 것이기 때문에 어쩔 수 없는 상황에서만 써야 한다
 예를 들어, 매니저 역할을 하고 있는 직원의 아이디, FIRST_NAME, LAST_NAME을 조회하는
 SQL 쿼리문을 작성해야할 경우

-- 비효율적
SELECT DISTINCT MA.EMPLOYEE_ID, MA.FIRST_NAME, MA.LAST_NAME
FROM EMPLOYEES EM, EMPLOYEES MA
WHERE EM.MANAGER_ID = MA.EMPLOYEE_ID
ORDER BY MA.EMPLOYEE_ID;

-- 효율적
-- 매니저를 하고 있는 직원들을 먼저 WHERE IN 으로 뽑아온 후, 해당 메인 쿼리에서 원하는 데이터 받아온다
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID
                        FROM EMPLOYEES)
ORDER BY EMPLOYEE_ID;


-- 비효율적
SELECT DISTINCT R.REGION_ID, R.REGION_NAME
FROM REGIONS R, COUNTRIES C
WHERE R.REGION_ID = C.REGION_ID
ORDER BY R.REGION_ID;


-- 효율적
SELECT REGION_ID, REGION_NAME
FROM REGIONS
WHERE REGION_ID IN (SELECT REGION_ID
                     FROM COUNTRIES)
ORDER BY REGION_ID;

