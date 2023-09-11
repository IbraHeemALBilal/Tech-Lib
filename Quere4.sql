USE [Tech-Lib];
WITH MonthlyGenrePopularity AS (
SELECT
B.Genre,
MONTH(L.DateBorrowed) AS BorrowedMonth,
COUNT(L.LoanID) AS Popularity,
RANK() OVER (PARTITION BY MONTH(L.DateBorrowed) ORDER BY COUNT(L.LoanID) DESC) AS GenreRank
FROM Books AS B
INNER JOIN
Loans AS L ON B.BookID = L.BookID
WHERE MONTH(L.DateBorrowed) = 3
GROUP BY B.Genre, MONTH(L.DateBorrowed)
)
SELECT Genre
FROM MonthlyGenrePopularity 
WHERE GenreRank = 1;
