-- ENSEIGNANT NOTES /pages/teachers/grades
-- Listes des notes des etudiants pour un travail
--
-- Récupérer les notes du travail @assignment_id de l'enseignant @teacher_id
--
-- Trier par nom d'étudiant croissant
-- 
-- +------------+--------------+----------------+
-- | student_id | student_name | student_points |
-- +------------+--------------+----------------+
-- |      20201 | AAA          |           NULL |
-- |      20202 | BBB          |              3 |
-- |      20203 | CCC          |              5 |
-- |      20204 | DDD          |              2 |
-- |      20205 | EEE          |              9 |
-- |      20206 | FFF          |             10 |
-- |      20207 | GGG          |              7 |
-- |      20208 | HHH          |              8 |
-- |      20209 | III          |              2 |
-- |      20200 | JJJ          |              6 |
-- +------------+--------------+----------------+
--

SET @assignment_id = 1;
SET @teacher_id = 1;

use monovox;

select 
s.id as `student_id`,
s.name as `student_name`,
g.point as "Student_points"
from grades as g
left join students as s on s.id = g.student_id
left join assignments as a on a.id = g.assignment_id
where a.id = @assignment_id
order by s.name
;


