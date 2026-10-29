drop DATABASE if EXISTS cars;

create database cars;

use cars;
				
create table klienci (id_klienta int auto_increment primary key,
						imie varchar (20),
						nazwisko varchar (30),
						firma varchar (50) not null DEFAULT '',
						ulica varchar (20),
						numer int,
						miasto varchar (20),
						kod varchar(6),
						nip varchar(13) not null DEFAULT '',
						telefon varchar (14)
						);
						
create table pracownicy (id_pracownika int auto_increment primary key,
							imie_p varchar (20),
							nazwisko_p varchar (30),
							data_zatr date,
							stanowisko varchar (30),
							pensja float,
							telefon_p varchar (14)
							);
							
create table samochody (id_samochodu int auto_increment primary key,
						marka varchar (20),
						model varchar (20),
						data_prod YEAR,
						kolor varchar (20),
						przebieg int,
						cena_doba FLOAT,
						dostepnosc int);
						
create table wypozyczenia (id_wypozyczenia int auto_increment primary key,
							id_klienta int,
							id_samochodu int,
							id_pracownika int,
							data_wyp date,
							data_odd date,
							FOREIGN key (id_klienta) REFERENCES klienci(id_klienta),
							FOREIGN key (id_samochodu) REFERENCES samochody(id_samochodu),
							FOREIGN key (id_pracownika) REFERENCES pracownicy(id_pracownika)							
							);
						
					
insert into klienci (imie,nazwisko,firma,ulica,numer,miasto,kod,nip,telefon) values ('damian','stelmach','pasja','mokra',6,'gliwice','44-100','345-76-43-234','385-746-350'),
																					('adam','stasiak','','sucha',16,'zabrze','44-200','','756-358-068'),
																					('mateusz','karwowski','corex','ciepla',12,'gliwice','44-100','674-96-83-785','285-746-087'),
																					('anna','majewska','tesla','wolna',21,'gliwice','44-100','455-73-42-224','485-236-150'),
																					('dawid','stary','','kopernika',10,'zabrze','44-200','','485-236-150'),
																					('monika','wolna','','mickiewicza',22,'knurow','44-300','','985-749-607'),
																					('weronika','pieczarska','polskie tramwaje','chorzowska',6,'chorzow','44-400','743-76-23-214','185-716-150'),
																					('marek','wozniak','','piotrowska',26,'katowice','44-500','','856-368-028'),
																					('tomasz','karwowski','molex','zimna',112,'knurow','44-300','674-96-83-785','485-769-617'),
																					('damian','witkowski','tapetowanie','andersa',67,'gliwice','44-100','145-26-42-284','345-726-354'),
																					('adam','swawolny','','opolska',166,'zabrze','44-200','','726-358-088'),
																					('stefan','maciejewski','auto guma','wroclawska',1,'katowice','44-500','174-16-23-285','785-729-647'),
																					('anna','frywolna','noname','zabrzanska',3,'chorzow','44-400','545-66-23-164','685-700-323'),
																					('weronika','malczewska','','blotnista',1,'mikolow','44-600','','746-318-168'),
																					('wiktoria','mrozek','chcemiec','witosa',124,'mikolow','44-600','174-16-13-185','985-249-628'),
																					('dariusz','michalczewski','twarogowo','zielona',26,'gliwice','44-100','645-16-43-214','375-744-344'),
																					('jerzy','stasik','','oliwska',76,'zabrze','44-200','','712-328-028'),
																					('genowefa','pigwa','pizzeria marianka','truskawkowa',14,'gliwice','44-100','174-16-13-185','685-749-657'),
																					('maciej','wesolik','obuwie','podeszwy',78,'gliwice','44-100','345-76-43-234','355-736-320'),
																					('adam','annawiecki','','albinosa',34,'katowice','44-500','','751-318-168'),
																					('anna','niewolna','gerwazowo - obiady','gwarna',23,'chorzow','44-300','274-92-23-725','285-749-607'),
																					('wojciech','dojada','torcik - slodosci','cicha',32,'chorzow','44-300','345-76-43-234','365-746-550'),
																					('malwina','niechce','','gerwazego',132,'zabrze','44-200','','726-358-168'),
																					('mateusz','premier','pieczarka','wyboista',122,'mikolow','44-600','174-96-83-785','225-749-107'),
																					('marek','jeszczeniepremier','wybory kopertowe na telefon','tramwajowa',6,'katowice','44-100','315-71-41-234','381-746-351'),
																					('karolina','malchewiecka','','morska',66,'zabrze','44-200','','716-358-168'),
																					('ilona','niepowiem','oponeo','walentego',13,'gliwice','44-100','674-96-83-785','215-749-617');
																					
insert into pracownicy (imie_p,nazwisko_p,data_zatr,stanowisko,pensja,telefon_p) values ('wojciech','anders','2015-12-12','obsluga klienta',5000.65,'185-256-340'),
																					    ('modest','amaro','2021-10-22','obsluga klienta',5400.95,'868-456-351'),
																					    ('andrzej','duda','2012-07-14','biuro',6200.75,'185-286-850'),
																					    ('adrian','mores','2010-04-02','biuro',6400.55,'285-897-250'),
																					    ('anna','stefanowska','2017-05-30','serwis',5600.45,'679-346-220');
																					
 
insert into samochody (marka,model,data_prod,kolor,przebieg,cena_doba,dostepnosc) values ('opel','astra',2000,'rudy',134000,155.20,2),
																			  ('mercedes','CLK',2011,'czarny',125500,650.50,3),
																			  ('audi','A4',2012,'czarny',145677,399.99,1),
																			  ('bmw','3',2015,'fioletowy',165423,389.99,3),
																			  ('renault','clio',2016,'rozowy',18050,359.99,2),
																			  ('opel','corsa',2021,'rudy',14040,409.99,1),
																			  ('mercedes','S',2021,'czarny',12500,799.99,4),
																			  ('audi','A8',2019,'bialy',165663,769.00,5),
																			  ('bmw','X6',2018,'fioletowy',18423,899.99,3),
																			  ('renault','megane',2017,'rozowy',17250,359.00,2),
																			  ('ford','mondeo',2005,'niebieski',133456,199.99,1);


insert into wypozyczenia (id_klienta,id_samochodu,id_pracownika,data_wyp,data_odd) values (1,1,1,'2020-12-10','2020-12-12'),
																						  (2,2,1,'2020-12-11','2020-12-12'),
																						  (3,3,2,'2020-12-11','2020-12-12'),
																						  (4,4,2,'2020-12-12','2020-12-14'),
																						  (1,1,2,'2020-12-14','2020-12-16'),
																						  (4,5,1,'2020-12-21','2020-12-24'),
																						  (5,7,1,'2020-12-21','2020-12-23'),
																						  (6,9,1,'2020-12-22','2020-12-30'),
																						  (7,11,2,'2021-01-10','2021-01-12'),
																						  (8,1,2,'2021-01-11','2021-01-12'),
																						  (9,10,2,'2021-01-13','2021-01-14'),
																						  (8,9,2,'2021-01-15','2021-01-16'),
																						  (7,6,3,'2021-01-16','2021-01-18'),
																						  (20,1,2,'2021-01-23','2021-01-24'),
																						  (22,11,3,'2021-01-26','2021-01-28'),
																						  (21,10,3,'2021-02-04','2021-02-12'),
																						  (19,9,2,'2021-02-04','2021-02-12'),
																						  (17,4,3,'2021-02-05','2021-02-12'),
																						  (20,2,2,'2021-02-07','2021-02-10'),
																						  (14,3,2,'2021-02-10','2021-02-12'),
																						  (26,1,4,'2021-02-11','2021-02-15'),
																						  (13,2,2,'2021-02-25','2021-02-27'),
																						  (16,9,4,'2021-03-11','2021-03-12'),
																						  (18,10,2,'2021-03-11','2021-03-12'),
																						  (19,11,1,'2021-03-11','2021-03-12'),
																						  (22,1,1,'2021-03-12','2021-03-14'),
																						  (26,2,2,'2021-03-14','2021-03-15'),
																						  (21,5,2,'2021-03-14','2021-03-17'),
																						  (14,7,4,'2021-03-14','2021-03-16'),
																						  (16,2,2,'2021-03-15','2021-03-17'),
																						  (15,8,3,'2021-03-15','2021-03-19'),
																						  (12,9,2,'2021-03-17','2021-03-18'),
																						  (2,10,4,'2021-04-02','2021-04-03'),
																						  (3,1,4,'2021-04-04','2021-04-05'),
																						  (6,2,2,'2021-04-05','2021-04-06'),
																						  (9,5,2,'2021-04-05','2021-04-07'),
																						  (10,7,1,'2021-04-05','2021-04-06'),
																						  (12,8,2,'2021-04-06','2021-04-09'),
																						  (22,2,1,'2021-04-11','2021-04-12'),
																						  (21,1,2,'2021-04-12','2021-04-13'),
																						  (20,10,1,'2021-04-12','2021-04-13'),
																						  (15,2,2,'2021-04-15','2021-04-16'),
																						  (12,3,4,'2021-04-15','2021-04-18'),
																						  (5,8,4,'2021-04-20','2021-04-21'),
																						  (6,7,4,'2021-04-20','2021-04-22'),
																						  (7,5,4,'2021-04-21','2021-04-24'),
																						  (8,9,2,'2021-05-02','2021-05-03'),
																						  (9,10,2,'2021-05-05','2021-05-06'),
																						  (6,11,3,'2021-05-06','2021-05-07'),
																						  (1,7,5,'2021-05-07','2021-05-07'),
																						  (2,6,3,'2021-05-12','2021-05-14'),
																						  (4,3,3,'2021-05-12','2021-05-14'),
																						  (22,4,1,'2021-05-12','2021-05-13'),
																						  (21,7,1,'2021-05-13','2021-05-15'),
																						  (20,10,4,'2021-05-20','2021-05-21'),
																						  (22,9,5,'2021-05-21','2021-05-22'),
																						  (2,3,2,'2021-05-22','2021-05-25');







