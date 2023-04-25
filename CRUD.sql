-- all.sql
-- ----------------------------------------------------------------------------
-- Проект......: Курс Бази даних
-- Призначення.: Збережені процедури для виконання CRUD операцій
-- Виконав. ...: Попов Микола
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
-- Процедура для зміни назви спеціальності
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
-- EOF all.sq