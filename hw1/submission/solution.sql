
select x.name, count(*)
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid
group by x.id
order by count(*) desc
limit 20;

/*
         name         | count 
----------------------+-------
 H. Vincent Poor      |  2088
 Mohamed-Slim Alouini |  1650
 Philip S. Yu         |  1509
 Lajos Hanzo          |  1374
 Wen Gao 0001         |  1282
 Victor C. M. Leung   |  1256
 Zhu Han              |  1192
 Hai Jin 0001         |  1187
 Witold Pedrycz       |  1170
 Dacheng Tao          |  1152
 Thomas S. Huang      |  1130
 Luca Benini          |  1109
 Leonard Barolli      |  1047
 Chin-Chen Chang 0001 |  1042
 Jiawei Han 0001      |  1037
 Nassir Navab         |  1036
 Luc Van Gool         |  1026
 Elisa Bertino        |  1016
 Jie Wu 0001          |   989
 Licheng Jiao         |   981
*/

select x.name, count(*)
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid and z.pubkey like 'conf/stoc/%'
group by x.id
order by count(*) desc
limit 20;

/*
           name            | count 
---------------------------+-------
 Avi Wigderson             |    58
 Robert Endre Tarjan       |    33
 Ran Raz                   |    30
 Moni Naor                 |    28
 Uriel Feige               |    28
 Noam Nisan                |    28
 Rafail Ostrovsky          |    27
 Mihalis Yannakakis        |    26
 Santosh S. Vempala        |    26
 Venkatesan Guruswami      |    26
 Oded Goldreich 0001       |    25
 Frank Thomson Leighton    |    25
 Christos H. Papadimitriou |    24
 Prabhakar Raghavan        |    24
 Moses Charikar            |    23
 Mikkel Thorup             |    23
 Rocco A. Servedio         |    22
 Eyal Kushilevitz          |    21
 Baruch Awerbuch           |    21
 Mikls Ajtai               |    21
*/

select x.name, count(*)
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid and z.pubkey like 'conf/sosp/%'
group by x.id
order by count(*) desc
limit 20;

/*
           name           | count 
--------------------------+-------
 M. Frans Kaashoek        |    23
 Nickolai Zeldovich       |    16
 Roger M. Needham         |    13
 Henry M. Levy            |    12
 Gerald J. Popek          |    10
 Barbara Liskov           |    10
 Yuanyuan Zhou 0001       |    10
 Thomas E. Anderson       |     9
 David Mazires            |     9
 Mahadev Satyanarayanan   |     9
 Andrea C. Arpaci-Dusseau |     9
 Remzi H. Arpaci-Dusseau  |     9
 Brian N. Bershad         |     9
 David R. Cheriton        |     8
 John K. Ousterhout       |     8
 Ion Stoica               |     8
 Willy Zwaenepoel         |     8
 Michael D. Schroeder     |     8
 David K. Gifford         |     8
 Robert Tappan Morris     |     7
*/

select x.name, count(*)
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid and z.pubkey like 'conf/sigmod/%'
group by x.id
order by count(*) desc
limit 20;

/*
         name          | count 
-----------------------+-------
 Surajit Chaudhuri     |    59
 Divesh Srivastava     |    57
 H. V. Jagadish        |    50
 Michael Stonebraker   |    48
 Jeffrey F. Naughton   |    47
 Michael J. Franklin   |    47
 Michael J. Carey 0001 |    46
 Jiawei Han 0001       |    41
 David J. DeWitt       |    40
 Samuel Madden         |    40
 Beng Chin Ooi         |    40
 Dan Suciu             |    38
 Joseph M. Hellerstein |    38
 Tim Kraska            |    38
 Donald Kossmann       |    38
 Hector Garcia-Molina  |    38
 Johannes Gehrke       |    38
 Raghu Ramakrishnan    |    37
 Guoliang Li 0001      |    33
 Kian-Lee Tan          |    33
*/

(select x.name
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid 
	and z.pubkey like 'conf/sigmod/%'
group by x.id
having count(*) > 10)
except
(select x.name
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid 
	and z.pubkey like 'conf/pods/%'
group by x.id);

/*
           name           
--------------------------
 Themis Palpanas
 Michael Stonebraker
 Zachary G. Ives
 M. Tamer zsu
 Gao Cong
 Samuel Madden
 Peter A. Boncz
 Alfons Kemper
 Dirk Habich
 Jiawei Han 0001
 Ion Stoica
 Stanley B. Zdonik
 Jayavel Shanmugasundaram
 Nan Tang 0001
 Raymond Chi-Wing Wong
 Xiaokui Xiao
 Nicolas Bruno
 Nan Zhang 0004
 Elke A. Rundensteiner
 Anastasia Ailamaki
 Olga Papaemmanouil
 Georgia Koutrika
 Juliana Freire
 Ihab F. Ilyas
 Mourad Ouzzani
 Wei Wang 0011
 Ioana Manolescu
 AnHai Doan
 Jian Pei
 Anthony K. H. Tung
 Luis Gravano
 Volker Markl
 Sourav S. Bhowmick
 Ahmed K. Elmagarmid
 Carlos Ordonez 0001
 Michael J. Cafarella
 Cong Yu 0001
 Torsten Grust
 Xifeng Yan
 Andrew Pavlo
 Zhifeng Bao
 Stratos Idreos
 Jeffrey Xu Yu
 Nick Roussopoulos
 Tilmann Rabl
 Feifei Li 0001
 Clement T. Yu
 Jignesh M. Patel
 Sihem Amer-Yahia
 Aditya G. Parameswaran
 Hans-Arno Jacobsen
 Arun Kumar 0001
 Kevin S. Beyer
 Louiqa Raschid
 Chengkai Li
 Mohamed F. Mokbel
 Kevin Chen-Chuan Chang
 Eugene Wu 0002
 Lei Chen 0002
 Guy M. Lohman
 Ugur etintemel
 Carsten Binnig
 Daniel J. Abadi
 Goetz Graefe
 Xiaofang Zhou 0001
 Alvin Cheung
 Jim Gray 0001
 Gautam Das 0001
 Stefano Ceri
 Krithi Ramamritham
 Kaushik Chakrabarti
 Guoliang Li 0001
 Donald Kossmann
 Tim Kraska
 Christian S. Jensen
 Jiannan Wang
 Jingren Zhou
 David B. Lomet
 Bin Cui 0001
 Jun Yang 0001
*/

(select x.name
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid 
	and z.pubkey like 'conf/pods/%'
group by x.id
having count(*) > 4)
except
(select x.name
from Author x, Authored y, Publication z
where x.id = y.authorid and y.pubid = z.pubid 
	and z.pubkey like 'conf/sigmod/%'
group by x.id)

/*
         name         
----------------------
 Michael Mitzenmacher
 Reinhard Pichler
 Srikanta Tirthapura
 Alan Nash
 Matthias Niewerth
 Kari-Jouko Rih
 Francesco Scarcello
 Martin Grohe
 Rasmus Pagh
 Marco A. Casanova
 Giuseppe De Giacomo
 Mikolaj Bojanczyk
 Thomas Schwentick
 Vassos Hadzilacos
 Nicole Schweikardt
 Nancy A. Lynch
 Kobbi Nissim
 David P. Woodruff
 Juan L. Reutter
 Jef Wijsen
 Hubie Chen

*/

/* I was not able to do query #4 */

delete from coauthors;
create table coauthors(
	id INT,
	id2 INT
); 
insert into coauthors(
	select x.authorid, y.authorid
	from Authored x, Authored y
	where x.pubid = y.pubid and x.authorid != y.authorid
);

select x.name, count(distinct y.id2)
from Author x, coauthors y
where x.id = y.id
group by x.id
order by count(distinct y.id2) desc
limit 20;

drop table coauthors; 

/*
          name           | count 
-------------------------+-------
 Athanasios V. Vasilakos |   476
 H. Vincent Poor         |   411
 Dacheng Tao             |   363
 Mohsen Guizani          |   353
 Schahram Dustdar        |   352
 Joel J. P. C. Rodrigues |   345
 Victor C. M. Leung      |   318
 Zhu Han                 |   316
 Kim-Kwang Raymond Choo  |   308
 Philip S. Yu            |   298
 Christos Faloutsos      |   284
 Luc Van Gool            |   276
 Thomas S. Huang         |   276
 Noga Alon               |   275
 Ian T. Foster           |   275
 Elisa Bertino           |   273
 Lajos Hanzo             |   268
 Albert Y. Zomaya        |   268
 Witold Pedrycz          |   262
 Carole A. Goble         |   260
*/

/* I was not able to do query #6 */

select substring(x.homepage for (position('.edu' in x.homepage))), count(*)
from Author x, Authored y, Publication z
where y.pubid = z.pubid and x.id = y.authorid 
	and z.pubkey like 'conf/stoc/%'
group by 1
order by 2 desc
limit 20;

/*
         substring         | count 
---------------------------+-------
                           |  3639
 http://www1.cs.columbia.  |    81
 http://www.cs.princeton.  |    63
 http://www.cis.upenn.     |    57
 http://www.cs.ucla.       |    54
 http://www.cs.cmu.        |    51
 http://theory.lcs.mit.    |    51
 http://people.csail.mit.  |    51
 http://www.cs.jhu.        |    49
 http://www.cs.washington. |    47
 http://www.cs.toronto.    |    46
 http://www.eecs.harvard.  |    44
 http://www.cs.berkeley.   |    41
 http://www.cc.gatech.     |    39
 http://www.cs.utexas.     |    38
 http://theory.stanford.   |    38
 http://www.cs.brown.      |    35
 http://www.cs.cornell.    |    34
 http://www.mit.           |    31
 http://cs-www.cs.yale.    |    29
*/

select substring(x.homepage for (position('.edu' in x.homepage))), count(*)
from Author x, Authored y, Publication z
where y.pubid = z.pubid and x.id = y.authorid 
	and z.pubkey like 'conf/sigmod/%'
group by 1
order by 2 desc
limit 20;

/*
         substring         | count 
---------------------------+-------
                           |  4817
 http://pages.cs.wisc.     |   131
 http://www.comp.nus.      |   108
 http://www.cs.cornell.    |    99
 http://www.ics.uci.       |    88
 http://www.cs.wisc.       |    86
 http://www.cs.cmu.        |    83
 http://www.cs.ucsb.       |    77
 http://www.cs.washington. |    76
 http://www-db.stanford.   |    74
 http://www.cs.berkeley.   |    71
 http://www.cs.duke.       |    68
 http://www.cs.toronto.    |    64
 http://www.ntu.           |    52
 http://www.cs.columbia.   |    52
 http://www.eecs.umich.    |    52
 http://www.cse.unsw.      |    48
 http://www.cs.purdue.     |    47
 http://www.cs.uic.        |    45
 http://db.csail.mit.      |    43
*/





