use [Udemy70-461]
/*
70-461 Session 3: Querying Microsoft SQL Server (T-SQL)
Section  2: Objective 4 - Create and Modify constraints
*/
go

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


/* Constraints */

-- Unique Constraints


alter table tblEmployee 
ADD Constraint unqGovernmentID UNIQUE(EmployeeGovernmentID)
go

select EmployeeGovernmentID , count(EmployeeGovernmentID) as MyCount from tblEmployee
group by EmployeeGovernmentID
having count(EmployeeGovernmentID) > 1


select * from tblEmployee where EmployeeGovernmentID in ('TX593671R ')

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



