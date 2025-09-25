--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/exercices/semaine5/exercice2.sql


create database if not exists todo;

use todo;

create or replace table tasks(
    id int unsigned not null auto_increment key,
    name varchar(100) not null,
    description varchar(500),
    employee varchar(250),
    due_date date default curdate(),
    estimated_duration time not null,
    actual_duration time,
    completed_date date default null
);

insert into 
    tasks(id, name, description, estimated_duration, due_date, employee, actual_duration, completed_date)
values 
    (default, 'a', 'tache a', 100000, concat(year(curdate()) - 2, '-01-01'), 'alice', 80000, concat(year(curdate()) - 2, '-01-01')),
    (default, 'b', 'tache b', 30000, concat(year(curdate()) - 1, '-01-01'), 'bob', 53000, concat(year(curdate()) - 1, '-01-02')),
    (default, 'c', 'tache c', 300000, concat(year(curdate()) - 2, '-01-01'), 'charlie', 100000, concat(year(curdate()) - 2, '-01-03')),
    (default, 'd', null, 100000, concat(year(curdate()), '-02-01'), 'alice', 50000, null),
    (default, 'e', null, 120000, concat(year(curdate()), '-02-01'), 'alice', 140000, null),
    (default, 'f', 'tache f', 240000, concat(year(curdate()) - 2, '-02-01'), 'charlie', null, concat(year(curdate()) - 2, '-01-01')),
    (default, 'g', 'tache g', 340000, concat(year(curdate()), '-03-01'), 'bob', 300000, null),
    (default, 'h', null, 10000, concat(year(curdate()), '-03-01'), 'bob', 11500, concat(year(curdate()), '-03-01')),
    (default, 'i', 'tache i', 180000, concat(year(curdate()), '-04-01'), 'bob', null, null),
    (default, 'j', 'tache j', 40000, concat(year(curdate()), '-05-01'), 'charlie', null, concat(year(curdate()), '-05-01')),
    (default, 'k', 'tache k', 160000, concat(year(curdate()) - 1, '-06-01'), 'charlie', 124500, concat(year(curdate()) - 1, '-06-02')),
    (default, 'l', 'tache l', 220000, concat(year(curdate()) - 2, '-06-01'), 'charlie', 210000, null),
    (default, 'm', null, 80000, concat(year(curdate()), '-07-01'), 'charlie', null, concat(year(curdate()), '-07-01')),
    (default, 'n', null, 60000, concat(year(curdate()), '-08-01'), 'alice', null, null),
    (default, 'o', null, 20000, concat(year(curdate()), '-08-01'), 'charlie', 43000, null),
    (default, 'p', 'tache p', 100000, concat(year(curdate()) - 2, '-08-01'), 'bob', 80000, null),
    (default, 'q', null, 10000, concat(year(curdate()) - 1, '-09-01'), 'alice', 100000, concat(year(curdate()) - 1, '-09-02')),
    (default, 'r', 'tache r', 30000, concat(year(curdate()), '-09-01'), 'alice', 70000, concat(year(curdate()), '-09-03')),
    (default, 's', 'tache s', 50000, concat(year(curdate()), '-10-01'), 'bob', 40000, null),
    (default, 't', null, 70000, concat(year(curdate()), '-10-01'), 'charlie', 60000, concat(year(curdate()), '-09-01')),
    (default, 'u', null, 20000, concat(year(curdate()) - 1, '-10-01'), 'charlie', 50000, null),
    (default, 'v', 'tache v', 40000, concat(year(curdate()), '-11-01'), 'bob', 50000, null),
    (default, 'w', 'tache w', 60000, concat(year(curdate()), '-11-01'), 'alice', 100000, null),
    (default, 'x', 'tache x', 120000, concat(year(curdate()), '-12-01'), 'alice', 100000, concat(year(curdate()), '-12-02')),
    (default, 'y', 'tache y', 240000, concat(year(curdate()) - 1, '-12-01'), 'charlie', 200000, null),
    (default, 'z', 'tache z', 360000, concat(year(curdate()), '-12-01'), 'bob', 300000, concat(year(curdate()), '-11-10'));



    select * from tasks;

    select
    employee,
    count(*) as `nombre de tâches`,
    count(if(actual_duration is not null and completed_date is not null, 1, null)) as `tache complèté`,
    count(if(actual_duration is not null and completed_date is null, 1, null)) as `tache en cours`,
    count(if(actual_duration is null and completed_date is null, 1, null)) as `en attente`,
    count(if(actual_duration is null and completed_date is not null , 1, null)) as `Annulee`,
    max(completed_date) as `derniere completion`,
    datediff(curdate(),max(completed_date)) as `nb jour comp`,
    avg(datediff(completed_date,due_date)) as `moyenne`


    from tasks
    where completed_date < curdate()
    group by employee
    order by `nombre de tâches` desc;

