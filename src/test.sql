create database test;
use test;
create table teacher
(
    id       int primary key auto_increment,
    name     varchar(100) not null unique,
    phone    varchar(50)  not null unique,
    email    varchar(50)  not null unique,
    birthday date         not null
);
create table class_room
(
    id            int primary key auto_increment,
    name          varchar(200) not null,
    total_student int default 0,
    start_date    date,
    end_date      date
);

create table teacher_class
(
    teacher_id      int,
    class_room_id   int,
    start_date      date,
    end_date        date,
    time_slot_start int,
    time_slot_end   int,
    foreign key (teacher_id) references teacher (id),
    foreign key (class_room_id) references class_room (id)
);

create table student
(
    id            int primary key auto_increment,
    name          varchar(150) not null,
    email         varchar(100) not null unique,
    phone         varchar(50)  not null unique,
    gender        tinyint      not null,
    class_room_id int,
    birthday      date         not null,
    foreign key (class_room_id) references class_room (id)
);

create table subject
(
    id   int primary key auto_increment,
    name varchar(200) not null unique
);
create table mark
(
    student_id int not null,
    subject_id int not null,
    score      int check (score >= 0 and score <= 10),
    foreign key (student_id) references student (id),
    foreign key (subject_id) references subject (id)
);

# 1. Bảng teacher ít nhất là 5 bản ghi dữ liệu phù hợp
insert into teacher (name, phone, email, birthday)
values ('Ho Xuan Hung', '0936455455', 'hungx@gmail.com', '1995-01-01'),
       ('Nguyen Minh Hung', '0899666555', 'hungm@gmail.com', '1990-02-01'),
       ('Tran Hong Son', '01221554584', 'son@gmail.com', '1998-01-27'),
       ('Cao Cuong', '0521548484', 'cuong@gmail.com', '1998-05-11'),
       ('Trinh Phuc Phuc', '0784512227', 'phuc@gmail.com', '1987-01-30');
# 2. Bảng class_room ít nhất là 5 bản ghi dữ liệu phù hợp
insert into class_room (name, total_student, start_date, end_date)
values ('Java Fullstack', 15, '2023-06-15', '2023-12-15'),
       ('Java Script', 30, '2023-05-15', '2023-11-15'),
       ('Python', 10, '2023-01-1', '2023-6-25'),
       ('C/C++', 15, '2022-07-15', '2023-1-15'),
       ('SQL', 13, '2023-02-15', '2023-8-15');

# 3. Bảng student Ít nhất 15 bản ghi dữ liệu phù hợp
insert into student (name, email, phone, gender, class_room_id, birthday)
values ('NTM Chu', 'chu@yahoo.com', '0345451538', 1, 1, '2000-01-26'),
       ('Pink Son', 'son@yahoo.com', '0645656565', 2, 1, '2001-01-27'),
       ('High Cuong', 'cuong@yahoo.com', '024584845564', 2, 1, '2001-04-08'),
       ('Spring Hiep', 'hiep@yahoo.com', '0987985656', 2, 1, '1999-10-26'),
       ('Light Phuc', 'phuc@yahoo.com', '05481854564', 2, 1, '1872-05-1'),
       ('Da Hoa', 'hoa@yahoo.com', '0978757752', 2, 2, '1999-10-26'),
       ('Anya Forger ', 'anya@yahoo.com', '0987987756', 2, 2, '2005-4-26'),
       ('Kamado Tanjirō', 'kamado@yahoo.com', '05454882', 2, 2, '1999-7-2'),
       ('Agatsuma Zenitsu', 'Zenitsu@yahoo.com', '054877555', 2, 2, '1999-10-26'),
       ('Hashibira Inosuke', 'heo@yahoo.com', '021595115', 2, 1, '1872-05-1'),
       ('Tsuyuri Kanao', 'buom@yahoo.com', '08784488', 1, 2, '1989-10-26'),
       ('Ubuyashiki Kagaya ', 'qui@yahoo.com', '01268948542', 1, 2, '2005-4-26'),
       ('Kamado Nezuko', 'Nezuko@yahoo.com', '0154848484', 1, 2, '1999-7-2'),
       ('Kanroji Mitsuri', 'Mitsuri@yahoo.com', '01268494848', 1, 2, '1999-10-26');

# 4. Bảng subject ít nhất 3 bản ghi dữ liệu phù hợp
insert into subject (name)
values ('HTML/CSS'),
       ('React'),
       ('Java Core'),
       ('MySQL');

# 5. Bảng mark ít nhất 20 bản ghi dữ liệu phù hợ
insert into mark (student_id, subject_id, score)
VALUES (1, 1, 10),
       (2, 1, 9),
       (3, 1, 7),
       (4, 1, 9),
       (5, 1, 8),
       (6, 2, 9),
       (7, 2, 10),
       (8, 3, 7),
       (9, 3, 8),
       (10, 4, 9),
       (11, 4, 9),
       (12, 1, 10),
       (13, 4, 9),
       (14, 3, 8),
       (14, 2, 8);
## Nhap thong itn bang teacher_class
insert into teacher_class
values (1, 1, '2023-06-15', '2023-12-15', null, null),
       (2, 4, '2023-01-15', '2023-10-15', null, null),
       (3, 3, '2022-06-1', '2023-1-15', null, null),
       (4, 2, '2023-07-15', '2023-2-20', null, null),
       (5, 5, '2023-06-15', '2023-12-25', null, null);

# II. Thực hiện các truy vấn dữ liệu.(60đ)
# 1. Lấy ra danh sách Student có sắp xếp tăng dần theo Name gồm các cột sau: Id, Name, Email, Phone, Address, Gender, BirthDay, Age (5đ)
select Id,
       Name,
       Email,
       Phone,
       Gender,
       BirthDay,
    YEAR
    (now()) - year(birthday) as age
from student
order by name asc;

# 2. Lấy ra danh sách Teacher gồm: Id, Name, Phone, Email, BirthDay, Age, TotalCLass (5đ)
select t.Id,
       t.Name,
       t.Phone,
       t.Email,
       t.BirthDay,
    year(now()) - year(birthday) as Age,
    count(tc.class_room_id)      as TotalCLass
from teacher t
    join teacher_class tc on t.id = tc.teacher_id
group by t.id;

# 3. Truy vấn danh sách class_room gồm: Id, Name, TotalStudent, StartDate, EndDate khai giảng năm 2023 (5đ)
select Id, Name, total_student, start_date, end_date
from class_room
where YEAR(start_date) = 2023;

# 4. Cập nhật cột ToalStudent trong bảng class_room = Tổng số Student của mỗi class_room theo Id của class_room(5đ)
update class_room cr
set cr.total_student = (select count(*) from student s where s.class_room_id = cr.id);
# SET SQL_SAFE_UPDATES=OFF;
# 5. Tạo View v_getStudentInfo thực hiện lấy ra danh sách Student gồm: Id, Name, Email, Phone,  Gender, BirthDay, ClassName, MarksAvg, Trong đó cột MarksAvg hiển thị như sau:
# 0 < MarksAvg <=5 Loại Yếu
# 5 < MarksAvg < 7.5 Loại Trung bình
# 7.5 <= MarksAvg <= 8 Loại GIỏi
# 8 < MarksAvg Loại xuất sắc (5đ)
create view v_getStudentInf as
select s.id,
       s.name,
       s.email,
       s.phone,
       case
           when s.gender = 1 then 'female'
           else 'male'
           end as Gender,
       cr.name,
       s.birthday,
       case
           when avg(m.score) <= 5 then 'Yeu'
           when avg(m.score) < 7.5 then 'Trung Binh'
           when avg(m.score) <= 8 then 'Gioi'
           else 'Xuat Sac'
           end as MarksAvg
from student s
         join class_room cr on s.class_room_id = cr.id
         join mark m on s.id = m.student_id
group by s.id
;

# 6. View v_getStudentMax hiển thị danh sách Sinh viên có điểm trung bình >= 7.5
create view v_getStudentMax as
select s.name
from student s
         join mark m on s.id = m.student_id
group by s.id
having avg(m.score) > 7.5;

# 7. Tạo thủ tục thêm mới dữ liệu vào bảng class_room (5đ)
delimiter //
create procedure update_classroom(newname varchar(200),
                                  newstart date,
                                  newend date)
begin
insert into class_room (name, total_student, start_date, end_date)
values (newname, null, newstart, newend);
end //

# 8. Tạo thủ tục cập nhật dữ liệu trên bảng student (5đ)
delimiter //
create procedure updateStudent(newid int, newname varchar(150), newemail Varchar(100), newphone varchar(50),
                               newgender tinyint, newclassid int, newbirthday date)
begin
update student set name = newname where id = newid;
update student set email = newemail where id = newemail;
update student set phone = newname where id = newphone;
update student set gender = newname where id = newgender;
update student set class_room_id = newname where id = newclassid;
update student set birthday = newname where id = newbirthday;
end //
# 9. Tạo thủ tục xóa dữ liệu theo id trên bảng subject (5đ)
delimiter //
create procedure removeSubject(removeId int)
begin
delete from subject where id = removeId;
end //

# 10.Tạo thủ tục getStudentPaginate lấy ra danh sách sinh viên có phân trang gồm:
# Id, Name, Email, Phone, Address, Gender, BirthDay, ClassName, Khi gọi thủ tuc
# truyền vào limit và page (15đ)

delimiter //
create procedure getStudentPaginate(
    currentPage int,
    limitPaginate int
)
begin

end //