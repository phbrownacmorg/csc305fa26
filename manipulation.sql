-- Insert yourself as a new row in the Student table
-- Note that no values are provided for StdMajor, StdClass, or StdGPA.
insert into Student(StdSSN, StdFirstName, StdLastName, StdCity, StdState, StdZip)
    values('432109876','Peter','Brown','Spartanburg','SC','29302');

-- enroll all the students whose last names begin with "B" or "D" into offering 8888
insert into Enrollment(StdSSN, OfferNo) -- leaving EnrGrade null
select StdSSN, '8888' as OfferNo
from Student
where StdLastName like 'B%' or StdLastName like 'D%';