USE [Tech-Lib];
DECLARE @NumberOfLoans INT;
SET @NumberOfLoans = (SELECT COUNT(LoanID) FROM Loans);

SELECT DATENAME(DW, DateBorrowed) AS DayName,
COUNT(LoanID) * 100.0 / @NumberOfLoans AS LoanPercentage ,
DENSE_RANK () OVER (ORDER BY COUNT(LoanID) DESC) AS A
FROM Loans
GROUP BY DATENAME(DW, DateBorrowed);

