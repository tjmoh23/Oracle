-- 리트코드 CROSS JOIN 문제 정답
SELECT 
    S.STUDENT_ID, S.STUDENT_NAME, S.SUBJECT_NAME, COUNT(E.SUBJECT_NAME) AS attended_exams
FROM (
    SELECT ST.STUDENT_ID, ST.STUDENT_NAME, SU.SUBJECT_NAME
    FROM STUDENTS ST CROSS JOIN SUBJECTS SU
      ) S, EXAMINATIONS E
WHERE S.STUDENT_ID = E.STUDENT_ID(+)
AND S.SUBJECT_NAME = E.SUBJECT_NAME(+)
GROUP BY S.STUDENT_ID, S.STUDENT_NAME, S.SUBJECT_NAME
ORDER BY S.STUDENT_ID, S.SUBJECT_NAME
  

  
COUNT(*)로 하게 되면 NULL 값도 함께 계산한다.
COUNT(*)는 전체 행수를 센다. 따라서 NULL 값도 계산한다.
COUNT(컬럼명)은 행수를 보는데 거기서 그에 해당하는 값까지 본다. 따라서 NULL 값은 계산 안 한다.
COUNT(컬럼명)을 쓰게 된다면 NULL 값은 무시하고 계산한다.

다중행 연산자: IN, ANY, SOME, ALL
단일행 연산자: =, >, < ...

다중행 연산자(ANY, SOME, ALL) + 단일행 연산자(=, >, <)

ORDER_ID가 1인 상품들의 QUANTITY
-> 116, 77, 52... -> 다중행

* ANY: 하나만 TRUE여도 TRUE
  ANY 대신 LEAST를 사용해도 되지만 LEAST 안은 숫자가 되어야 한다.
  LEAST는 값 집합 중에서 최소값 하나만 반환. 따라서 단일행 연산자를 사용해야한다!
  GREATEST는 값 집합 중에서 최대값을 반환

* ALL: 모두 TRUE여야 TRUE
* SOME: ANY와 똑같다고 생각하면 된다. 차이점 없고 의미가 똑같다.




FETCH FIRST 와 비슷한 ROWNUM 을 알아보자.

* ROWNUM: 1, 2, 3, 4 ... 행 번호를 표현
SELECT
FROM EMPOLYEES
WHERE ROWNUM <= 10; 
-- 정렬 안 된 원본 데이터에서 10개 추출
-- 원본 데이터에서 행 번호가 10보다 작거나 같은 행을 추출
-- SELECT절에 쓸 필요없고 단지 WHERE절에 장착되어 있는 기능이라고 생각하면 된다. 
-- '='만 사용하면 안 된다! 반드시 부등호도 함께 시작해야한다. 10번째 행만 갖고 오는 게 아니다. 
-- 무조건 <= (작거나 같다)만 가능하다. 크거나 같다, 같다는 안 된다!




-- 입사일이 빠른 순서대로 10명?
SELECT * -- 3
FROM EMPLOYEES -- 1
WHERE ROWNUM <= 10 -- 2
ORDER BY HIRE_DATE ASC -- 4 / 이렇게 풀면 안 된다. 이건 정렬 안 된 원본 데이터에서 10개 가져온 거다.

그럼 어떻게 할까?
  
SELECT *
FROM(
      SELECT *
      FROM EMPLOYEES
      ORDER BY HIRE_DATE ASC
    )
WHERE ROWNUM <= 10 -- 이렇게 푼다!

다음과 같이 풀 수도 있다.

SELECT *
FROM EMPLYEES
ORDER BY HIRE_DATE ASC
FETCH FIRST 10 ROWS ONLY; 
-- FETCH FIRST 7 ROWS WITH TIES; 는 같은 제일 마지막 행을 보고 같은 데이터가 있으면 그대로 출력한다는 의미.
-- 6번째 행까지는 입사일 안 보고 그냥 가져 온다. 7번째 행은 입사일을 본다.
-- 6번째 행까지는 입사일이 같다고 하더라도 상관없이 순서를 부여한다. 같든 말든 상관없다. ROWNUM과의 차이점이라고 할 수 있겠다.



* SUBSTR
SELECT
  STANDARD_COST, LIST_PRICE, SUBSTR(DESCRIPTION, 1, INSTR(DESCRIPTION, ':') - 1) AS "구분"
FROM PRODUCTS
-- INSTR: 숫자로 변경해주는 함수
-- INSTR(DESCRIPTION, ':') - 1는 ':' 바로 앞에 있는 문자열까지의 위치를 반환
-- 만약 어렵다고 느껴진다면? REGEXP_SUBSTR(DESCRIPTION, '[^:]+', 1, 1) AS "구분2" 로 사용한다. 더 쉽다! ! !
-- +를 안 쓰면 앞글자 하나만 나온다. 전체를 다 나오게 하려면 +를 써야한다.




-- https://leetcode.com/problems/restaurant-growth/ 문제 풀어오기
