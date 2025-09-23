--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/exercices/semaine5/exercice1.sql


create database if not exists cuisto;

use cuisto;

create or replace table recipes (
    name varchar(250) not null,
    description varchar(1000),
    ingredients varchar(1000),
    steps varchar(2000),
    preparation_time int default 0,
    category varchar(50)
);

insert into
    recipes
values 
    ('Sandwich', 'Une garniture entre 2 tranches de pain', 'Pain, Garniture', 'Trancher, Garnir, Déguster', 5, 'Principal'),
    ('Sandwich', 'Du fromage entre 2 tranches de pain', 'Pain, Fromage', 'Trancher, Garnir, Griller, Déguster', 7, 'Principal'),
    ('Paté chinois', NULL, 'Steak, Blé d''inde, Patates', 'Cuire la viande, mélanger', 30, 'Principal'),
    ('Lasagne', 'Pâtes étagées', 'Pâtes, sauce', 'Cuire, Étendre, Garnir', 35, 'Principal'),
    ('Poutine', NULL, 'Patates, Sauce brune, Fromage en grain', 'Couper les patates en frites, cuire au four, réchauffer la sauce, servir', 30, 'Principal'),
    ('Soupe', 'Bouillon de légumes', 'Légumes de saison', 'Mélanger dans un chaudron, bouillir', 20, 'Entrée'),
    ('Soupe', 'Crème de brocoli', 'Bouillon, Patates, Brocoli', 'Cuire, Passer au mélangeur', 25, 'Entrée'),
    ('Soupe', 'Poulet et nouilles', 'Poulet, nouilles', 'Cuire le poulet et les pâtes séparément, mélanger', 45, 'Entrée');

insert into 
    recipes (name, description, category)
values 
    ('Pomme', 'Fruit frais', 'Collation'), 
    ('Cheddar', 'Batonnets de fromage', 'Collation'), 
    ('Craquelins', 'Petits biscuits', 'Collation');

insert into 
    recipes (name)
values 
    ('Café'), 
    ('Chocolat chaud'), 
    ('Thé');


    select * from recipes;


    select
    ifnull(category, "n/a"),
    count(category) as `nb recette`,
    MIN(preparation_time) as `prep min`,
    MAX(preparation_time) as `prep max`,
    avg(preparation_time) as `prep moyenne`
    from recipes
    group by category;


    select
    count(name) as `nb recette`,
    GROUP_CONCAT(distinct category SEPARATOR ' | ')
    from recipes;
