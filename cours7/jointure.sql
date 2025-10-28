-- Reference: https://fr.wikipedia.org/wiki/Alphabet_grec

drop database if exists alphabet;
create database alphabet;

-- Different de CREATE OR REPLACE DATABASE qui est en ordre alphabetique
-- Sinon DROP TABLES IF EXISTS alphabet.greek, alphabet.english;

create table alphabet.english (
  id int unsigned primary key,
  letter varchar(1)
);

create table alphabet.greek (
  id int unsigned primary key,
  name varchar(10),
  english_id int unsigned,
  foreign key (english_id) references english(id) on delete cascade
);

insert into alphabet.english values (1, 'a'), (2, 'b'), (3, 'c'), (4, 'd'), (5, 'e'), (6, 'f'), (7, 'g'), (8, 'h'), (9, 'i'), (10, 'j'), (11, 'k'), (12, 'l'), (13, 'm'), (14, 'n'), (15, 'o'), (16, 'p'), (17, 'q'), (18, 'r'), (19, 's'), (20, 't'), (21, 'u'), (22, 'v'), (23, 'w'), (24, 'x'), (25, 'y'), (26, 'z');

insert into alphabet.greek values (1, 'alpha', 1), (2, 'beta', 2), (3, 'gamma', 7), (4, 'delta', 4), (5, 'epsilon', 5), (6, 'zeta', 26), (7, 'eta', null), (8, 'theta', null), (9, 'iota', 9), (10, 'kappa', 11), (11, 'lambda', 12), (12, 'mu', 13), (13, 'nu', 14), (14, 'xi', 24), (15, 'omicron', 15), (16, 'pi', 16), (17, 'rho', 18), (18, 'sigma', 19), (19, 'tau', 20), (20, 'upsilon', 21), (21, 'phi', null), (22, 'chi', null), (23, 'psi', null), (24, 'omega', null);

-- select 
--     * 
-- from 
--     alphabet.english
-- cross join 
--     alphabet.greek;


select 
    *
from 
    alphabet.english
inner join 
    alphabet.greek on alphabet.english.id = alphabet.greek.english_id
order by 
    letter;




    select 
    *
from 
    alphabet.english
left join 
    alphabet.greek on alphabet.english.id = alphabet.greek.english_id;




    select 
    *
from 
    alphabet.english
left join 
    alphabet.greek on alphabet.english.id = alphabet.greek.english_id
where 
    alphabet.greek.id is null; -- <== exclusif à english





    select
    *
from 
    alphabet.english
right join 
    alphabet.greek on alphabet.english.id = alphabet.greek.english_id
order by 
    alphabet.greek.id;
