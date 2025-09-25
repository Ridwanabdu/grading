CREATE DATABASE IF NOT EXISTS LibraryDB;
USE LibraryDB;
CREATE TABLE IF NOT EXISTS Members (
    MemberID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(255)
);
CREATE TABLE IF NOT EXISTS Books (
    BookID INT AUTO_INCREMENT PRIMARY KEY,
    Title VARCHAR(100) NOT NULL,
    Author VARCHAR(100) NOT NULL,
    ISBN VARCHAR(20) UNIQUE,
    CopiesAvailable INT DEFAULT 0
);
CREATE TABLE IF NOT EXISTS Categories (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY,
    CategoryName VARCHAR(50) UNIQUE NOT NULL
);
CREATE TABLE IF NOT EXISTS BorrowedBooks (
    BorrowID INT AUTO_INCREMENT PRIMARY KEY,
    MemberID INT NOT NULL,
    BookID INT NOT NULL,
    BorrowDate DATETIME DEFAULT CURRENT_TIMESTAMP,
    ReturnDate DATETIME,
    FOREIGN KEY (MemberID) REFERENCES Members(MemberID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    UNIQUE (MemberID, BookID, BorrowDate)  -- prevent duplicate borrow on same day
);
CREATE TABLE IF NOT EXISTS BookCategories (
    BookID INT NOT NULL,
    CategoryID INT NOT NULL,
    PRIMARY KEY (BookID, CategoryID),
    FOREIGN KEY (BookID) REFERENCES Books(BookID)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
INSERT INTO Members (FirstName, LastName, Email, Phone, Address) VALUES
('Abdela', 'Harun', 'abdela@gmail.com', '1234567890', ' Main St'),
('Ahmed', 'Muhammed', 'ahmed@gmail.com', '0987654321', 'main St');

INSERT INTO Books (Title, Author, ISBN, CopiesAvailable) VALUES
('The Great Gatsby', 'F. Scott Fitzgerald', '9780743273565', 3),
('1984', 'George Orwell', '9780451524935', 5),
('To Kill a Mockingbird', 'Harper Lee', '9780060935467', 2);

INSERT INTO Categories (CategoryName) VALUES
('Fiction'), ('Classics'), ('Dystopian');

INSERT INTO BookCategories (BookID, CategoryID) VALUES
(1, 1), (1, 2),  
(2, 1), (2, 3),  
(3, 1), (3, 2);  
INSERT INTO BorrowedBooks (MemberID, BookID, BorrowDate, ReturnDate) VALUES
(1, 1, CURRENT_TIMESTAMP, NULL),  
(1, 2, CURRENT_TIMESTAMP, NULL),  
(2, 3, '2025-09-24 10:00:00', NULL);  

SELECT * FROM Books;
SELECT * FROM Categories;
SELECT * FROM BorrowedBooks;
SELECT * FROM BookCategories;
