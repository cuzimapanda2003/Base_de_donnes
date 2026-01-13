-- ENSEIGNANT TRAVAIL /pages/teachers/assignment
-- Affiche les details d'un travail, si existant, ET le pourcentage restant
--
-- Récupérer le travail @assignment_id s'il appartient à l'enseignant @teacher_id
--      Ajouter la colonne remaining_weight qui calcule 
--      le poids restant à allouer sur 100 pour ce @group, durant la session @semester, du cours @code
--
-- ATTENTION cette requete est utilisée pour afficher le poids restant lors de la CRÉATION d'un travail
-- donc il faut gérer la situation où le @assignment_id est null également
--
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | code       | group | semester | remaining_weight | id   | name | weight | points | date       |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | 420-0Q4-SW |     1 | A2020    |                0 |    1 | TP 1 |     40 |     10 | 2020-10-01 |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
--
--
-- Si en creation, le assignment_id est null, donc les données de l'assignment aussi
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | code       | group | semester | remaining_weight | id   | name | weight | points | date       |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
-- | 420-0Q4-SW |     1 | A2020    |                0 |      |      |        |        |            |
-- +------------+-------+----------+------------------+------+------+--------+--------+------------+
--
use monovox;

set @group = 1;
set @code = '420-0q4-sw';
set @semester = 'a2020';
set @assignment_id = 1;  
set @teacher_id = 1;

select
    @code as code,
    @group as `group`,
    @semester as semester,
    
    100 - coalesce((
        select sum(a2.weight)
        from assignments a2
        join groups g2 on g2.number = a2.group_number
            and g2.semester = a2.group_semester
            and g2.course_code = a2.group_course
        where g2.teacher_employee_number = @teacher_id
            and a2.group_number = @group
            and a2.group_course = @code
            and a2.group_semester = @semester
            and (@assignment_id is null or a2.id != @assignment_id)
    ), 0) as remaining_weight,
    
    a.id,
    a.name,
    a.weight,
    a.points,
    a.date
    
from groups g
left join assignments a on a.id = @assignment_id
    and a.group_number = g.number
    and a.group_semester = g.semester
    and a.group_course = g.course_code
    
where g.teacher_employee_number = @teacher_id
    and g.number = @group
    and g.semester = @semester
    and g.course_code = @code;