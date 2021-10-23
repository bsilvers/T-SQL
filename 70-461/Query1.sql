use [Udemy70-461]

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

alter table tblTransaction 
add constraint unqTransaction UNIQUE(Amount, DateOfTransaction, EmployeeNumber)







