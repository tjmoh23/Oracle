
SELECT
    S.NAME
FROM(
        SELECT
            STU.ID, STU.NAME, STU.SALARY, STU.FRIEND_ID, S.NAME AS F_NAME
        FROM (
                SELECT
                    S.ID, S.NAME, S.SALARY, F.FRIEND_ID
                FROM (
                        SELECT
                            S.ID, S.NAME, P.SALARY
                        FROM STUDENTS S, PACKAGES P
                        WHERE S.ID = P.ID ) S, FRIENDS F
                WHERE S.ID = F.ID) STU, STUDENTS S
        WHERE STU.FRIEND_ID = S.ID ) S, PACKAGES P
WHERE S.FRIEND_ID = P.ID
AND P.SALARY > S.SALARY
ORDER BY P.SALARY
;



-- 문제 출처: https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true
