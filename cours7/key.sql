create or replace table teachers (
  -- raccourci directement à la création de la colonne
  -- primary est optionnel, mais on précise pour être explicite
  employee_number int unsigned auto_increment primary key,
  name varchar(200) not null
);
-- describe teachers; pour constater le not null ajouté automatiquement

create or replace table courses (
  code char(10) not null,
  name varchar(200) not null,
  teacher_employee_number int unsigned,
  semester char(5) not null,

  -- définition dédiée, permet de nommer PLUSIEURS colonnes: CLÉ COMPOSITE
  primary key (code, teacher_employee_number, semester)
);



create or replace table courses (
  code char(10) not null,
  name varchar(200) not null,
  semester char(5) not null,
  teacher_employee_number int unsigned, -- NOT NULL ???

  -- le type des colonnes doit correspondre
  foreign key (teacher_employee_number) references teachers (employee_number)
);

create or replace table grades (
  student_da varchar(7),
  grade smallint unsigned not null,
  course_code char(10) not null,
  course_teacher int unsigned not null,
  course_semester char(5) not null,

  primary key (student_da, course_code, course_teacher, course_semester),

  foreign key (course_code, course_teacher, course_semester)
    references courses(code, teacher_employee_number, semester)
  -- , foreign key (student_da) references students(da) -- on peut définir PLUSIEURS FK
);

FOREIGN KEY (col[, ...])
  REFERENCES table_name (col[, ...])
  [ON DELETE { RESTRICT | CASCADE | SET NULL }]
  [ON UPDATE { RESTRICT | CASCADE | SET NULL }]