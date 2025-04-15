-- Studenti iscritti al corso di Economia
SELECT students.*
FROM students
JOIN degrees ON students.degree_id = degrees.id
WHERE degrees.name = 'Economia';

-- Corsi magistrali del dipartimento di Neuroscienze
SELECT degrees.*
FROM degrees
JOIN departments ON degrees.department_id = departments.id
WHERE degrees.level = 'magistrale' AND departments.name = 'Neuroscienze';

-- Corsi insegnati da Fulvio Amato (id=44)
SELECT courses.*
FROM courses
JOIN course_teacher ON courses.id = course_teacher.course_id
WHERE course_teacher.teacher_id = 44;

-- Studenti con corso di laurea e dipartimento, ordinati per cognome e nome
SELECT students.*, degrees.name AS corso_laurea, departments.name AS dipartimento
FROM students
JOIN degrees ON students.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
ORDER BY students.surname, students.name;

-- Corsi di laurea con i relativi corsi e insegnanti
SELECT degrees.name AS corso_laurea, courses.name AS corso, teachers.name AS docente, teachers.surname AS cognome
FROM degrees
JOIN courses ON degrees.id = courses.degree_id
JOIN course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON course_teacher.teacher_id = teachers.id;

-- Docenti che insegnano nel dipartimento di Matematica (id=54)
SELECT DISTINCT teachers.*
FROM teachers
JOIN course_teacher ON teachers.id = course_teacher.teacher_id
JOIN courses ON course_teacher.course_id = courses.id
JOIN degrees ON courses.degree_id = degrees.id
WHERE degrees.department_id = 54;

-- Per ogni studente, numero di tentativi e voto massimo per ogni esame con voto minimo 18
SELECT students.id AS studente_id, students.name, students.surname, exams.course_id,
       COUNT(*) AS tentativi, MAX(grade) AS voto_massimo
FROM exam_student
JOIN exams ON exam_student.exam_id = exams.id
JOIN students ON exam_student.student_id = students.id
GROUP BY students.id, exams.course_id
HAVING voto_massimo >= 18;
