SELECT *
FROM DUAL; -- ���̺�� �ƹ��� ���� ���� �ָ� ����� ��

WHERE STATUS LIKE "Sh%" -> Sh�� �����ϴ� �� ��������
"%Sh%"


ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD (DAY) HH24:MI:SS'
-- (DAY)�� ����� ������ ��������
SELECT SYSDATE
FROM DUAL;


-- ���� �޽��� ��� �Ӽ� ����
-- 'KOREAN' ���� �ٲٸ� ���� �޽����� �ѱ۷� ���
ALTER SESSION SET NLS_LANGUAGE = 'ENGLISH' 
ALTER SESSION SET NLS_LANGUAGE = 'KOREAN' 
SELECT MANAGER_ID, COUN(*) C -- ���� ������
FROM EMPLOYEES
GROUP BY MANAGER_ID;



<������ �Լ�>
CONCAT(���ڿ� ��ġ��)
SUBSTR(���ڿ� �ڸ���)
LENGTH(���ڿ� ����)
TRIM(���ڿ�/���� ����)


-- LENGTH(���ڿ� ����)
SELECT FIRST_NAME, LAST_NAME
FROM EMPLOYEES;


SELECT 
    NAME, LENGTH(NAME) AS LEN
FROM(
SELECT 
    FIRST_NAME || ' ' || LAST_NAME AS NAME
FROM EMPLOYEES) T; -- T�� ��Ī


-- TRIM(���ڿ�/���� ����)
-- LTRIM/RTIRM
-- ������ ���ڸ� �Է��ϸ� ���� ����, �Է����� ������ ���� ����
SELECT  
    TRIM(LEADING 'A' FROM 'AAB   ') AS C1, -- �տ� A ������ A ����
    TRIM(LEADING FROM 'AAB   ') AS C2, -- �տ������� ���� ����
    TRIM(TRAILING 'B' FROM 'AAB  ') AS C3, -- �ڿ� B ������ B ����
    TRIM(TRAILING FROM 'AAB   ') AS C4, -- �ڿ������� ���� ����
    TRIM(BOTH 'A' FROM 'AAB   ') AS C5, -- ���ʿ� A ������ A ����
    TRIM(BOTH FROM 'AAB   ') AS C6, -- ���� ���� ����
    TRIM('A' FROM 'AAB   ') AS C7, -- BOTH�� �Ȱ���(defalut��)
    TRIM('AAB   ') AS C8
FROM DUAL; -- ���������� ����ϱ�

��°�: 'B   ', 'AAB   ', 'AAB   ', 'AAB', 'B   ', 'AAB', 'B   ', 'AAB'


[������ �Լ�]
������ �Լ� : CONCAT, SUBSTR, LENGTH,TRIM
��ȯ �Լ� : TO_CHAR, TO_NUMBER, TO_DATE
NULL �Լ� : NVL, NVL2, COALESCE


-- NVL(�ΰ� ä���)
SELECT 
    ADDRESS,
    POSTAL_CODE,
    CITY,
    NVL(STATE, 'No Data') AS STATE, -- �ΰ� 'No Data'�� ä��� 
FROM LOCATIONS;


SELECT
    NVL2(1, 2, 3) AS A1, -- ù ��° ���� ���� �ƴϸ� �� ��° �� �ֱ�
    NVL2(NULL, 2, 3) AS A2 -- ù ��° ���� ���̸� �� ��° �� �ֱ�
FROM DUAL;


-- ó������ ���� �ƴ� �� ��ȯ(COALESCE �Լ�)
SELECT
    COALESCE(1, 2, 3) AS A1,
    COALESCE(NULL, 2, 3) AS A2,
    COALESCE(NULL, NULL, 3) AS A3
FROM DUAL; -- �ϳ��� ������ ��ȯ



������ �Լ�: ���� ���� �׷쿡 ���� ����Ǵ� �Լ�
1. ���� �Լ�
 COUNT, SUM, AVG, MAX, MIN
    - GROUP BY �� �Բ� ����
2. ��� ���� �Լ�
 ROLLUP, CUBE, GROUPING SETS
3. ������ �Լ�


[GROUP BY ��Ģ]
GROUP BY �� �÷� �ܿ��� �ٸ� �÷��� SELECT ���� �� �� ����
SELECT ������ GROUP BY �� �÷� + �����Լ�
�����Լ��� ���� �� ���� ���� �����ϴ�


SELECT 
    PRODUCT_ID, 
    ROUND(AVG(QUANTITY), 2) AS AVG_QUANTITY,
    AVG(UNIT_PRICE),
    MAX(QUANTITY),
    MIN(QUANTITY) -- �̷��� �����Լ��� SELECT ���� �� �� �ִ�
FROM ORDER_ITEMS
GROUP BY PRODUCT_ID
ORDER BY PRODUCT_ID;


-- JOIN
�⺻Ű: ���̺� �ִ� ��� ����� �ĺ��� �� �ִ� �÷�
��) �й�


�⺻Ű ���� ����
1. NOT NULL
    �⺻Ű��� �ϸ�, �ݵ�� ���� ������ �Ѵ�
2. �ߺ��� X
    �й��� ���� �������� �ߺ��� ������ �� �ǰ�����
���� ������ �����ϴ� �÷��� �� ���̺� �� �� �̻��̶��
�� �߿� �� �� ������ �� �ϳ��� ���ؾ� �Ѵ�


�⺻Ű�� ��� ���� ���ؾ� �ϴ� �÷�
1. �̸�(��������)
2. ���� ���ɼ��� �ִ� �÷�(�ּ�, ��ȭ��ȣ)
    �⺻Ű�� ���� �ٲ��� �ʴ� ������ �ؾ��Ѵ�
3. �÷����� �� �÷�(�ֹε�Ϲ�ȣ)


�⺻Ű�� ������ ���� �÷�
- ID(���� ��ȣ, ���� �Һ�, �÷����� ª��)


DESCRIBE REGIONS; -- �⺻Ű ã��: NOT NULL �� ���� �÷� ����
DESCRIBE PRODUCTS;
DESCRIBE EMPLOYEES;
-- PK: �⺻Ű
-- FK: �ܷ�Ű


-- �⺻�� �����ϱ� ���� �ߺ��� Ȯ��
SELECT HIRE_DATE, COUNT(*) AS C
FROM EMPLOYEES
GROUP BY HIRE_DATE;
-- �⺻���� �� ���� ���� �ִ�. 


�� ���̺��� �����ϱ� ���ؼ��� �ܷ�Ű�� �ʿ��ϴ�
JOIN ��Ģ
1. �ڽ� ���̺��� �θ� ���̺�κ��� �⺻Ű�� ��ӹ޴´�
    �ڽ� ���̺� ���忡���� ��ӹ��� Ű�� �ܷ�Ű��� �Ѵ�


���� ����
ON �θ����̺�.�⺻Ű = �ڽ����̺�.�ܷ�Ű
(�ڽ����̺�.�ܷ�Ű = �θ����̺�.�⺻Ű)


SELECT *
FROM COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID; 
-- ���ε� ���̺����� REGION_ID �÷��� �ߺ��̹Ƿ� �⺻Ű�� ����� �� ����


SELECT *
FROM LOCATIONS L, COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID;
-- 2�� ���̺��� ������ ���� 1���� �ܷ�Ű �ʿ�
-- 3�� ���̺��� ������ ���� 2���� �ܷ�Ű �ʿ�


��, N���� ���̺��� ������ ���� N-1���� �ܷ�Ű�� �ʿ��ϴ�
�ܷ�Ű�� ���� �÷��� ���ε� ���̺����� ���̻� �⺻Ű�� ����� �� ����


SELECT *
FROM WAREHOUSES W, LOCATIONS L, COUNTRIES C, REGIONS R
WHERE C.REGION_ID = R.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID
AND L.LOCATION_ID = W.LOCATION_ID
ORDER BY W.WAREHOUSE_ID;



[����]
�ܷ�Ű�� �� ������ŭ ���� ���������
�������ǿ� ���� �ܷ�Ű �÷��� ���ε� ���̺��� �⺻Ű�� �� �� ����
�ܷ�Ű�� �� ���� �÷� �߿��� �ٽ� �⺻Ű�� ��ƾ� �Ѵ�


-- �߰��� LTRIM�� RTRIM�� ���ؼ��� �����غ���
