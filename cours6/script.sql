--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/cours6/script.sql


create or replace database school;
use school;

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

insert into 
    school.teachers (employee_number, name, email, birthday)
values 
    (1, 'James', 'jhoffman@cshawi.ca', '1990-01-01'), 
    (2, 'Mathieu', 'mstyves@cshawi.ca', '1980-02-02'), 
    (3, 'Stevens', 'sgagnon@cshawi.ca', '1965-03-03'), 
    (4, 'Marco', 'mguilmette@cshawi.ca', '1975-04-04'), 
    (5, 'Lyne', 'lamyot@cshawi.ca', '1985-05-05'), 
    (6, 'Nicolas', 'nbourre@cshawi.ca', '1988-08-08');

insert into 
    school.courses(code, credits, name, description, teacher, semester)
values  
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 1, concat('A', year(curdate()) - 1)), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 1, concat('A', year(curdate()))), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 1, concat('A', year(curdate())  - 3)), 
    ('420-0Q7-SW', 2.33, 'Base de données 1', null, 1, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 1, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 1, concat('A', year(curdate()))), 
    ('420-0Q7-SW', 2.33, 'Base de données 1', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 2, concat('A', year(curdate()))), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 2, concat('A', year(curdate())  - 3)), 
    ('420-0SU-SW', 1.33, 'Web: Client 1', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-2SU-SW', 2.33, 'Web: Serveur 2', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-1SY-SW', 2.66, 'Analyse objet', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 3, concat('A', year(curdate()) - 1)), 
    ('420-0SV-SW', 1.66, 'Échange de données 1', 'Développement d''applications client-serveur', 3, concat('A', year(curdate()) - 1)), 
    ('420-1SX-SW', 1.66, 'Robotique', 'Programmer un robot pour suivree un tracé', 3, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 3, concat('A', year(curdate()))), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 4, concat('A', year(curdate()) - 8)), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 4, concat('A', year(curdate()) - 7)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 1, concat('A', year(curdate()))), 
    ('420-0Q7-SW', 2.33, 'Base de données 1', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 2, concat('A', year(curdate()))), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 2, concat('A', year(curdate())  - 3)), 
    ('420-0SU-SW', 1.33, 'Web: Client 1', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-2SU-SW', 2.33, 'Web: Serveur 2', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-1SY-SW', 2.66, 'Analyse objet', null, 2, concat('A', year(curdate()) - 1)), 
    ('420-0Q4-SW', 2, 'Initiation à la profession', null, 3, concat('A', year(curdate()) - 1)), 
    ('420-0SV-SW', 1.66, 'Échange de données 1', 'Développement d''applications client-serveur', 3, concat('A', year(curdate()) - 1)), 
    ('420-1SX-SW', 1.66, 'Robotique', 'Programmer un robot pour suivree un tracé', 3, concat('A', year(curdate()) - 1)), 
    ('420-2SS-SW', 2, 'Développement d''applications mobiles', null, 5, concat('A', year(curdate()))),
    ('420-0SU-SW', 1.33, 'Web: Client 1', null, 2, concat('A', year(curdate())));

-- Liste des cours, en affichant le courriel de contact de l'enseignant du cours
select
    code,
    name,
    (select email from school.teachers where employee_number = teacher) as `courriel`,
    (select name from school.teachers where employee_number = teacher) as `nom`
from school.courses;

-- on peut utiliser le nom complet de la table 
-- OU
-- donner des alias aux tables 
-- pour rendre explicite la manipulation des colonnes
select
    courses.code,
    courses.name,
    (select t.email from school.teachers as t where t.employee_number = courses.teacher) as `courriel`,
    (select t.name from school.teachers as t  where t.employee_number = courses.teacher) as `nom`
from school.courses;


-- nombre de cours pour chaque prof
select
 name,
(
    select count(*)
    from courses
    where teacher = employee_number
) as `nb de cours`
from teachers;

-- les cours dont le nombre de credits est en dessous de la moyenne. on veut le code du cours, le nom , nb de credit et nom prof

-- select avg(credits) from courses;

select
code,
name,
credits,
(select name from teachers where employee_number = teacher) as `nom`
 from courses
 where credits < (select avg(credits) from courses);

-- requete ligne:
select name, credits from courses;



