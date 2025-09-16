--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--source /home/etd/BaseDeDonne/exercices/semaine3/exercices01.sql

create database if not exists cuisto;

use cuisto;

create or replace table recipes (
    name varchar(250) not null,
    description varchar(1000),
    ingredients varchar(1000),
    steps varchar(2000),
    preparation_time int default 0,
    category varchar(50) not null default 'Uncategorized'
);

insert into 
    recipes
values 
    ('Sandwich', 'Une garniture entre 2 tranches de pain', 'Pain, Garniture', 'Trancher, Garnir, Déguster', 5, 'Principal'),
    ('Sandwich', 'Du fromage entre 2 tranches de pain', 'Pain, Fromage', 'Trancher, Garnir, Griller, Déguster', 12, DEFAULT),
    ('Paté chinois', NULL, 'Steak, Blé d''inde, Patates', 'Cuire la viande, mélanger', 45, 'Principal'),
    ('Lasagne', 'Pâtes étagées', 'Pâtes, sauce', 'Cuire, Étendre, Garnir', 90, 'Principal'),
    ('Poutine', NULL, 'Patates, Sauce brune, Fromage en grain', 'Couper les patates en frites, cuire au four, réchauffer la sauce, servir', 30, DEFAULT),
    ('Bouilli', NULL, 'Patates, Fèves, Choux, Carottes, Cubes de boeuf', 'Couper les légumes, mélanger, cuire dans un bouillon', 150, 'Principal'),
    ('Soupe', 'Bouillon de légumes', 'Légumes de saison', 'mélanger dans un chaudron, bouillir', 20, 'Entrée'),
    ('Soupe', 'Crème de brocoli', 'Bouillon, Patates, Brocoli', 'Cuire, Passer au mélangeur', 25, 'Entrée'),
    ('Soupe', 'Poulet et nouilles', 'Poulet, nouilles', 'cuire le poulet et les pâtes séparément, mélanger', 45, 'Entrée');

insert into
    recipes (name, category, ingredients, steps, preparation_time)
values 
    ('Pomme', 'Collation', DEFAULT, DEFAULT, DEFAULT), 
    ('Banane', 'Collation', DEFAULT, DEFAULT, DEFAULT), 
    ('Fromage', 'Collation', DEFAULT, 'Couper en bâtons', 2), 
    ('Craquelins', 'Collation', 'Biscuits au choix', 'Tartiner au goût', DEFAULT);


    update recipes 
    set category = "Plat principale"
    where category = "Principal";

    select * from recipes;

    update recipes 
    set name = contcat("(", name, ")")
    where category = "Entrée";

    select * from recipes;


    update recipes 
    set name =  "+++NOM"
    order by preparation_time desc
    limit 5;

  select * from recipes;

  update recipes
  set preparation_time = 1
  where preparation_time = 0 and steps is not null;

   select * from recipes;


   update recipes
   set preparation_time = preparation_time * 2
   where CHAR_LENGTH(steps) > 40;


    select * from recipes;

    UPDATE recipes
    SET name = CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2, CHAR_LENGTH(name))));


    select * from recipes;

    delete from recipes
    where category = 'Uncategorized'
    returning name, description, ingredients,steps,preparation_time,category;

    delete from recipes
    where description is null and ingredients is null and steps is null
    returning name, description, ingredients, steps;


    DELETE FROM recipes
    ORDER BY preparation_time DESC
    LIMIT 1
    returning name, preparation_time;


create database if not exists cuisto;

use cuisto;

create or replace table recipes (
    name varchar(250) not null,
    description varchar(1000),
    ingredients varchar(1000),
    steps varchar(2000),
    preparation_time int default 0,
    category varchar(50) not null default 'Uncategorized'
);

insert into 
    recipes
values 
    ('Sandwich', 'Une garniture entre 2 tranches de pain', 'Pain, Garniture', 'Trancher, Garnir, Déguster', 5, 'Principal'),
    ('Sandwich', 'Du fromage entre 2 tranches de pain', 'Pain, Fromage', 'Trancher, Garnir, Griller, Déguster', 12, DEFAULT),
    ('Paté chinois', NULL, 'Steak, Blé d''inde, Patates', 'Cuire la viande, mélanger', 45, 'Principal'),
    ('Lasagne', 'Pâtes étagées', 'Pâtes, sauce', 'Cuire, Étendre, Garnir', 90, 'Principal'),
    ('Poutine', NULL, 'Patates, Sauce brune, Fromage en grain', 'Couper les patates en frites, cuire au four, réchauffer la sauce, servir', 30, DEFAULT),
    ('Bouilli', NULL, 'Patates, Fèves, Choux, Carottes, Cubes de boeuf', 'Couper les légumes, mélanger, cuire dans un bouillon', 150, 'Principal'),
    ('Soupe', 'Bouillon de légumes', 'Légumes de saison', 'mélanger dans un chaudron, bouillir', 20, 'Entrée'),
    ('Soupe', 'Crème de brocoli', 'Bouillon, Patates, Brocoli', 'Cuire, Passer au mélangeur', 25, 'Entrée'),
    ('Soupe', 'Poulet et nouilles', 'Poulet, nouilles', 'cuire le poulet et les pâtes séparément, mélanger', 45, 'Entrée');

insert into
    recipes (name, category, ingredients, steps, preparation_time)
values 
    ('Pomme', 'Collation', DEFAULT, DEFAULT, DEFAULT), 
    ('Banane', 'Collation', DEFAULT, DEFAULT, DEFAULT), 
    ('Fromage', 'Collation', DEFAULT, 'Couper en bâtons', 2), 
    ('Craquelins', 'Collation', 'Biscuits au choix', 'Tartiner au goût', DEFAULT);


    update recipes 
    set category = "Plat principale"
    where category = "Principal";

    select * from recipes;

    update recipes 
    set name = contcat("(", name, ")")
    where category = "Entrée";

    select * from recipes;


    update recipes 
    set name =  "+++NOM"
    order by preparation_time desc
    limit 5;

  select * from recipes;

  update recipes
  set preparation_time = 1
  where preparation_time = 0 and steps is not null;

   select * from recipes;


   update recipes
   set preparation_time = preparation_time * 2
   where CHAR_LENGTH(steps) > 40;


    select * from recipes;

    update recipes
    set name = CONCAT(UPPER(LEFT(name, 1)), LOWER(SUBSTRING(name, 2, CHAR_LENGTH(name))));


    select * from recipes;

    delete from recipes
    where category = 'Uncategorized'
    returning name, description, ingredients,steps,preparation_time,category;

    delete from recipes
    where description is null and ingredients is null and steps is null
    returning name, description, ingredients, steps;


    delete from recipes
    order by preparation_time desc
    limit 1
    returning name, preparation_time;


    delete from recipes
    where preparation_time > 60
    returning name, CONCAT(FLOOR(preparation_time / 60), 'h', LPAD(preparation_time % 60, 2, '0')) AS formatted_time;

    delete from recipes;
    select * from recipes;


