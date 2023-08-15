-- 어렵다 ;
-- 하나의 컬럼에 필요한 조건에 맞는 답을 두 개 갖고 와야 한다. 결과물 잘 보고 문제 풀자!!
-- 같은 값이 있으면 사전순으로 정렬해서 하나만 갖고 오게 해야 한다.

SELECT NAME AS RESULTS
FROM (
    SELECT U.NAME, COUNT(*) AS CNT
    FROM USERS U, MOVIERATING MR
    WHERE U.USER_ID = MR.USER_ID
    GROUP BY U.NAME
    ORDER BY CNT DESC, U.NAME ASC
)
WHERE ROWNUM <= 1

UNION ALL

SELECT TITLE AS RESULTS
FROM (
    SELECT TITLE, AVG(RATING) AS MOVIE_RATE
    FROM (
        SELECT *
        FROM MOVIES M, MOVIERATING MR
        WHERE M.MOVIE_ID = MR.MOVIE_ID
        AND MR.CREATED_AT LIKE '2020-02%'
    )
    GROUP BY TITLE
    ORDER BY MOVIE_RATE DESC, TITLE
)
WHERE ROWNUM <= 1


-- ROWNUM은 원본에서 하나만 가져옴
-- UNION과 UNION ALL 잘 선택해서 사용할 
-- 문제 출처: https://leetcode.com/problems/movie-rating/
