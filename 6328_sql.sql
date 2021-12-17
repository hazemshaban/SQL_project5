#1>>
SELECT student_name FROM student 
WHERE `level`="SR" and student_id in (SELECT DISTINCT e.student_id FROM enrolled as e
natural join semester_course as s
WHERE s.prof_id=1);

#2>>
SELECT max(age)
FROM student 
WHERE major="History" or student_id IN(
SELECT enrolled.student_id FROM enrolled
NATURAL JOIN semester_course
NATURAL JOIN professor
WHERE professor.prof_name="Michael Miller");

#3>>
SELECT DISTINCT s.student_name ,c.name 
FROM student as s
 LEFT JOIN enrolled as e
 on e.student_id=s.student_id 
left JOIN course as c 
on c.course_code=e.course_code;

#4>>
SELECT p1.prof_name
FROM professor as p1
WHERE not EXISTS ( 
    SELECT s.course_code
    FROM semester_course as s 
    NATURAL JOIN enrolled as e
    NATURAL JOIN professor as p2
    WHERE p1.prof_id=p2.prof_id
    GROUP BY p1.prof_id
    HAVING COUNT(e.student_id)>=5
    );


#5>>
SELECT s.student_name
FROM student as s
WHERE not EXISTS
((
SELECT s2.course_code,s2.quarter,s2.year
FROM semester_course as s2 
WHERE s2.prof_id =2)
except
(
SELECT e.course_code ,e.quarter,e.year
FROM enrolled as e 
WHERE e.student_id=s.student_id
));


#6>>
SELECT c.course_code ,c.name from course as c
WHERE c.course_code in
(SELECT s.course_code
FROM semester_course as s
WHERE s.prof_id in (
SELECT p.prof_id
FROM professor as p
NATURAL JOIN department as d 
WHERE d.dept_name= "Computer Science"
))or c.course_code not in (SELECT s2.course_code FROM semester_course as s2) ;



#7>>
(SELECT s.student_name as names
FROM student as s 
WHERE s.student_name LIKE "M%" and s.age<20)
UNION 
(
SELECT p.prof_name
FROM semester_course as s
NATURAL JOIN professor as p
WHERE p.prof_name LIKE "M%"
GROUP BY p.prof_id
HAVING COUNT(*)>2);

#8>>
SELECT  p.prof_id,p.prof_name 
FROM professor as p
LEFT JOIN semester_course as s
on p.prof_id=s.prof_id
WHERE p.dept_id in (1,2,3,4)
GROUP BY p.prof_id 
HAVING COUNT(*)<2
;

#9>>
(SELECT S.student_id,S.student_name,P.prof_id,P.prof_name,S1.course_code
FROM student as s
NATURAL LEFT JOIN enrolled as e 
NATURAL LEFT JOIN semester_course as s1
NATURAL LEFT JOIN professor as p
)
UNION
(
SELECT S.student_id,S.student_name,P.prof_id,P.prof_name,S1.course_code
FROM professor as P
NATURAL LEFT JOIN semester_course as S1
NATURAL LEFT JOIN enrolled as E
NATURAL LEFT JOIN student as S
  );


#10>>
SELECT c.name ,c.course_code  ,p.prof_name,p.prof_id
FROM semester_course AS S
NATURAL JOIN course as c
NATURAL JOIN professor as p
GROUP by p.prof_id ,c.course_code
HAVING COUNT(*) >1;


#11>>
SELECT d.dept_name   
FROM semester_course  as s
NATURAL RIGHT JOIN professor as p
NATURAL RIGHT JOIN department as d
GROUP by d.dept_name 
HAVING COUNT(s.course_code)<3;
