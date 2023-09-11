
CREATE OR ALTER PROCEDURE sp_AddNewBorrower
    @FirstName NVARCHAR(50),
    @LastName NVARCHAR(50),
    @Email NVARCHAR(255),
    @DateOfBirth DATE,
    @MembershipDate DATE
AS
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Borrowers WHERE Email = @Email)
    BEGIN
        INSERT INTO Borrowers (FirstName, LastName, Email, DateOfBirth, MembershipDate)
        VALUES (@FirstName, @LastName, @Email, @DateOfBirth, @MembershipDate);
        END
    ELSE
    BEGIN
        THROW 50001, 'Borrower with the same Email already exists.', 1;
    END
END;
EXEC sp_AddNewBorrower
    @FirstName = 'John',
    @LastName = 'Doe',
    @Email = 'johndeoeeeeeeee@example.com',
    @DateOfBirth = '1990-05-15',
    @MembershipDate = '2023-09-10';
	SELECT * FROM Borrowers WHERE Email='johndeoeeeeeeee@example.com';