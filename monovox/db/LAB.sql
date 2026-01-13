use monovox;

drop table if exists grades;
drop table if exists assignments;

create table assignments(
  id int unsigned auto_increment primary key,
  name varchar(100) not null,
  weight tinyint unsigned not null,
  points tinyint unsigned not null,
  date date not null,
  group_semester char(5) not null,
  group_course char(10) not null,
  group_number tinyint unsigned not null,
  foreign key (group_number, group_semester, group_course)
    references groups(number, semester, course_code)
    on delete cascade
);

create table grades(
  student_id int unsigned not null,
  assignment_id int unsigned not null,
  point tinyint unsigned,
  primary key(student_id, assignment_id),
  foreign key (student_id) references students(id),
  foreign key (assignment_id) references assignments(id) on delete cascade
);

delimiter $$

create trigger assignments_insert_create_grades
after insert on assignments
for each row
begin
    insert into grades (student_id, assignment_id, point)
    select c.student_id, new.id, null
    from classes c
    join groups g 
      on g.number = c.group_number
     and g.semester = c.group_semester
     and g.course_code = c.group_course
     and g.teacher_employee_number = c.group_teacher
    where g.number = new.group_number
      and g.semester = new.group_semester
      and g.course_code = new.group_course;
end $$

delimiter ;



insert into assignments 
(name, weight, points, date, group_semester, group_course, group_number) values
('TP 1', 40, 10, '2020-10-01', 'a2020', '420-0q4-sw', 1),
('Formatif', 0, 0, '2020-11-03', 'a2020', '420-0q4-sw', 1),
('Examen final', 60, 100, '2020-12-11', 'a2020', '420-0q4-sw', 1),

('Projet de session', 100, 40, '2020-11-29', 'a2020', '420-0su-sw', 1),

('TP 1', 30, 15, '2021-09-15', 'a2021', '420-0q4-sw', 1),
('Examen intra', 30, 50, '2021-10-20', 'a2021', '420-0q4-sw', 1),
('Examen final', 40, 60, '2021-12-10', 'a2021', '420-0q4-sw', 1),

('Laboratoire 1', 20, 20, '2021-09-10', 'a2021', '420-0su-sw', 2),
('TP HTML/CSS', 30, 50, '2021-10-05', 'a2021', '420-0su-sw', 2),
('Projet JavaScript', 50, 100, '2021-11-30', 'a2021', '420-0su-sw', 2);


update grades set point = 8 where student_id = 20201 and assignment_id = 1;
update grades set point = 10 where student_id = 20202 and assignment_id = 1;
update grades set point = 6 where student_id = 20203 and assignment_id = 1;
update grades set point = 9 where student_id = 20204 and assignment_id = 1;
update grades set point = 7 where student_id = 20205 and assignment_id = 1;
