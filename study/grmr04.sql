/*
조회된 자료에서 첫 번째 값 혹은 마지막 값 바로 추출하기
*/


1. FIRST_VALUE()
-- 조회한 테이블에서 첫 번째 값 추출하기
-- OVER()에 ORDER BY를 꼭 넣어줘야 한다.
-- (나 같은 경우는 5월을 기준으로 6~8월의 잔존율을 구하기 위해 5월 값을 컬럼으로 만들어서 계산식을 만들고 싶을 때 생각해냈다)

  
  select
    yyyymm, uv, first_value(uv) over(order by yyyymm) as min -- 5월 기준 컬럼 생성
  from(
    select
      substr(login_date, 1, 6) as yyyymm,
      count(distinct USER_ID) as uv -- 월별 로그인 고객 수
    from SAMPLE_DATA
    where date between 20230501 and 20230831
    group by substr(login_date, 1, 6)
  ) a
;




2. LAST_VALUE()
-- 조회한 테이블에서 마지막 값을 새로운 열에 표현해줄 때 사용
-- OVER()에서 ORDER BY를 사용해야 한다.
-- 추가로 데이터의 범위도 함께 설정해줘야 한다.(매번 행을 읽을 때 읽히고 있는 행이 마지막이 되기 때문에 범위를 설정해줘야 함!)
-- 조회한 데이터 전체 범위일 경우: BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING

select
  last_value(uv) over(order by yyyymmdd between unbounded preceding and unbounded following)
from SAMPLE_DATA

-- 출처 링크: https://zyngirok.com/entry/SQL-%EB%AC%B8%EB%B2%95-%EC%B6%94%EC%B6%9C-%ED%95%A8%EC%88%98-FIRSTVALUE-LASTVALUE
