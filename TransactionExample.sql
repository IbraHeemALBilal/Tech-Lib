use [Tech-Lib];

BEGIN TRANSACTION;
INSERT INTO Loans (BookID, BorrowerID, DateBorrowed, DueDate)
VALUES (1, 1, '2023-09-10', '2023-09-17'); 

UPDATE Books
SET CurrentStatus = 'Borrowed'
WHERE BookID = 1; 

SELECT CurrentStatus
FROM Books
WHERE BookID = 1;

IF (SELECT CurrentStatus FROM Books WHERE BookID = 1) = 'Borrowed'
BEGIN
    COMMIT TRANSACTION;
    PRINT 'Transaction Committed: Book borrowed successfully';
END
ELSE
BEGIN
    ROLLBACK TRANSACTION;
    PRINT 'Transaction Rolled Back: Book borrowing failed';
END
