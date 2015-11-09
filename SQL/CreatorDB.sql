--DB creation
use master
go

--drop database LibraryDB
--go

create database LibraryDB
go

-- Tables construction block

use LibraryDB
go

 create table Books
(
ID int not null primary key identity(1,1),
Title nvarchar(300) not null
 )
 go

 create table Authors
(
ID int not null primary key identity(1,1),
Name nvarchar(20) not null, 
Surname nvarchar(20) not null
)
 go

 create table AuthorBooks
(
  AuthorID int,
  BookID int,
  constraint AuthorBookPK primary KEY (AuthorID, BookID),
  constraint FK_Author 
      foreign key  (AuthorID) references Authors(ID) ,
  constraint FK_Book
      foreign key (BookID) references Books(ID) 
)
go

 create table Users
(
ID int not null primary key identity(1,1),
Login nvarchar(20) not null unique, 
Name nvarchar(20) not null,
Surname nvarchar(20) not null,
Email nvarchar(20),
Password nvarchar(50) not null default '123123',
 )
 go

create table Records
(
UserID int not null,
DateOut datetime,
DateIn datetime,
BookID int not null,
constraint FK_User
		foreign key(UserID) references [Users](ID),
constraint FK_BookID
		foreign key(BookID) references Books(ID)
 )
 go

 -- DB test entries

insert into Authors values 
('Andy','Right'),
('Alex','Frost'),
('Grace','White'),
('Kevlin','Henney'),
('Robert','Martin'),
('Robert','Read'),
('Paul','Wickers'),
('Donald','Knuth'),
('Grace','White'),
('Alex','MacCow'),
('Andrew','Burgess'),
('Alan','Fridman'),
('Don','Knuth'),
('Garry','White'),
('Alan','MacCow'),
('Alfred','Burgess'),
('Ben','Fridman')
go

insert into Books values 
('Depth in C#'),
('Web assembly'),
('Adjustable design'),
('Introduction to Algorithms'),
('Head First Java'),
('JavaScript: The Good Parts'),
('The Algorithm Design Manual'),
('Art of Computer Programming, Volume 1: Fundamental Algorithms'),
('Algorithms in a Nutshell '),
('Algorithms of the Intelligent Web '),
('The C Programming Language '),
('C Programming for the Absolute Beginner '),
('Head First HTML5 Programming '),
('Art of Computer Programming, Volume 3: Sorting and Searching '),
('The Passionate Programmer '),
('The Clean Coder: A Code of Conduct for Professional '),
('Depth in C# 2'),
('Web assembly 2'),
('Adjustable design 2'),
('Introduction to Algorithms 2'),
('Head First Java 2'),
('JavaScript: The Good Parts 2'),
('The Algorithm Design Manual 2'),
('Art of Computer Programming, Volume 12: Fundamental Algorithms'),
('Algorithms in a Nutshell 2'),
('Algorithms of the Intelligent Web 2'),
('The C Programming Language 2'),
('C Programming for the Absolute Beginner 2'),
('Head First HTML5 Programming 2'),
('Art of Computer Programming, Volume 23: Sorting and Searching '),
('The Passionate Programmer 2'),
('The Clean Coder: A Code of Conduct for Professional 2')
go

insert into AuthorBooks(BookID, AuthorID) values 
(1,1),
(2,12),(2,3),
(3,14),(3,7),
(4,3),(4,4),
(5,5),(5,7),
(6,2),(6,3),
(7,12),(7,3),
(8,8),(8,13),
(9,3),(9,9),
(10,10),(10,6),
(11,11),(11,3),
(12,12),(12,3),
(13,14),(13,7),
(14,3),(14,4),
(15,5),(15,7),(5,15), 
(16,2),(16,3),(6,16),
(17,12),(17,3),
(18,8),(18,13),
(19,3),(19,9),
(20,10),(20,6),
(21,11),(21,3),
(22,12),(22,3),
(23,14),(23,7),
(24,3),(24,4),
(25,5),(25,7), 
(26,2),
(27,12),(27,3),
(28,8),(28,13),
(29,3),
(30,10),(30,6),
(31,11),(31,3)
go


select * from AuthorBooks
go