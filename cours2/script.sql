--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
--source /home/etd/BaseDeDonne/cours2/script.sql
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);

create or replace user "administrateur"@"%" identified by 'pwda';
create or replace database school;
grant all on school.* to "administrateur";

use school;

create or replace table teachers(
employee_number int auto_increment key,
name varchar(200) not null,
email varchar(200) unique
);

create or replace table courses(
code char(10) not null unique,
credits double(2,1) not null default 1,
description varchar(1000)
);

create or replace table groupes(
number tinyint(3) not null,
session char(5) not null
);

create or replace table students(
    admission_number char(7) not null unique,
    name varchar(200) not null
);

insert into teachers
values (2315,"M-C Bélanger", "mc@gmail.com"),
(2316, "james", "jhoff@gmail.com");

insert into teachers(employee_number, name, email)
values(2317, "Mathieu", "m@gmail.com"),
(2318, "nick", "nick@gmail.com");

insert into courses
values("420-1q7-sw", 2.3, "initiation");

insert into teachers
values(default,"lyne","lyn@blabla");

--afficher le tableau dans la base de donner
select
     name,
     employee_number,
    email
from
    teachers;

--affiche le tableau en ordre de création
select * from teachers;


-- affiche tableau ou la description est null
--select * from teachers where the description is NULL;

--autre exemple, ou l'on affiche les teachers en haut de 2318
--select * from teachers where employee_number > 2318

select
    employee_number as `numéro d'employer`,
    name as `nom`,
    email as `courriel`
from teachers;

create or replace table numbers(
    number_1 int,
    number_2 int
);

insert into numbers
values(23, 50);

select
number_1,
number_2,
number_1 + number_2 as `somme`
from numbers



