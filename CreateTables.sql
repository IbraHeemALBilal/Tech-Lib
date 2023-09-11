use [Tech-Lib];
CREATE TABLE Books (
    BookID INT IDENTITY(1,1) PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    Author VARCHAR(255) NOT NULL,
    ISBN VARCHAR(13) NOT NULL,
    PublishedDate DATE,
    Genre VARCHAR(50),
    ShelfLocation VARCHAR(50),
    CurrentStatus VARCHAR(20) CHECK (CurrentStatus IN ('Available', 'Borrowed')) NOT NULL
);
CREATE TABLE Borrowers (
    BorrowerID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    DateOfBirth DATE,
    MembershipDate DATE
);
CREATE TABLE Loans (
    LoanID INT IDENTITY(1,1) PRIMARY KEY,
    BookID INT,
    BorrowerID INT,
    DateBorrowed DATE,
    DueDate DATE,
    DateReturned DATE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID),
    FOREIGN KEY (BorrowerID) REFERENCES Borrowers(BorrowerID)
);


