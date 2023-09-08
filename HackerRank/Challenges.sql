-- 두 명 이상의 학생이 동일한 수의 챌린지를 생성했고 개수가 생성된 최대 챌린지 수보다 적은 경우 결과에서 해당 학생을 제외합니다.

-- 내 풀이
-- 1. RANK()로 순위 지정 후, COUNT OVER()로 해당 순위 개수를 센 후,
-- 2. CASE문으로 1등이 아니면서 총 합이 2개 이상인 행을 1로 선정
-- 3. 마지막에 0인 행들만 추출

SELECT
    HACKER_ID, NAME, CC
FROM(
        SELECT
            HACKER_ID, NAME, CC, 
            CASE WHEN (RANK != 1 AND RCNT >= 2) THEN 1 ELSE 0 END AS FINAL
        FROM(
                SELECT
                    HACKER_ID, NAME, CC, RANK,
                    COUNT(RANK) OVER(PARTITION BY RANK ORDER BY CC) AS RCNT
                FROM(
                        SELECT
                            C.HACKER_ID,
                            H.NAME,
                            COUNT(C.CHALLENGE_ID) AS CC,
                            DENSE_RANK() OVER(ORDER BY COUNT(C.CHALLENGE_ID) DESC) RANK
                        FROM CHALLENGES C, HACKERS H
                        WHERE C.HACKER_ID = H.HACKER_ID
                        GROUP BY C.HACKER_ID, H.NAME
                    )
            )
    )
WHERE FINAL = 0
ORDER BY CC DESC, HACKER_ID;



-- 문제 출처: https://www.hackerrank.com/challenges/challenges/problem?isFullScreen=true
-- 내가 이걸 풀다니 감격이다 ㅠㅠ
