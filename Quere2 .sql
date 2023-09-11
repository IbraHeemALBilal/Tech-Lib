USE [Tech-Lib];
WITH BorrowerLoanCounts AS (
SELECT BorrowerID , COUNT(LoanID) AS BorrowedCount
FROM Loans 
WHERE DateReturned IS NULL 
GROUP BY BorrowerID
HAVING COUNT(LoanID) >= 2 
)
SELECT Borrowers.FirstName,Borrowers.LastName
FROM Borrowers
WHERE BorrowerID IN (
SELECT BorrowerID
FROM BorrowerLoanCounts
);
 