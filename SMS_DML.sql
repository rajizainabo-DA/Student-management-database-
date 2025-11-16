-- How many students are enrolled in each course
SELECT Course_name, count(e.student_id)  AS Total_student 
FROM enrollment e
JOIN courses c ON e.course_id = c.course_id 
GROUP BY Course_name;




-- which students are enrolled in multiple courses and which courses are they taking
SELECT s.Student_id,c.Course_name FROM students s
JOIN enrollment e ON s.student_id = e.student_id
JOIN courses c on e.course_id = c.course_id
WHERE s.student_id IN (
			  SELECT student_id 
						FROM enrollment
						GROUP BY student_id
						HAVING count(course_id) > 1
					 ) ORDER BY s.student_id;
      
      
      
      
      
      -- what is the total number of students per dept across all courses
      SELECT Dept_name, count(student_id) Total_student FROM students s
      JOIN departments d ON s.department_id =d.department_id
      GROUP BY Dept_name;
     
     
     
     
      -- which courses have the highest number of enrollment
	SELECT c.Course_id, Course_name, count(enrollment_id) Total_enrollment FROM enrollment e
    JOIN courses c on e.course_id = c.course_id
    GROUP BY course_id, course_name
    ORDER BY Total_enrollment DESC
    LIMIT 1;
    
    -- which dept has the least no of students
    SELECT Dept_name, count(student_id) Total_student FROM students s
	JOIN departments d ON s.department_id =d.department_id
	GROUP BY Dept_name
    ORDER BY Total_student ASC
    LIMIT 1;
    
    
    
    -- Are there students not enrolled  in any course
    SELECT s.names FROM students s
    JOIN enrollment e ON s.student_id = e.student_id
	WHERE s.student_id IS NULL;
    
    
    
    
    -- Avg course per student
    SELECT round(avg(course_count),2) AS Avg_course_student
    FROM(
         SELECT 
               Student_ID,count(Course_ID) AS Course_count
               FROM enrollment
               GROUP BY student_id
       ) derived;
    
    
    
    
    -- what is the gender distribution of student across courses -- and instructors
    SELECT c.Course_id, c.Course_name,s.Gender,count(s.student_id) Total_students FROM enrollment e 
    JOIN students s ON e.student_id = s.student_id
    JOIN courses c ON e.course_id = c.course_id
    GROUP BY c.Course_id, c.course_name,s.gender
    ORDER BY c.course_name;
    
    

    
   -- what is the gender distribution of instructors
    SELECT Gender, count(instructor_ID) AS Total_instructor
    FROM Instructors
    GROUP BY Gender;