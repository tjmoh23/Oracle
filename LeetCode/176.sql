-- 풀이 1
SELECT 
  MAX(SALARY) AS SECONDHIGHESTSALARY
FROM
  (
    SELECT 
      ID, SALARY, 
      DENSE_RANK() OVER(ORDER BY SALARY DESC) AS RANK
    FROM EMPLOYEE
  )
WHERE RANK = 2


-- 풀이 2
-- 1위 가격 지운 테이블에서 1위 가격 출력 (그렇게 되면 2위가 나오는 거임)
SELECT MAX(SALARY) AS SecondHighestSalary
FROM EMPLOYEE
WHERE SALARY NOT IN (SELECT MAX(SALARY)
                    FROM EMPLOYEE)



-- 만약 두 번째 값이 아예 없으면 NULL을 반환해야 하는데 그 부분에서 어떻게 해결해야할지 고민되었다
-- MAX함수는 값이 없으면 NULL이라도 반환을 해야하므로 MAX함수 사용하여 NULL값 표현해줌
-- 문제 출처: https://leetcode.com/problems/second-highest-salary/description/
