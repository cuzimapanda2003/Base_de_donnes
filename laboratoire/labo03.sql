--
-- votre nom : marc-antoine blais
--

drop database if exists airport;
create database airport;
use airport;


create table countries (
  codeiso char(3) primary key,
  name varchar(100) not null
);


create table pilots (
  id int unsigned auto_increment primary key,
  name varchar(100) not null,
  birthday date not null,
  country_code char(3) not null,
  foreign key (country_code)
    references countries(codeiso)
    on update cascade
    on delete restrict
);


create table routes (
  codeiata char(3) not null,
  sequence char(4) not null,
  origine char(3) not null,
  destination char(3) not null,
  primary key (codeiata, sequence),
  foreign key (origine)
    references countries(codeiso)
    on update cascade,
  foreign key (destination)
    references countries(codeiso)
    on update cascade
);


create table lookup (
  id int auto_increment primary key,
  manufacturer_name varchar(100) not null unique
);


create table planes (
  caa_code char(6) primary key,
  manufacturer_id int not null,
  model varchar(100) not null,
  foreign key (manufacturer_id)
    references lookup(id)
    on update cascade
    on delete restrict
);


create table maintenances (
  id int auto_increment primary key,
  plane_code char(6) not null,
  start date not null,
  end date,
  description varchar(1000) not null,
  foreign key (plane_code)
    references planes(caa_code)
    on delete cascade
    on update cascade
);


create table flights (
  id int unsigned auto_increment primary key,
  departure datetime not null,
  duration time not null,
  delay time not null default '00:00:00',
  route_code char(3) not null,
  route_seq char(4) not null,
  plane_code char(6) not null,
  foreign key (route_code, route_seq)
    references routes(codeiata, sequence)
    on update cascade,
  foreign key (plane_code)
    references planes(caa_code)
    on update cascade
);


create table flights_pilots (
  flight_id int unsigned not null,
  pilot_id int unsigned not null,
  is_copilot boolean not null default false,
  primary key (flight_id, pilot_id),
  foreign key (flight_id)
    references flights(id)
    on delete cascade
    on update cascade,
  foreign key (pilot_id)
    references pilots(id)
    on update cascade
);

create table audits (
  flight_id int unsigned primary key,
  pilot tinyint not null check (pilot between 1 and 4),
  copilot tinyint not null check (copilot between 1 and 4),
  crew tinyint not null check (crew between 1 and 4),
  food tinyint not null check (food between 1 and 4),
  toilets tinyint not null check (toilets between 1 and 4),
  comment varchar(1000),
  foreign key (flight_id)
    references flights(id)
    on delete cascade
    on update cascade
);


-- **Insérer** des données de départ dans chaque table en couvrant différentes relations possibles

insert into countries (codeiso, name) values
('CAN', 'Canada'),
('USA', 'United States'),
('FRA', 'France'),
('MEX', 'Mexico');




insert into pilots (name, birthday, country_code) values
('Jean Tremblay', '1980-05-12', 'CAN'),
('Sophie Dubois', '1987-03-21', 'CAN'),
('John Smith', '1975-09-15', 'USA'),
('Marie Dupont', '1990-11-02', 'FRA');



insert into lookup (manufacturer_name) values
('Airbus'),
('Boeing'),
('Bombardier');



insert into planes (caa_code, manufacturer_id, model) values
('CAA001', 1, 'A320'),
('CAA002', 2, '737 MAX'),
('CAA003', 3, 'CRJ-900');



insert into maintenances (plane_code, start, end, description) values
('CAA001', '2024-12-01', '2024-12-03', 'Routine engine check'),
('CAA002', '2025-01-10', null, 'Ongoing software update');


insert into routes (codeiata, sequence, origine, destination) values
('YUL', '0001', 'CAN', 'USA'),
('YUL', '0002', 'CAN', 'FRA'),
('CDG', '0001', 'FRA', 'CAN');


insert into flights (departure, duration, delay, route_code, route_seq, plane_code) values
('2025-02-10 08:30:00', '05:15:00', '00:10:00', 'YUL', '0001', 'CAA001'),
('2025-03-05 22:00:00', '06:45:00', '00:00:00', 'YUL', '0002', 'CAA001'),
('2025-04-01 14:15:00', '07:20:00', '00:30:00', 'CDG', '0001', 'CAA002');

insert into flights_pilots (flight_id, pilot_id, is_copilot) values
(1, 1, false),
(1, 2, true);

insert into flights_pilots (flight_id, pilot_id, is_copilot) values
(2, 3, false),
(2, 4, true);


insert into flights_pilots (flight_id, pilot_id, is_copilot) values
(3, 1, false),
(3, 4, true);


insert into audits (flight_id, pilot, copilot, crew, food, toilets, comment) values
(1, 4, 4, 3, 2, 4, 'Excellent flight performance, food service needs improvement.');



-- **Récupérer** les *pilotes* qui ont plus de temps de vol que la moyenne
select
    p.name as pilot,
    sec_to_time(sum(time_to_sec(f.duration))) as flight_time,
    sec_to_time(
        sum(time_to_sec(f.duration)) - floor((
            select avg(total_seconds)
            from (
                select sum(time_to_sec(f2.duration)) as total_seconds
                from flights f2
                join flights_pilots fp2 on f2.id = fp2.flight_id
                where fp2.is_copilot = false
                group by fp2.pilot_id
            ) as subquery
        ))
    ) as `diff`
from pilots as p
left join flights_pilots fp on p.id = fp.pilot_id
left join flights f on f.id = fp.flight_id
group by p.name
having sum(time_to_sec(f.duration)) > (
    select avg(total_seconds)
    from (
        select sum(time_to_sec(f2.duration)) as total_seconds
        from flights f2
        join flights_pilots fp2 on f2.id = fp2.flight_id
        where fp2.is_copilot = false
        group by fp2.pilot_id
    ) as subquery
);


-- **Récupérer** les *pilotes/copilotes* en calculant

select
 p.name,
 count(distinct fp.flight_id) as `flights`,
 sum(case when fp.is_copilot = false then 1 else 0 end) as `pilot`,
 sum(case when fp.is_copilot = true then 1 else 0 end) as `copilot`
 from pilots as p
 left join flights_pilots fp on p.id = fp.pilot_id
 left join flights f on f.id = fp.flight_id
 group by p.name
 order by flights desc, pilot desc, copilot desc
;



-- **Récupérer**, pour chaque possibilité de pays, le nombres de routes, de vols et de pilotes
select
  o.codeiso as `origin`,
  d.codeiso as `destination`,
  count(distinct f.id) as `flights`,
  count(distinct r.codeiata) as `routes`,
  (
  select count(*)
  from pilots as p
  where p.country_code = o.codeiso
  ) as `pilots`
 from countries as o
 cross join countries as d
 left join routes as r
  on r.origine = o.codeiso
  and r.destination = d.codeiso
 left join flights as f
  on f.route_code = r.codeiata
  and f.route_seq = r.sequence
 group by o.codeiso, d.codeiso
 order by origin asc, flights desc
;


-- **Récupérer** un résumé des vols

select
  concat(f.route_code, ' : ', r.origine, ' -> ', r.destination) as `route`,
  f.departure,
  f.duration,
  f.delay,
  concat(l.manufacturer_name, ' ', p.model, ' ', p.caa_code) as `plane`,
  case
  when group_concat(distinct concat(pl.name, case when fp.is_copilot = false then '*' else '' end)
  order by fp.is_copilot asc separator ', ') is not null
  then group_concat(distinct concat(pl.name, case when fp.is_copilot = false then '*' else '' end)
  order by fp.is_copilot asc separator ', ')
  else 'NULL'
  end as `pilots`,
  case
  when a.flight_id is not null then
  concat(
  round((a.pilot + a.copilot + a.crew + a.food + a.toilets) / 5, 1),
  ' : ',
  if(a.comment = '' or a.comment is null, 'N/A', a.comment)
  )
  else 'NULL'
  end as `audit`
  from flights as f
  left join routes as r
  on f.route_code = r.codeiata
  and f.route_seq = r.sequence
  left join planes as p
  on f.plane_code = p.caa_code
  left join lookup as l
  on p.manufacturer_id = l.id
  left join flights_pilots as fp
  on f.id = fp.flight_id
  left join pilots as pl
  on fp.pilot_id = pl.id
  left join audits as a
  on f.id = a.flight_id
  group by
  f.id, f.departure, f.duration, f.delay,
  r.codeiata, r.origine, r.destination,
  p.caa_code, l.manufacturer_name, p.model,
  a.flight_id, a.comment,
  a.pilot, a.copilot, a.crew, a.food, a.toilets
  order by
  route asc,
  f.departure asc
;


-- **Récupérer** le sommaire des heures de vols par avion de chaque manufacturier

select plane, flight_time
from (
  select
    case
      when l.manufacturer_name is null and p.model is null then 'total'
      when p.model is null then concat('> ', lower(coalesce(l.manufacturer_name, 'unknown')))
      else lower(coalesce(p.model, 'unknown'))
    end as plane,
    coalesce(sec_to_time(sum(time_to_sec(f.duration))), '00:00:00') as flight_time,
    l.manufacturer_name,
    p.model
  from flights f
  left join planes p on f.plane_code = p.caa_code
  left join lookup l on p.manufacturer_id = l.id
  group by l.manufacturer_name, p.model with rollup
) as t
order by
  case when manufacturer_name is null then 2 else 1 end,
  manufacturer_name,
  case when model is null then 2 else 1 end,
  model;
