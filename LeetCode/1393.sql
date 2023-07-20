SELECT
    STOCK_NAME, 
    SUM(ADJ_PRICE) AS capital_gain_loss 
FROM
    ( 
        SELECT
        STOCK_NAME, OPERATION,
        CASE WHEN OPERATION = 'Buy' THEN -PRICE
        ELSE PRICE END AS ADJ_PRICE
        FROM STOCKS
    )
GROUP BY STOCK_NAME

-- CASE WHEN 사용하여 BUY는 음수로 변경해준 후 총합 계산하기
-- 문제 출처: https://leetcode.com/problems/capital-gainloss/description/
