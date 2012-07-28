Create table Contact(
	Id uniqueidentifier primary key,
	Name varchar(max),
	Birthday date
);

create table Phone(
	Id uniqueidentifier primary key,
	ContactId uniqueidentifier foreign key references Contact(Id),
	Description varchar(max),
	Number varchar(max)
);

create table Email(
	Id uniqueidentifier primary key,
	ContactId uniqueidentifier foreign key references Contact(Id),
	Description varchar(max),
	Address varchar(max)
);

create table InputType(
	Id int primary key,
	Description varchar(max)
);

--We could serialize here, but now we're unable to report against this blob of characters.
--
--create table OtherSerialized(
--	Id uniqueidentifier primary key,
--	ContactId uniqueidentifier foreign key references Contact(Id),
--	InputType int foreign key references InputType(Id), 
--	[Key] varchar(max),
--	Value varchar(max) --non primitive types get serialized?
--);

create table Input(
	Id uniqueidentifier primary key,
	InputType int foreign key references InputType(Id)	
);

create table Other(
	Id uniqueidentifier primary key,
	ContactId uniqueidentifier foreign key references Contact(Id),
	[Key] varchar(max),
	InputId uniqueidentifier foreign key references Input(Id)
);

create table StringInput(
	Id uniqueidentifier primary key foreign key references Input(Id),
	Value varchar(max)
);

create table IntInput(
	Id uniqueidentifier primary key foreign key references Input(Id),
	Value int
);

create table ListInput(
	Id uniqueidentifier primary key foreign key references Input(Id)	
);

create table ListItem(
	Id uniqueidentifier primary key,
	ListInputId uniqueidentifier foreign key references ListInput(Id),
	InputId uniqueidentifier foreign key references Input(Id)	
);


--Setup Input Types
insert into InputType values(1,'String');
insert into InputType values(2,'Int');
insert into InputType values(3,'List');

--Create Contact
DECLARE @contactId uniqueidentifier = newid();
insert into Contact values(@contactId,'Josh Bush','2012-12-31');

--Add Phones and Emails
insert into Phone values(newid(),@contactId,'Work','867-5309');
insert into Phone values(newid(),@contactId,'Home','555-5555');
insert into Email values(newid(),@contactId,'Work','josh.bush@fireflylogic.com');

--Add dynamic integer input
DECLARE @input1 uniqueidentifier = newid();
insert into Input values(@input1,2);
insert into IntInput values(@input1,1);
insert into Other values(newid(),@contactId,'Number Of Kids',@input1);


--Add dynamic list input
DECLARE @input2 uniqueidentifier = newid();
insert into Input values(@input2,3);
insert into ListInput values(@input2);

	-- create sub-input for list item
	DECLARE @input2_1 uniqueidentifier = newid();
	insert into Input values(@input2_1,1);
	insert into StringInput values(@input2_1,'Hudson');

insert into ListItem values(newid(),@input2,@input2_1);
insert into Other values(newid(),@contactId,'Kid Names',@input2);

--Add dynamic string input
DECLARE @input3 uniqueidentifier = newid();
insert into Input values(@input3,2);
insert into StringInput values(@input3,'Mountain Dew');
insert into Other values(newid(),@contactId,'Favorite Drink',@input3);