###  테이블 생성
```
CREATE TABLE 테이블명 (
  컬럼명1 데이터형 제약조건,
  컬럼명2 데이터형 제약조건
)
```
**자주 사용하는 데이터형**
- CHAR(N): 고정 길이 문자열, N 이하 값일 경우 나머지 칸은 공백 처리
- VARCHAR(N): 가변 길이 문자열, N 이하 값일 경우 크기 맞춤
- NUMBER(N): N 자리수만큼 숫자 입력
- DATE: 날짜 입력 시 사용


**제약조건**
- NOT NULL: NULL 불가
- UNIQUE: NULL 허용, 중복 불가
- PRIMARY KEY: NULL과 중복 모두 불가
- FOREIGN KEY: NULL 허용, 다른 테이블의 PRIMARY KEY여야 하고 해당 테이블 컬럼에 삽입되지 않은 값은 사용 불가
  ```
    컬럼명 데이터형 REFERENCES 참조테이블(참조할 테이블의 PRIMARY KEY)
  ```
- CHECK: 특정 범위, 특정 값만 들어갈 수 있게 함
    ```
      VALUE VARCHER(10) CHECK(VALUE BETWEEN 1 AND 10) -- 1과 10 사이의 값만 들어갈 수 있다
      VALUE VARCHER(10) CHECK(VALUE IN ('A', 'B') -- A 또는 B만 들어갈 수 있다
    ```
- DEFAULT: NULL 값이 들어갈 경우 지정된 값 삽입
    ```
      VALUE VARCHAER(10) DEFAULT'홍길동' -- NULL 값일 경우 홍길동 삽입
    ```



### INSERT, UPDATE, DELETE, SELECT


참고 링크
https://wakestand.tistory.com/notice/412
