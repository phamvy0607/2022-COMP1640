USE master 
GO
--delete database if it already exit
IF EXISTS (SELECT * FROM sysdatabases WHERE name= 'GatheringFeedback')
	DROP DATABASE GatheringFeedback
GO

CREATE DATABASE GatheringFeedback
GO

USE GatheringFeedback
GO

--Create Domain

--Create tables
CREATE TABLE Roles
(
	RoleID			int		identity	not null,
	RoleName		nvarchar(50)
	Primary key(RoleID)
	)

CREATE TABLE Departments
(
	DepartmentID	int		identity	not null,
	DepartmentName	nvarchar(50)
	Primary key(DepartmentID)
	)
CREATE TABLE Categories
(
	CategoryID		int		identity	not null,
	CategoryName	nvarchar(50),
	Primary Key(CategoryID)
	)
CREATE TABLE EventS
(
	EventID			int		identity	not null,
	EventName		nvarchar(50),
	EventDescription	nvarchar(max),
	OpenDate		datetime,
	preClosureDate	datetime,
	ClosureDate		datetime,
	Primary key	(EventID)
)
CREATE TABLE Staffs 
(
	StaffID			int		identity	not null,
	Name			nvarchar(50),
	DoB				date,
	Age				int,
	Genre			char(1)	check (Genre in ('F', 'M'))	DEFAULT 'M',
	Nationality		nvarchar(50),
	Address			nvarchar(100),
	EmailAddress	nvarchar(100)	unique	not null,
	Password		nvarchar(50)			not null,
	ImageProfile	varbinary(max),
	RoleID			int,
	DepartmentID	int,
	Primary Key(StaffID),
	
	)
CREATE TABLE Posts
(
	PostID			int		,
	PostDate		Datetime,
	Content			nvarchar(max),
	AnonymousPost	bit,
	CategoryID		int,
	CommentID		int,
	AttachID		int,
	StaffID			int,
	EventID			int,
	Primary Key(PostID)
	)
CREATE TABLE Comments
(	
	CommentID		int		identity	not null,
	Content			nvarchar(200),
	CommentDate		DateTime,
	AnonymousComment bit,
	IconID			int,
	PostID			int,
	StaffID			int,
	Primary Key(CommentID)
	)
CREATE TABLE AttachFiles
(
	AttachID		int		identity	not null,
	FileName		nvarchar(50),
	Attackfile		varbinary(max),
	Primary Key (AttachID)
)
-- Create intermediate table
CREATE TABLE Sentiments
(
	StaffID			int,
	PostID			int,
	Sentiment		int,
	SentimentDescription	nvarchar(50)
	Primary Key(StaffID, PostID)
	)
CREATE TABLE VotingRates
(
	StaffID			int,
	CommentID		int,
	Voting			bit,
	VotingDescription	nvarchar(50)
	Primary Key(StaffID,CommentID)
	)
GO

--Insert sample value into tables
--Insert Value to Roles
INSERT INTO Roles	(RoleName)
					values	('Administrator'),
							('Quality Assurance Manager'),
							('Quality Assurance Coordinator'),
							('Staff')


--Insert value to Departments table - get from greenwich university  
INSERT INTO Departments (DepartmentName)
					values	('Accounting and Finance'),
								('Human Resources and Organisational Behaviour'),
								('International Business and Economics'),
								('Marketing, Events and Tourism'),
								('Systems Management and Strategy'),
								('Education'),
								('Health Sciences'),
								('Human Sciences'),
								('Pharmacy'),
								('Natural Resources Institute'),
								('Engineering'),
								('Science'),
								('Computing and Mathematical Sciences'),
								('Design'),
								('Humanities and Social Sciences'),
								('Law and Criminology')


--Insert value to Categories table
INSERT INTO Categories (CategoryName)
						values	('Negative Feedback'),
								('Positive Feedback'),
								('Negative Feed-forward'),
								('Positive feed-forward')

--Insert value to Staffs table
				--	(Name,DoB,Age,Genre,Nationality,Address, EmailAddress, Password, ImageProfile ,RoleID ,DepartmentID, PostID)
INSERT INTO Staffs	(Name,DoB,Genre,Nationality,Address,EmailAddress,Password,RoleID,DepartmentID)
						values	('Admin',null,'M', null,null,'Admin','Admin',1 ,null),
								('Craig Vance','10/08/85','M','England','604 Richmond Road MOTHERWELL ML19 0IR','haxab97127@wodeda.com','1',2,1),
								('Bailey Rees','12/28/96','M','England','25 Albert Road KINGSTON UPON THAMES KT64 4KB','sahsokskovorodnikov@texasaol.com','1',4,2),
								('Ferne Bean','11/21/84','F','England','847 Queen Street DERBY DE62 5KG','cr8zyhm56@lohpcn.com','1',2,3),
								('Desiree Kumar','01/12/85','F','England','71 Park Avenue GLASGOW G21 5XD','krizaziz@mobitivaisao.com','1',2,4),
								('Alaya Nolan','12/09/93','F','England','97 George Street BIRMINGHAM B76 0DG','ikature@adax.site','1',3,5),
								('Leoni Houghton','01/05/78','F','England','9948 Manchester Road LINCOLN LN96 5UL','hst4r73@mymailcr.com','1',3,6),
								('Etta Hope','01/05/78','F','England','669 Main Street WIGAN WN1 9ZM','ryanj5@vireonidae.com','1',3,7),
								('Ruben John','09/20/74','M','England','14 Kings Road EAST CENTRAL LONDON EC11 5NJ','chachinc@nkgursr.com','1',2,8),
								('Emilee Mann','10/21/75','F','England','4 Victoria Street STOCKPORT SK60 2FQ','trojanmano@usayoman.com','1',2,9),
								('Amalie Ireland','03/18/85','F','England','4 New Street HEMEL HEMPSTEAD HP41 9FC','hotmex@king.buzz' ,'1',2,10),
								('Stanley Ho','10/04/87','M','England','95 Albert Road BELFAST BT41 6DS','captkerk@silnmy.com','1',2,11),
								('Vanessa Wooten','06/03/74','F','England','664 Broadway EAST LONDON E18 9XU','albandr@emvil.com','1',2,12),
								('Mehmet Byrd','08/25/88','M','England','13 Highfield Road CREWE CW69 7PD','avrelymusiq@eloltsf.com','1',2,13),
								('Donovan Mcfadden','12/11/96','M','England','70 Church Street DURHAM DH95 1UV','klaudiastaszak1@ectong.xyz','1',2,15),
								('Zakariya Valencia','07/19/75','M','England','31 Station Road CARLISLE CA35 5YT','ragingt@texasaol.com','1',4,1),
								('Ivy-Rose Ryder','08/11/84','F','England','72 The Crescent CARDIFF CF29 5KB','mijldalk@emvil.com','1',4,2),
								('Giulia Jackson','07/25/90','M','England','9028 Park Road EXETER EX56 8CB','bogdanenokelena@boranora.com','1',4,4),
								('Nile Vaughn','08/14/76','F','England','19 West Street BLACKPOOL FY43 8SX','disantis12@onlinecmail.com','1',4,6),
								('Hareem Alfaro','04/16/81','M','England','9106 Alexander Road LIVERPOOL L35 9NQ','gerphil@lompikachi.com','1',4,9),
								('Brittany Lake','03/16/80','M','England','86 King Street NORTH LONDON N40 6BP','tanechkaz93@gemuk.buzz','1',4,2)
insert Into Posts (PostID,PostDate,Content,AnonymousPost,CategoryID,CommentID,AttachID,StaffID)
						values	(1,4/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. 
								Sit beatae iusto ipsa earum. Ipsum, officiis? Consequatur 
								doloremque repellendus alias maxime magni rerum quas sint 
								itaque quaerat? Ratione excepturi perspiciatis dolore.',1,1,null,null,5),
								(2,5/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. 
								Excepturi maiores cupiditate tempora nihil, error doloribus voluptatem 
								quam sunt ratione, omnis laudantium pariatur illo. Debitis cupiditate 
								rerum harum molestias nihil impedit.',0,2,null,null,9),
								(3,5/4/2022,'Lorem, ipsum dolor sit amet consectetur adipisicing elit. 
								Quas molestiae ad, quod temporibus ipsum laboriosam veniam odit inventore 
								nam blanditiis soluta tempore aliquid quam illum nihil voluptatibus distinctio 
								laudantium ratione!',1,2,null,null,13),
								(4,6/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Id reprehenderit 
								voluptatibus repudiandae, quia neque laudantium quam quas quo ducimus inventore amet 
								obcaecati voluptatem ipsum iusto ipsa iste incidunt atque vel.',1,2,null,null,12),
								(5,8/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Id reprehenderit 
								voluptatibus repudiandae, quia neque laudantium quam quas quo ducimus inventore amet 
								obcaecati voluptatem ipsum iusto ipsa iste incidunt atque vel.',1,1,null,null,15),
								(6,9/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Id reprehenderit 
								voluptatibus repudiandae, quia neque laudantium quam quas quo ducimus inventore amet 
								obcaecati voluptatem ipsum iusto ipsa iste incidunt atque vel.',0,3,null,null,15),
								(7,10/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Vero 
								laboriosam velit dolores ipsam explicabo facilis quasi nobis enim? Quas mollitia 
								libero eligendi quae nam, necessitatibus velit molestiae laborum ducimus non!',0,4,null,null,14),
								(8,12/4/2022,'Lorem ipsum dolor, sit amet consectetur adipisicing elit. Odit maxime vero deleniti 
								doloribus iusto voluptatem perferendis, amet ea possimus debitis tempora delectus voluptas ipsum vitae 
								dignissimos nam cupiditate optio minima.',1,2,null,null,12),
								(9,14/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Consequatur asperiores similique 
								distinctio, nisi animi quibusdam ea. Voluptate delectus porro necessitatibus. Fuga, molestias fugit. 
								Praesentium repellat blanditiis ipsum aperiam eligendi eius.',0,1,null,null,11),
								(10,15/4/2022,'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Blanditiis impedit 
								repellat ex culpa perspiciatis repudiandae aliquam magni quos labore nam itaque odio, quis saepe 
								in maiores ipsum quia assumenda quisquam.',1,3,null,null,11),
								(11,16/4/2022,'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Blanditiis impedit 
								repellat ex culpa perspiciatis repudiandae aliquam magni quos labore nam itaque odio, quis saepe 
								in maiores ipsum quia assumenda quisquam.',0,4,null,null,9),
								(12,19/4/2022,'Lorem ipsum dolor sit amet consectetur adipisicing elit. Officia, illo ipsum 
								exercitationem, nobis numquam aliquam veniam veritatis doloremque nulla, molestias alias voluptate. 
								Praesentium, fuga. Dolores delectus modi quae veniam eum!',1,2,null,null,8),
								(13,20/4/2022,'Lorem ipsum, dolor sit amet consectetur adipisicing elit. Consequuntur iusto quidem 
								fuga asperiores? Laboriosam quia aliquam minus quasi voluptatum! Neque dolorem exercitationem esse 
								molestias nemo ea adipisci laudantium maxime. Accusamus.',1,4,null,null,5)
Insert into Comments(Content,CommentDate, AnonymousComment,PostID)
						values	('Example comment for post id1',4/4/2022,0,1),
								('Example comment for post id1',5/4/2022,0,1),
								('Example comment for post id1',6/4/2022,0,1),
								('Example comment for post id1',7/4/2022,0,1),
								('Example comment for post id1',8/4/2022,0,1),
								('Example comment for post id1',9/4/2022,0,1),
								('Example comment for post id1',9/4/2022,1,2),
								('Example comment for post id1',9/4/2022,1,2),
								('Example comment for post id1',9/4/2022,0,2),
								('Example comment for post id1',9/4/2022,0,2),
								('Example comment for post id1',9/4/2022,1,2)
--Add Foreign keys constraint to tables
ALTER TABLE Staffs
	ADD	Constraint	FK_Staffs_Roles	Foreign Key(RoleID)			references Roles(RoleID),
		Constraint	FK_Staffs_Departments	Foreign Key(DepartmentID)	references Departments(DepartmentID)
GO
ALTER TABLE Posts
	ADD Constraint	FK_Posts_Categories		Foreign Key(CategoryID)		references Categories(CategoryID),
		Constraint	FK_Posts_Comments		Foreign Key(CommentID)		references Comments(CommentID),
		Constraint	FK_Posts_AttachFiles	Foreign Key(AttachID)		references AttachFiles(AttachID),
		Constraint	FK_Posts_Staffs			Foreign Key(StaffID)		references Staffs(StaffID),
		Constraint	FK_Posts_Events			Foreign Key (EventID)		references Events(EventID)
GO
ALTER TABLE Sentiments
	ADD 
		Constraint	FK_Sentiments_Posts		Foreign Key(PostID)			references Posts(PostID)
GO
ALTER TABLE VotingRates
	ADD Constraint 	FK_VotingRates_Staffs	Foreign key(StaffID)		references Staffs(StaffID),
		Constraint 	FK_VotingRates_Comments	Foreign key(CommentID)		references Comments(CommentID)
GO
Alter table Comments
	Add Constraint	FK_Comments_Posts		Foreign Key(PostID)			references	Posts(PostID),
		Constraint	FK_Comments_Staffs		Foreign Key(StaffID)		references	Staffs(StaffID)
