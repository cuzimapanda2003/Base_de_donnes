--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/cours4/script.sql


create or replace database school;

create table school.teachers (
  employee_number int auto_increment key,
  name varchar(200) not null,
  email varchar(200) unique not null,
  birthday date not null
);

create table school.courses (
  code char(10) not null,
  credits double(3,2) not null default 1,
  name varchar(200) not null,
  description varchar(1000),
  teacher int not null,
  semester char(5) not null
);

INSERT INTO 
    school.teachers (employee_number, name, email, birthday)
VALUES 
    (1, 'James', 'jhoffman@cshawi.ca', '1990-01-01'), 
    (2, 'Mathieu', 'mstyves@cshawi.ca', '1980-02-02'), 
    (3, 'Stevens', 'sgagnon@cshawi.ca', '1970-03-03'), 
    (4, 'Marco', 'mguilmette@cshawi.ca', '1975-04-04');

INSERT INTO 
    school.courses(code, credits, name, description, teacher, semester)
VALUES  
    ('420-0Q4-SW', 2, 'Initiation à la profession', NULL, 1, 'A2021'), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', NULL, 1, 'A2020'), 
    ('420-0Q7-SW', 2.33, 'Base de données 1', NULL, 1, 'A2021'), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', NULL, 1, 'A2021'), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', NULL, 1, 'A2020'), 
    ('420-0Q7-SW', 2.33, 'Base de données 1', NULL, 2, 'A2021'), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', NULL, 2, 'A2020'), 
    ('420-0SU-SW', 1.33, 'Web: Client 1', NULL, 2, 'A2021'), 
    ('420-2SU-SW', 2.33, 'Web: Serveur 2', NULL, 2, 'A2021'), 
    ('420-1SY-SW', 2.66, 'Analyse objet', NULL, 2, 'A2021'), 
    ('420-0SV-SW', 1.66, 'Échange de données 1', 'Développement d''applications client-serveur', 3, 'A2021'), 
    ('420-1SX-SW', 1.66, 'Robotique', 'Programmer un robot pour suivre un tracé', 3, 'A2021');


-- % pour n'importe quels caractères
-- _ pour 1 seul caractère
-- La recherche est case-INsensitive
select * from school.courses
where name like "web%"; -- qui débute par web

select * from school.teachers
where name not like "%a%"; -- qui ne contient pas a

select * from school.courses
where code like "420-0Q_-SW"; -- _ peut être remplacé par n'importe quel caractère









    -- Bornes incluses, expression >= a AND expression <= b

select * from school.courses
where credits between 2 and 3;

select * from school.courses
where left(name, 1) between 'a' and 'd'; -- cours dont la 1ere lettre du nom est a, b, c ou d

select * from school.teachers
where birthday between '1970-01-01' and '1980-12-31';

-- si on ne précise pas d'heure, la comparaison s'effectue à 00:00,
-- donc une valeur avec une heure plus tard sur la même date sera rejetée
select * from school.teachers
where birthday between '1970-03-03' and '1980-12-31';

select * from school.teachers
where birthday between '1970-03-03 09:45' and '1980-12-31';









select * from school.teachers
where employee_number in(1, 2, 3, 7);
-- employee_number = 1 || employee_number = 2 || employee_number = 3 || employee_number = 7

select * from school.courses
where code not in('autre', '420-0Q4-SW', '420-0Q7-SW');
-- code != 'autre' && code != '420-0Q4-SW' && code != '420-0Q7-SW'







select distinct teacher -- valeurs possibles dans la colonne teacher
from school.courses;

-- le distinct s'applique sur la combinaison des colonnes spécifiées
select distinct teacher, code
from school.courses;

select * from school.courses
order by credits desc, name asc; -- tri

select *
from school.teachers
limit 1 offset 2; -- le 3eme enseignant










select  name as `nom`,
        -- ifnull(expression, value_true)
        ifnull(description, '[vide]') as `description`,
        
        -- if(condition, value_true, value_false)
        if(credits > 2, 'inférieure', 'supérieure') as `charge`,

        -- case when (condition) then value_true ... else value end
        case when (credits < 1) then 'tres petit'
             when (credits between 1 and 2) then 'petit'
             when (credits = 2) then 'standard'
             when (credits between 2 and 3) then 'moyen'
             when (credits > 3) then 'gros'
        end as `pondération`,

        -- case (exp) when value then value_true ... else value end
        case teacher when 1 then 'james'
             when 2 then 'Mathieu'
             when 3 then 'Marco'
             else '???'
        end as `nom enseignant`

from school.courses;












select  name as `nom`,

        char_length(name) as `longueur nom`,

        concat_ws(' | ', code, name, credits ) as `sommaire`,

        format(credits, 1) as `format credits`,

        substring(code, 5, 3) as `identifiant`

from school.courses;










select
    curdate() as `aujourd'hui`,

    now() as `maintenant`,

    name as `nom`,

    birthday as `date de naissance`,

    datediff(curdate(), birthday) as `age jours`,

    timestampdiff(year, birthday, curdate()) as `age annees`,

    concat_ws(' ', dayname(birthday), day(birthday), monthname(birthday), year(birthday)) as `jour de naissance`,

    date_format(birthday, '%W %e %M %Y','fr_CA') as `format jour de naissance`
from school.teachers;