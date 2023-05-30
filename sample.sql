-- CONCAT: ���ڿ� ��ġ��
SELECT 
    FIRST_NAME,
    LAST_NAME,
    CONCAT(FIRST_NAME, LAST_NAME) AS NAME 
FROM EMPLOYEES;


-- || ����Ͽ� ���ڿ� ��ġ��
-- " " ū����ǥ�� ���� �߻�, ���̿� ���� ���� �� ū ����ǥ ���
SELECT FIRST_NAME || ' ' || LAST_NAME AS NAME 
FROM EMPLOYEES;


-- SUBSTR: ���ڿ� �ڸ���
SELECT 
    TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') AS ORDER_DATE,
    SUBSTR(ORDER_DATE, 1, 4) AS �ֹ��⵵,
    SUBSTR(ORDER_DATE, 6, 2) AS �ֹ���, -- 6��°���� 2���� ��������
    SUBSTR(ORDER_DATE, 9, 2) AS �ֹ���
FROM ORDERS;


-- TO_CHAR: ���ڳ� ��¥�� ���ڿ��� ��ȯ
-- TO_NUMBER: ���ڿ��� ���ڷ� ��ȯ
-- TO_DATE: ���ڿ��� ��¥�� ��ȯ


SELECT 
    TO_CHAR(ORDER_DATE, 'YYYY-MM-DD') AS ORDER_DATE,
    EXTRACT(YEAR FROM ORDER_DATE) AS �ֹ��⵵, -- �ʿ��� �κ� ����
    EXTRACT(MONTH FROM ORDER_DATE) AS �ֹ���,
    EXTRACT(DAY FROM ORDER_DATE) AS �ֹ���
FROM ORDERS;


SELECT
    CATEGORY_ID, -- ������ �׷������ ī�װ��� ���� ����Ѵ�
    ROUND(AVG(STANDARD_COST), 2) AS AVG_COST,
    ROUND(AVG(LIST_PRICE), 2) AS AVG_PRICE
FROM PRODUCTS
GROUP BY CATEGORY_ID
HAVING AVG(STANDARD_COST) > 1000
AND AVG(LIST_PRICE) > 1400
ORDER BY CATEGORY_ID; -- ���� �׷������ ī�װ��� �������� �Ѵ�