-- which professors (by first and last name) taught which courses during Winter 2005? (inner join)
select FacFirstName, FacLastName, CourseNo
from Faculty inner join Offering on Faculty.FacSSN = Offering.FacSSN
where OffTerm = 'WINTER' and OffYear = 2005;

-- Same, but including the offerings that term with no faculty assigned (left join)
select CourseNo, FacFirstName, FacLastName
from Offering left join Faculty on Faculty.FacSSN = Offering.FacSSN
where OffTerm = 'WINTER' and OffYear = 2005
order by CourseNo, FacLastName, FacFirstName;

-- Which students have taken which courses from Leonard Fibon, and when? (4-way join)
select StdFirstName, StdLastName, CourseNo, OffTerm, OffYear, FacFirstName, FacLastName
from ((Student natural join Enrollment) -- on StdSSN
        natural join Offering) -- on OfferNo
            natural join Faculty -- on FacSSN
where FacFirstName = "LEONARD" and FacLastName = "FIBON";

-- AGGREGATIONS

-- How many courses has each student taken during the period covered by the database?
select StdFirstName, StdLastName, count(*) as NumCourses
from Student natural join Enrollment
group by StdFirstName, StdLastName;

-- How many *distinct* courses has each student taken?
select StdFirstName, StdLastName, count(distinct Offering.CourseNo) as NumCourses
from Student natural join Enrollment natural join Offering
group by StdFirstName, StdLastName;

-- How many credit hours does each student have?
select StdFirstName, StdLastName, count(distinct Course.CourseNo) * CrsUnits as CreditHours
from Student natural join Enrollment natural join Offering natural join Course
group by StdFirstName, StdLastName
order by CreditHours desc, StdLastName, StdFirstName;

-- What is each student's GPA?
select StdFirstName, StdLastName, StdGPA, 
    round(avg(EnrGrade * CrsUnits)/CrsUnits, 2) as GPA
from Student natural join Enrollment natural join Offering natural join Course
group by StdFirstName, StdLastName, StdGPA
order by GPA desc, StdLastName, StdFirstName;

-- What are Cristopher Colan's grades? 3.25
select StdFirstName, StdLastName, OfferNo, CourseNo, EnrGrade
from Student natural join Enrollment natural join Offering
where StdLastName = 'COLAN';

-- Who are all the students with *actual* GPA's at 3.3 or above?
select StdFirstName, StdLastName, StdGPA, 
    round(avg(EnrGrade * CrsUnits)/CrsUnits, 2) as GPA
from Student natural join Enrollment natural join Offering natural join Course
group by StdFirstName, StdLastName, StdGPA
having GPA >= 3.3
order by GPA desc, StdLastName, StdFirstName;

-- List the SSN, first and last name, and salary of both faculty member
-- and supervisor for all faculty who are paid more than their supervisors
-- [repeat next class]
select Fac.FacSSN, Fac.FacFirstName, Fac.FacLastName, Fac.FacSalary,
    Supv.FacSSN as SupvSSN, Supv.FacFirstName as SupvFirstName, 
    Supv.FacLastName as SupvLastName, Supv.FacSalary as SupvSalary
from Faculty Fac inner join Faculty Supv on Fac.FacSupervisor = Supv.FacSSN
where Fac.FacSalary > Supv.FacSalary;