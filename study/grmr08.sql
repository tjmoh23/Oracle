/*
정규식 사용법
1. .: 문자 하나
2. *: 앞 글자의 *개수 숫자 이상 반복
3. ^: 첫 값
4. $: 끝 값
5. [.]: 괄호 안의 문자열 일치 확인
6. {.}: 반복
7. |: OR
*/



/* '_' 사용하기 */
-- h_t finds hot, hat, hit
-- 두 번째 글자에 '원'이 들어가는 값 조회
where name like '_이%' -- '%___이%'
-- 가로 시작하는 두 글자 문자 조회
where name like '가_'

  
/* regexp 사용하기 */
-- 코코몽 또는 구름빵이 들어간 값 조회
 where name regexp '코코몽|구름빵'
-- 정규식 이용하여 숫자가 들어간 값만 조회
where name regexp '^[0-9]+$'
-- 정규식 이용하여 '범'으로 시작하고 한글로 끝나는 값이 들어있으면 조회
where name regexp '범[가-힇]+$' -- '^범[가-힇]+$'






/* 참고 링크
1. https://wakestand.tistory.com/486
2. https://audgnssweet.tistory.com/65
*/
