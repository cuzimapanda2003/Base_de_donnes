-- ENSEIGNANT GROUPES /pages/teachers/groups
-- Liste des groupes pour une session de l'enseignant
--
-- Récupérer les groupes de l'enseignant @teacher_id pour la session @semester
--      Ajouter la colonne students qui indique le nombre d'étudiants du groupe
--
-- Trier par code et number croissant
--
-- +--------+------------+-----------------------------+----------+
-- | number | code       | name                        | students |
-- +--------+------------+-----------------------------+----------+
-- |      1 | 420-0Q4-SW | Initiation à la profession  |       11 |
-- |      2 | 420-0SU-SW | Web Client 1                |        0 |
-- +--------+------------+-----------------------------+----------+
--


SET @teacher_id = 1;
SET @semester = 'A2021';




select 
  g.number,
  g.course_code as "code",
  c.name,
  COUNT(cls.student_id) as "students"
from groups as g
left join courses as c on g.course_code = c.code
left join classes as cls on cls.group_number = g.number
                     and cls.group_semester = g.semester
                     and cls.group_course = g.course_code
                     and cls.group_teacher = g.teacher_employee_number
where g.teacher_employee_number = @teacher_id
  and g.semester = @semester
group by g.number, g.course_code, c.name
order by g.course_code, g.number;
