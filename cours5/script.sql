--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/cours5/script.sql

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



--Group by

select
    teacher,
    count(code) as `# cours/prof carriere`
from school.courses
group by teacher;

select
  semester,
  name,
 count(semester) as `# cours/session`
from school.courses
group by semester, name;

select
teacher,
semester,
count(code) as `# cours/prof/session` 
from school.courses
group by teacher, semester; -- par enseignant et session

select
teacher,
semester,
 count(code) as `# cours/prof/session > 2`
from school.courses
group by teacher, semester
having `# cours/prof/session > 2` > 2;


-- compter la moyenne de crédits donn er par chacun des profs :
select 
teacher,
avg(credits) as `moyenne de crédit`
from school.courses
group by teacher -- on peut replacer le order by si on veut en ordre de prof exemple: group by teacher desc 
having `moyenne de crédit` >=2 --where des agrégatio ( having )
order by `moyenne de crédit`;

