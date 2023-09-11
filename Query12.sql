USE [Tech-Lib];
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'dbo.AuditLog') AND type = 'U')
BEGIN
    CREATE TABLE dbo.AuditLog (
        LogID INT IDENTITY(1,1) PRIMARY KEY,
        BookID INT,
        StatusChange VARCHAR(100),
        ChangeDate DATETIME
    );
END

CREATE OR ALTER TRIGGER tr_BookStatusChange
ON Books
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @OldStatus VARCHAR(20);
    DECLARE @NewStatus VARCHAR(20);
    DECLARE @BookID INT;

    SELECT @OldStatus = d.CurrentStatus, @NewStatus = i.CurrentStatus, @BookID = i.BookID
    FROM inserted i
    INNER JOIN deleted d ON i.BookID = d.BookID;

    IF @OldStatus <> @NewStatus
    BEGIN
        INSERT INTO dbo.AuditLog (BookID, StatusChange, ChangeDate)
        VALUES (@BookID, CONCAT('Status changed from ', @OldStatus, ' to ', @NewStatus), GETDATE());
    END
END;

SELECT * FROM Books;
UPDATE Books
SET CurrentStatus = 'Borrowed'
WHERE BookID = 2;
SELECT * FROM dbo.AuditLog;
