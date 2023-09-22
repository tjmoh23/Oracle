-- substring(문자열, 시작위치, 가져올 문자 수)
-- 원하는 문자열 가져오기
select
	substring(name, 1,10)
from sample_data
;

-- replace(문자열, 기존 문자열, 변경할 문자열)
-- 문자열 변경하기
	replace(name, '변신', '강아지')
from sample_data
;

-- reverse(문자열)
-- 문자열 역순으로 변경
select
	reverse(name)
from sample_data
;
