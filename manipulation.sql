-- Insert yourself as a new row in the Student table
-- Note that no values are provided for StdMajor, StdClass, or StdGPA.
insert into Student(StdSSN, StdFirstName, StdLastName, StdCity, StdState, StdZip)
    values('432109876','Peter','Brown','Spartanburg','SC','29302');

-- enroll all the students whose last names begin with "B" or "D" into offering 8888
insert into Enrollment(StdSSN, OfferNo) -- leaving EnrGrade null
select StdSSN, '8888' as OfferNo
from Student
where StdLastName like 'B%' or StdLastName like 'D%';

-- Give a 10% raise to faculty making less than $66,000
update Faculty set FacSalary = FacSalary * 1.1
where FacSalary < 66000; -- Based on the existing value, not the updated one

-- Give a 5% raise to the rest.  Oh, except Nicki Macon, who already got a raise.
update Faculty set FacSalary = FacSalary * 1.05
where FacSalary > 66000 and FacSalary <> 71500; 

-- The preceding two queries would have been easier if done in the other order,
-- so that Nicki Macon wouldn't have crossed the line.

-- Give a 5% raise to faculty making more than $66,000.
update Faculty set FacSalary = FacSalary * 1.05
where FacSalary > 66000;

-- *Now* we give a 10% raise to the rest.
update Faculty set FacSalary = FacSalary * 1.1
where FacSalary <= 66000;

-- Delete IS320 from the Course table, without violating referential integrity.
-- First, we need to delete the offerings that reference IS320.
delete from Offering where CourseNo = 'IS320';
-- The above statement (surprisingly) works, because the Enrollment table, which 
--   had enrollments in those offerings, has its foreign key constraint set as 
--   "on delete cascade".  So when the offerings were deleted, the enrollments
--   were *automatically* also deleted.  (This is a reason to be careful with 
--   "on delete cascade", by the way.  It's great *if* you're sure you always
--   want to delete the related rows.  If you ever find you *didn't* want to delete
--   some of the related rows, however, you'd better hope you have good backups,
--   because it's too late to stop the deletion.)
delete from Course where CourseNo = 'IS320';