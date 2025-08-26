--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
--source /home/etd/BaseDeDonne/exercices/semaine2/exercices02.sql
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);



create database if not exists todo;
grant all on todo.* to "manager"@"%" identified by "psw";
use todo;

create or replace table tasks(
id int unsigned not null auto_increment key,
name varchar(100) not null,
description varchar(500),
estimated_duration tinyint unsigned not null,
due_date date not null,
employee varchar(250),
actual_duration tinyint unsigned,
completed boolean not null default 0
);

INSERT INTO 
    tasks
VALUES 
    (DEFAULT, 'a', 'tache a', 10, '2021-01-01', 'alice', 8, TRUE),
    (DEFAULT, 'b', 'tache b', 3, '2021-01-01', 'bob', 5, TRUE),
    (DEFAULT, 'c', 'tache c', 30, '2021-01-01', 'charlie', 10, TRUE),
    (DEFAULT, 'd', NULL, 10, '2021-02-01', 'alice', 5, FALSE),
    (DEFAULT, 'e', NULL, 12, '2021-02-01', 'alice', 14, FALSE),
    (DEFAULT, 'f', 'tache f', 24, '2021-02-01', 'charlie', NULL, TRUE),
    (DEFAULT, 'g', 'tache g', 34, '2021-03-01', 'bob', 30, FALSE),
    (DEFAULT, 'h', NULL, 1, '2021-03-01', 'bob', 1, TRUE),
    (DEFAULT, 'i', 'tache i', 18, '2021-04-01', 'bob', NULL, FALSE),
    (DEFAULT, 'j', 'tache j', 4, '2021-05-01', 'charlie', NULL, TRUE),
    (DEFAULT, 'k', 'tache k', 16, '2021-06-01', 'charlie', 12, TRUE),
    (DEFAULT, 'l', 'tache l', 22, '2021-06-01', 'charlie', 21, FALSE),
    (DEFAULT, 'm', NULL, 8, '2021-07-01', 'charlie', NULL, TRUE),
    (DEFAULT, 'n', NULL, 6, '2021-08-01', 'alice', NULL, FALSE),
    (DEFAULT, 'o', NULL, 2, '2021-08-01', 'charlie', 4, FALSE),
    (DEFAULT, 'p', 'tache p', 10, '2021-08-01', 'bob', 8, FALSE),
    (DEFAULT, 'q', NULL, 1, '2021-09-01', 'alice', 10, TRUE),
    (DEFAULT, 'r', 'tache r', 3, '2021-09-01', 'alice', 7, TRUE),
    (DEFAULT, 's', 'tache s', 5, '2021-10-01', 'bob', 4, FALSE),
    (DEFAULT, 't', NULL, 7, '2021-10-01', 'charlie', 6, TRUE),
    (DEFAULT, 'u', NULL, 2, '2021-10-01', 'charlie', 5, FALSE),
    (DEFAULT, 'v', 'tache v', 4, '2021-11-01', 'bob', 5, FALSE),
    (DEFAULT, 'w', 'tache w', 6, '2021-11-01', 'alice', 10, FALSE),
    (DEFAULT, 'x', 'tache x', 12, '2021-12-01', 'alice', 10, TRUE),
    (DEFAULT, 'y', 'tache y', 24, '2021-12-01', 'charlie', 20, FALSE),
    (DEFAULT, 'z', 'tache z', 36, '2021-12-01', 'bob', 30, TRUE);



    select
        name,
        description,
        due_date,
        estimated_duration,
        actual_duration,
        completed
    from tasks;

select * from tasks where employee = "alice";

select * from tasks where actual_duration = 0;

select * from tasks where actual_duration > estimated_duration;

    select
        name,
        description,
        due_date,
        estimated_duration,
        actual_duration,
        completed,
        estimated_duration - actual_duration as `gain`
    from tasks where actual_duration < estimated_duration ;

