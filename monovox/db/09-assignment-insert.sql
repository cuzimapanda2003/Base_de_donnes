use monovox;

set @name = 'test travail';
set @weight = 20;
set @points = 10;
set @date = '2020-11-15';
set @group = 1;
set @semester = 'a2020';
set @code = '420-0q4-sw';
set @teacher_id = 1;

insert into assignments (name, weight, points, date, group_number, group_semester, group_course)
select
    @name,
    @weight,
    @points,
    @date,
    g.number,
    g.semester,
    g.course_code
from groups g
where g.number = @group
  and g.semester = @semester
  and g.course_code = @code
  and g.teacher_employee_number = @teacher_id;
