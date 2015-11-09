use librarydb
go
--- book
create function GetBookAuthors(@bookid int)
returns nvarchar(max)
as
begin
declare @res nvarchar(max)
select @res =stuff((select authors.name+' '+authors.surname+';'
from authorbooks,authors
where authors.id = authorbooks.authorid 
and authorbooks.bookid = @bookid 
and authorbooks.authorid is not null
order by authors.name, authors.surname
for xml path('')),1,0,'')
return @res
end
go

create function GetBookStatus(@bookid int)
returns nvarchar(max)
as
begin
declare @res nvarchar(300)
declare @user nvarchar(150)
declare @date datetime
select @date = records.dateout, @user= name+' '+surname  
    from records, users
    where records.bookid = @bookid 
	and records.userid = users.ID
	and dateout is not null 
	and datein is null
		if (@date is not null)
		 begin	
		 set @res = convert(varchar, @date, 120)+'|'+@user
		 end
		else
		 begin
		 set @res = 'available'
		 end
 return @res
end
go

create function GetBooks(@isAvail bit,@userId int)
returns @filteredBooks table
(
	Id			  int,
    Title         nvarchar(max),
    Authors       nvarchar(max),
    Status        nvarchar(150)
   ) 
as
begin
if exists(select * from Users where ID = @userId)
	begin
	insert @filteredBooks
			select distinct
			books.Id as Id,
			books.title as title, 
			dbo.GetBookAuthors(books.id) as author, 
			dbo.GetBookStatus(books.id) as status
			from books,records
			where (records.BookID = Books.ID and records.UserID = @userId) 
			and (dbo.GetBookStatus(books.id) not like ('available'))
	end
		else if(@isAvail = 1)
			begin
			insert @filteredBooks
				select 
				books.Id as Id,
				books.title as title, 
				dbo.GetBookAuthors(books.id) as author,
				dbo.GetBookStatus(books.id) as status
				from books
				where (dbo.GetBookStatus(books.id) like ('available'))
			end
			else 
			begin
			insert @filteredBooks
				select 
				books.Id as Id,
				books.title as title, 
				dbo.GetBookAuthors(books.id) as author, 
				dbo.GetBookStatus(books.id) as status
				from books
			end
   RETURN
end
go

--- user
create proc AddUser 
 @login nvarchar(20)
,@name nvarchar(20)
,@surname nvarchar(20)
,@password nvarchar(50)
,@email nvarchar(20)
as
begin
if exists (select * 
    from [users]
    where login = @login)
begin
select 0
end
else
begin
insert into [users](email,login,name,password,surname)
values (
 @email
,@login
,@name
,@password
,@surname
)
select 1
end
end
go

create procedure UserExists
@login nvarchar(20),
@password nvarchar(50)
as
begin
 if exists (select * 
    from [users]
    where login = @login and password = @password)
 begin	
  select 1
 end
 else
 begin
  select 0
 end
end 
go


select * from GetBooks(1,1) order by Id 
go