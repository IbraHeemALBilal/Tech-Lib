WITH BorrowerAgeGroups AS (
    SELECT
        BR.BorrowerID,
        CASE
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 0 AND 10 THEN '0-10'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 11 AND 20 THEN '11-20'
            WHEN DATEDIFF(YEAR, BR.DateOfBirth, GETDATE()) BETWEEN 21 AND 30 THEN '21-30'
            ELSE 'Unknown'
        END AS AgeGroup
    FROM Borrowers AS BR
)
SELECT
    AgeGroup,
    PreferredGenre
FROM (
    SELECT
        BA.AgeGroup,
        B.Genre AS PreferredGenre,
        ROW_NUMBER() OVER (PARTITION BY BA.AgeGroup ORDER BY COUNT(L.LoanID) DESC) AS RowNum
    FROM BorrowerAgeGroups AS BA
    INNER JOIN Loans AS L ON BA.BorrowerID = L.BorrowerID
    INNER JOIN Books AS B ON L.BookID = B.BookID
    GROUP BY BA.AgeGroup, B.Genre
) AS RankedGenres
WHERE RowNum = 1
ORDER BY AgeGroup;