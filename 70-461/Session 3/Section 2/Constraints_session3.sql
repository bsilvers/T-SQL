use [Udemy70-461]
/*
Udemy Course
https://americanairlines.udemy.com/course/70-461-session-3-querying-microsoft-sql-server-2012/

70-461 Session 3: Querying Microsoft SQL Server (T-SQL)
Section  2: Objective 4 - Create and Modify constraints

https://docs.microsoft.com/en-us/sql/sql-server/?view=sql-server-ver15
*/
go

select * from tblEmployee

select EmployeeNumber , count(*)
from tblEmployee
group by EmployeeNumber
having count(*) > 1

select EmployeeGovernmentID , count(*)
from tblEmployee
group by EmployeeGovernmentID
having count(*) > 1


select * from tblEmployee where EmployeeNumber = 131

begin tran

	insert into tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
	VALUES('123', 'FirstName', 'MiddleName', 'LastName', '123435', '1985-01-01','Customer Relations')

	select * from tblEmployee where EmployeeNumber = 123

rollback tran

select * from tblTransaction


select *
FROM tbltransaction t
inner join tblEmployee e on t.EmployeeNumber = e.EmployeeNumber
order by e.EmployeeNumber



select *
from tblEmployee e
left outer join tblTransaction t on e.EmployeeNumber = t.EmployeeNumber
inner join tblDepartment d on e.Department = d.Department


select *
from tblDepartment


/* Constraints 
 Unique Constraints
https://docs.microsoft.com/en-us/sql/relational-databases/tables/unique-constraints-and-check-constraints?view=sql-server-ver15
*/


alter table tblEmployee 
ADD Constraint unqGovernmentID UNIQUE(EmployeeGovernmentID)
go

select EmployeeGovernmentID , count(EmployeeGovernmentID) as MyCount from tblEmployee
group by EmployeeGovernmentID
having count(EmployeeGovernmentID) > 1


select * from tblEmployee where EmployeeGovernmentID in ('TX593671R ')

	insert into tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
	VALUES('123', 'FirstName', 'MiddleName', 'LastName', 'TX593671R ', '1985-01-01','Customer Relations')


begin tran
delete from tblEmployee
where EmployeeNumber = 131

delete top(1) from tblEmployee
where EmployeeNumber = 131


rollback tran

commit tran

select * from tbltransaction


alter table tblTransaction 
add constraint unqTransaction UNIQUE(Amount, DateOfTransaction, EmployeeNumber)


delete from tblTransaction where employeenumber = 131

insert into tblTransaction
values(1,'2021-10-23',131)
--,(1,'2021-10-23',131)

insert into tblTransaction
values(1,'2021-10-23',131)


alter table tblTransaction 
drop constraint unqTransaction


create table tblTransaction2
(amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
CONSTRAINT unqTransaction2 UNIQUE(Amount, DateOfTransaction,EmployeeNumber))

drop table tblTransaction2

go



/* Default Contraints */

alter table tblTransaction
add DateOfEntry datetime 

alter table tblTransaction
add constraint defDateOfEntry default getdate() for DateOfEntry;

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values(1,'2021-10-23',1)


insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values(1,'2021-10-24',1, '2013-01-01')

select* from tblTransaction

/*
-- this fails because of constraint name

create table tblTransaction2
(amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
DateOfEntry datetime null CONSTRAINT defDateOfEntry DEFAULT(GETDATE())
)
*/

create table tblTransaction2
(amount smallmoney not null,
DateOfTransaction smalldatetime not null,
EmployeeNumber int not null,
DateOfEntry datetime null CONSTRAINT tblTransaction2_defDateOfEntry DEFAULT(GETDATE())
)

insert into tblTransaction2(amount, DateOfTransaction, EmployeeNumber)
values(1,'2014-01-01',1)

insert into tblTransaction2(Amount, DateOfTransaction, EmployeeNumber, DateOfEntry)
values(1,'2021-10-24',1, '2013-01-01')

drop table tblTransaction2

alter table tblTransaction 
drop column DateOfEntry


alter table tblTransaction
drop constraint defDateOfEntry


/* 
Check Constraint 
https://docs.microsoft.com/en-us/sql/relational-databases/tables/create-check-constraints?view=sql-server-ver15
*/
alter table tblTransaction
add constraint chkAmount check (Amount>-1000 and Amount < 1000)

insert into tblTransaction(Amount, DateOfTransaction, EmployeeNumber)
values(-110,'2014-01-01',1)

alter table tblEmployee
add constraint chkMiddleName check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName OR EmployeeMiddleName is null)

alter table tblEmployee with nocheck
add constraint chkMiddleName check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName OR EmployeeMiddleName is null)


-- R = R
-- V. replace .  with V
-- Homework use DateAdd to only allow 18 years or older
alter table tblEmployee with nocheck
add constraint chkDateOfBirth check (DateOfBirth between '1900-01-01' and getdate())


alter table tblEmployee
drop constraint chkMiddleName

begin tran
	insert into tblEmployee
	values(2003,'A','B.','C','D','2014-01-01','Accounts')
	select * from tblEmployee where EmployeeNumber = 2003
rollback tran

create table tblEmployee2
(EmployeeMiddleName varchar(50) null check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName or EmployeeMiddleName is null))

create table tblEmployee2
(EmployeeMiddleName varchar(50) null constraint CK_EmployeeMiddleName check
(REPLACE(EmployeeMiddleName,'.','') = EmployeeMiddleName or EmployeeMiddleName is null))


drop table tblEmployee2

alter table tblEmployee
drop chkDateOfBirth
alter table tblEmployee
drop chkMiddleName
alter table tblTransaction
drop chkAmount


/* Primary Key 
https://docs.microsoft.com/en-us/sql/relational-databases/tables/primary-and-foreign-key-constraints?view=sql-server-ver15
Clustering means sorting

null-able
not nullable
clustered
one per table
surrogate key
natural key
*/
select * from tblEmployee

alter table tblEmployee
add constraint PK_tblEmployee PRIMARY KEY (EmployeeNumber)

insert into tblEmployee(EmployeeNumber, EmployeeFirstName, EmployeeMiddleName, EmployeeLastName, EmployeeGovernmentID, DateOfBirth, Department)
values(2004,'FirstName', 'MiddleName', 'LastName','AB12345FI','2014-01-01','Accounts')

delete from tblEmployee where EmployeeNumber = 2004

alter table tblEmployee
drop constraint PK_tblEmployee

create table tblEmployee2
(EmployeeNumber int constraint PK_tblEmployee2 PRIMARY KEY IDENTITY(1,1),
EmployeeName nvarchar(20))

insert into tblEmployee2
values('My Name'),
('My Name')

select * from tblEmployee2

delete from tblEmployee2

truncate table tblEmployee2

insert into tblEmployee2(EmployeeNumber, EmployeeName)
values(3, 'My Name'),
(4, 'My Name')

insert into tblEmployee2(EmployeeNumber, EmployeeName)
values(40, 'My Name'),
(41, 'My Name')


set IDENTITY_INSERT tbleEmployee2 ON 

drop table tblEmployee2


select @@IDENTITY
select SCOPE_IDENTITY()

-- last used identity for a given table
select IDENT_CURRENT('dbo.tblEmployee2')
select IDENT_CURRENT('dbo.tblEmployee')


create table tblEmployee3
(EmployeeNumber int constraint PK_tblEmployee3 PRIMARY KEY IDENTITY(1,1),
EmployeeName nvarchar(20))

insert into tblEmployee3
values('My Name'),
('My Name')


drop table tblEmployee3

/* Foreign Key 
https://docs.microsoft.com/en-us/sql/relational-databases/tables/primary-and-foreign-key-constraints?view=sql-server-ver15#FKeys

Foreign key is opposite or counterpart of a primary key
Foreign key references that specific row in another table

SEEK - goes thru the order of the primary key index
SCANNING - without an idex 

CASCADE foreign key
*/

BEGIN TRAN

ALTER TABLE tblTransaction ALTER COLUMN EmployeeNumber INT NULL
ALTER TABLE tblTransaction ADD CONSTRAINT DF_tblTransaction DEFAULT 124 FOR EmployeeNumber
-- this doesn't work
--ALTER TABLE tblTransaction
--ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber)
--REFERENCES tblEmployee(EmployeeNumber)

-- have to add with nocheck
ALTER TABLE tblTransaction with nocheck
ADD CONSTRAINT FK_tblTransaction_EmployeeNumber FOREIGN KEY (EmployeeNumber)
REFERENCES tblEmployee(EmployeeNumber) 
ON UPDATE CASCADE
--ON UPDATE SET NULL
--ON UPDATE SET DEFAULT
--ON DELETE NO ACTION
ON DELETE CASCADE
--On DELETE SET NULL
--ON DELETE SET DEFAULT



UPDATE tblEmployee SET EmployeeNumber = 9123 WHERE EmployeeNumber = 123
--DELETE tblEmployee WHERE EmployeeNumber = 123

select E.EmployeeNumber, T.*
from tblEmployee as E
RIGHT JOIN tblTransaction  as T ON E.EmployeeNumber = T.EmployeeNumber
where T.Amount IN (-179.47, 786.22, -967.36, 957.03)


ROLLBACK TRAN











/*   */
/**/
/**/