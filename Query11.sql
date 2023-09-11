CREATE OR ALTER PROCEDURE sp_BorrowedBooksReport
    @StartDate Date,
    @EndDate Date
AS
BEGIN 
SELECT B.Title , B.Bookid , L.DateBorrowed
FROM Books AS B
INNER JOIN Loans As L
ON b.BookID=L.BookID
WHERE L.DateBorrowed BETWEEN @StartDate AND @EndDate
END;

DECLARE @StartDate DATE = '2023-01-01';
DECLARE @EndDate DATE = '2023-01-10';

EXEC sp_BorrowedBooksReport @StartDate, @EndDate;
