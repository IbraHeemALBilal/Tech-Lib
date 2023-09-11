USE [Tech-Lib];
SELECT B.Author , 
RANK() OVER (ORDER BY COUNT(L.LoanID) DESC) AS Popularty
FROM Books AS B
INNER JOIN Loans AS L 
ON B.BookID=L.BookID
GROUP BY B.Author;