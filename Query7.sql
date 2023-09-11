USE [Tech-Lib];
CREATE OR ALTER FUNCTION fn_BookBorrowingFrequency
(@BookID INT)
RETURNS INT
BEGIN
       DECLARE @BorrowingFrequency INT;
	   SET @BorrowingFrequency = (SELECT COUNT(LoanID) FROM Loans 
	                         WHERE BookID=@BookID)
       RETURN @BorrowingFrequency
END;

DECLARE @BookID INT;
SET @BookID = 9; 
DECLARE @BorrowingFrequency INT;
SET @BorrowingFrequency = dbo.fn_BookBorrowingFrequency(@BookID);
PRINT 'Borrowing Frequency for BookID ' + CAST(@BookID AS VARCHAR) +  ' : ' + CAST(@BorrowingFrequency AS VARCHAR);

