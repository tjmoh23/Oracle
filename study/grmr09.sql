CONCAT(문자열1, 문자열2, ...)
문자열 이을 때 사용
  
CONCAT_WS(구분자, 문자열1, 문자열2, ...)
구분자와 함께 문자열을 이을 때 사용
  

SELECT
  CONCAT('2023', '10', '07')
  CONCAT_WS('-', '2023', '10', '07')
  CONCAT_WS('-', SUBSTR(BASE_DATE, 1, 4), SUBSTR(BASE_DATE, 5, 2), SUBSTR(BASE_DATE, 7, 2))
FROM TABLE


/*
[결괏값]
20231008
2023-10-07
BASE_DATE 컬럼에 해당하는 값을 구간별로 나누어 '-' 문자 삽입 
*/
