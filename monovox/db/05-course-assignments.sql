-- ENSEIGNANT TRAVAUX /pages/teachers/assignments
-- Liste des travaux et statistiques
--
-- Récupérer les travaux du groupe @group pour le cours @code durant la session @semester
-- de l'enseignant @teacher_id
-- Ajouter les colonnes pour chaque travail
--      average calcule les moyenne des notes en % 
--      failed indique le nombre de notes en échec(< 60%)
--      filled indique le nombre de notes saisies(pas NULL) 
--      total indique le nombre total de notes saisies ou non
--
-- Trier par date croissante
--
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
-- | id | name      | weight | points | date       | average | failed | filled | total |
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
-- |  1 | TP 1      |     40 |     10 | 2020-10-01 | 57.78   |      4 |      9 |    10 |
-- |  3 | Formatif  |      0 |      0 | 2020-11-03 | NULL    |      0 |      0 |     0 |
-- |  2 | Final     |     60 |    100 | 2020-12-11 | 70.40   |      3 |     10 |    10 |
-- +----+-----------+--------+--------+------------+---------+--------+--------+-------+
--


SET @semester = 'A2020';
SET @group = 1;
SET @code = '420-0Q4-SW';
SET @teacher_id = 1;

select 
    a.id,
    a.name,
    a.weight,
    a.points,
    a.date,
    round(avg(g.point * 100.0 / a.points), 2) as average,
    count(case when g.point * 100.0 / a.points < 60 then 1 end) as failed,
    count(g.point) as filled,
    count(*) as total
from assignments as a
left join grades as g on a.id = g.assignment_id
where a.group_semester = @semester
    and a.group_course = @code
    and a.group_number = @group
    and exists (
        select 1 from groups as g2
        where g2.semester = a.group_semester
            and g2.course_code = a.group_course
            and g2.number = a.group_number
            and g2.teacher_employee_number = @teacher_id
    )
group by a.id, a.name, a.weight, a.points, a.date
order by a.date;