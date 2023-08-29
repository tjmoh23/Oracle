
-- 내 풀이
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



-- 더 간단한 다른 풀이
SELECT
    S.NAME
FROM(
        SELECT 
            S.ID, S.NAME, P.SALARY
        FROM STUDENTS S, PACKAGES P
        WHERE S.ID = P.ID
    ) S,
    (
        SELECT 
            F.ID, F.FRIEND_ID, P.SALARY
        FROM FRIENDS F, PACKAGES P
        WHERE F.FRIEND_ID = P.ID
    ) F
WHERE S.ID = F.ID
AND S.SALARY < F.SALARY
ORDER BY F.SALARY;



-- 문제 출처: https://www.hackerrank.com/challenges/placements/problem?isFullScreen=true
