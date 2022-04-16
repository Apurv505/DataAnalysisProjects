USE LMSDatabase;
DROP TABLE IF EXISTS issued_books;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS books;
DROP TABLE IF EXISTS authors;


Create table authors(
    authorid int not null AUTO_INCREMENT,
    authorname varchar(255) not null,
    primary key(authorid)
);

Create TABLE books(
    bookId int NOT NULL AUTO_INCREMENT,
    bookName varChar(255) NOT NULL,
    authorid int,
    primary key(bookId),
    foreign key(authorid) references authors(authorid)
);


Create TABLE customers (
    customerId int NOT NULL AUTO_INCREMENT,
    customerName varChar(255) NOT NULL,
    customerAddress varChar(255) NOT NULL,
    primary key(customerId)
);

Create table issued_books(
    customerId int,
    bookId int,
    issueDate date,
    returnDate date,
    foreign key(customerId) references customers(customerId),
    foreign key(bookId) references books(bookId)
);

INSERT INTO `authors`(authorname) 
VALUES("Ciaran Buck"),
  ("Marny Forbes"),
  ("Fay Madden"),
  ("Alfonso Estrada"),
  ("Blossom Berger"),
  ("Brody Waller"),
  ("Teegan Mosley")
;

INSERT INTO `books`(authorid, bookName)
VALUES
    (1, 'The Catcher in the Rye'),
    (2, 'Nine Stories'),
    (3, 'Franny and Zooey'),
    (4, 'The Great Gatsby'),
    (5, 'Tender id the Night'),
    (6, 'Pride and Prejudice'),
    (7, 'Professional ASP.NET 4.5 in C# and VB')
;

INSERT INTO `customers` (`customerName`,`customerAddress`)
VALUES
  ("Blake Webb","Ap #410-2347 Ullamcorper. St."),
  ("Colorado Bailey","Ap #855-9142 Phasellus Street"),
  ("Hiram Mendoza","4014 Egestas. Rd."),
  ("Ignatius Logan","168-4981 Ipsum Rd."),
  ("Roth Bond","106-2327 Amet, Rd."),
  ("Seth Kline","P.O. Box 779, 491 Ut, Rd."),
  ("Murphy Gilliam","575-2093 Lacus. Rd."),
  ("Bert Carrillo","Ap #691-129 Sed Rd."),
  ("Yvette Pena","482-3681 Orci, Road"),
  ("Caryn Sutton","P.O. Box 164, 2376 Mollis. Street"),
  ("Cody Maxwell","744-929 Dui Street"),
  ("Rajah Cote","Ap #942-6036 Massa. Street"),
  ("Stella Little","Ap #925-434 Ipsum Road"),
  ("Yoko Grimes","532-4357 In Av."),
  ("Lilah Juarez","1517 Dolor Street"),
  ("Hunter Webb","984 Neque. Road"),
  ("Naomi Petersen","693-361 Mi Ave"),
  ("Colorado King","465-767 Ullamcorper. Street"),
  ("Bo Curry","585-7786 Iaculis Rd."),
  ("Belle Houston","7285 Sed St.")
;


Insert into issued_books(customerId, bookId, issueDate, returnDate)
VALUES(1, 1, '2020-01-01', '2020-02-14'),
       (2, 2, '2020-02-02', '2020-02-07'),
       (3, 3, '2020-02-03', '2020-02-08'),
       (4, 4, '2020-02-04', '2020-02-09'),
       (5, 5, '2020-02-05', '2020-02-10'),
       (6, 6, '2020-02-06', '2020-02-11'),
       (7, 7, '2020-02-07', '2020-02-12')
;


-- Find the book name,author name, days left of the books issued to customers

USE LMSDatabase;
Select customerName,customerAddress, issueDate,returnDate, bookName,authorname, timestampdiff(Day,issueDate,returnDate) as `days left`
from customers inner join issued_books 
on customers.customerId = issued_books.customerId
inner join books on issued_books.bookId = books.bookId
inner join authors on authors.authorid = books.bookId;
