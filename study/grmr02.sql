/*
[MySQL 날짜형 변환]
- CAST(BASE_DATE AS DATE)
- from_unixtime(BASE_DATE, '%Y-%m-%d')
  -> int형으로 저장된 유닉스 타임 시간을 datetime으로 변환해주는 함수
- convert(BASE_DATE, CHAR) -- 숫자를 문자로
- str_to_date(str, '%Y%m%d%H%i%s') -- 문자열에 날짜 및 시간 부분이 모두 포함된 경우 datetime 값을 반환
*/



-- base_date가 int 타입으로, 20230912 형태일 때
  
select
    cast(base_date as char), -- 20230912 숫자 -> 문자
    convert(BASE_DATE, CHAR) -- 20230912 숫자 -> 문자
    cast(base_date as date), -- 2023-09-12 
    from_unixtime(base_date, '%Y-%m-%d'), -- 1970-09-12
    str_to_date(cast(base_date as char), '%Y%m%d%H%i%s') -- 2023-09-12 00:00:00 문자 -> 날짜
from sample_table;



-- mysql 형변환 참고 링크
-- https://kwonyang.tistory.com/20
