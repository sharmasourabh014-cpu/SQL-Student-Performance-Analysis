SELECT * FROM students;
SELECT * FROM marks;
SELECT * FROM attendance;

#Subject-wise average marks
SELECT subject, ROUND(AVG(marks),2) AS avg_marks
FROM marks
GROUP BY subject;

#Top 3 students (overall performance)
SELECT s.name, ROUND(AVG(m.marks),2) AS avg_score
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.name
ORDER BY avg_score DESC
LIMIT 3;

#Attendance percentage
SELECT s.name,
ROUND((a.attended_classes/a.total_classes)*100,2) AS attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id;

#Students below 75% attendance
SELECT s.name,
ROUND((a.attended_classes/a.total_classes)*100,2) AS attendance_percentage
FROM students s
JOIN attendance a ON s.student_id = a.student_id
WHERE (a.attended_classes/a.total_classes)*100 < 75;

#Performance + attendance combined
SELECT 
    s.name,
    ROUND(AVG(m.marks),2) AS avg_marks,
    ROUND((MAX(a.attended_classes) / MAX(a.total_classes)) * 100, 2) 
        AS attendance_percentage
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name;

#top performers with attendance
SELECT 
    s.name,
    ROUND(AVG(m.marks),2) AS avg_marks,
    ROUND((MAX(a.attended_classes) / MAX(a.total_classes)) * 100, 2) AS attendance_percentage
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name
HAVING avg_marks >= 70;

#PASS / FAIL + Average Report
SELECT 
    s.name,
    ROUND(AVG(m.marks),2) AS avg_marks,
    CASE 
        WHEN AVG(m.marks) >= 40 THEN 'PASS'
        ELSE 'FAIL'
    END AS result_status
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name;

#Grade System
SELECT 
    s.name,
    ROUND(AVG(m.marks),2) AS avg_marks,
    CASE
        WHEN AVG(m.marks) >= 75 THEN 'A'
        WHEN AVG(m.marks) >= 60 THEN 'B'
        WHEN AVG(m.marks) >= 50 THEN 'C'
        ELSE 'D'
    END AS grade
FROM students s
JOIN marks m ON s.student_id = m.student_id
GROUP BY s.student_id, s.name;

#Subject Topper
SELECT subject, name, marks
FROM (
    SELECT m.subject, s.name, m.marks,
           RANK() OVER (PARTITION BY m.subject ORDER BY m.marks DESC) AS rnk
    FROM marks m
    JOIN students s ON m.student_id = s.student_id
) ranked
WHERE rnk = 1;

#Risk students (low marks + low attendance)
SELECT 
    s.name,
    ROUND(AVG(m.marks),2) AS avg_marks,
    ROUND((MAX(a.attended_classes)/MAX(a.total_classes))*100,2) AS attendance
FROM students s
JOIN marks m ON s.student_id = m.student_id
JOIN attendance a ON s.student_id = a.student_id
GROUP BY s.student_id, s.name
HAVING avg_marks < 50 OR attendance < 75;