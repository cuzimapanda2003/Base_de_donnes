-- ENSEIGNANT EDITION TRAVAIL
--
-- Mettre à jour le travail @assignment_id enseigné par @teacher_id 
-- avec les données @name, @weight, @points, @date 
--
-- Pour s'assurer que l'enseignant est bien responsable du cours
-- La syntaxe pour plusieurs table du UPDATE peut être utilisée plutôt qu'une sous-requête
--
use monovox;
set @name = 'test travail';
set @weight = 30;
set @points = 20;
set @date = '2020-11-20';
set @assignment_id = 1;
set @teacher_id = 1;

update assignments a
join groups g
  on g.number = a.group_number
 and g.semester = a.group_semester
 and g.course_code = a.group_course
set
  a.name = @name,
  a.weight = @weight,
  a.points = @points,
  a.date = @date
where a.id = @assignment_id
  and g.teacher_employee_number = @teacher_id;