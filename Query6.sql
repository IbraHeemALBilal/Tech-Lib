USE [Tech-Lib];
CREATE OR ALTER FUNCTION dbo.fn_CalculateOverdueFees
(@LoanID INT)
RETURNS INT
AS
BEGIN
    DECLARE @OverdueFee INT;
    DECLARE @OverdueDays INT;

    SELECT @OverdueDays = DATEDIFF(DAY, DueDate, GETDATE())
    FROM Loans
    WHERE LoanID = @LoanID;

    IF @OverdueDays <= 0
    BEGIN
        SET @OverdueFee = 0;
    END
    ELSE
    BEGIN
        IF @OverdueDays <= 30
        BEGIN
            SET @OverdueFee = @OverdueDays * 1; 
        END
        ELSE
        BEGIN
            SET @OverdueFee = (30 * 1) + ((@OverdueDays - 30) * 2); 
        END
    END

    RETURN @OverdueFee;
END;


DECLARE @Fee INT;
SET @Fee = dbo.fn_CalculateOverdueFees(150);
PRINT 'Overdue Fee: $' + CAST(@Fee AS VARCHAR);
