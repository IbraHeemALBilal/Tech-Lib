USE [Tech-Lib];
CREATE INDEX IX_Books_Title ON Books (Title);
CREATE INDEX IX_Books_Genre ON Books (Genre);
EXEC sp_helpindex 'Books';

CREATE UNIQUE INDEX IX_Borrowers_Email ON Borrowers (Email);
EXEC sp_helpindex 'Borrowers';

CREATE INDEX IX_Loans_BookID ON Loans (BookID);
CREATE INDEX IX_Loans_BorrowerID ON Loans (BorrowerID);
CREATE INDEX IX_Loans_DueDate ON Loans (DueDate);
EXEC sp_helpindex 'Loans';

