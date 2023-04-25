-- all.sql
-- ----------------------------------------------------------------------------
-- Проект......: Курс Бази даних
-- Призначення.: Збережені процедури для виконання CRUD операцій
-- Виконав. ...: 
-- Історія змін: 24 квітня 2023 -- дата створення

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нової організації
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateOrganization
     @name NVARCHAR(50)
AS
BEGIN
 -- перевірити значення вхідних параметрів на допустимість
    IF ( @name IS NULL OR @name = '' )
    BEGIN
        THROW 50000, 'Organization name is required', 1;
    END;
 -- Виконати операцію додавання даних
    INSERT INTO Organizations (organization_name)
    VALUES ( @name );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateOrganization 'FRI';

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних організації
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetOrganization
    @name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Organizations
    WHERE organization_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetOrganization 'FRI'

-- ----------------------------------------------------------------------------
-- Процедура для зміни назви організації
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetOrganizationName
    @name NVARCHAR(50),
    @new_name NVARCHAR(50)
AS
BEGIN
    -- перевірити значення вхідних параметрів на допустимість
    IF ( @new_name IS NULL OR @new_name = '' )
    BEGIN
        THROW 50000, 'Organization name is required', 1;
    END;
    -- Виконати зміну назви організації
    UPDATE Organizations
    SET organization_name = @new_name
    WHERE organization_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetOrganizationName 'FRI', 'Cooper&Co'

-- ----------------------------------------------------------------------------
-- Процедура для видалення організації
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteOrganization
    @name NVARCHAR(50)  
AS
BEGIN
    DELETE FROM Organizations WHERE organization_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteOrganization 'Cooper&Co'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нової спеціальності
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateSpecialty
     @specialty_name NVARCHAR(50),
     @duration_in_months INT,
     @number_of_sessions INT,
     @cost DECIMAL(10,2),
     @has_accommodation NCHAR(1)
AS
BEGIN
 -- перевірити значення вхідних параметрів на допустимість
    IF ( @specialty_name IS NULL OR @specialty_name = '' )
    BEGIN
        THROW 50000, 'Specialty name is required', 1;
    END;
    IF ( @duration_in_months IS NULL OR @number_of_sessions IS NULL OR @cost IS NULL OR @has_accommodation IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
 -- Виконати операцію додавання даних
    IF ( @has_accommodation = 'Y' OR @has_accommodation = 'N' )
    BEGIN
        INSERT INTO Specialties (specialty_name, duration_in_months, number_of_sessions, cost, has_accommodation)
        VALUES ( @specialty_name, @duration_in_months, @number_of_sessions, @cost, @has_accommodation );
    END;
    ELSE
    BEGIN
        THROW 50000, 'Wrong value for has_accommodation', 1;
    END;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateSpecialty 'Marinada', 3, 2, 3531, 'N';

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних спеціальності
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetSpecialty
    @name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Specialties
    WHERE specialty_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetSpecialty 'Marinada'

-- ----------------------------------------------------------------------------
-- Процедура для зміни вартості спеціальності
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetSpecialtyCost
    @name NVARCHAR(50),
    @new_cost DECIMAL(10,2)
AS
BEGIN
    -- перевірити значення вхідних параметрів на допустимість
    IF ( @name IS NULL OR @name = '' AND @new_cost IS NULL OR @new_cost = 0 )
    BEGIN
        THROW 50000, 'Specialty name is required and cost need to be bigger than 0', 1;
    END;
    -- Виконати зміну назви організації
    UPDATE Specialties
    SET cost = @new_cost
    WHERE specialty_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetSpecialtyCost 'Marinada', 7370

-- ----------------------------------------------------------------------------
-- Процедура для видалення спеціальності
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteSpecialty
    @name NVARCHAR(50)  
AS
BEGIN
    DELETE FROM Specialties WHERE specialty_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteSpecialty 'Marinada'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нової групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateGroup
     @specialty_id INT,
     @group_name NVARCHAR(50),
     @number_of_students INT,
     @date_of_start DATE,
     @date_of_end DATE
AS
BEGIN
 -- перевірити значення вхідних параметрів на допустимість
    IF ( @specialty_id IS NULL OR @group_name IS NULL OR @group_name = '' OR @number_of_students IS NULL or @number_of_students = 0 OR @date_of_start IS NULL OR @date_of_end IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO Groups (specialty_id, group_name, number_of_students, date_of_start, date_of_end)
    VALUES ( @specialty_id, @group_name, @number_of_students, @date_of_start, @date_of_end );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateGroup 1, 'FRI-1', 20, '2019-09-01', '2020-06-01';

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetGroup
    @name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Groups
    WHERE group_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetGroup 'FRI-1'

-- ----------------------------------------------------------------------------
-- Процедура для зміни назви групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetGroupName
    @name NVARCHAR(50),
    @new_name NVARCHAR(50)
AS
BEGIN
    -- перевірити значення вхідних параметрів на допустимість
    IF ( @new_name IS NULL OR @new_name = '' )
    BEGIN
        THROW 50000, 'Group name is required', 1;
    END;
    -- Виконати зміну назви організації
    UPDATE Groups
    SET group_name = @new_name
    WHERE group_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetGroupName 'FRI-1', 'FRI-23'

-- ----------------------------------------------------------------------------
-- Процедура для видалення групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteGroup
    @name NVARCHAR(50)  
AS
BEGIN
    DELETE FROM Groups WHERE group_name = @name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteGroup 'FRI-23'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateStudent
    @group_id INT,
    @organization_id INT,
    @first_name NVARCHAR(50), 
    @last_name NVARCHAR(50)
AS
BEGIN
    IF ( @group_id IS NULL OR @organization_id IS NULL OR @first_name IS NULL OR @first_name = '' OR @last_name IS NULL OR @last_name = '' )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO Students ( group_id, organization_id, first_name, last_name )
    VALUES ( @group_id, @organization_id, @first_name, @last_name );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateStudent 15, 6, 'Rita', 'Mojkur';

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetStudent
    @last_name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Students
    WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetStudent 'Mojkur'

-- ----------------------------------------------------------------------------
-- Процедура для зміни імені студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetStudentName
    @last_name NVARCHAR(50),
    @new_first_name NVARCHAR(50), 
    @new_last_name NVARCHAR(50)
AS
BEGIN
    IF (  @new_first_name IS NULL OR @new_first_name = '' OR @new_last_name IS NULL OR @new_last_name = '' )
    BEGIN
        THROW 50000, 'Student name is required', 1;
    END;
    UPDATE Students
    SET first_name = @new_first_name, last_name = @new_last_name
    WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetStudentName 'Mojkur', 'Margarita', 'Mojkur'

-- ----------------------------------------------------------------------------
-- Процедура для видалення студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteStudent
    @last_name NVARCHAR(50)  
AS
BEGIN
    DELETE FROM Students WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteStudent 'Mojkur'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового предмету
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateSubject
    @subject_name NVARCHAR(50),
    @hours_lecture INT,
    @hours_lab INT
AS
BEGIN
    IF ( @subject_name IS NULL OR @subject_name = '' OR @hours_lecture IS NULL OR @hours_lab IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO Subjects ( subject_name, hours_lecture, hours_lab )
    VALUES ( @subject_name, @hours_lecture, @hours_lab );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateSubject 'Math', 30, 30;

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних предмету
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetSubject
    @subject_name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Subjects
    WHERE subject_name = @subject_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetSubject 'Math'

-- ----------------------------------------------------------------------------
-- Процедура для зміни кількості годин лекцій та лабораторних занять
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetSubjectHours
    @subject_name NVARCHAR(50),
    @new_hours_lecture INT,
    @new_hours_lab INT
AS
BEGIN
    IF ( @new_hours_lecture IS NULL OR @new_hours_lab IS NULL )
    BEGIN
        THROW 50000, 'Student name is required', 1;
    END;
    UPDATE Subjects
    SET hours_lecture = @new_hours_lecture, hours_lab = @new_hours_lab
    WHERE subject_name = @subject_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetSubjectHours 'Math', 40, 40

-- ----------------------------------------------------------------------------
-- Процедура для видалення предмету
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteSubject
    @subject_name NVARCHAR(50)
AS
BEGIN
    DELETE FROM Subjects WHERE subject_name = @subject_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteSubject 'Math'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateTeacher
    @first_name NVARCHAR(50), 
    @last_name NVARCHAR(50), 
    @degree NCHAR(1)
AS
BEGIN
    IF ( @first_name IS NULL OR @first_name = '' OR @last_name IS NULL OR @last_name = '' OR @degree IS NULL OR @degree = '' )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    IF ( @degree = 'Y' OR @degree = 'N' )
    BEGIN
        INSERT INTO Teachers ( first_name, last_name, degree )
        VALUES ( @first_name, @last_name, @degree );
    END;
    ELSE
    BEGIN
        THROW 50000, 'Wrong value for degree', 1;
    END;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateTeacher 'Iran', 'Vicatds', 'Y';

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetTeacher
    @last_name NVARCHAR(50)
AS
BEGIN
    SELECT *
    FROM Teachers
    WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetTeacher 'Vicatds'

-- ----------------------------------------------------------------------------
-- Процедура для зміни імені викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetTeacherName
    @last_name NVARCHAR(50), 
    @new_first_name NVARCHAR(50),
    @new_last_name NVARCHAR(50)
AS
BEGIN
    IF (  @new_first_name IS NULL OR @new_first_name = '' OR @new_last_name IS NULL OR @new_last_name = '' )
    BEGIN
        THROW 50000, 'Teacher name is required', 1;
    END;
    UPDATE Teachers
    SET first_name = @new_first_name, last_name = @new_last_name
    WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetTeacherName 'Vicatds', 'Marta', 'Stepanidivna'

-- ----------------------------------------------------------------------------
-- Процедура для видалення викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteTeacher
    @last_name NVARCHAR(50)
AS
BEGIN
    DELETE FROM Teachers WHERE last_name = @last_name;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteTeacher 'Stepanidivna'

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового предмету викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateTeacherSubject
    @teacher_id INT,
    @subject_id INT,
    @hours_lecture INT,
    @hours_lab INT
AS
BEGIN
    IF ( @teacher_id IS NULL OR @subject_id IS NULL OR @hours_lecture IS NULL OR @hours_lab IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO TeacherSubjects ( teacher_id, subject_id, hours_lecture, hours_lab )
    VALUES ( @teacher_id, @subject_id, @hours_lecture, @hours_lab );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateTeacherSubject 2, 4, 30, 30;

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних всіх предметів викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetTeacherSubjects
    @teacher_id INT
AS
BEGIN
    SELECT *
    FROM TeacherSubjects
    WHERE teacher_id = @teacher_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetTeacherSubjects 2

-- ----------------------------------------------------------------------------
-- Процедура для зміни викладача предмету
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetTeacherName
    @teacher_id INT,
    @new_teacher_id INT,
    @subject_id INT
AS
BEGIN
    IF ( @teacher_id IS NULL OR @new_teacher_id IS NULL OR @subject_id IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    UPDATE TeacherSubjects
    SET teacher_id = @new_teacher_id
    WHERE teacher_id = @teacher_id AND subject_id = @subject_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetTeacherName 2, 1, 4

-- ----------------------------------------------------------------------------
-- Процедура для видалення предмету викладача
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteTeacherSubject
    @teacher_id INT,
    @subject_id INT
AS
BEGIN
    DELETE FROM TeacherSubjects WHERE teacher_id = @teacher_id AND subject_id = @subject_id;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteTeacherSubject 1, 4

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового предмету групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateGroupSubject
    @group_id INT,
    @subject_id INT
AS
BEGIN
    IF ( @group_id IS NULL OR @subject_id IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO GroupSubjects ( group_id, subject_id )
    VALUES ( @group_id, @subject_id );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateGroupSubject 1, 6;

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних всіх предметів групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetGroupSubjects
    @group_id INT
AS
BEGIN
    SELECT *
    FROM GroupSubjects
    WHERE group_id = @group_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC  GetGroupSubjects 1

-- ----------------------------------------------------------------------------
-- Процедура для зміни предмету для групи 
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetGroupSubject
    @group_id INT,
    @subject_id INT,
    @new_subject_id INT
AS
BEGIN
    IF ( @group_id IS NULL OR @subject_id IS NULL OR @new_subject_id IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    UPDATE GroupSubjects
    SET subject_id = @new_subject_id
    WHERE group_id = @group_id AND subject_id = @subject_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetGroupSubject 1, 6, 7

-- ----------------------------------------------------------------------------
-- Процедура для видалення предмету у групи
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteTeacherSubject
    @group_id INT,
    @subject_id INT
AS
BEGIN
    DELETE FROM GroupSubjects WHERE group_id = @group_id AND subject_id = @subject_id;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteTeacherSubject 1, 7

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового екзамена
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateExam
    @student_id INT, 
    @subject_id INT, 
    @exam_date DATE, 
    @exam_result DECIMAL(5,2)
AS
BEGIN
    IF ( @student_id IS NULL OR @subject_id IS NULL OR @exam_date IS NULL OR @exam_result IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO Exams ( student_id, subject_id, exam_date, exam_result )
    VALUES ( @student_id, @subject_id, @exam_date, @exam_result );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateExam 1, 1, '2019-01-01', 5.00

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних всіх екзаменів студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetGroupSubjects
    @student_id INT
AS
BEGIN
    SELECT *
    FROM Exams
    WHERE student_id = @student_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetGroupSubjects 1

-- ----------------------------------------------------------------------------
-- Процедура для зміни результату екзамену
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetExamResult
    @student_id INT, 
    @subject_id INT, 
    @exam_result DECIMAL(5,2)
AS
BEGIN
    IF ( @student_id IS NULL OR @subject_id IS NULL OR @exam_result IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    UPDATE Exams
    SET exam_result = @exam_result
    WHERE student_id = @student_id AND subject_id = @subject_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetExamResult 1, 1, 4.00

-- ----------------------------------------------------------------------------
-- Процедура для видалення екзамену
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteExam
    @exam_id INT
AS
BEGIN
    DELETE FROM Exams WHERE exam_id = @exam_id;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteExam 1

-- ----------------------------------------------------------------------------
-- Процедура для створення рядка даних нового cертифікату
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE CreateCertificate
    @student_id INT,
    @specialty_id INT, 
    @date_issued DATE
AS
BEGIN
    IF ( @student_id IS NULL OR @specialty_id IS NULL OR @date_issued IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    INSERT INTO Certificates ( student_id, specialty_id, date_issued )
    VALUES ( @student_id, @specialty_id, @date_issued );
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC CreateCertificate 1, 1, '2019-01-01'

-- ---------------------------------------------------------------------------
-- Процедура для отримання даних всіх cертифікатів студента
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE GetStudentCertificates
    @student_id INT
AS
BEGIN
    SELECT *
    FROM Certificates
    WHERE student_id = @student_id;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC GetStudentCertificates 1

-- ----------------------------------------------------------------------------
-- Процедура для зміни дати видачі сертифікату
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE SetCertificateDate
    @student_id INT,
    @specialty_id INT, 
    @new_date_issued DATE
AS
BEGIN
    IF ( @student_id IS NULL OR @specialty_id IS NULL OR @new_date_issued IS NULL )
    BEGIN
        THROW 50000, 'Some data is missing', 1;
    END;
    UPDATE Certificates
    SET date_issued = @new_date_issued
    WHERE student_id = @student_id AND specialty_id = @specialty_id;
END;
GO
-- Для перевірки можна зробити наступний виклик:
--EXECUTE SetCertificateDate 1, 1, '2019-01-04'

-- ----------------------------------------------------------------------------
-- Процедура для видалення сертифікату
-- ----------------------------------------------------------------------------
CREATE OR ALTER PROCEDURE DeleteExam
    @student_id INT,
    @specialty_id INT
AS
BEGIN
    DELETE FROM Certificates WHERE student_id = @student_id AND specialty_id = @specialty_id;
GO
-- Для перевірки можна зробити наступний виклик:
--EXEC DeleteExam 1, 1






























-- ----------------------------------------------------------------------------
-- EOF all.sq