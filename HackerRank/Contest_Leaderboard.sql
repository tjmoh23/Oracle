-- 내 풀이

SELECT H.HACKER_ID, H.NAME, S.TOTAL_SCORE
FROM HACKERS H, 
                (SELECT
                    HACKER_ID, SUM(MAX_SCORE) AS TOTAL_SCORE
                FROM (
                        SELECT
                            HACKER_ID, CHALLENGE_ID, MAX(SCORE) AS MAX_SCORE
                        FROM SUBMISSIONS
                        GROUP BY HACKER_ID, CHALLENGE_ID
                        ORDER BY HACKER_ID, CHALLENGE_ID
                    )
                GROUP BY HACKER_ID
                ORDER BY TOTAL_SCORE DESC) S
WHERE H.HACKER_ID = S.HACKER_ID
AND S.TOTAL_SCORE != 0
ORDER BY S.TOTAL_SCORE DESC, H.HACKER_ID;


-- SELECT절 3번 쓸 필요없이 2번 SELECT절에서 바로 JOIN 한 후 GROUP BY, SUM 하면 된다.
-- 더 간단하게 풀 수 있다!


-- 다른 풀이

SELECT H.HACKER_ID, H.NAME, SUM(T.SCORE) TOTAL_SCORE
FROM HACKERS H, (
        SELECT HACKER_ID, CHALLENGE_ID, MAX(SCORE) AS SCORE
        FROM SUBMISSIONS S
        GROUP BY HACKER_ID, CHALLENGE_ID
    ) T
WHERE H.HACKER_ID = T.HACKER_ID
GROUP BY H.HACKER_ID, H.NAME
HAVING SUM(T.SCORE) > 0
ORDER BY TOTAL_SCORE DESC, HACKER_ID ASC
;


-- 문제 출처: https://www.hackerrank.com/challenges/contest-leaderboard/problem?isFullScreen=true
