USE [Tech-Lib];
WITH BorrowerBorrowingCounts AS (
SELECT BorrowerID, COUNT(LoanID) AS BorrowingCount
FROM Loans
GROUP BY BorrowerID
)
SELECT
B.BorrowerID,
BBC.BorrowingCount AS BorrowingFrequency,
RANK() OVER (ORDER BY BBC.BorrowingCount DESC) AS BorrowingFrequencyRank
FROM Borrowers AS B
INNER JOIN
BorrowerBorrowingCounts AS BBC
ON B.BorrowerID = BBC.BorrowerID;