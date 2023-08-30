-- 4개 테이블 JOIN한 쿼리
-- 부모 쿼리와 자식 쿼리 어떻게 조인할지 잘 확인하기

SELECT
    HACKER_ID, NAME
FROM(
    SELECT 
        S.HACKER_ID, H.NAME, S.CHALLENGE_ID
    FROM HACKERS H, DIFFICULTY D, CHALLENGES C, SUBMISSIONS S
    WHERE S.HACKER_ID = H.HACKER_ID
    AND C.DIFFICULTY_LEVEL = D.DIFFICULTY_LEVEL
    AND S. CHALLENGE_ID = C.CHALLENGE_ID
    AND S.SCORE = D.SCORE
    )
GROUP BY HACKER_ID, NAME
HAVING COUNT(CHALLENGE_ID) >= 2      -- COUNT(*)
ORDER BY COUNT(CHALLENGE_ID) DESC, HACKER_ID;      -- COUNT(*)


-- 문제 출처: https://www.hackerrank.com/challenges/full-score/problem?isFullScreen=true