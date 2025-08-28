--sauvegarde: ctrl+s ou ctrl + f5
-- mysql -u nom -p (enter) et entrer le mot de passe ensuite
--source /home/etd/BaseDeDonne/laboratoire/labo01.sql
-- modifier dans la vm bind-address = 0.0.0.0 dans le nano /etc/mysql/mariadb.conf.d/50-server.cnf
-- pour montrer les database: show databases;
-- montrer les table de databases: show tables;
-- describe (nom table);
--
-- VOTRE NOM: Marc-Antoine Blais
--

--
-- Serveur
--

-- Base de donnée airport 
create database if not exists airport;
use airport


-- Utilisateur alice, mot de passe, privilèges, localhost
create user if not exists "alice"@"localhost" identified by "pwd";
grant all on airport to "alice"@"localhost";


-- Utilisateur bob, mot de passe, privilèges, externe
create user if not exists "bob"@"%" identified by "pwd";




-- Table pilots, colonnes, types, attributs


create table if not exists pilots(
name varchar(300) not null,
age tinyint unsigned not null,
country varchar(20) not null,
experience tinyint unsigned not null default 0,
weekly_flight tinyint unsigned
);



-- Initialisation flights, insertions fournies



--
-- Modélisation
--

/*

NOM TABLE
-------------
col_a TYPE ATTR ATTR = DEFAULT
col_b TYPE ATTR ATTR = DEFAULT
...

*/


--
-- Insertions minimales
--

-- pilots


-- flights



--
-- Pilotes
--

-- Les pilotes, plus de 50 ans: nom, âge, nationalité, expérience, vols hebdomadaires


-- Les pilotes, européens: `Nom`, `Nationalité`


-- Les pilotes, pas États-Unis: `Nom`, `Nationalité`


-- Les pilotes, en service: `Nom`, `Expérience`, `Vols hebdomadaires`, *Vols annuels*


-- Les pilotes, pilotés plus de moitié de la vie: `Nom`, `Âge`, `Expérience`, *% Exp*


--
-- Vols
--

-- Les vols, de alice, dans un Airbus: numéro, *départ*, origine, destination, durée, retard, avion


-- Les vols, intra-europe: Pilote, Numéro, Origine, Destination


-- [BONUS] Les vols, en retard au moins 1h: `Pilote`, `Numéro`, `Origine`, `Destination`, `Avion`, *Départ*, *Durée*, *Arrivée prévue*, *Retard*, *Arrivée réelle*


