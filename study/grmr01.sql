1. 몫 구하기
오라클에서 몫을 구할 때는 /을 이용하여 나누기 연산을 한다.
/을 사용하면 소수점까지 모두 출력하고,
FLOOR()로 감싸주면 정수만 출력한다. -- FLOOR(): 내림함수


SELECT
  DISTINCT CITY,
  ID/2,
  FLOOR(ID/2)
FROM STATION;



2. 나머지 구하기
오라클에서는 %로 나머지를 구할 수 없고  MOD() 함수를 사용하여 구한다.
MOD(A, B): A를 B로 나눈 나머지 출력


SELECT
    DISTINCT CITY
FROM STATION
WHERE MOD(ID, 2)=0;

