--source /home/etd/BaseDeDonne/laboratoire/labo02.sql
-- VOTRE NOM: Marc-Antoie Blais

--
-- SERVEUR
--

-- - Créer la base de données `shop`
-- - Créer l'utilisateur `alice` avec le mot de passe `pwd` possédant les accès complets sur `shop` via une connexion externe
-- - Créer les tables products et sales

create or replace database shop;
use shop;
create user if not exists "alice"@"%" identified by "pwd";
grant all on shop to "alice"@"%";


create table if not exists products(
    name varchar(100) unique not null,
    description varchar(100),
    sales_start date not null default curdate(),
    sales_end date,
    quantity int unsigned not null default 0,
    cost double(5,2) unsigned not null,
    price double(5,2) unsigned not null
);


create table if not exists sales(
id varchar(200)  primary key not null,
product varchar(200) not null,
quantity tinyint unsigned not null,
price double(10,2) unsigned not null,
discount tinyint unsigned
);

--
-- INSERTIONS
--

-- minimale products
insert into `products`(name,quantity,cost,price)
values("patate", 5, 2.52, 12.99);

-- minimale sales
insert into `sales`(id, product, quantity, price)
values("jean","freezer",14,199.99);

-- significatives
insert into `products`
values('chat', 'animal', '2010-10-20', '2011-10-25', 14, 1.00, 120.00),
      ("train", "jeux pour chat",'2010-10-20', '2011-10-25', 14, 1.00, 120.00),
      ("conduit", "jeux pour chat",'2010-10-20', '2011-10-25', 0, 1.00, 120.00);

INSERT into 
  sales (id, product, quantity, price, discount) 
VALUES
  ('alice cooper-20241123', 'Sifflet ultrason', 1, 2.99, NULL),
  ('bob dylan-20241207', 'Croquettes pour chatons', 2, 22.49, 0),
  ('bob dylan-20230923', 'Croquettes pour chatons', 10, 22.49, 30),
  ('alice cooper-20230922', 'Sac de transport', 1, 10.00, NULL),
  ('bob dylan-20230729', 'Collier', 0, 0.00, NULL),
  ('dave foster-20230801', 'Biscuits pour chien', 99, 2.99, 50),
  ('franck sinatra-20230729', 'Collier', 0, 0.00, NULL),
  ('alice cooper-20230920', 'Arbre à chat', 2, 89.99, 15),
  ('bob dylan-20231115', 'Peluche sonore', 3, 5.99, 0),
  ('carla bruni-20221218', 'Jouet pour chat', 4, 7.99, 20),
  ('dave foster-20221222', 'Grattoir en carton', 1, 14.00, 10),
  ('ed sheeran-20230901', 'Gamelle antidérapante', 5, 12.99, 5),
  ('freddie mercury-20221224', 'Pipettes anti-puces', 2, 15.50, 25),
  ('gainsbourg serge-20230103', 'Gamelle antidérapante', 1, 12.99, 0),
  ('carla bruni-20230925', 'Arbre à chat', 1, 89.99, 50),
  ('bob dylan-20221224', 'Biscuits pour chien', 10, 4.00, 35),
  ('alice cooper-20181201', 'Jouet pour chat', 3, 7.99, NULL);

select * from sales;
select * from products;




--
-- PRODUITS
--

-- **Récupérer** les produits pour chat, donc qui contiennent le *mot* `chat` dans le nom. ou la description.

select * from products where name like "%chat%" OR description like "%chat%" ;



-- **Récupérer** le sommaire des produits, trié par date de fin de vente, quantité en inventaire et *profit*, en calculant les valeurs suivantes
-- 
-- - *product* contient le nom du produit ET s'il possède une description, séparée par `:`
-- - *years* est le nombre d'années de ventes du produit, par rapport à aujourd'hui s'il est toujours en vente
-- - *profit* est le *montant* généré par la vente du produit, considérant sont prix coûtant
-- - *margins* est le pourcentage correspondant au profit par rapport au prix de vente
-- - *status* est l'état du produit soit
    -- - `selling: {quantity}` si en vente et quantité > 0
    -- - `out of stock` si en vente et quantité <= 0
    -- - `clearance: {quantity} => {valeur de l'inventaire}` si pas en vente et quantité > 0
    -- - `archived` sinon, donc pas en vente et quantité <= 0 
select
    if(description is not null and description != '', concat(name, ': ', description), name) as product,
    concat( timestampdiff(year, sales_start, ifnull(sales_end, curdate())),if(sales_end is null or sales_end >= curdate(), '+', '')) as years,
    cost,
    price,
    round(price - cost, 2) as profit,
    concat(round(((price - cost) / price) * 100, 0), '%') as margins,
    case
        when (sales_end is null or sales_end >= curdate()) and quantity > 0
            then concat('selling: ', quantity)
        when (sales_end is null or sales_end >= curdate()) and quantity <= 0
            then 'out of stock'
        when (sales_end < curdate()) and quantity > 0
            then concat('clearance: ', quantity, ' => ', round(quantity * price, 2), '$')
        else 'archived'
    end as status

from products
order by sales_end, quantity, profit;


-- **Supprimer** les produits *archivés* depuis plus de 5 ans, en affichant le nom des items affectés
delete from products
where sales_end is not null
  and sales_end < curdate() - interval 5 year
  and quantity <= 0
returning name;



-- --
-- -- VENTES
-- --

-- **Récupérer** le nom des différents clients des ventes

select id from sales;



-- **Récupérer** les ventes réalisés durant le temps des Fêtes de l'*année précédente*(15 novembre au 31 décembre), triés du plus anciens au plus récent
-- 
-- - Afficher la *date* au format aaaa-mm-jj

select
    substring_index(id, '-', (char_length(id) - char_length(replace(id, '-', '')))) as client,
    str_to_date(substring_index(id, '-', -1), '%Y%m%d') as sale_date,
    product,
    quantity,
    price,
    discount
from sales
where str_to_date(substring_index(id, '-', -1), '%Y%m%d')
      between str_to_date(concat(year(curdate())-1, '-11-15'), '%Y-%m-%d')
          and str_to_date(concat(year(curdate())-1, '-12-31'), '%Y-%m-%d')
order by sale_date;




-- **Récupérer** les ventes de la plus récente à la plus ancienne en calculant
-- 
-- - *date* au format texte `Mois jour(indicateur st, nd, rd) Année
-- - *subtotal* montant de la vente sans le rabais
-- - *total* montant de la vente AVEC le rabais


select
    concat(
        date_format(str_to_date(substring_index(id, '-', -1), '%Y%m%d'), '%M %e'),
        case day(str_to_date(substring_index(id, '-', -1), '%Y%m%d'))
            when 1 then 'st'
            when 2 then 'nd'
            when 3 then 'rd'
            when 21 then 'st'
            when 22 then 'nd'
            when 23 then 'rd'
            when 31 then 'st'
            else 'th'
        end,
        date_format(str_to_date(substring_index(id, '-', -1), '%Y%m%d'), ' %Y')
    ) as date,
    product,
    quantity,
    price,
    discount,
    round(quantity * price, 2) as subtotal,
    round(quantity * price * (1 - ifnull(discount, 0) / 100), 2) as total
from sales
order by str_to_date(substring_index(id, '-', -1), '%Y%m%d') desc;


-- **Récupérer** les ventes par produit dont le rabais moyen est de plus de 25% 
select 
product,
round(avg(ifnull(discount, 0)), 2) as rabais_moyen
from sales
group by product
having avg(ifnull(discount, 0)) > 25;



-- **Récupérer** le sommaire des ventes pour chaque produit en calculant
-- 
-- - *$ amount* montant des ventes en considérant le rabais
-- - *# items* quantité totale vendue
-- - *# transactions* nombre de ventes dans lesquelles on retrouve le produit

select 
    product,
    round(sum(quantity * price * (1 - ifnull(discount,0)/100)), 2) as `$ amount`,
    sum(quantity) as `# items`,
    count(*) as `# transactions`
from sales
group by product;




-- **Récupérer** le sommaire des ventes pour chaque année de la plus récente à la plus ancienne, par client en ordre alphabétique, en calculant
-- 
-- - *year* l'année
-- - *client* le nom du client
-- - *$ amount* montant total des achats, en considérant le rabais
-- - *# products* nombre de produits différents achetés

select
    year(str_to_date(substring_index(id, '-', -1), '%Y%m%d')) as `year`,
    substring_index(id, '-', (char_length(id) - char_length(replace(id, '-', '')))) as client,
    round(sum(quantity * price * (1 - ifnull(discount,0)/100)), 2) as `$ amount`,
    count(distinct product) as `# products`
from sales
group by `year`, client
order by `year` desc, client asc;



-- **Récupérer** le meilleur client de l'*année dernière*
-- 
-- - *client* le nom du client
-- - *$ amount* montant total des achats durant l'année dernière, en considérant le rabais

select 
    substring_index(id, '-', (char_length(id) - char_length(replace(id, '-', '')))) as client,
    round(sum(quantity * price * (1 - ifnull(discount,0)/100)), 2) as `$ amount`
from sales
where year(str_to_date(substring_index(id, '-', -1), '%Y%m%d')) = year(curdate()) - 1
group by client
order by `$ amount` desc
limit 1;



-- **Mettre à jour** le rabais des ventes à 0 s'il est nul

update sales
set discount = 0
where discount is null;

-- **Supprimer** les ventes ne contenant aucuns articles en retournant le produit, le nom du client et la date correctement formatée

