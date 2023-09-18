/*
조회된 자료에서 첫 번째 값 혹은 마지막 값 바로 추출하기
*/


1. FIRST_VALUE()
-- 조회한 테이블에서 첫 번째 값 추출하기
-- OVER()에 ORDER BY를 꼭 넣어줘야 한다.
-- (나 같은 경우는 5월을 기준으로 6~8월의 잔존율을 구하기 위해 5월 값을 컬럼으로 만들어서 계산식을 만들고 싶을 때 생각해냈다)
  
2. LAST_VALUE()
-- 조회한 테이블에서 마지막 값을 새로운 열에 표현해줄 때 사용
-- OVER()에서 ORDER BY를 사용해야 한다.
-- 추가로 데이터의 범위도 함께 설정해줘야 한다.
-- 조회한 데이터 전체 범위일 경우: BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING


-- 출처 링크: https://zyngirok.com/entry/SQL-%EB%AC%B8%EB%B2%95-%EC%B6%94%EC%B6%9C-%ED%95%A8%EC%88%98-FIRSTVALUE-LASTVALUE
