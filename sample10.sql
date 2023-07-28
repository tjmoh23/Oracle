--  https://school.programmers.co.kr/learn/courses/30/lessons/131124
-- 프로그래머스 정답이 아닌데도 정답 처리되는 문제 해결하기

-- 내 풀이
-- 매우 복잡한 느낌..
SELECT 
    P.MEMBER_NAME, R.REVIEW_TEXT, 
    TO_CHAR(R.REVIEW_DATE, 'YYYY-MM-DD') AS REVIEW_DATE
FROM MEMBER_PROFILE P, REST_REVIEW R
WHERE P.MEMBER_ID = R.MEMBER_ID
AND P.MEMBER_ID IN (SELECT MEMBER_ID
                    FROM(
                        SELECT 
                            MEMBER_ID,
                            DENSE_RANK() OVER(ORDER BY CNT DESC) AS RANK
                        FROM(
                            SELECT 
                                MEMBER_ID,
                                COUNT(REVIEW_ID) AS CNT
                            FROM
                            (   SELECT 
                                  P.MEMBER_ID, 
                                  P.MEMBER_NAME, R.REVIEW_ID, R.REVIEW_TEXT, R.REVIEW_DATE
                                FROM MEMBER_PROFILE P, REST_REVIEW R
                                WHERE P.MEMBER_ID = R.MEMBER_ID
                            )
                            GROUP BY MEMBER_ID
                            )    
                        )
                    WHERE RANK = 1)
ORDER BY REVIEW_DATE, REVIEW_TEXT 


  
-- 상빈님 풀이
SELECT M.MEMBER_NAME, R.REVIEW_TEXT, TO_CHAR(R.REVIEW_DATE, 'YYYY-MM-DD') AS REVIEW_DATE
FROM MEMBER_PROFILE M, REST_REVIEW R
WHERE M.MEMBER_ID = R.MEMBER_ID
AND M.MEMBER_ID IN (
        SELECT
            MEMBER_ID
        FROM REST_REVIEW
        GROUP BY MEMBER_ID
        ORDER BY COUNT(*) DESC
        FETCH FIRST 1 ROWS WITH TIES
    )
ORDER BY REVIEW_DATE ASC, REVIEW_TEXT ASC;


-- 먼저 리뷰를 가장 많이 작성한 회원을 리뷰 테이블에서 가져온 후 (가장 많은 리뷰를 쓴 회원순으로 정렬),  # 1
-- FETCH FIRST 1 ROWS WITH TIES를 사용하여 제일 상단에 있는 행을 가져오도록 한다. # 2
-- FETCH FIRST 1 ROWS ONLY와  FETCH FIRST 1 ROWS WITH TIES의 차이점?
-- FETCH FIRST 1 ROWS ONLY은 딱 하나의 데이터만 출력하므로, 이걸 사용할 경우 가장 많은 리뷰를 작성한 회원이 여러 명일지라도 그 중 상위에 있는 데이터만 가져오므로 안 된다!
-- FETCH FIRST 1 ROWS WITH TIES를 사용하면 가장 많은 리뷰를 작성한 회원이 여러 명일 경우 모든 회원을 출력한다.
-- 다시 말해, FETCH FIRST 1 ROWS WITH TIES는 동순위이면 함께 출력, WITH TIES 대신 ONLY를 사용한다면 상위에 있는 데이터 딱 하나만 출력한다.
-- 그 후 회원 테이블과의 조인을 통해 필요한 내용을 출력한다. # 3

-- CROSS JOIN: 조인 조건이 없는 조인 방법
-- 모든 조합에 대해 조인한다.
-- 크로스 조인 관련 리트 코드 문제: https://leetcode.com/problems/students-and-examinations/
