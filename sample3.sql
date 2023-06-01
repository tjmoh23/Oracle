�ߺ� ������ Ȯ���ϴ� ���
ALL: �ߺ� ������ ��� ���(�⺻��)
DISTINCT: �ߺ� �����͸� 1������ ���

SELECT SALESMAN_ID -- SALESMAN_ID �� ��� ���
FROM ORDERS;

SELECT ALL SALESMAN_ID -- �⺻���̹Ƿ� �� ������ �Ȱ��� ���
FROM ORDERS;

SELECT DISTINCT SALESMAN_ID
FROM ORDERS;


-- IN ������
SELECT REGION_NAME, COUNTRY_NAME
FROM REGIONS R, COUNTRIES C
WHERE R.REGION_ID = C.REGION_ID
AND REGION_NAME IN ('Asia', 'Europe')
/*
REGION_NAME = 'Asia' 
OR REGION_NAME = 'Europe'
*/
ORDER BY REGION_NAME;


-- ��������
�������� ����
- ��Į�� ��������: SELECT ���� ���� ��������
- �ζ��� ��: FROM ���� ���� ��������
- ��ø ��������: WHERE ���� ���� ��������

��ø ��������
- ������ ��������: ���������� ��ȯ�Ǵ� ����� �ϳ�. '=' ����, IN ����
- ������ ��������: ���������� ��ȯ�Ǵ� ���� ���� ��. '=' �Ұ���, IN ����

SELECT MANAGER_ID, COUNT(*) AS C
FROM EMPLOYEES
GROUP BY MANAGER_ID
ORDER BY MANAGER_ID; 


SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID = (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE MANAGER_ID = 3); -- ������ ���� ����('=' ���)
                    

SELECT *
FROM EMPLOYEES
WHERE MANAGER_ID IN (SELECT MANAGER_ID
                    FROM EMPLOYEES
                    WHERE MANAGER_ID = 1); -- ������ ���� ����
       

����) ���� �ֱٿ� ����� ������ ������� ���� ������ ������ �����ϴ� ����
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME, LAST_NAME,
    EMAIL, PHONE, MANAGER_ID, 
    TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE,
    JOB_TITLE
FROM EMPLOYEES
WHERE HIRE_DATE = (SELECT MIN(HIRE_DATE) 
                    FROM EMPLOYEES) /*���� ������ ����*/
OR HIRE_DATE = (SELECT MAX(HIRE_DATE)
                    FROM EMPLOYEES); /*���� �ֱ� ���� ����*/
    -- �ζ��� �並 ��� ȿ���� ����
    -- ��ø ���� ������ ������ �� ����

SELECT
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    HIRE_DATE
FROM (
SELECT 
    EMPLOYEE_ID,
    FIRST_NAME,
    LAST_NAME,
    TO_CHAR(HIRE_DATE, 'YYYY-MM-DD') AS HIRE_DATE,
    ROW_NUMBER() OVER(ORDER BY HIRE_DATE) MIN_DATE,
    ROW_NUMBER() OVER(ORDER BY HIRE_DATE DESC) MAX_DATE
FROM EMPLOYEES ) 
WHERE MIN_DATE = 1
OR MAX_DATE = 1
ORDER BY HIRE_DATE ASC; -- ��ø���� ������ ����ϸ� ������ �������� ���̽�


�� ���� ������ �ִ� ������ ���������� �ִ� ������ ������ �� �ȴ�!


-- JOIN(����)
SELECT *
FROM COUNTRIES C, REGIONS R -- ,�� �����ϱ�
WHERE R.REGION_ID = C.REGION_ID; -- ��, ��Ī ���� �ʿ�


SELECT *
FROM COUNTRIES C JOIN REGIONS R -- JOIN���� �����ϱ�(����Ʈ INNER JOIN)
ON R.REGION_ID = C.REGION_ID;


[INNER JOIN �� Ư���� ����]
-- NATURAL JOIN
�θ����̺��� �⺻Ű�� �ڽ����̺��� �ܷ�Ű�� �÷���, ������ Ÿ���� ������ �� �� �ִ� ���� ���
���� ���� ����, ��Ī ���� �ʿ� ����
SELECT *
FROM REGIONS NATURAL JOIN COUNTRIES; -- '�� ����'�� �Ȱ��� ������� ���´�


-- USING ��
SELECT *
FROM REGIONS JOIN COUNTRIES
USING (REGION_ID) -- �ٷ� �� ������ '�� ����'�� �Ȱ��� ������� ���´�, ��Ī ���� �ʿ� ����


-- 3�� ���̺� ����
SELECT
    R.REGION_NAME,
    C.COUNTRY_NAME,
    L.CITY, L.STATE
FROM REGIONS R, COUNTRIES C, LOCATIONS L
WHERE R.REGION_ID = C.REGION_ID
AND C.COUNTRY_ID = L.COUNTRY_ID


-- ���߷� ���η� �غ���
SELECT
    REGION_NAME,
    COUNTRY_NAME,
    CITY, STATE
FROM REGIONS NATURAL JOIN COUNTRIES NATURAL JOIN LOCATIONS;


-- USING ���� �غ���
SELECT *
FROM REGIONS JOIN COUNTRIES
USING (REGION_ID)
JOIN LOCATIONS
USING (COUNTRY_ID);


[����]
NATURAL JOIN �� USING �� INNER JOIN �� Ư���� JOIN �̴�

NATURAL JOIN
- ���� ���̺� �� �÷���, Ÿ���� ���� Ű�� �ڵ����� ����(���� ������ ����)
- NATURAL JOIN �� ���� �÷��� Alias�� ���� ������ ����

USING
- �����ϴ� �÷��� ���� ���̺� �� �÷���, Ÿ���� ���ƾ� �Ѵ�
- ���� �������� USING (����� �÷�)
- USING ���� ���� �÷����θ� ������ �ȴ�


������ ���� ������ �������� ���̽�
1. ������ �ϸ鼭 DISTINCT �� ����ϴ� ���̽�
 DISTINCT �� ������ �� �������� �ϴ� ���̱� ������ ��¿ �� ���� ��Ȳ������ ��� �Ѵ�
 ���� ���, �Ŵ��� ������ �ϰ� �ִ� ������ ���̵�, FIRST_NAME, LAST_NAME�� ��ȸ�ϴ�
 SQL �������� �ۼ��ؾ��� ���

-- ��ȿ����
SELECT DISTINCT MA.EMPLOYEE_ID, MA.FIRST_NAME, MA.LAST_NAME
FROM EMPLOYEES EM, EMPLOYEES MA
WHERE EM.MANAGER_ID = MA.EMPLOYEE_ID
ORDER BY MA.EMPLOYEE_ID;

-- ȿ����
-- �Ŵ����� �ϰ� �ִ� �������� ���� WHERE IN ���� �̾ƿ� ��, �ش� ���� �������� ���ϴ� ������ �޾ƿ´�
SELECT EMPLOYEE_ID, FIRST_NAME, LAST_NAME
FROM EMPLOYEES
WHERE EMPLOYEE_ID IN (SELECT MANAGER_ID
                        FROM EMPLOYEES)
ORDER BY EMPLOYEE_ID


-- ��ȿ����
SELECT DISTINCT R.REGION_ID, R.REGION_NAME
FROM REGIONS R, COUNTRIES C
WHERE R.REGION_ID = C.REGION_ID
ORDER BY R.REGION_ID;


-- ȿ����
SELECT REGION_ID, REGION_NAME
FROM REGIONS
WHERE REGION_ID IN (SELECT REGION_ID
                     FROM COUNTRIES)
ORDER BY REGION_ID;

