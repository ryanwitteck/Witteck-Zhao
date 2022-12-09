CREATE DATABASE witteck_zhao_db;

GRANT ALL PRIVILEGES ON witteck_zhao_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

-- Move into database we just created
USE witteck_zhao_db;


-- category pool: toys, computers, electronics, outdoors, travel, home, health, clothing, pets, sports

create table supplier (
	supplier_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	phone VARCHAR(50) UNIQUE NOT NULL,
	fax VARCHAR(50),
	email VARCHAR(50) UNIQUE NOT NULL
);
create table products (
	product_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_name VARCHAR(50) UNIQUE NOT NULL,
	supplier_id INTEGER NOT NULL,
	description VARCHAR(50) NOT NULL,
	unit_price DECIMAL(5,2) NOT NULL,
	quantity INTEGER NOT NULL,
	rating INTEGER NOT NULL,
	constraint fk_1
		foreign key (supplier_id) references supplier (supplier_id)
);
create table product_image (
	product_image_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_id INTEGER UNIQUE NOT NULL,
	constraint fk_2
		foreign key (product_id) references products (product_id)
);
create table company (
	company_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	company_name VARCHAR(50) NOT NULL,
	supplier_id INTEGER UNIQUE NOT NULL,
	address VARCHAR(50),
	city VARCHAR(50),
	state VARCHAR(50),
	country VARCHAR(50),
	zip_code VARCHAR(50),
	constraint fk_3
		foreign key (supplier_id) references supplier (supplier_id)
);
create table sales_rep (
	sales_rep_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	birthday DATE NOT NULL,
	phone VARCHAR(50) UNIQUE NOT NULL,
	fax VARCHAR(50),
	address VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state VARCHAR(50),
	country VARCHAR(50) NOT NULL,
	zip_code VARCHAR(50) NOT NULL
);
create table supplier_rep (
	supplier_id INTEGER NOT NULL UNIQUE,
	sales_rep_id INTEGER NOT NULL UNIQUE,
	PRIMARY KEY (supplier_id, sales_rep_id),
	constraint fk_4
		foreign key (supplier_id) references supplier (supplier_id),
	constraint fk_5
		foreign key (sales_rep_id) references sales_rep (sales_rep_id)
);
create table customers (
    customer_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50) NOT NULL,
	address VARCHAR(50) NOT NULL,
	city VARCHAR(50) NOT NULL,
	state VARCHAR(50),
	country VARCHAR(50) NOT NULL,
	zip_code VARCHAR(50) NOT NULL,
	phone_number VARCHAR(50) UNIQUE NOT NULL,
	email VARCHAR(50) UNIQUE NOT NULL,
	fax VARCHAR(50)
);
create table invoice (
	invoice_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	customer_id INTEGER NOT NULL,
	date DATE NOT NULL,
	total DECIMAL(7,2) NOT NULL,
	billing_address VARCHAR(50) NOT NULL,
	billing_city VARCHAR(50) NOT NULL,
	billing_state VARCHAR(50),
	billing_country VARCHAR(50) NOT NULL,
	billing_zip VARCHAR(50) NOT NULL,
	constraint fk_6
		foreign key (customer_id) references customers (customer_id)
);
create table invoice_line (
	invoice_line_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	unit_price DECIMAL(8,2) NOT NULL,
	quantity INT NOT NULL,
	invoice_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	constraint fk_7
		foreign key (invoice_id) references invoice (invoice_id),
	constraint fk_8
		foreign key (product_id) references products (product_id)
);
create table category (
	category_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name VARCHAR(11) NOT NULL
);
create table category_product (
	product_id INTEGER NOT NULL UNIQUE,
	category_id INTEGER NOT NULL UNIQUE,
	PRIMARY KEY (product_id, category_id),
	constraint fk_9
		foreign key (category_id) references category (category_id),
	constraint fk_10
		foreign key (product_id) references products (product_id)
);
create table reviews (
	review_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	title VARCHAR(50) NOT NULL,
	description TEXT NOT NULL ,
	rating INTEGER NOT NULL,
	constraint fk_11
		foreign key (product_id) references products (product_id),
	constraint fk_12
		foreign key (customer_id) references customers (customer_id)
);

insert into sales_rep
	(first_name, last_name, email, birthday, phone, fax, address, city, state, country, zip_code)
values
	('Trista', 'Baumer', 'tbaumer0@cornell.edu', '1999-12-29', '999-856-4450', '525-783-3821', '8124 Lukken Drive', 'Litvínov', null, 'Czech Republic', '64539'),
	('Dur', 'Chappell', 'dchappell1@statcounter.com', '1999-12-23', '710-152-0535', '372-413-1439', '1 7th Place', 'Huangduobu', null, 'China', '15307'),
	('Mohammed', 'Devonside', 'mdevonside2@gravatar.com', '2000-6-23', '421-979-0222', '202-683-0562', '2102 Loomis Hill', 'Ustyuzhna', null, 'Russia', '42159'),
	('Rollie', 'Ekless', 'rekless3@squidoo.com', '1999-11-29', '987-138-7697', '801-801-8301', '25 Jenifer Hill', 'Nadvoitsy', null, 'Russia', '92119'),
	('Edd', 'Shillaker', 'eshillaker4@liveinternet.ru', '1999-12-11', '845-244-7298', '951-875-5383', '6 Summerview Crossing', 'Nārāyanganj', null, 'Bangladesh', '19395');

insert into supplier (supplier_id, first_name, last_name, phone, fax, email) values (1, 'Marinna', 'Swindles', '562-273-5187', '499-453-2012', 'mswindles0@foxnews.com');
insert into supplier (supplier_id, first_name, last_name, phone, fax, email) values (2, 'Vanni', 'Dufton', '477-307-8334', '125-570-5084', 'vdufton1@gravatar.com');
insert into supplier (supplier_id, first_name, last_name, phone, fax, email) values (3, 'Hatti', 'Gillogley', '318-197-9171', '167-982-7885', 'hgillogley2@google.co.uk');
insert into supplier (supplier_id, first_name, last_name, phone, fax, email) values (4, 'Othilie', 'Bentley', '787-948-0701', '380-831-9053', 'obentley3@sun.com');
insert into supplier (supplier_id, first_name, last_name, phone, fax, email) values (5, 'Rosetta', 'McTurley', '869-828-1232', '925-680-3611', 'rmcturley4@jugem.jp');

insert into supplier_rep (supplier_id, sales_rep_id) values (1, 1);
insert into supplier_rep (supplier_id, sales_rep_id) values (2, 2);
insert into supplier_rep (supplier_id, sales_rep_id) values (3, 3);
insert into supplier_rep (supplier_id, sales_rep_id) values (4, 4);
insert into supplier_rep (supplier_id, sales_rep_id) values (5, 5);

insert into company (company_id, company_name, supplier_id) values (1, 'Addy', 1);
insert into company (company_id, company_name, supplier_id) values (2, 'Godfry', 2);
insert into company (company_id, company_name, supplier_id) values (3, 'Sollie', 3);
insert into company (company_id, company_name, supplier_id) values (4, 'Balduin', 4);
insert into company (company_id, company_name, supplier_id) values (5, 'Granville', 5);

insert into products (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 1', 1, 3, 'utilize granular web-readiness', 13.37, 466, 0);
insert into products (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 2', 2, 1, 'target B2B functionalities', 43.39, 223, 0);
insert into products (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 3', 3, 3, 'streamline 24/365 architectures', 95.52, 184, 0);
insert into products (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 4', 4, 2, 'unleash global applications', 13.01, 96, 0);
insert into products (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 5', 5, 5, 'productize transparent eyeballs', 93.77, 59, 0);

insert into category (category_id, name) values (1, 'outdoors');
insert into category (category_id, name) values (2, 'health');
insert into category (category_id, name) values (3, 'computers');
insert into category (category_id, name) values (4, 'toys');
insert into category (category_id, name) values (5, 'clothing');

insert into category_product (product_id, category_id) values (1, 1);
insert into category_product (product_id, category_id) values (2, 2);
insert into category_product (product_id, category_id) values (3, 3);
insert into category_product (product_id, category_id) values (4, 4);
insert into category_product (product_id, category_id) values (5, 5);

insert into customers (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (1, 'Pearl', 'Spillane', '12 Scofield Street', 'Turt', null, 'Mongolia', '04302', '860-596-5229', 'pspillane0@ft.com', '770-189-8031');
insert into customers (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (2, 'Lorrie', 'Gillman', '3 Butterfield Court', 'Dallas', 'Texas', 'United States', '45031', '972-659-2415', 'lgillman1@huffingtonpost.com', '708-872-9837');
insert into customers (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (3, 'Sean', 'Whitticks', '5950 Havey Crossing', 'Busdi', null, 'Philippines', '76592', '431-727-6468', 'swhitticks2@mysql.com', '915-317-9974');
insert into customers (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (4, 'Sheff', 'Balnave', '7 Hauk Lane', 'Takamatsu-shi', null, 'Japan', '86274', '463-884-8386', 'sbalnave3@slideshare.net', '401-561-0785');
insert into customers (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (5, 'Nickolaus', 'MacGaughie', '4 Wayridge Street', 'Dajing', null, 'China', '64738', '763-779-0176', 'nmacgaughie4@forbes.com', '372-397-2821');

insert into invoice (invoice_id, customer_id,  date, total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (1, 1,  '2022-6-25', 5018.71, '06 Hooker Place', 'Sishiba', null, 'China', '63167');
insert into invoice (invoice_id, customer_id,  date, total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (2, 2,  '2021-1-26', 2917.38, '8 Hanover Junction', 'Baitashan', null, 'China', '10862');
insert into invoice (invoice_id, customer_id,  date, total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (3, 3, '2021-5-16', 1314.58, '7737 Redwing Terrace', 'Shengze', null, 'China', '21709');
insert into invoice (invoice_id, customer_id,  date, total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (4, 4, '2021-2-13', 3249.73, '15 Cody Way', 'Nýdek', null, 'Czech Republic', '60625');
insert into invoice (invoice_id, customer_id,  date, total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (5, 5,  '2021-8-29', 9752.87, '70420 Fuller Lane', 'Orleans', null, 'Brazil', '26765');

insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (1, 265.55, 44, 1, 1);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (2, 97686.51, 36, 2, 2);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (3, 10572.02, 26, 3, 3);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (4, 59247.11, 5, 4, 4);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (5, 37255.13, 44, 5, 5);

insert into reviews (title, description, rating, product_id, customer_id) values ('info-mediaries', 'ac nibh fusce lacus purus aliquet at feugiat non pretium quis', 1, 1, 5);
insert into reviews (title, description, rating, product_id, customer_id) values ('productivity', 'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin', 1, 2, 3);
insert into reviews (title, description, rating, product_id, customer_id) values ('Cross-platform', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis', 1, 1, 3);
insert into reviews (title, description, rating, product_id, customer_id) values ('Cross-group', 'sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa', 2, 4, 5);
insert into reviews (title, description, rating, product_id, customer_id) values ('uniform', 'morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel', 4, 5, 2);


/*
-- LOGIN STUFF - incomplete

-- Table of users
create table users (
    userID INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email VARCHAR(50) NOT NULL,
    passwordHash BINARY(64) NOT NULL,
    firstName VARCHAR(50) NULL,
    lastName VARCHAR(50) NULL,
	salt BINARY(16) NOT NULL
);

-- Procedure for adding new users
create procedure uspAddUser (
    IN loginName VARCHAR(50), 
    IN passwd VARCHAR(50),
    IN firstName VARCHAR(50), 
    IN lastName VARCHAR(50),
    OUT responseMessage VARCHAR(250)
)
BEGIN
    DECLARE salt BINARY(16);
	SET salt = guid();

    BEGIN TRY
        INSERT INTO users (email, passwordHash, firstName, lastName, salt);
        VALUES(loginName, HASHBYTES('SHA2_512', passwd+CAST(salt AS VARCHAR(36))), firstName, lastName, salt);

       SET responseMessage='Success';
    END TRY;
    BEGIN CATCH
        SET responseMessage=ERROR_MESSAGE();
    END CATCH;

END;

-- Add admin user
declare @resMessage VARCHAR(250);

exec uspAddUser (
          loginName = N'Admin',
          passwd = N'123',
          firstName = N'Admin',
          lastName = N'Administrator',
          responseMessage=@resMessage OUTPUT);

-- create login procedure
create procedure uspLogin (
    IN loginName VARCHAR(254),
    IN passwd VARCHAR(50),
    OUT responseMessage VARCHAR(250)=''
)
BEGIN

    SET NOCOUNT ON

    DECLARE userID INT

    IF EXISTS (SELECT TOP 1 userID FROM users WHERE email=loginName)
    BEGIN
        SET userID=(SELECT userID FROM users WHERE email=loginName AND PasswordHash=HASHBYTES('SHA2_512', @pPassword+CAST(Salt AS VARCHAR(36))))

       IF(userID IS NULL)
           SET responseMessage='Incorrect password'
       ELSE 
           SET responseMessage='User successfully logged in'
    END
    ELSE
       SET responseMessage='Invalid login'

END;
*/