--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/exercices/semaine6/cuisto.sql

create or replace database cuisto;

use cuisto;

create table cooks (
    email varchar(100) not null,
    name varchar(100) not null,
    join_date date not null default curdate()
);

create table categories (
    name varchar(100) not null
);

create table recipes (
    id int unsigned auto_increment key,
    name varchar(200) not null,
    description varchar(1000),
    ingredients varchar(1000),
    cook_email varchar(100) not null,
    category_name varchar(100)
);


create table steps (
    id int unsigned auto_increment key,
    description varchar(100) not null,
    duration time not null default 0,
    number smallint unsigned not null default 0,
    recipe_id int unsigned not null
);

insert into categories values ('Déjeuner'), ('Diner'), ('Souper'), ('Collation');

insert into 
    cooks
values  
    ('alice@mail.com', 'Alice', default),
    ('bob@mail.com', 'Bob', default),
    ('charlie@mail.com', 'Charlie', default),
    ('david@mail.com', 'David', default),
    ('eve@mail.com', 'Eve', default);

insert into 
    recipes
values  (default, 'Nom A', 'Description A', 'Ingredients A', 'alice@mail.com', NULL),
        (default, 'Nom B', 'Description B', 'Ingredients B', 'alice@mail.com', 'Déjeuner'),
        (default, 'Nom C', 'Description C', 'Ingredients C', 'bob@mail.com', 'Diner'),
        (default, 'Nom D', 'Description D', 'Ingredients D', 'charlie@mail.com', 'Souper'),
        (default, 'Nom E', 'Description E', 'Ingredients E', 'charlie@mail.com', 'Souper'),
        (default, 'Nom F', 'Description F', 'Ingredients F', 'bob@mail.com', 'Diner'),
        (default, 'Nom G', 'Description G', 'Ingredients G', 'alice@mail.com', 'Déjeuner'),
        (default, 'Nom H', 'Description H', 'Ingredients H', 'bob@mail.com', NULL),
        (default, 'Nom I', 'Description I', 'Ingredients I', 'alice@mail.com', 'Souper'),
        (default, 'Nom J', 'Description J', 'Ingredients J', 'alice@mail.com', 'Diner'),
        (default, 'Nom K', 'Description K', 'Ingredients K', 'charlie@mail.com', 'Souper'),
        (default, 'Nom L', 'Description L', 'Ingredients L', 'charlie@mail.com', 'Diner'),
        (default, 'Nom M', 'Description M', 'Ingredients M', 'charlie@mail.com', 'Déjeuner');

insert into steps
values  (default, 'Étape a', 0, 1, 1),
        (default, 'Étape aaaa', '00:01', 4, 1),
        (default, 'Étape aa', '00:02', 2, 1),
        (default, 'Étape aaa', '00:03', 3, 1),
        (default, 'Étape b', '00:04', 1, 2),
        (default, 'Étape bb', '00:05', 2, 2),
        (default, 'Étape ccc', '00:02', 3, 3),
        (default, 'Étape cc', '00:04', 2, 3),
        (default, 'Étape c', '00:12', 1, 3),
        (default, 'Étape d', '00:02', 1, 4),
        (default, 'Étape dd', '00:01', 2, 4),
        (default, 'Étape ddd', 0, 3, 4),
        (default, 'Étape dddddd', '00:01', 6, 4),
        (default, 'Étape ddddd', '00:02', 5, 4),
        (default, 'Étape dddd', '00:03', 4, 4);



select * from recipes;
select * from steps;
select * from cooks;
select * from categories;

--Récuperer les catégories ayant des recettes
select name
from categories
where name in(select distinct category_name from recipes where category_name is not null);

-- Récupérer les catégories n'ayant PAS de recettes
select name
 from categories
  where name not in (select distinct category_name from recipes where category_name is not null);

-- Récupérer toutes les recettes en ajoutant le nom du cuisinier

select
name,
(select name from cooks where email = cook_email)
from recipes;


-- recuperer les cuisinier qui prepaent des dejeuner

select 
    email,
    name,
    join_date
from 
    cooks
where email in (
                    select 
                        cook_email
                        from recipes
                        where category_name = "Déjeuner"

)
;

-- Récupérer les recettes sans étapes

select
     *
 from recipes
 where id not in (select recipe_id from steps)
;


-- Récupérer les catégories et le nombre de recettes que chacune contient, triées en ordre croissant du nombre de recettes

select
    name,
   ifnull( (select
    count(*) as `nb`
from recipes
where category_name = c.name
group by category_name),0) as `nb_recette`

from categories as c
order by nb_recette
    ;

