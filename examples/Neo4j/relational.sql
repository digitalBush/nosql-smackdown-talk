create table Person(
	Id varchar(50) primary key,
	Name varchar(max)
);

create table Friend(
	PersonId varchar(50) foreign key references Person(Id),
	FriendWithPersonId varchar(50) foreign key references Person(Id)
);

create table Technology(
	Id int primary key,
	Name varchar(max)
);

create table PersonTechnology(
	PersonId varchar(50) foreign key references Person(Id),
	TechnologyId int foreign key references Technology(Id),
);

--People
insert into Person values ('digitalbush','Josh Bush');
insert into Person values ('ifandelse','Jim Cowart');
insert into Person values ('A_Robson','Alex Robson');
insert into Person values ('bryan_hunter','Bryan Hunter');
insert into Person values ('elijahmanor','Elijah Manor');
insert into Person values ('danmohl','Dan Mohl');
insert into Person values ('derekgreer','Derek Greer');
insert into Person values ('reverentgeek','David Neal');
insert into Person values ('calvinb','Calvin Bottoms');
insert into Person values ('jcreamer898','Jonathan Creamer');

--My Friends
insert into Friend values ('digitalbush','elijahmanor');
insert into Friend values ('digitalbush','A_Robson');
insert into Friend values ('digitalbush','bryan_hunter');

--Friends of Friends
insert into Friend values ('A_Robson','danmohl'); --F
insert into Friend values ('A_Robson','calvinb'); --Ruby

insert into Friend values ('elijahmanor','ifandelse'); --Erlang
insert into Friend values ('elijahmanor','jcreamer898'); --Javascript

insert into Friend values ('bryan_hunter','reverentgeek'); --NoSQL
insert into Friend values ('bryan_hunter','derekgreer'); --C

--Technologies
insert into Technology values(1,'NoSQL');
insert into Technology values(2,'Erlang');
insert into Technology values(3,'C');
insert into Technology values(4,'Ruby');
insert into Technology values(5,'F');
insert into Technology values(6,'Javascript');

--My technologies
insert into PersonTechnology values('digitalbush',1);
insert into PersonTechnology values('digitalbush',2);
insert into PersonTechnology values('digitalbush',5);

--Ignore my friends technology to keep example simple

--Friend of Friends Technologies
insert into PersonTechnology values('danmohl',5);
insert into PersonTechnology values('calvinb',4);
insert into PersonTechnology values('ifandelse',2);
insert into PersonTechnology values('jcreamer898',6);
insert into PersonTechnology values('reverentgeek',1);
insert into PersonTechnology values('derekgreer',3);



select Person.Id,Person.Name,Technology.Name
from Person 
join PersonTechnology ON (Person.Id = PersonTechnology.PersonId)
join Technology ON (PersonTechnology.TechnologyId=Technology.Id)
join Friend fof on(fof.FriendWithPersonId=Person.Id)
join Friend friend on(fof.PersonId = friend.FriendWithPersonId)
where friend.PersonId = 'digitalbush'
AND PersonTechnology.TechnologyId in (
	select TechnologyId
	from PersonTechnology myTech
	where myTech.PersonId='digitalbush'
)

