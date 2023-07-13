SELECT PRODUCT_ID, PRODUCT_NAME, PRODUCT_CD, CATEGORY, PRICE 
FROM FOOD_PRODUCT
WHERE PRICE IN (SELECT MAX(PRICE)
                FROM FOOD_PRODUCT)

SELECT *
FROM FOOD_PRODUCT
WHERE PRICE = (SELECT MAX(PRICE)
                FROM FOOD_PRODUCT) 

-- 서브쿼리와 메인쿼리의 FROM절이 같으면 성능이 안 좋아질 수 있다



-- 리트 코드 문제에서 MAX()함수는 출력할 게 없으면 NULL을 반환한다.


SELECT NAME, DATETIME
FROM(
    SELECT NAME, DATETIME,
            ROW_NUMBER() OVER(ORDER BY DATETIME) AS RANK
    FROM ANIMAL_INS
    WHERE ANIMAL_ID NOT IN (SELECT ANIMAL_ID
                            FROM ANIMAL_OUTS)
    )
WHERE RANK IN (1,2,3);


-- DENSE_RANK가 아니라 ROW_NUMBER를 사용해야 한다!
-- 공동 순위가 있을 경우, DENSE_RANK를 사용하면 3마리 이상의 값이 나올 수 있다.



7/11 문제 풀이
면접 준비로 인해 면접 끝나고 정리하는 거로 하자
