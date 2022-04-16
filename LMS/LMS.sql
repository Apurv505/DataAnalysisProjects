USE LMSDatabase;
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
    bookId int,
    primary key(customerId),
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


UPDATE customers
SET BOOKID = CASE 
    WHEN customerId%2 = 0 THEN 1
    ELSE 2
    END
;

SELECT * FROM customers;
SELECT * FROM books;
Select * from authors;

-- Find the books(and their author) issued by the customers

select * from customers 
inner join books on customers.bookId = books.bookId 
inner join authors on authors.authorid = books.bookId
order by customerId;

