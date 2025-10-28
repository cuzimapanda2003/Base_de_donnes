drop database cuisto;
create database cuisto;

use cuisto;

create table cooks (
    email varchar(100) primary key,
    name varchar(100) not null,
    join_date date not null default curdate()
);

create table categories (
    name varchar(100) primary key
);

create table recipes (
    id int unsigned auto_increment primary key,
    name varchar(200) not null,
    description varchar(1000),
    ingredients varchar(1000),
    cook_email varchar(100) not null,
    category_name varchar(100),
    -- Supprimer un cuisinier entraîne la suppression de ses recettes et 
    -- On peut modifier le nom des catégories et le courriel des cuisiniers
    foreign key (cook_email) references cooks(email) on delete cascade on UPDATE cascade,
    -- Supprimer une catégorie assigne NULL aux recettes correspondantes et 
    -- On peut modifier le nom des catégories et le courriel des cuisiniers
    foreign key (category_name) references categories(name) on delete set null on UPDATE cascade
);


create table steps (
  	description varchar(100) not null,
  	duration time not null default 0,
  	number smallint unsigned not null default 0,
  	recipe_id int unsigned not null,
    -- Supprimer une recette entraîne la suppression de ses étapes
    foreign key (recipe_id) references recipes(id) on delete cascade
);

insert into categories values ('Déjeuner'), ('Diner'), ('Souper'), ('Collation');

insert into cooks
values 	('alice@mail.com', 'Alice', default),
		('bob@mail.com', 'Bob', default),
        ('charlie@mail.com', 'Charlie', default),
        ('david@mail.com', 'David', default),
        ('eve@mail.com', 'Eve', default);

insert into recipes
values 	(default, 'Nom A', 'Description A', 'Ingredients A', 'alice@mail.com', null),
		(default, 'Nom B', 'Description B', 'Ingredients B', 'alice@mail.com', 'Déjeuner'),
        (default, 'Nom C', 'Description C', 'Ingredients C', 'bob@mail.com', 'Diner'),
        (default, 'Nom D', 'Description D', 'Ingredients D', 'charlie@mail.com', 'Souper'),
        (default, 'Nom E', 'Description E', 'Ingredients E', 'charlie@mail.com', 'Souper'),
        (default, 'Nom F', 'Description F', 'Ingredients F', 'bob@mail.com', 'Diner'),
        (default, 'Nom G', 'Description G', 'Ingredients G', 'alice@mail.com', 'Déjeuner'),
        (default, 'Nom H', 'Description H', 'Ingredients H', 'bob@mail.com', null),
        (default, 'Nom I', 'Description I', 'Ingredients I', 'alice@mail.com', 'Souper'),
        (default, 'Nom J', 'Description J', 'Ingredients J', 'alice@mail.com', 'Diner'),
        (default, 'Nom K', 'Description K', 'Ingredients K', 'charlie@mail.com', 'Souper'),
        (default, 'Nom L', 'Description L', 'Ingredients L', 'charlie@mail.com', 'Diner'),
        (default, 'Nom M', 'Description M', 'Ingredients M', 'charlie@mail.com', 'Déjeuner');

insert into steps
values 	('Étape a', 0, 1, 1),
		('Étape aaaa', '00:01', 4, 1),
        ('Étape aa', '00:02', 2, 1),
        ('Étape aaa', '00:03', 3, 1),
        ('Étape b', '00:04', 1, 2),
        ('Étape bb', '00:05', 2, 2),
        ('Étape c', '00:12', 1, 3),
        ('Étape d', '00:02', 1, 4),
        ('Étape dd', '00:01', 2, 4),
        ('Étape ddd', 0, 3, 4),
        ('Étape dddddd', '00:01', 6, 4),
        ('Étape ddddd', '00:02', 5, 4),
        ('Étape dddd', '00:03', 4, 4);


       -- select * from cooks;
      --  select * from recipes order by cook_email;
      --  select * from steps;
       
       -- delete from cooks where name = "Alice";

      --  select * from cooks;
      --  select * from recipes order by cook_email;
     --   select * from steps;

       -- select * from recipes order by cook_email;
       -- delete from categories where name = "Déjeuner";
       -- select * from recipes order by cook_email;


       -- UPDATE categories
       -- set name = "patator"
       -- where name = "Souper";

      --  UPDATE cooks 
      --  set email = "patator3000@gmail.com"
     --   where email = 'bob@mail.com';

      --  select * from recipes;

        -- Récupérer(jointure) les catégories utilisées
        select
         distinct cat.*
          from categories as cat
           inner join recipes as r
            on cat.name = r.category_name ;

-- Récupérer(jointure) les catégories n'ayant PAS de recettes
select 
distinct cat.name 
from categories as cat
left join recipes as r on cat.name = r.category_name
where r.category_name is null;


-- Récupérer(jointure) toutes les recettes en ajoutant le nom du cuisinier

select
r.*,
c.name
from recipes as r
 inner join cooks as c on c.email = r.cook_email;

 -- Récupérer(jointure) les cuisiniers qui préparent des déjeuners

 select
  distinct c.*
 from cooks as c
 inner join  recipes as r on c.email = r.cook_email
 where r.category_name = "Déjeuner"
   ;

   -- Récupérer(jointure) les recettes sans étapes

   select
    r.* 
   from recipes as r
   left join steps as s on r.id = s.recipe_id
   where s.recipe_id is null
   ;

   -- Récupérer(jointure) les catégories et
   -- le nombre de recettes que chacune contient, triées en ordre décroissant du nombre de recettes

   select
     c.name ,
    count(r.id) as "nb recette"
    from categories as c
    left join recipes as r on r.category_name = c.name
    group by c.name
    order by c.name desc
    ;


-- Récupérer(jointure) les recettes ayant moins de 5 étapes


