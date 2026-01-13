-- ENSEIGNANT NOTES /pages/teachers/grades
-- Liste deroulante des autres travaux du groupe-cours
--
-- Récupérer les travaux de l'enseignant @teacher_id 
-- dans le même groupe-cours-session que le travail @assignment_id
-- Ajouter les colonnes
--      average qui calcule la moyenne des resultats pour ce travail en %
--      course est le nom du cours(sera toujours le même car on ne récupère que les travaux d'un seul cours)
--
-- Trier par date croissante
--
-- +----+-----------+--------+--------+---------+-----------------------------+
-- | id | name      | points | weight | average | course                      |
-- +----+-----------+--------+--------+---------+-----------------------------+
-- |  1 | TP 1      |     10 |     40 | 57.78   | Initiation à la profession  |
-- |  2 | Final     |    100 |     60 | 70.40   | Initiation à la profession  |
-- +----+-----------+--------+--------+---------+-----------------------------+
--
SET @assignment_id = 1;
SET @teacher_id = 1;
use monovox;

select 
 a.id,
 a.name,
 a.points,
 a.weight,
 ROUND(AVG(g.point / a.points * 100),2) as `average`,
 c.name as `course`
 from assignments as a
 left join grades as g on g.assignment_id = a.id
 left join courses as c on c.code = a.group_course
 WHERE 
    a.group_number = (
        SELECT group_number FROM assignments WHERE id = @assignment_id
    )
    AND a.group_semester = (
        SELECT group_semester FROM assignments WHERE id = @assignment_id
    )
    AND a.group_course = (
        SELECT group_course FROM assignments WHERE id = @assignment_id
    )
 group by a.id, a.name, a.points, a.weight, c.name
 order by a.date;
 ;


