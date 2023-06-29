### 오라클과 MySQL 차이점?


#### 오라클에서는 ORDER BY에서만 별칭을 사용할 수 있다

``` 
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE
FROM TRANSACTIONS T, USERS U
WHERE T.ACCOUNT = U.ACCOUNT
GROUP BY U.NAME
HAVING BALANCE > 10000 
```
로 실행을 할 경우 에러가 발생

- MySQL에서는 예외적으로 GROUP BY에서 별칭을 사용할 수 있었지만 오라클은 더 제한적이기 때문에 별칭 사용 불가하다!
- FROM -> WHERE -> GROUP BY -> HAVING -> SELECT -> ORDER BY 순으로 진행이 되므로
- 따라서 SELECT에서 정의한 별칭을 아직 GROUP BY에서 사용할 수 없는 것이다
```
SELECT U.NAME, SUM(T.AMOUNT) AS BALANCE
FROM TRANSACTIONS T, USERS U
WHERE T.ACCOUNT = U.ACCOUNT
GROUP BY U.NAME
HAVING SUM(T.AMOUNT) > 10000
```
이렇게 실행을 해야한다

---

#### 오라클에서는 DATE_FORMAT 사용이 안 된다

```
SELECT 
        DATE_FORMAT(EVENT_DAY, '%Y-%m-%d') AS DAY,  
        EMP_ID, 
        SUM(OUT_TIME - IN_TIME) AS TOTAL_TIME
FROM EMPLOYEES
GROUP BY EVENT_DAY, EMP_ID
ORDER BY EVENT_DAY, EMP_ID
```
로 실행을 할 경우 에러가 발생

```
SELECT 
        TO_CHAR(EVENT_DAY, 'YYYY-MM-DD') AS DAY,
        EMP_ID, 
        SUM(OUT_TIME - IN_TIME) AS TOTAL_TIME
FROM EMPLOYEES
GROUP BY EVENT_DAY, EMP_ID
ORDER BY EVENT_DAY, EMP_ID
```

- 'YYYY-MM-DD 00:00:00' 형태의 DATE 타입을 'YYYY-MM-DD'로 나타내고 싶을 경우
- 오라클에서는 `DATE_FORMAT`이 아닌 `TO_CHAR`를 사용한다
- `TO_CHAR(EVENT_DAY, 'YYYY-MM-DD')` 로 표현한다

---

#### 아우터(외부) 조인 사용법
```
SELECT 
    V.CUSTOMER_ID,
    COUNT(V.VISIT_ID) AS COUNT_NO_TRANS
FROM VISITS V, TRANSACTIONS T
WHERE V.VISIT_ID = T.VISIT_ID(+) 
AND T.TRANSACTION_ID IS NULL
GROUP BY V.CUSTOMER_ID
```
- 어떤 테이블에서 기본키이고, 어떤 테이블에서 외래키인지 확인하고 부모 테이블과 자식 테이블 구분 잘 해서 사용하기
- 외부 조인할 때는 자식 테이블 옆에 바로 (+)를 붙인
- 자식 테이블에 (+)만 바로 옆에 붙여주면 된다.
- `T.VISIT_ID(+) = V.VISIT_ID` 이렇게도 된다
