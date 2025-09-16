--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/cours3/script.sql


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

insert into 
    school.teachers (employee_number, name, email, birthday)
values 
    (1, 'James', 'jhoffman@cshawi.ca', '1990-01-01'), 
    (2, 'Mathieu', 'mstyves@cshawi.ca', '1980-02-02'), 
    (3, 'Stevens', 'sgagnon@cshawi.ca', '1970-03-03'), 
    (4, 'Marco', 'mguilmette@cshawi.ca', '1975-04-04');

insert into 
    school.courses(code, credits, name, description, teacher, semester)
values  
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
    ('420-1SX-SW', 1.66, 'Robotique', 'Programmer un robot pour suivree un tracé', 3, 'A2021');


--select * from school.courses;

update school.courses
set description = 'n/a',     -- valeur
    name = upper(name),      -- fonction
    credits = (credits * 2); -- calcul

update school.courses
set teacher = 4
where teacher = 1; -- condition, marco(4) remplacera James(1)


--select * from school.courses;


select * from school.courses;

delete from school.courses
where teacher = 3 -- supprime les cours de Stevens(3)
returning code, upper(name) as `nom`, credits; -- les cours supprimés

delete from school.courses; -- vide la table

select * from school.courses;


select * from school.teachers;

delete from school.teachers
order by employee_number desc
limit 1; -- supprime l'enseignant avec le numero le plus élevé

select * from school.teachers;