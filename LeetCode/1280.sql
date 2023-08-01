-- CROSS JOIN

SELECT 
  S.STUDENT_ID, S.STUDENT_NAME, S.SUBJECT_NAME, COUNT(E.SUBJECT_NAME) AS ATTENDED_EXAMS
FROM(
  SELECT *
  FROM STUDENTS ST CROSS JOIN SUBJECTS SB
    ) S, EXAMINATIONS E
WHERE S.STUDENT_ID = E.STUDENT_ID(+)
AND S.SUBJECT_NAME = E.SUBJECT_NAME(+)
GROUP BY S.STUDENT_ID, S.STUDENT_NAME, S.SUBJECT_NAME
ORDER BY STUDENT_ID, SUBJECT_NAME

-- 문제 출처: https://leetcode.com/problems/students-and-examinations/description/