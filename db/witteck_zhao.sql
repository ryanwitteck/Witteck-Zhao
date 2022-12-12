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
create table product (
	product_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_name VARCHAR(50) UNIQUE NOT NULL,
	supplier_id INTEGER NOT NULL,
	description VARCHAR(50) NOT NULL,
	unit_price DECIMAL(5,2) NOT NULL,
	quantity INTEGER NOT NULL,
	rating INTEGER DEFAULT 0,
	is_approved BOOLEAN DEFAULT FALSE,
	constraint fk_1
		foreign key (supplier_id) references supplier (supplier_id)
		on update CASCADE
		on delete RESTRICT
);
create table product_image (
	product_image_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_id INTEGER UNIQUE NOT NULL,
	image_url TEXT,
	constraint fk_2
		foreign key (product_id) references product (product_id)
		on update CASCADE
		on delete RESTRICT
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
		on update CASCADE
		on delete RESTRICT
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
	supplier_id INTEGER NOT NULL,
	sales_rep_id INTEGER NOT NULL,
	PRIMARY KEY (supplier_id, sales_rep_id),
	constraint fk_4
		foreign key (supplier_id) references supplier (supplier_id)
		on update CASCADE
		on delete RESTRICT,
	constraint fk_5
		foreign key (sales_rep_id) references sales_rep (sales_rep_id)
		on update CASCADE
		on delete RESTRICT
);
create table customer (
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
	date DATETIME DEFAULT CURRENT_TIMESTAMP,
	total DECIMAL(7,2) NOT NULL,
	billing_address VARCHAR(50) NOT NULL,
	billing_city VARCHAR(50) NOT NULL,
	billing_state VARCHAR(50),
	billing_country VARCHAR(50) NOT NULL,
	billing_zip VARCHAR(50) NOT NULL,
	constraint fk_6
		foreign key (customer_id) references customer (customer_id)
		on update CASCADE
		on delete RESTRICT
);
create table invoice_line (
	invoice_line_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	unit_price DECIMAL(8,2) NOT NULL,
	quantity INT NOT NULL,
	invoice_id INTEGER NOT NULL,
	product_id INTEGER NOT NULL,
	constraint fk_7
		foreign key (invoice_id) references invoice (invoice_id)
		on update CASCADE
		on delete RESTRICT,
	constraint fk_8
		foreign key (product_id) references product (product_id)
		on update CASCADE
		on delete RESTRICT
);
create table category (
	category_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	name VARCHAR(11) NOT NULL
);
create table category_product (
	product_id INTEGER NOT NULL,
	category_id INTEGER NOT NULL,
	PRIMARY KEY (product_id, category_id),
	constraint fk_9
		foreign key (category_id) references category (category_id)
		on update CASCADE
		on delete RESTRICT,
	constraint fk_10
		foreign key (product_id) references product (product_id)
		on update CASCADE
		on delete RESTRICT
);
create table review (
	review_id INTEGER PRIMARY KEY AUTO_INCREMENT NOT NULL,
	product_id INTEGER NOT NULL,
	customer_id INTEGER NOT NULL,
	title VARCHAR(50) NOT NULL,
	description TEXT NOT NULL ,
	rating INTEGER NOT NULL,
	constraint fk_11
		foreign key (product_id) references product (product_id)
		on update CASCADE
		on delete RESTRICT,
	constraint fk_12
		foreign key (customer_id) references customer (customer_id)
		on update CASCADE
		on delete RESTRICT
);

insert into sales_rep
	(first_name, last_name, email, birthday, phone, fax, address, city, state, country, zip_code)
values
	('Trista', 'Baumer', 'tbaumer0@cornell.edu', '1999-12-29', '999-856-4450', '525-783-3821', '8124 Lukken Drive', 'Litvínov', null, 'Czech Republic', '64539'),
	('Dur', 'Chappell', 'dchappell1@statcounter.com', '1999-12-23', '710-152-0535', '372-413-1439', '1 7th Place', 'Huangduobu', null, 'China', '15307'),
	('Mohammed', 'Devonside', 'mdevonside2@gravatar.com', '2000-6-23', '421-979-0222', '202-683-0562', '2102 Loomis Hill', 'Ustyuzhna', null, 'Russia', '42159'),
	('Rollie', 'Ekless', 'rekless3@squidoo.com', '1999-11-29', '987-138-7697', '801-801-8301', '25 Jenifer Hill', 'Nadvoitsy', null, 'Russia', '92119'),
	('Edd', 'Shillaker', 'eshillaker4@liveinternet.ru', '1999-12-11', '845-244-7298', '951-875-5383', '6 Summerview Crossing', 'Nārāyanganj', null, 'Bangladesh', '19395');

insert into supplier 
	(first_name, last_name, phone, fax, email) 
values 
	('Marinna', 'Swindles', '562-273-5187', '499-453-2012', 'mswindles0@foxnews.com'),
	('Vanni', 'Dufton', '477-307-8334', '125-570-5084', 'vdufton1@gravatar.com'),
	('Hatti', 'Gillogley', '318-197-9171', '167-982-7885', 'hgillogley2@google.co.uk'),
	('Othilie', 'Bentley', '787-948-0701', '380-831-9053', 'obentley3@sun.com'),
	('Rosetta', 'McTurley', '869-828-1232', '925-680-3611', 'rmcturley4@jugem.jp');

insert into supplier_rep (supplier_id, sales_rep_id) values (1, 1);
insert into supplier_rep (supplier_id, sales_rep_id) values (2, 2);
insert into supplier_rep (supplier_id, sales_rep_id) values (3, 3);
insert into supplier_rep (supplier_id, sales_rep_id) values (4, 4);
insert into supplier_rep (supplier_id, sales_rep_id) values (5, 5);

insert into company (company_name, supplier_id) values ('Addy', 1);
insert into company (company_name, supplier_id) values ('Godfry', 2);
insert into company (company_name, supplier_id) values ('Sollie', 3);
insert into company (company_name, supplier_id) values ('Balduin', 4);
insert into company (company_name, supplier_id) values ('Granville', 5);

insert into product (product_name, product_id, supplier_id, description, unit_price, quantity, rating, is_approved ) values ('product 1', 1, 3, 'utilize granular web-readiness', 13.37, 466, 0, TRUE);
insert into product (product_name, product_id, supplier_id, description, unit_price, quantity, rating, is_approved ) values ('product 2', 2, 1, 'target B2B functionalities', 43.39, 223, 0, TRUE);
insert into product (product_name, product_id, supplier_id, description, unit_price, quantity, rating, is_approved ) values ('product 3', 3, 3, 'streamline 24/365 architectures', 95.52, 184, 0, TRUE);
insert into product (product_name, product_id, supplier_id, description, unit_price, quantity, rating, is_approved ) values ('product 4', 4, 2, 'unleash global applications', 13.01, 96, 0, TRUE);
insert into product (product_name, product_id, supplier_id, description, unit_price, quantity, rating ) values ('product 5', 5, 5, 'productize transparent eyeballs', 93.77, 59, 0);

insert into product_image
	(product_id, image_url)
values
	(1, 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUWFRgVFhYYGRgYGhwcHBwaGhweHBgaGhwcHhwcHB4dIS4nHB4rHxwaJjgmKy8xNTU1HCQ7QDs0Py40NTEBDAwMEA8QHhISGjQhJCs0NDQ0NDQ0NDQ0NDQ0NDU0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NDQ0NP/AABEIAOEA4QMBIgACEQEDEQH/xAAcAAEAAgMBAQEAAAAAAAAAAAAAAwQFBgcCAQj/xAA+EAABAwIEAwUGBQMEAQUBAAABAAIRAyEEEjFBBVFhInGBkaEGMrHB0fAHE0JSciPh8RRigrKSM3ODosIV/8QAGAEBAQEBAQAAAAAAAAAAAAAAAAECAwT/xAAfEQEBAQEAAwEBAAMAAAAAAAAAARECEiExA0EiMmH/2gAMAwEAAhEDEQA/AOMoiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiIgIiICIiAiK3w/BPrVG02NLnuMAfXoluEmqiLdPa/2M/0dCnUD85L8roGhLSR4dkrS1JZZsWyy5RERVBERAREQEREBERAREQEREBERARWMFhXVHtY0EucYAC3Kp7C9kf1BmjZsieRvdZ67nP1rnm9fGiosvxfgFbD3c2W/ubcX0nksQtSyzYlllyiIiIIiICIiAux/hZ7OCnTOJqDtPHZn9LNfM6rmns3wk4iuxkdmRm7hqv0K2mKdNrGQABC593b4uvEya1T8RSHYHEdMhHeKrB5wSPFcNXbfbskYGvIJnILWntsPXkuJLXDPf0REWmBERAREQEREBERAREQEREBERBvP4d4MRWrbtysb0zSXegAW7URcD5LVPw6P9Cr/wC63/qVtdBnbk6Lh3/tXp4n+MWsRhGuaQRmB1BEgg6iNwQuVe1fAfyH52D+k4x/B+7T6kdF2FtRuWAD8B5xdYnjXD2ua5rmy14hwHLYi3vAiRfULMvjdi9c+UyuIIsjxfhj6D8rrg+64aOHMfTZY5emWWbHmssuURexTJ0BPgvdPDOdGVpM9ETEKt4DBmo6NABJPILYOGeyZcA+q7K03yj3jpY8lYxVNjBkptDWnfUm+p3Kx13P46c8X7W1/htwprc1WLaN5kCxPiQf/FdAqmVr/s24MY1gjKAADzgRPiQTPVbCWrjLvt2s/jXPbTC58I9pc0DM0kviBEncjeN1wp9GHFovG4+Oseq7r7dPpswb/wA2SHOaAAYJdMiNdgVwuvUBJDRDZsPqdz92Xblx7+o8oGpk8h9fpK8l3IQvKALbmIvrmkahfEBERAREQEREBERAREQEREHQPw5rg061PcOY6OhBaT5hvmtufUyHUid/8Ll/sbjfysXTP6XnI7+L7T4GD4LqOOZlMO8LT4Fef9PXT1fl75XsHiHf7O+wPr9FYxL8zSCWuJtb+ywtLGtaQ3KXH/iB6XVv/wDoEt7LPK43tyWK1ntqvFqbHk0qgzMkkEHtMdvHeBosDU4NRY7tAkbcj1kfBbLjKQe8k2tANyDNo5j1VI4B5s4Wix2PSOcwFebYz1Pfx6Y1rSxoawZvdMdkjv2MqHEViwGQ1pa6DGvLyuPRZClTAbkI99oJMSGNLTmjrKx1GiXl4fJFNrmg/qd2THhdakS0dVe0jM0wSNDctJiQe/ZHOb+ZkcLGCx0fGLrOuwTn0ZEOdluf2vbYEeMT5qpS4d+YRnIaWjO17bGLiHA9YGyek2slwBgY8jPMkCOYjWemi3MOznsusNvW61HAdl4aWXa4CeZJE38iPktjwzBByGCSbc9dfRRqIPafg4xmHfSmHWLHa3B5dRI8VwTEUwxxaRLgSCDIDSDBEamCCLx3L9JB0AB1oOvdH34LiHt5gMlYuDYLy5xFp1F/X1C6fnf45/pN9tW/PdsY7gB8F8NZ37j5lRouriIiICIiAiIgIiICIiAiIgIiIJ8G/K9h5OB8jK7Zh5e0h12sAM7mRbvsuNcKwpqVWNAmXCfPvXXX4ptNjmOIBgRtdunofReb977j0/h8rG8Rx/5c5BcwJiTfpp9+CrFlec2Z5aTMyS2Dsfh/ZesMG1HgCHX8e481tDWCmAWlwEaa+h0+7KS5HSqeFDQztgZom4EEjcFVHvzk5h2XQSB3n78NVbqAlxcYJO3PlHIqvXbltmALmwNJGpHT/HVZ1Kr1Q5rw1nuEQCRcPP6SdnZSehA5rzw6iQ9+57QG+jWiOt17oVO1Djdw01bECPUCPDVY5lQ4fEhrjNN5DhG1wCB4HbktsVtXACHkjIWFpLajDydo8cwvXG8BDHta27qbm+MiPCTqs3gMOwuz2zRGYcuR6aeqtPYCYIF/LuTRqlXDuOHbDSHsaxwk+8WuBMxqNfNTcB4ialFziCHMcGz3HXx0hbHUwFiRpGn38FjHcLZhqD3PeGsLi97jYAWtPP1koa+4PHh5g3gx3d59Vpv4k8LGTOIg+F+Zga9867aq1h/aGmXhtKk5zCYz2A0gQ0GWjvWx47CsqUyx4ljxpEeuysuVLNj89FfFlPaDAfk1304PZP8Aj0hYteiOFmCIiIIiICIiAiIgIiICIiAvTGEmACe5XOHcMqVnBrGzJ6Lqfsp+H7acVK3vRZsnXrFlnruRvnm1R9hfZsU2/nOu4i3IDnB3WU9o6RPZGpAhbYcLlEALXONMIeO7r1Xktt62vVJJzka/wfhhY/M58zsGzfpOvksucUS/cgREjtRMX/uo2MyjNNzp07lVp0zJ0M3JIkDvnX71V+p8ZJhzTMka9Y5TvsosfRc9wAG1tvGPu68tflu6dbEX+GnovmPxUNDWDtvMNN4H+49ALxvCQrHFjWOBqVmtAkQ6AI0jVZY4WjXYA17HRoWmSPpMLm3EmnOS9xNzc6+mncFd4dh6lN4yEseQCL2IIkBw3F9Oq63ly8nXeHksAbyWXDw5vzWp+z/EhXp5tHizhyI1H3zWdoVYWMbbBghIIXNvxix7gaOHHuZTUeP3GcrZ6CHHvjkuh8NqCfvdaT+LHB87qVXMGw1zDmmCAcw001K6csX1WoexTG/mls+8wOaR+l0/IkeS33hVRmJZUY9oIY8AHlma14g9M0eC5vwWi6k5wok1azwWgMHZYD+ou0C3ng2HOHpinmD6j3Z3kGwJiR3RA8lOsXnfbnf4jYbJiGmZLmCedrAnyWnrePxJwzxXbMRkZAEl2mpAFhM631WkuaRqF25+OPX15REVZEREBERAREQEXtlMuIABJOgFytp4d7LQA+uYETlGvTMdvBTrqc/Wueb18YHh/C6tYwxpI3MgAd5K2nhfsa3M381xPNrTbztPgsw1wa1rGDK0WhvIfFbN7O8OLiHuvynT+5XDr9Lfnp25/OT77ZXgXBKVFoyMAMd/xKz50UTGQvbisNoqiwPGqcwYWae5Y7GslplZqxq2MkAD7CgbXLM2Z0NGsgTa2n3up8fUDZ6fVYE0XPkzY3jkrConY2tVflblYyYLg2XETtK2SphAaIfTl72EOgntOA94X3IlYinh8rbyCPvVMNxF9N3Zh0XuJAHKdlphrXEcC97i9gL2E2jVvRw2P0VzheGez+pWMZR2Gk35DuH0Wyzhq5L30yx/6jTL2OJ65dfFW6Hs5hXGRmfp7z3O+JW/Jnx/6172Wx5ZXJvke6PPQ/fNdHasRT9n6YeHBoECIWUYIkdVmujIYCsRbl8FkeJ4BuIYwOiWmRymCBI3CwtKrCz2ArAgQrz79M9evcYLHYE02xSptaT+0ADv+wqvD8A5vacM3SDflrrrqtzy3WF9tsV+Rg6lVpa1wbAJ0BdbzV8WfJwz8RMcKmKcA4uDOzJ3IsfWVqkqWHPcSAXEyTAk99l9NCPeLW9Jk+QmD3wu0mTHG3bqBIUktGgnqfp/leCZVR8REQEREBERBuHBsOyjfIHP/c7b+IHxWTqYp7ou0gzESPmrn5LW+80zMaWv8Avn+lO28jSw6TovLbt2vVJkyK2Hx7mGcg8Zn79VnMB7VPEBzYHMaLEvYAI1Ou0Ex6FV2vg6DXl9/feiul8N4w14E6lZP80HRcqwmLeww0x0+nJbbwfjTX9g2dymZjkd1FbDUcIWPxD9QpX1N1VqmQsqxONwodytujcK0NGX0+7K09o3hV3sINpv5JCqrqbS2J156rGvwsGWvAJ5791tFk6mFJkmOii/0Dd7991qM1j6DGl2UHM7SABA66ET0W28HwwaJIvzub/VYvC0WizRCz1B2VoEpqYtOFlUewqU1FG+oFRQq4wAxKu4DieVwAWu47gD8zn0nmXXg3joJVjgrnF7A9sOIINt7D6qPT+c5vPt0rD1c4BWB9u6FN+DqfmuDWMh5kSCW6A2O/RZfDPAaAFjPaXiDqWHe5jc7yCGtzZS4nrzidF2jxX6/P8AiKhN2spuEyAHl0cuwahE/wDHwVCrXqNvlDf/AImD1yhZyviaVcmWy+bsqNAqTvlqU8hfyhwc7TsmFjRhqcn8usWO0IcTFjpIAcT0yeK6OTG1MU9wguMHbbyUTWk2AlX8VRrsEuLi0bh2Zo7yCcp6GDdUnVnGxcT3kqo8OEWXxEQEREBERB05+JZMyQCd5IMQeV4lfQ0uBh0t7u/WNx9VYZVcSS5gIBNzDRbS0dk9/NT1KQyy91nNNhJnugTPzXketjsTSIuIIG7eo+SqimSAOZi/d9IWRo0XteWe8wSbwXQdJkDSy8VKQM9oAmLW7Xdtt6KjGNJBA+xGvxVik+IgmZ8fuV9fSiwmL2Pl9lV3tgTpubdPhf1VRtPDeMkQyobfu5d/1WaqMkZm3GvetEw9Q6H1iOq2bgOOj+m4226dFi8tSr7mSJXxj5s5Xa1CO0BbdQvw4OiioXUYFt1SrMIV8gtC+flT3/BWM1jaboO88lk8NiATBF+S8jASez57/wBlYo8LcLjXb6/ffstJqSq87AD7uqtd53PdCvDhz4nU/RfX4QsbJYSR/YFXE1VwOafqveUurB7QLAgkd6iZncYNgNQCvPE/aDD4WmXZg994aDqfufJakTyxa4v7S0cK0/mOOaB2QOf+VoXtD7QuxbS4Oy5HQW7MM9lzhu0ESdbdoQWX1H2h4u/EPdUcbPItNhrBHQjyghVcBxI06ofq0gNe39zTAcOukrrOXK9L9eozEnLWIpYhsjO73XkfpqHY7BxvzLpkY/FFzXGniGHM20z2xy7Vw8RpM2iCApuOYUNdIMhuVod+5jmzSd17IIP8eqjw2Ma9go1rtHuP/VT6dWcxeNRyVZR0WvBBovzRoAYcP+Os9Wz3o/ENcSKjQ10+8GwJ/wBzRB8RfWxUWNwTqZg3GxGhBuD4jwOxKj/1T4gnMOTrwOk3HhCD7XpZYJFjoQZBHS3objdV7K0yqIMDvabtPUbiPPqvDqIIltxuDqO/mOo8YVRXREQEREHTP9eWF2RpqOJn3iOsDuVsV3OEPaWHfIZm2hnUyOqgqOYxp2buXR2iNxF3dwVjD12v91ht72cAA2sIGlvgvK9aNrhk1JkBt7OuflfS19l9GHPZykXBBP6pHzmLhSHCAixEE91osfSN1V/ILHSHTeSRymx8JhAqPtD7ZeyLc943KgfSkTsfGPu91I194dcc9h17+vRTNZmBcIykdALCdOaqKFJkHfU7brIYV8m9uvPRQuph2lnAXtH3snuxfvmUG/cExQezI49obncbKWrRyGNjp0WpcKxrmukHe8TstzwuPZWbAIzRPes2GqrqUryMPOitPpFp6Fe6bLqSD7Rw9x6rI0mQvOHCtsZuukjFr6xi1T8QOLCjhy0OyucCdJOUamBeLi40W2zC5L+JPGw6Q0MfTBykE3aQXCQRcXbE/FbjFaVjfaSsA4B3vEA72aXNWEq4pzoc4ku679om/wD5FQ1qkk8pJHiVHK6SMWpTUsW3ibdL/frzUKIqjM4ZxqUgDcs/pnnkec1PwbUF+jgFhle4bVy5590th3cS1s94DiVHxBkPJ/d2vPWO4yPBFS4XGWyPNr5TE5JuRG7CdR4jcOirsAMOblOstMgg6EcwehVVWGVbZXXG3NvUfTfpqiIi3kQfvqvjXEGQYI3C91KZb1B0I0P3yUSCfsu5Nd/9T9D6dyic0gwV5XsPtBuPh3IPCL1A5+iIOlUMJlM1AOxIGsT+74+ikdiCXWiAQ7YSTv5BWq1M1HBuaJJ5WaAZ01cYPooKdFrZ7MS45SSbjrygLyPWYmu5xEEkTcTrbu+e69YfCvzEm4EWHPn8Lq7RY0kOIEN0jqdR5HzVnFvkm2XnEXIidr6C/immMMWZi0vkNNgBzAIM7z1Xl9IgdgyADAm32VcYQZboTOsiCdpHP5r5Ww4AGR0EWvoCdZ59/RXUxVDJbmiDEx05/fOF4c6Y2mD5/YsrzHDU32JB5RBj0VbEUXu0bMX5WQfWP05TcAc945qKjjHU6vYdBkkDzNhtv5JQf+kgXv8AfRV8fTIIcAI03keuvjurPqV1Hg+LFei18QTqDzCnfQLTZan7CcQIJpGDEOJBnX6iD4rf/wAvM2VbymquGcrzBZVmUlO0q8s1jfaHEZMPUdmywNeS4F7SV879iXFwkb+69szvLyPHwXYvxCxb2UAGG8yRe4HddcMxb8zHEWgzt+kkbdHtH/Erpyx0xaL28zfnr3rwtsCIiCaj7r/4j/u1S1nZmNdu05T43HfcOJ/koQYaepHkJ+o8l6w5mW7OEeOo9QB4oIEREEjKkW1B1Hz6HqvpZuLjluO/p1+CiX0GNEHxFJmB1HiPmN14IQfEREHVadUZuTJMTcwAIPiL+PVTYnETAJhh0BsS07jkT6ArGPfDgSfeDQADsLEel1OcQKlVlNxmGuzO5QDb0cvLj1au42oW9kwXxIDdAAQTPOwK91cVa5B/SPAbHqR8VQOMLZMHeDtNyQT3EheaDxlyn3i6x5NN/imGrYrxlc02aBba4+XzUrIyFzgIBuImQek+qjwFOWw6I00F4tIt1HRWKtRpGUaN0PKRp3TsoqhjKjJGQdnpMi3w5hTUa72uAaJGhva+14+wrFCi0S7K1wIm2oI6T9wlB4kyJuDoCNSI7lRFicMXjMx0G5giFiWufmLXjTnaQBpC2l72NOaDEXi9+7lt5KDE4VlRoBtF5tbx2U0xheGY4srMfB65R13XUuF8Xa9msRA9Aubt4aWOu2QYvynmrmHAY+HOcG6gDQ6TdbnTF5dPpYhp3C+lywGAptgOYSOkyOayb69rrUrNjn/4q4kRl/aybTIkwRbvB8FyPBvElpNnecwR5w5w7yF0L2/4gx9R8G7W+6bZmjWD5jmJ6rmtVkHpqDzB0K6cudeXNgkHay8qxXOYB+5s7vG/iPgVXWmRERAREQS1jJzfuv47+t/EKJSNMgt8R37+Y+AUaAiIgIiICIiDf2MdlBNi2TPS6+YWsW5qjhY6xqJmD3fRRYyo6WNGkTHMaR/2UlTENaC33pABNri0HpGi4O7Ikh+SLXBAnUSc3pZfWZQyP1HQ/AGN1imh7oe42bdvIa+WiGsT2YI2kdDYx81MXWYJLGZM3uCes7j0PkvmGxLRDsrpvmMbaRCxld5tYyd+g5d/zVsMcQC2RmMH+RFj38wpi6yVPEsdcuNuUzHKR1Cp4hxa4BplpJvqdNO/TzUQp5LnWIHiZnp9QrbHszw4HQ6jQ287IqajxEGx00H9+WilfGYPDiLd4g2Omv1UVOow2IbDiBJtHepWYWSYIkTF793IhTDVk1S05Xk5IImALLzj2y1uV0t2UTzIDTFget/DXwUraPZOU35Tb+6DZeCSGCVJxjEFrHQbx96rEcL4rAyuBHI84+CxXtNxdj2QHTtH3Hkt8xjpzn2jxed5bEOaTy0OoEfDvWIZ2hl32P8A+e47de9esXWLnkyTBgTrA2PNViu0calYdjvbuOx++qiUjnTrrz5/3UZKqCIiAiIgIURAREQEREBERBvJ99v8fkqtT3/+P0RFwd2R2P8AEfFVz757j8SiIL1T36f8Pqvbd+5nzRFGlh//AKg/l9V8xmo/ifkiKCOl7ngP+qynCtR3/JEVHmvt4/NeKXvnwX1FIJR7p/kVqXF9X/fJEW+WOmnVdT3leERdnEREQEREBERAREQEREBERAREQf/Z'),
	(2, 'data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wCEAAoHCBUVFBgUFBQZGBgYGxsaGRsbGxgaGxkaGhsbGxkbHBsbIS0kHB0rIRoYJjclKy4xNDY0GiM6PzoyPi00NDMBCwsLEA8QHRISHTMqIyozMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzM//AABEIAOEA4QMBIgACEQEDEQH/xAAbAAACAgMBAAAAAAAAAAAAAAAFBgMEAAECB//EAEAQAAIBAwMCBAQDBQcDAwUAAAECEQADIQQSMQVBIlFhcQYTMoFCkaFSscHR8BQjM3KCsuEHYvFDksIVFiRjc//EABkBAAMBAQEAAAAAAAAAAAAAAAABAgMEBf/EACIRAQEAAgIDAQEBAAMAAAAAAAABAhEhMQMSQTIiYRNCUf/aAAwDAQACEQMRAD8AuJbqcLUYatl6569DbT1Wd67uvVG5dzRovZetvRDQP4xQO3dohpbhDA+tLWqd5j0Tpz4FFKD9KOBReuqvP+tmhuuWiRqlrVxVYdoyLGsTmlzXaVWJxTRre9LGsuwxFXl0eHYFqNKFNdW0qa++9gi5ZiAPcmBTFa0toMyJYRwgKs7HxFhyeRAJnI4iuSzl2e2oAI8VOt6req6ajkiySrgT8tiGVsTCODzg4PMc0vtdKkqwIIMEHBB8iKk5lsVu3KD69pqb50iqepaqhUFvjNcoKlvjNc260jKiekatawiKgQxUOpvVrjWNijebNbs1Wuvmp9OaqIyiwwrtau9J6Rd1L7La4GXdsIg82bt7cnsKZW6BpLKEu1y8VwSCLaz5BYLR6zTy8mOPYmFvRJumrXSutvaaJlaudU0Vv5QuWi2zeVZX27lY5GVAkQIHsfOlq4INYZZb5jSY/K9A/wDupPOtV59vrKXvR/xx6gXrlrlQh607VjXfG3eqN05qw5qs7UQskmnNEbLcUKtPmraXM4opR6b0ZvCKNil7oR8C+1MIrovUcV7ZVXWDFWqr6oYp49py6KXVWgGvMurdRf5hE16f1cYNeQ9eMXTVeTo/F2LfD1+dTZk/+on+4Uw9C10lsSSzfVJE8ySTHnwPy7pnw8Z1Fkf/ALLf+9aY9O4S84AwbjGD7/qK4/Jl66rrwx9uBzqvTnuIHCWy4yIkGRwVb6pwOxHlQi6p1Uo4Caq34SMAXlAkcnDj+Q7iGi0hdA7MAIwFmI9Dtz9sYoF8Q9KDDfaDI6ncCNu5oHAJbcCBORn1Ha9fYz3qgSWj35FRam3RrSaldVuVoGpQAsANougz4gP2sfeDQ/UpiltpOYXrq5qIVa1KwarGtZWWU5dl8VUvvVoJNc3bGKuM6DOc0x/CvRjqGLu2yxb8V64YAUdlE8ueAO3Pvz0D4abUM9y4/wArT2vFdusMBRkqvYvH5cnsCzat/nqmj0ifL0xAKggF3ELNx8zuiD58Y8pyz1xOymO+1tLvzf8A8fSza0tuGO2fmXGBn5jO0R+E85j9mKi1t21btkC2Q0QoJkgRkrFEX0S2dP8ALt73UfVCbQWnxHamSY754HrSr1jVEpHzG28bW3BTHYqe/vFY3jmtceeIh0d4PZ1KtnNthPIbdH+0tQPU2KL9GSbepnytke+9R+6ar3kq8fyWv6BvkGt0R21lG1+pvBrhjUhFRuDWVrpkQO9VXerTWSawaalsaVraE0U0aVza01XrNqKe06O/QD4F9qYhS18Pt4FplWun/rHFlP6rqq+oGKsVDfGKMe0ZdFXqqYNeUfEliLk1651Jea8w+J0/vK0z6Hj7C+nSjq68qwYe4MimrrCgXnHYsHHnDgNHEd4+1LGmFOeu0pvgG3HgVEuSch0EA+oIMfauLzziO7xXV2O9IYNbDqpYxAliJJjJxOcZPaMcV31O24A8IJHbIRR3wD4j6d88VT6BrV2zB7qp+pnI+rYJwAd09p+9S9T6gm3mX4iA4T3VJAPoT71XtJixyxvs866xqjavpcA2Op5UnA77oJ5mOfxd6Njqli5bt3HXZ80ujtH0vb2zMH6SZOPOhnxBpbjGTbIQ5G4SJmSNpEz2A7iKFaO3cvhLbEJaRixPAJCn8XntTmfP0pY5DLc6MGl6It4lhdUqGglJby5jjvzVq/07S2kLlC4mAd31cfTH9ZoH0P4gQX0sXLZCv/dgg+GQPAYHI3Fp9/Sueo9TY3EF/wAJtk7jldwDsqM0TAOwGQO+BXRjZPjLK2jt3odpm222ZTEkHxBQeASODFV+ndIW5cW2zgbjAHBJzPIxEGapdQ+KraKm60S7sS4RiVIA8POSTO6DPMTVVdeyXk1Nso+9mKsgKmbinwOrQYAJ8U+X2WWepxCmO+xn4h65uUaXRIRbVgkKjHfJKs8AZMr3IxEkTVnoF+2oRP70TO1mgK53b2c7BCyZO2e586TDorupuNtRmglmAMmeMt3OJiTx5zTLp9XcsotvU2wFIyzBQynkLgjcZzPM5mFDVjK0oz1lL6KzWyWUcSTu475Mn7yZ5ERXnNy9de4TdwZmCI9oxJHrTRrPiK/bg2rihIgh1Jbjks5eV9p55NAN39quyAqM3IDSJ9DPE0Z3cPCaoj0to01xv27iIP8AQrMf9y8zUNwTVsOq2FsgeJLlzeexYhYj02wM+VVXFbSfxCl/qodlZWTWVk24NtckVEXrpGqWu0yJNWLdiorDVeSosErFtAV3trqa7VaqQWj/AMPnwimhOKVuhnFNNviumfmOLP8AVdVHe4qSuLnFE7Rl0XOpDmvL/i3DV6n1Ic15p8X281pn0PH2XdMxNPWp1DDp1z5cK5ZiWgHFzxj28LRPYqfKkjTJRtr7/wBkv24BT5Yb1lWnaPQyx/8ANcmfMdU4hZ+H+pXxcFpLrJvb1hucehMQDIjzFevWrC2UHzLhc8gtE4HbFec/A9kJbfVOCAhIXcqEMf2VzuDg5GQDJHeadhdNxA7ruDRsUqVmTmeYxt7ds4qMtJt2D9U6lcuQo2radVAIwVZmhOcbWBA9M+VBk07hWL3GHJZThVTKv4m7Bg5ExvDDI8MNOpCA93eGT5aKZM7ZBjO0EAz23D7rPxHrBZIdgFZ1QDwx4VMbTkTA3YmBBkSZowicqHaK4BrHwitbG23b3MVUlpZgTh2mYjE94GR/WNM1u4CwnePmHMbiZaAd0iIUgDjdxxNr4k6eLXytWGzccFudoUgECI4+rvxE55l+LrIW/bOwqdqzt3EiAIIY8GCRIwIJk5raIql1CwvyrKMflkAMpgsNxBI9doPhJgzj1NbLOUzuV5wEWVYvJkeRKq2cY5nFS/FGl+ZqbOn3MWOWHJWQC0d/OPLM94ovfW0y2GJJA2kiUIJMHIPkPqxPpEUEJdPuXrO+5v4MKZgvyTt8hg9onMHYVJ/pXxF88kXrYkeFTnwiTA9DHf8A5qjqrZIFv5ZAWNpX/DcndJjyke5IJJiCYNTYQDa1wSpIAWF2mDAE/UVg+L0qLFSq3xnpHUfMRyUkSDBAGduTiTBMCT5xiVbpu5rqGSMjiJ+04/OmtPGTYuMzI0hWjIMwSJxAIj37RMrOkUW9TtWYVyBuHiO3iR5mnOj2eeuuNynYquwBubTMuAMn1gxx2oW5xXPzWclnMseffvUhSuq46wkZY5by2r1ld7KysfVvsbLGrFtawW6kVaz032ms1aV6rLXc0epbXEerSmhiPmrSXaNAxdFamuzxSZ0K7JNONg4rafly5/pLXL8V1XLURF6AeojmvPPi23ivRuojmvP/AIrXwmrz/J+L9FbTLTT0dQ9s21MOzj/29/40raY05/C9sBHuGQfpH9H+sVyx1+T8t2tOtxltbVKoBIELvPnxEgiOZx96JLpc7mXABMcnvmGGTBzUep6hZ0lotecKDHrJjAURJ9o7VUs/F+l+S2oYuUXAhCzMQCI/7eD5d+1LWmOwXqHUVtX1JVjmGKxmfpUyJU/aTjyxS/6j2BcbSrkC4wEmF+uN8g9+DI/lOtV8S6i4rPasIitBX5lwF9vIO0kRIjvwPah1v4ga81tbyBWRwyMPEm/tHkPLLc8096LWzF/1I0JOjRLY3fKKnvIIx4fM5bH8YpP1d66x0zOQWRUENkJvVVA8ieHzmWHlTL1rWXlKh13IxmeYbMCe/J7dh50M1KMsY/CTknIH0liRiQB+nEYeN4KxvpOnnqjNcBOxVCnO2QgncT9UAN5yZ75qP4r6eW6nZKgH5jJOBGPqkDvEkj/it/2m5bu/3cu5xJ+oDdIBzECI7wIB4FRdU1pttbu3AWuhWCjEgHkyOCJH5/me2qNCvxNrbj3tlhGYJAJMQ5dSNowexOMc95xJoLZKiSBMTAIJC5YKoE7QR3x6yKU011+5cY/MVeJEFlE8AyMnjIov07q15LpsPYW5cVd+5HjduUEMRB3HI9qrcpaq71DSbxI+tBvWGnduMtJOAcyNrDz4BgQtu5cJ1G2SpG/cCVbjaQTwY5HlBq3pviO2CVvK6TEFk8IJ/wAsk+5zjkUTVLbXGCkQ9snEwZAggkRnI58valILQrUuGuMwEAmYGfep7aYofbolp+K7Mpwyx7c/LrKmrKx02GCKi3VjmsRawldaVCTUwStWUq0LdG01TcxWhdq1cs4qo6Ux2O/DN2XI9qftKfDXnHwzIuGvRtGcVrj+XN5JrJYrRrdaNJnegbqIpC+Kk8Br0DqApF+J0lDWuXOJeO8kSw9O3wlcDI9vzIM+gmaTtLoLjmFWm3o6PYtuSsnbgYPPaubHG7dWeU9QxtE2s1dy5qPFp7JKqGnbuGOByJ5kH70VOlt39He0lrYjFSoAgSyxtwOx2jj1q1a072dKEVdzMV8JO2ScsQx5OPKZpJ61pWS6LlrehJ3Ky75RgYKmPxTHIhpJNTlzkzx6Weg6i1fsHT3gFv2wUIeA2BtnP2x6VV+I9JasaUhnUu0KgU5xAMdxHma1/axecLq7CO3a4v8AduRn6isNOAPseMwXs6PRHS3XtWibu0LNze7LukDa7GB/pPOKyuH9e2+Fy8aHulldZ01HgM+1AecOpWSYzEiY8qBde0RtkDJ8EZ7TzmcmIH271P8A9M9Y06m1EoHVgcR9IUAR38IJpq6voBcKsxAAO4+pAxM9hWlslTJuE/oHSwNQhfg2yfMZCnn0M5juaVOu9Rtt1By3+GsID+ERz9pkU9db1DWLbG2QSoO3zg8jn8s1518MajbfW4YO4sHU5LK3I9TxT1LKXWhvdprW661xTuA8IiTEkfvNddEX5XzdbeBRnG20piQuPERiBhf15qPX6+2rk2dLaQr+IJLnODjBzzg9vehGuvXbhBuEsTwIPh5yMY9/+aWGHrzsZZbWNRdOpJQKoWCQe+8eR79xGPLtU3w3qHRXRiSUYqQeYYEcnBiK46VbZQHgDMwSJc4iAO0ke+M1lvcl+4uTu8TD1BMxA/qK18c50zyv1La5oppxihKHNE9M9dmXTLDtZ21ldTWVjpvtf21ItcTWleud2L2nFXJFDLTxVkXKksonu5FVtmaxr1aRpp2jGCPRcXPtT/ozikHpSxcBp50VwAZNaYflzeaf0v1omgXVPiFLfgtwz/oPekDr3W9ZccqlxgggHbgSe2M1WmZ+6prbYxuE0rdR1FsqWY+ET7/lQ3S2vlovzDudvpUzGe5nvWuvaMvaC23IPJHGTwD6UZZ/BjiE3dZ8tX+WwPBwJkHjM+GmL4et3NjfNKy4kqMkSMBp+n25pSu6N7R2LtNwCSw+lQOCJx8z/u7ds5Bjpd8rcErwFOcTES3iMk5Ix3qZkqw4fMtm2rSF2GCMdufqHmKQPizX2xqAqKy3GAbcAzK6/wDcqYJgDGQe/oW+LOlG4T9QR/Ew8O2e05PlkxFQ6Tp9y2VLD5iY8RKs0+YPfnmP51llxVzmF/pytfuAIGXcDM7IJxyiTsj1hsgYo/d0ZS38sYL/AFtnxfc57mPKnCzpgtvetsl38JI2S0TGZoBdZ0Yvc0l0AIHEAXHLNygUHLjy4zg4yUQK6Vp7ti6tsLCOQ3AEwRvZpnGYC/8AYTNG9X1i0SU3jHOfQ/y9v0q11ro9y7aV7DhHUN4WEbtyxtJ/C0x4sxnFeTXSdPcdNXZUXARkwZDfiBPNZ+u92tJeoK/EXUQ+LThoMGDPY9/X1/4oNY6cwQPyRzGDMwOOKvfDvw9c1jNcG23YLEFh9TbT4to7TxPamnrNu2j27aG0oIbduYKyhc7goU7uD3H61f54jO88lUWDek7txGI49cmDMDsCe3uBl5blsG5ctuEnbElCSDgGc4gdhTj0bpBd/mW20zzuO1GdfCGG3aDMnmZxPnFEvibSeFIQGBxJ5MdysdvMVW06KPROrWxs+YsMzAfigL2AkHj396v9VS3vc2WBn6gMjzbbIzkDHaMcYCafTNc1BYAIwyAMwBOZniJ86nYwfDwODn8/etvDjztnneNNW+aJaaqPPiHP4h/8h/XPvRDSia6r0zx7WZrKk21lZtdievTan92pxyaq6O1cJDFwRih+r6tcuXDbU7UJIJoxoNG6iPqHI8jWWwPO1u2swDjt51SuM2Cdqg/nVkIAAHABj8qX/iPWXDcVLX1ERJ4qZT5WtS9xWgQauaXSXObgwe4qTo1gC34jLx45yZrrT3Pm3MmLaGOeSP4U/Yli0ZEIOO/8qi6x1U2LeGJYjueKuaS5O98BR9MelA+vWy5BYBQeD6edFyOTaLpeqe4pYHE7vFP3nzqz0+yWufMuHCgwMAf5jVjpWjX5YIAIzDYyO8+lVNfqGu3BbtDwoM/SPEefepUzTaouzXGI3HAH7IE4A7tVR1cuX+ZNtZMzIQdpJ+rv+dVtSty0q212rvYsSRuEfsnz/dUPVOpLbXZucB1IckDaCB2j+vSopr12xbuWmuWzLQcHvtwDjI9jUenuBwgWHcQrvKNcUk8BeADHOK18PaH5lt0YBl271ON2ZkZ745qHTakWbYW0qBCSWaCdoESfN2MwSMAHgDNP/S/w6WPFb2na5UbWBAYA9pk5PpP8qHrq2S5ESpwWbwAR29R2xNDU6yoIvBdibthVuSI8O2Ocx5x51rqwTUFdpO9jHhMuvOGjMY9O3nSvJnnp1z5i/wCJA7FVGfSXmR9hSp1DSolwrbt6tyAynxuFG9iW8TMASPIcD0qToD/IBD3HdVnJOJgeAHuFkS3G5gMgSCOs1dq/aJe4Qp/ErEdyOR7SPdaWWOymWlPT602kA+XdxCjc4eFUQGJnkjvSH/1AupqFS4U23BiZE7TB2t27yOftTo3Qi1tPkXQyHJPJIORHpEUB6p8JNc8W6TOd0nn+pp44+oyy2s9E6lstKltUKIihRMHgcnvNV9co37h/ZkP4C5aZYy4JkTIHGOMmu+n/AAiy4FwqT3Ejz7d6O3tHYtqovMGYYk+ePy7H7UXDfImWuEfQumKGO+xaAUSj2xHhkwI7Zngke1QfEWttqflAku+IkuQD5gmfyIohqdfCI1tYRjtJEAqRIwPQifLIqpqkTab7JNwCTEjftE+AcgxmO4nuDVTD4i5fSvrrC2VNtfEz5flyvkWiGX3CmhDWIG5TuXzGY9G7j7gTVTV9RNy61wdzIz2/h9jVu3qmOTk/tcN/7hyfUzXRhNRnl24RoM0T0xHah24McwD59j7gce4/LvVvTmMGtfiZ2KbqyoPmVlQ0X1RL94C2o2pz2mj3VdUlm3ubEYEc0O+H9ALYDsvjbOO3pUnxXpRCkgkk59hXMsEPVmfdcuZAEIR59pFXOk2GdvmOWUxJB7eUUOtaP5txEtrsQRumRu9jTRrLvywqKAdwgDmg0d2/8xvl2Qxb8T8bR39zV/U6QW7SIP2ln1qbQWFtKGWVJE+IDM9qEdS6oVvBHgBszyQfQUW6KRet3BBQjaJOZIDHyoNrGuXr62/wAZJEgL3PvUtm7dunbZA2j8T9z3gD99C+mXL39odNxKzBhd8keUY/OpUZeo6q2LZS24bYAJGRnEYxNa6DoSi7mgM2ZEznzrp9NDLbUAgAE7QognzEc+9WOo60ooTbG7AImJjktj8hQCx8UoHvoOQBtIAhj3+oHvxNRfEnTWa2qIn0AvsVZAxBiTnHeftW+p6Q3byMCTtywB8SyIIEASfWTW9H1K26taa4xdMKTuJgTBdlMSfI+lHY6VPh3Utb/CWLgKEYlQCeAxHB/wC2J8yByL6rbbePGhdRnayhR3I3CAEEYgdqls9O3F5U4G+NwICwQSVk7j6miGu0iXbZuW1VZBY4DYHBkgA8fY+c0hAZNQWWd4ubTLW1LkMDgGSpB9Bx3zRLpGpPzAW2rcf/AAg0qot5G8gcMSCAxBIVGaIAqn0zVW7jkOHhM3AzFUJ/CF+WAIYiSPIMcgGret0a/La6qSzbXfbu2MowiCRGwuqjaMqisBAMUCuPiHrJAa2u5cAEdto+lQfwnxFm/wC5252iuupa0ppCB2c2xz4vli2haPJjbBA/nSvodS/zwl9WY3HRXnBILeLEcmf30aXUK+nDed1vI+KS7E+p3U0pei9av22B3xsHi8oAiB67j+tGdH8cXNoV0VjJz/XuPsKUwxKkRyZ5575/lXLKAwC8ydvrGD+lT71XrDNf+LL9wIAAsYePPOfaP3UOu6u6Gb5j79wjPPPf+dDtMp3Er2OR5jM/w/Op22OwDdsfxBx34Hrij2tGpDb0rqO+29tRuMSo88KCufUr9j9wL1+tuT8t5UJkqhIOzliswQ6/WpEcOJzV/wCGTb+YNpzBHBzwCQfaoep2C1w3Bgk7l4wOV/IRW+E2zyuivrdMZNzG6R8wL9MmIuLAEI8qYxBbGCAMsnFF79iFJUDwqWUHIKZL2z3MS/8ApZj5ULCAQV+k5HmPNT6j9cHuK1k0ztbNWbL8VWaprVaFO1zfWqjrKjTTb0X+2IADjyEDFCOvaxZVdhJbCwYj7V11HW7ZtovhT8QXCn70uWNY928dwkgQsfqfQ1zNDXoLJFsTwo+oxj/mqvT71u5eDM5x9PYD0Jqw1xbdkqACMAyOCe5mptEAlwbRJIxA8PtmgljX3f7zbvIAyDAj/mlPWWle4QdzciWO0T6e9HeqOYOADPaBtHl60uajXi5cEmUUgbSIJnEk1G91etQVfULbtkMm1Su0EPHA4xVX4Qc7XukbEWYG4y0+n8aG3LZdnESi4SDA9gM0ZspssJaKBN7AnlmMfvk+VPRGDpBEm5BBk7gYkzwDQf416g9tAyFQq4Ezuk+k5WiXTdYGLEEqtsBYgAbjySe1Dfi/T/NtGI2iT2/gaKIqdB1xuKHuOGBUldoLEdjvUSI/dS5qkXTXypWVcAgnxR6yAffAoj8K61rdthtlJ2DKKC37OSIBBia6+LdCnyBctKfA8kbPEoySIiFSfz5o6LsItM1u8ZbarwbZIIV5yVJY/lTB8PdRNwG21zknbNwCYzAESx+33pZdrd+2BvKOi+CSNzt+0Me4watfDOuufMe4qj5ltYaQBuAwMx+1BORgHypU0Xxf01rd5URFRW8T5kbjhnbJhVA+0MfxUR03Wg1sWmKLDSqt4SLanbbVixjdtAPOQw5ojqdT/bdPKqnzCNjFd0HdIMu6qCu2Rweceded9VVrV9iRwwKzBED6RPoIH2onPBX/ANM/UNLbe5aa2ADvBwsQVMkeuY4/5pbDMtg25Mh2dSO5Vba4/wBLMfPwirvS+pm5eTcCD9PhInxEDvwoHMRV/TrZIbdG1LmYjxI4KMZHAIUZ7QaJvE+KVbepZeCRx/MfuH6VIuraIjyg+XH8v1ot1jQKrFlXncRERAIEx2EMImqNqyVUmOFYiR58ZHenuFpxZ1b9pysEczmYz+dcPccngj1g4n+B7/aiemvoDJHIEiPxRxRTSaq27LCq2M5g+RkEQSPyM0Siwd+B9ARbe5c7iQZxPOPyovrgP3/oSB+kVXs3tlsBBgLLAYjGM+37651NyQf8z/wro8bHIL1B8jlSHH2+r9M/6fWg1uOBhXyufoccj2zHsyk8Vf1tzad3McjzHcffihlkeJrc4Jwf+4fSfYjH+qe1aVMbYVPpaju5Abvw3uO/3H6g13pjmqhCHyaypN1ZTC2mqX5DtcuNufEbTA+/eh3RNHuuAlC4U5AaDnv7Cj+n6bFt1AMEAgk9/MDsKB6RSb21dyqWy8EgeeR2ridBl6teEhF4UyQRuU+9d9O1yspDZKttBUMSs+tWNRYcLuVkKgEGBM+XehumaQJttLeGFbaDnkiQfvU28qk4da/xM1sOeJ3wCMdjSlr9QSp2boUw8Jg+WRTN1C0mxwPDiMj+PelXRjcwAJKoQchiOcSB2pSHTH0TSobaFgVJ8Q2hjuHHiHn602X9EtxQXxsgjjtxkGl2xqX3u6HYltckEeJoztWOKN9D1bvb8S7t4lWgbfvmSaqJoBpnC3XtqrHcxMHCgY8WDBPuKM63ShLcbwUMzKrub7nn2iqHW0a3dQFlRH8LbpPr2PfyNWeqlP7OSrboG0t4oHsTj3ifegEvVXLaO7IVDArGFU7QV+lWJzg+f2o5futftk/NRAVPYuVjkM87d3r++ly6f7u4zNhiEEic9iWxA7wCeeO9ddP1W5HR7n0wCSSRkwqoVOTj15qTBdPq/l3GDgSpJWRBJEwsr2gmeRV3UrlbiHLMCQilgQsoPFwMl8d5ntVXrmkClXVSRMFhBVj378/lUd8o7wx2hgIndMqscAHmJ579qZGReoXLTIrkqDOWUnDEIAWkcfVz6cCp/iDpC3UhXTeAGY53GQTgxH+kelBNaq3Eh87YUMWg4AXdsBg/vg1at6ZtPbD2tt3wzC/UoIxOw4ExzznmlThc/wDpOottIU48QOIIUz+8cVn9puW3YSQswJ4GZRs8x4T9qb+maxrlsH5YzKMqhRAkQ2RySeB2ExVd9Ul22yXLQlV2gkydzAMpYySTA7nkj0g9i0WrPU2wrfUrMRuJ2yx8Sme3eTwfeRGOpuDGAAeCOJEEEfkaZrnQFuW/CEV0XLFsuYXgd4yKp6Hplu4kMAGUFSOODgieeYj2o9ofrQlderAb8EfSeREnwt7HIPrRPRdRtKo+YCN5kssc94IyJMSOOYPaiWh+B1uORuOzBBHMH09DiDRvpn/Ty2j7muMwGR7+opzVTdu+n3HNotcB8cBfRRkz9pqq7nbnzP6gUZ6vcAVgABsUKORJPMfb99AEueAT5n+FdGHTPJQ1pwaHdwfSD7rj92386Jat5FDAeR6yP4/16CrqV4ndn9rB/wA44P3/AItUVk5rLbdjwf08j/XYmtLg5571cSvfNrKrbqymDrf1cIwgMWEQBz5ZoT0PUNaZ2ZDBwFUiJPFQpqSRA8ScCMR5Gq3TrafOHzFOO8mAexJFcMdJ3P8AhmVRTzHJH3peOoIvRbYO7SSvAQYEsTz7US6vf221VCXkTuA3Z7SaW9LrXRW3EATLAwe/5x6Uvp/BzqGn3KytcnAkQACfYcClzU6km4EgqhHC5Lbex8xRbqdxjaF0EwfqA5Y+g8vSlK31JmctmcgRgqPOeBRILTRpHVLbxbLm4CQOyKcTzM+sU1dEvA2QFYYAEwRBHaSBP2pGtoLdiLcnefG27IJAgCKu9N6upbazSE4WdpMCWOcz5Dv6VaV/4yeLasMNuBnG4RxMdsVc0muN+39R2uNi4kkgQ0qDheY/M0G+K+vptFuQYjcAVZ85xtOO3ehfwv1YhNoUrsLHcMmIkysn0GPOkFzqPQmZblvYcxsILBRBknbxJ+/FJOqsvZlT9J4K4me/n9qa7vxSGPyyzmQY+gATPaJJ+9VHe26CbeGJk5JBM7dyzyc57RUmA29dJUkwoyZCwYxGecR/WaM6iwL1v+6tsuzxAmFXETIUnnzNUP8A6GudzlVA8BMDcT587RyZNMHQuh3LTRvTaciTu3dhtxHPr2opRU6N09ro+TcBDESvjYjae5JMHniCfarF7S6nRbRauC4HgbQgOBMhCcDA9ah6/rb1i4DbZAv7c7xOZA5P/ihWp+K7hZCm4bcEk4by8Ix9valN1XEHmfeFICq0eJVWdgIPYgDtzicmoL+0lrlu5Lx9BAOCniMdyBJnvHHeg1nrrsx4Uv8AWI8JHczMyRI9jiiGkgn5nhAY5HcDaCEEcYkc9opXHRy7XF1Wwhlzt2u+ZJbbsb2Ev+lFTqkDOflg7DhTHiYLJyByRMe4HpSo19lDCACJXEEQSWjy/Kpksk3GaQd7SR2YAQJ+45FIH3Sa0Ah7auV2fTIMYDCB9yPt35pgXUB7e4AqYyIg/kaSekdRYQq7uPECu4A+47T3Hnx5NumQfLJuYxMbiYq8UZF7qlto2TGecQT6jmh403hiII/r+FENchnJP3/Qg1yi+GujGMrS5q7UUKuYajvUxmgOp5q6SZXrFuZqEGuC1G0r3zKyqm+sqvYHpdKbgYIAqjyxjvQ43ltHcpJE+Mbsn2HeqfTOpXHBtp4hJ3Ekj/zUHVGZQBHiBxHl71xOoydW1Sm2r2xgjgdh6xxVDo2k3KXucMeWALR+yPSqKahrqbSCgX/LB+/NW+i2lLgM5UKSYk+KPbFP6XxP1rVkWmUFV2GVxmBgZ7UodLtB2BLgHMyDAAzwBnFH/iK4rDbsnPIM49Se1LOikNAMbZJxIHbgd6MRkbuibfmvbCEqIaQZ7x9wat9f+H28V62SpIMjAgdzj8NUfhxl/wASIdpjLQNp5IByP41e6v8AFIVfl7g+PFsAE5xl8ACqSULvR7lwyCVgCAwgZ9RgD980O6h0+5p2G6QfpwSJxlgY4p16Rp0uzdUyByxKzMzABwPtW+oacOzK4QqPpX6fEYJG4qJk+VIyHq3LRcAA7Yjt+I+9cJ1FxA3woMgCfyiYpy0/SLJV1a2qTjc0ng52LHJPeaE6/oVo3FVLq2yRwZP6CTz/AEKWwFX7F19rSx7jmRPeO3ETRDSdC1jrBLIhzMkE4jgcyO1ENDoPkQy3kcHuSsTxAHcxOCY9RXPVuq3ym1HgLJUojKDmBEzA8qNnoM1PTPlk/PuMxwY3CT2IyTPrVQ2bQLKjb5wDxE8gecTVG/ddp3ZJMk9/z/riq6NGaeqWxIWFJXM9pyIOYB7wTRHp52lLYuCGI5yA+QM9hyfuKCG6zS0mRBOTn1/PNHeg2CxUusq4j742tP5T7mlZwJXN1blttrzsZxB5wDAj7T9hTHpeju4m52CmfzXIH9Y8jVHW7T/dhfQt+yOykecGJqK91A2It7y2/vOU3YJGfEuSCp/gDUa2rejRp71uyFRYN/6YMrOO2ImBUWmuaq5dILhVxuBA2kDJjyP6UJ+F7JuE3Lp3kfSxOJ7Z7Qe9X+qpdt3BdVGIyCwYkAR3ERFXimrvUNaJKiAQMeo9POqKa3FCNXrt49QfKOfLy9q40xJFa45Flin1+omaCX3k0Uv2jQq8sGtLWWkqjFRstdocVy4oDmK3WqygjB0q8GIVQV3DsVJB9qI9W0g2KDHsDkepmhHT71oIEbxNEiRG0/5vOp+oamU3TMYUAc+ZPnXNXRBazpptjOwxmYYN5ZFcaVHthsGG5YAz+X8aD6PUO+xLY2CZLuSI8zA7UZ6ghtDcdrnaB9TZn9lRJpkEdRh3e4xMAQc9x2AHkI/OlzQamH43FzCA8ZOCTTR1OyLdkkBdzE5VjiY8InMedLWgcLcXc30EsYAxHAz60YijjILCENhydsDI8QkxFE7nw+u1B8sERLMdwKnvOP14pdSTdW7duBJO5TBJJnkjsPX0pn6t19BbWLgnIAVv1Ikj9aqk703Tiq7bQtjap2tsncx/9SQZgZx51BrIXbuvBygEB5UnnxHM7TBxPlStrPiq6wIBBkgtI+oLxIBj8ue9Ar+rZiTxJkx5+dTo3p2n1/zG+W9vf4ASoaUkeQJVe3mTQ/rvRrtwm5bTYVUGACxiOIgD2x96Xfhnq7WrmGJnks2DGQAJEn716FpeuC4hg7W5aQYgHjf3kdj51N4OcvLEuXLVyTu3LJMic/5eJk0Q0mruXFydxJmXgxHOBx2/OmXrGme8GgQpbauAOQM7pJ28YHqaB9K0ZFrgBmuMCPLaB38pIgffypb3D1qqGp0xiTORiBjn/wA1xZ6OxnbE7RjPcH09AfuKNae4ot+KQcxgESf+O386vK6MHHC4VYkY4DR7AGiWwWAdnp9tApJ8Jw4OCCcYI7QT+lFrBt7CoGRG3kH8PBHYgEe8VXuacXFLFYMyIyOcn2E+/Fd2gA4B5EAjEZ9uxoIP6rr3lypbaxHIGfKfXt+XlUeg0bX4LiWXIAmW28++P9tW3tKSxMEADkcsZ/lRbTWCxVFhD55EkdwTwfbzo9hpQv8AWxaCrbAgEblgrB7xmP0FPrdQW7oxctuJcYOO3Iz3oHpPg+07hmkzlsnB+4yKJ9a6fZ09tLKDZgkeRnmT51eJfSXr7BVsiPYRP8KtdNtzVTVypias9LvQavDsZ9CFzS4pe6jag0y39QIoBr3mt7JpzqloVt1rqzXVypOoNtZXdZTIS0f+B/qrnUf4f2rKyuZ0CnQvr/0Vb1f+In3rKylRAn8L+z/7qV9P/jn/ADn99brKrEUT+LfrT/J/OlvVcn7fuFZWUyQGuDWVlIJ7v0LXoJ/wm/zWv9q1lZUZ9Kx7d6rkf5l/jVQcP/mP/wAKysqMV5OLH+D/AKv5VVf/AA19z+5Kysqk1PoP8N/9f+41xb/F7W/4VlZQlTH1N/lH/wAqY9JwP/6D/bWVlTVQ4dK5/wBVCvjv8HvW6ytceinZJ13b2rWi5rKyqx7GfQje4oRqa3WVv8YOLFbesrKEo6ysrKA//9k='),
	(3, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFrGnNhEwtB06CAGJ8Ffnfh1dWz07WVgwT-g&usqp=CAU'),
	(4, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTP9m2WpV2GtO56fGLQYYNeqfibpWpi2KRkoQ&usqp=CAU'),
	(5, 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT-XfFZZMOj6q6zb-Cux7YDKqterBymd2UcMQ&usqp=CAU');

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

insert into customer (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (1, 'Pearl', 'Spillane', '12 Scofield Street', 'Turt', null, 'Mongolia', '04302', '860-596-5229', 'pspillane0@ft.com', '770-189-8031');
insert into customer (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (2, 'Lorrie', 'Gillman', '3 Butterfield Court', 'Dallas', 'Texas', 'United States', '45031', '972-659-2415', 'lgillman1@huffingtonpost.com', '708-872-9837');
insert into customer (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (3, 'Sean', 'Whitticks', '5950 Havey Crossing', 'Busdi', null, 'Philippines', '76592', '431-727-6468', 'swhitticks2@mysql.com', '915-317-9974');
insert into customer (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (4, 'Sheff', 'Balnave', '7 Hauk Lane', 'Takamatsu-shi', null, 'Japan', '86274', '463-884-8386', 'sbalnave3@slideshare.net', '401-561-0785');
insert into customer (customer_id, first_name, last_name, address, city, state, country, zip_code, phone_number, email, fax) values (5, 'Nickolaus', 'MacGaughie', '4 Wayridge Street', 'Dajing', null, 'China', '64738', '763-779-0176', 'nmacgaughie4@forbes.com', '372-397-2821');

insert into invoice (invoice_id, customer_id,  total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (1, 1, 5018.71, '06 Hooker Place', 'Sishiba', null, 'China', '63167');
insert into invoice (invoice_id, customer_id,  total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (2, 2, 2917.38, '8 Hanover Junction', 'Baitashan', null, 'China', '10862');
insert into invoice (invoice_id, customer_id,  total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (3, 3, 1314.58, '7737 Redwing Terrace', 'Shengze', null, 'China', '21709');
insert into invoice (invoice_id, customer_id,  total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (4, 4, 3249.73, '15 Cody Way', 'Nýdek', null, 'Czech Republic', '60625');
insert into invoice (invoice_id, customer_id,  total, billing_address, billing_city, billing_state, billing_country, billing_zip) values (5, 5, 9752.87, '70420 Fuller Lane', 'Orleans', null, 'Brazil', '26765');

insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (1, 265.55, 44, 1, 1);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (2, 97686.51, 36, 2, 2);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (3, 10572.02, 26, 3, 3);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (4, 59247.11, 5, 4, 4);
insert into invoice_line (invoice_line_id, unit_price, quantity, invoice_id, product_id) values (5, 37255.13, 44, 5, 5);

insert into review (title, description, rating, product_id, customer_id) values ('info-mediaries', 'ac nibh fusce lacus purus aliquet at feugiat non pretium quis', 1, 1, 5);
insert into review (title, description, rating, product_id, customer_id) values ('productivity', 'faucibus orci luctus et ultrices posuere cubilia curae nulla dapibus dolor vel est donec odio justo sollicitudin', 1, 2, 3);
insert into review (title, description, rating, product_id, customer_id) values ('Cross-platform', 'magna vulputate luctus cum sociis natoque penatibus et magnis dis parturient montes nascetur ridiculus mus vivamus vestibulum sagittis sapien cum sociis', 1, 1, 3);
insert into review (title, description, rating, product_id, customer_id) values ('Cross-group', 'sit amet sem fusce consequat nulla nisl nunc nisl duis bibendum felis sed interdum venenatis turpis enim blandit mi in porttitor pede justo eu massa', 2, 4, 5);
insert into review (title, description, rating, product_id, customer_id) values ('uniform', 'morbi non quam nec dui luctus rutrum nulla tellus in sagittis dui vel', 4, 5, 2);


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