dropdb dblp;

Drop table if exists Author;
Drop table if exists Publication;
Drop table if exists Authored;
Drop table if exists Article;
Drop table if exists Book;
Drop table if exists Inproceedings;
Drop table if exists Incollection;

CREATE DATABASE dblp
    WITH 
    OWNER = postgres
    ENCODING = 'UTF8'
    LC_COLLATE = 'en_US.UTF-8'
    LC_CTYPE = 'en_US.UTF-8'
    TABLESPACE = pg_default
    CONNECTION LIMIT = -1;

Create table Author(
	id INT,
	name TEXT,
	homepage TEXT,
	PRIMARY KEY(id)
);

Create table Authored(
	authorid INT,
	pubid INT
);

Create table Publication(
	pubid INT,
	pubkey TEXT UNIQUE,
	title TEXT,
	year INT,
	PRIMARY KEY(pubid)
); 

Create table Article(
	pubkey TEXT,
	journal TEXT,
	month TEXT,
	volume TEXT,
	number TEXT,
	CONSTRAINT fk_article
		FOREIGN KEY(pubkey)
			REFERENCES Publication(pubkey)
);

Create table Book(
	pubkey TEXT,
	publisher TEXT,
	isbn TEXT,
	CONSTRAINT fk_book
		FOREIGN KEY(pubkey)
			REFERENCES Publication(pubkey)
);

Create table Inproceedings(
	pubkey TEXT,
	booktitle TEXT,
	editor TEXT,
	CONSTRAINT fk_inproceedings
		FOREIGN KEY(pubkey)
			REFERENCES Publication(pubkey)
);

Create table Incollection(
	pubkey TEXT,
	booktitle TEXT,
	publisher TEXT,
	isbn TEXT,
	CONSTRAINT fk_incollection
		FOREIGN KEY(pubkey)
			REFERENCES Publication(pubkey)
);
