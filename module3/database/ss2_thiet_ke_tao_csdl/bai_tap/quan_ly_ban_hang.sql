create database if not exists quan_ly_ban_hang;
use quan_ly_ban_hang;
create table customer(
	cID int auto_increment primary key,
	cName varchar(100) not null,
    cAge int
);
create table `order`(
	oID int primary key,
    cID int,
    oDate date,
    oTotalPrice int,
    foreign key (cID) references customer(cID)
);
create table product(
	pID int primary key,
    pName varchar(100) not null,
    pPrice int
);
create table order_detail(
	oID int,
    pID int,
    odQTY int,
    primary key (oID, pID),
    foreign key (oID) references `order`(oID),
    foreign key (pID) references product(pID)
);
