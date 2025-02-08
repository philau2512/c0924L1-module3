create database if not exists student_management;
use student_management;
create table class(
	id int primary key,
    `name` varchar(100) not null
);
create table teacher(
	id int primary key,
    `name` varchar(100) not null,
    age int,
    country varchar(100)
);