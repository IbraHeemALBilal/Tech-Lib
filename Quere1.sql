use [Tech-Lib];
SELECT B.Title 
FROM Books AS B
INNER JOIN Loans AS L
ON B.BookID = L.BookID
WHERE L.BorrowerID = 40;