-- List the SSN, first and last name, and salary of both faculty member
-- and supervisor for all faculty who are paid more than their supervisors
select sub.FacSSN as subSSN, sub.FacFirstName as subFirst, sub.FacLastName as subLast, 
    sub.FacSalary as subSalary,
    sup.FacSSN as supSSN, sup.FacFirstName as supFirst, sup.FacLastName as supLast, 
    sup.FacSalary as supSalary
from Faculty as sub inner join Faculty as sup on sub.FacSupervisor = sup.FacSSN
where sub.FacSalary > sup.FacSalary;

-- List the SSN and name (first and last) of the first- and second-level subordinates
-- of Victoria Emmanuel.  Include a computed column with the subordinate level (1 or 2).

-- First-level subordinates only
select s1.FacSSN as s1_SSN, s1.FacFirstName as s1_first, s1.facLastName as s1_last
from Faculty as VE inner join Faculty as s1 on s1.FacSupervisor = VE.FacSSN
where VE.FacFirstName = 'VICTORIA' and VE.FacLastName = 'EMMANUEL';

-- Include second-level subordinates
select s1.FacSSN as s1_SSN, s1.FacFirstName as s1_first, s1.FacLastName as s1_last, 
    '1' as s1_level,
    s2.FacSSN as s2_SSN, s2.FacFirstName as s2_first, s2.FacLastName as s2_last,
    '2' as s2_level
from (Faculty as VE inner join Faculty as s1 on s1.FacSupervisor = VE.FacSSN)
    left join Faculty as s2 on s2.FacSupervisor = s1.FacSSN
where VE.FacFirstName = 'VICTORIA' and VE.FacLastName = 'EMMANUEL';

-- Do a single list as a union
select s1.FacSSN as SSN, s1.FacFirstName as FirstName, s1.FacLastName as LastName, 
    '1' as SubLevel
from Faculty as VE inner join Faculty as s1 on s1.FacSupervisor = VE.FacSSN
where VE.FacFirstName = 'VICTORIA' and VE.FacLastName = 'EMMANUEL'
    union
select s2.FacSSN as SSN, s2.FacFirstName as FirstName, s2.FacLastName as LastName,
    '2' as SubLevel
from (Faculty as VE inner join Faculty as s1 on s1.FacSupervisor = VE.FacSSN)
    inner join Faculty as s2 on s2.FacSupervisor = s1.FacSSN
where VE.FacFirstName = 'VICTORIA' and VE.FacLastName = 'EMMANUEL'
order by SubLevel, LastName;

-- list the names (first and last) and course numbers for which a faculty member teaches
-- the same course as his or her supervisor in calendar year 2003.
select F1.FacFirstName as F1_First, F1.FacLastName as F1_Last, O1.CourseNo as O1_Course,
    F2.FacFirstName as F2_First, F2.FacLastName as F2_Last, O2.CourseNo as O2_Course
from (Faculty as F1 natural join Offering as O1)
        inner join
     (Faculty as F2 natural join Offering as O2)
        on O1.CourseNo = O2.CourseNo
where O1.OffYear = 2005 and O2.OffYear = 2005
	and F1.FacSupervisor = F2.FacSSN; -- fourth join condition