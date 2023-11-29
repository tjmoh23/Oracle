/*
CHOOSE 함수
CHOOSE(인덱스, 값1, 값2, .. 값N)
값들 중 인덱스에 해당하는 값 출력
인덱스에 해당하는 값이 없으면 NULL 출력
*/

SELECT
  CHOOSE(1, 'A', 'B', 'C'), -- A 
  CHOOSE(3, 'A', 'B', 'C'), -- C
  CHOOSE(4, 'A', 'B', 'C') -- NULL 출력
FROM SAMPLE_TABLE

  

/*
요일 반환(숫자)
DATEPART(WEEKDAY, GETDATE())
1: 일
2: 월
3: 화
4: 수
5: 목
6: 금
7: 토
*/

SELECT  
  DATEPART(WEEKDAY, GETDATE()) AS WEEKNUM,
  CHOOSE(DATEPART(WEEKDAY, GETDATE()), '일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일') AS TODAY
FROM SAMPLE_TABLE
