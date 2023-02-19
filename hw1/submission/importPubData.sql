
alter table Authored
drop constraint fk_authored;

alter table Authored
drop constraint fk_authored2;


alter table Author
drop constraint author_pkey;

alter table Publication
drop constraint publication_pkey;

alter table Article
drop constraint fk_article;

alter table Book 
drop constraint fk_book;

alter table Inproceedings
drop constraint fk_inproceedings;

alter table Incollection
drop constraint fk_incollection;

create temp table pub1(
	pubid INT,
	pubkey TEXT
);
insert into pub1
select nextval(‘q’) as pubid, k 
from Pub where p = ‘article’ or p = ‘book’ or p = ‘incollection’ or p = %’inproceedings’;

create sequence q;
insert into Publication
select nextval(‘q’) as pubid, x.v, y.v from pub1, Field x, Field y
where pub1.pubkey=x.k and x.k=y.k %and x.p=‘title’ and y.p=‘year’;
drop sequence q;


delete from Article;

create temp table article_temp1(
	k TEXT,
	p TEXT,
	v TEXT
); 
insert into article_temp1(
	select Pub.k as k, Field.p as p, Field.v as v
	from Pub,Field
	where Pub.p = 'article' and Pub.k = Field.k
		and (Field.p = 'journal' or Field.p = 'month'
			or Field.p = 'volume' or Field.p= 'number')
);

create index atx on article_temp1(k);
create index atxx on article_temp1(p);

create temp table article_journals(
	k TEXT,
	v TEXT
);
insert into article_journals(
	select k, v
	from article_temp1
	where p = 'journal'
);

create temp table article_month(
	k TEXT,
	v TEXT 
); 
insert into article_month(
	select k, v
	from article_temp1
	where p = 'month'
);

create temp table article_volume(
	k TEXT,
	v TEXT
);
insert into article_volume(
	select k,v
	from article_temp1
	where p = 'volume'
);

create temp table article_number(
	k TEXT,
	v TEXT
); 
insert into article_number(
	select k,v
	from article_temp1
	where p = 'number'
);

insert into Article(
	select article_journals.k, article_journals.v, article_month.v, article_volume.v, article_number.v
	from article_journals
	left join article_month on article_journals.k = article_month.k
	left join article_volume on article_journals.k = article_volume.k
	left join article_number on article_journals.k = article_number.k
);



delete from Book;

create temp table pub_book(
	k TEXT,
	p TEXT,
	v TEXT 
);
insert into pub_book(
select Pub.k as k, Field.p as p, Field.v as v
        from Pub, Field
        where Pub.p = 'book' and Pub.k = Field.k
        and (Field.p = 'publisher' or Field.p = 'isbn')
);
create index pbx on pub_book(k);
create index pbxx on pub_book(p);

create temp table pub_all(
	k TEXT
);
insert into pub_all(
	select k
	from Pub
	where Pub.p = 'book'
);
create index pax on pub_all(k);

create temp table pub_pub(
	k TEXT,
	v TEXT
);
insert into pub_pub(
	select k, v
	from pub_book
	where p = 'publisher'
);

create temp table pub_isbn(
	k TEXT,
	v TEXT
);
insert into pub_isbn(
	select k, v
	from pub_book
	where p = 'isbn'
);

insert into Book(
	select pub_all.k, pub_pub.v, pub_isbn.v
	from pub_all
	left join pub_pub on pub_all.k = pub_pub.k
	left join pub_isbn on pub_all.k = pub_isbn.k
);


delete from Inproceedings;

create temp table pub_inp(
	k TEXT,
	p TEXT,
	v TEXT
);
insert into pub_inp(
	select Pub.k as k, Field.p as p, Field.v as v
	from Pub, Field
	where Pub.p = 'inproceedings'
		and (Field.p = 'booktitle' or Field.p = 'editor')
		and Pub.k = Field.k
); 
create index pipx on pub_inp(k);

create temp table inp_all(
	k TEXT
); 
insert into inp_all(
	select k
	from Pub
	where p = 'inproceedings'
);
create index iax on inp_all(k);

create temp table pub_bt(
	k TEXT,
	v TEXT
);
insert into pub_bt(
	select k, v
	from pub_inp
	where p = 'booktitle' 
);

create temp table pub_ed(
	k TEXT,
	v TEXT
);
insert into pub_ed(
	select k, v
	from pub_inp 
	where p = 'editor' 
);

insert into Inproceedings(
	select inp_all.k, pub_bt.v, pub_ed.v
	from inp_all
	left join pub_bt on inp_all.k = pub_bt.k
	left join pub_ed on inp_all.k = pub_ed.k
);

delete from Incollection; 

create temp table inc_all( 
	k TEXT
);
insert into inc_all(
	select k
	from Pub
	where p = 'incollection'
);

create temp table inc_field(
	k TEXT,
	p TEXT,
	v TEXT
);
insert into inc_field(
	select Field.k as k, Field.p, Field.v as v
	from Pub, Field
	where (Field.p = 'booktitle' or Field.p = 'publisher' or Field.p = 'isbn')
		and Pub.k = Field.k
);
create index ifx on inc_field(p); 

create temp table inc_bt(
	k TEXT,
	v TEXT
);
insert into inc_bt(
	select k, v
	from inc_field
	where p = 'booktitle'
);

create temp table inc_pub(
        k TEXT,
        v TEXT
);
insert into inc_pub(
        select k, v
        from inc_field
        where p = 'publisher'
);


create temp table inc_isbn(
        k TEXT,
        v TEXT
); 
insert into inc_isbn(
        select k, v
        from inc_field
        where p = 'isbn'
); 

insert into Incollection(
	select inc_all.k, inc_bt.v, inc_pub.v, inc_isbn.v
	from inc_all
	left join inc_bt on inc_all.k = inc_bt.k
	left join inc_pub on inc_all.k = inc_pub.k
	left join inc_isbn on inc_all.k = inc_isbn.k	
);

delete from Author; 

create sequence q; 
insert into Author(
	select nextval('q') as authorid, x.v, min(y.v)
	from Field x, Field y
	where x.k = y.k and x.p = 'author' and x.k like 'homepages/%' and y.p ='url'
	group by x.v	
); 
drop sequence q;

delete from Authored;

insert into Authored(
	select z.id, x.pubid
	from Publication x, Field y, Author z
	where x.pubkey = y.k and y.v = z.name and y.p = 'author'
);

alter table Author
add primary key(id);

alter table Publication
add primary key(pubid);

create unique index concurrently unique_pubkey
on Publication(pubkey);

alter table Publication
add constraint fk_unique_pubkey
unique using index unique_pubkey;

alter table Authored
add constraint fk_authored
foreign key (authorid)
references Author(id);

alter table Authored
add constraint fk_authored2
foreign key (pubid)
references Publication(pubid);

alter table Article
add constraint fk_article
foreign key (pubkey)
references Publication(pubkey);	

alter table Book
add constraint fk_book
foreign key (pubkey)
references Publication(pubkey);

alter table Inproceedings
add constraint fk_article
foreign key (pubkey)
references Publication(pubkey);

alter table Incollection
add constraint fk_article
foreign key (pubkey)
references Publication(pubkey); 

