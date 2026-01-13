-- ENSEIGNANT SUPPRESSION TRAVAIL
--
-- Supprimer le travail identifié par @assignment_id et appartenant à l'enseignant @teacher_id
--
use monovox;

set @assignment_id = 1;
set @teacher_id = 1;

delete a
from assignments a
join groups g
  on g.number = a.group_number
 and g.semester = a.group_semester
 and g.course_code = a.group_course
where a.id = @assignment_id
  and g.teacher_employee_number = @teacher_id;
