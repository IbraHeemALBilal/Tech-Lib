CREATE OR ALTER PROCEDURE sp_GetBorrowersWithOverdueBooks
AS
BEGIN
    CREATE TABLE #TempBorrowers (
        BorrowerID INT PRIMARY KEY
    );

    INSERT INTO #TempBorrowers (BorrowerID)
    SELECT DISTINCT L.BorrowerID
    FROM Loans AS L
    WHERE L.DueDate < GETDATE() AND L.DateReturned IS NULL;

    SELECT
        B.Title AS BookTitle,
        BR.FirstName AS BorrowerFirstName,
        BR.LastName AS BorrowerLastName,
        L.DueDate
    FROM #TempBorrowers AS TB
    INNER JOIN Loans AS L ON TB.BorrowerID = L.BorrowerID
    INNER JOIN Books AS B ON L.BookID = B.BookID
    INNER JOIN Borrowers AS BR ON TB.BorrowerID = BR.BorrowerID;
    DROP TABLE #TempBorrowers;
END;
USE [Tech-Lib];
EXEC sp_GetBorrowersWithOverdueBooks;