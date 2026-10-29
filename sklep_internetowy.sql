DROP DATABASE IF EXISTS sklep_internetowy;

CREATE DATABASE sklep_internetowy CHARACTER SET utf8 COLLATE utf8_general_ci;

USE sklep_internetowy;

CREATE TABLE Kategorie (
	IDKategorii int NOT NULL DEFAULT 0 ,
	OpisKategorii nvarchar (75) NULL 
);

CREATE TABLE Klienci (
	IDKlienta int NOT NULL ,
	ImieKlienta nvarchar (25) NULL ,
	NazwiskoKlienta nvarchar (25) NULL ,
	AdresKlienta nvarchar (50) NULL ,
	MiastoKlienta nvarchar (30) NULL ,
	WojZamKlienta nvarchar (2) NULL ,
	KodPocztowyKlienta nvarchar (10) NULL ,
	TelefonKlienta nvarchar (20) NULL 
);

CREATE TABLE Pracownicy (
	IDPracownika int NOT NULL ,
	ImiePracownika nvarchar (25) NULL ,
	NazwiskoPracownika nvarchar (25) NULL ,
	AdresPracownika nvarchar (50) NULL ,
	MiastoPracownika nvarchar (30) NULL ,
	KodPocztowyPracownika nvarchar (10) NULL ,
	TelefonPracownika nvarchar (20) NULL , 
    DataUrodzPracownika date NULL
);

CREATE TABLE Dane_zamowien (
	NumerZamowienia int NOT NULL DEFAULT 0 ,
	NumerProduktu int NOT NULL DEFAULT 0 ,
	CenaZakupu decimal (15, 2) NULL DEFAULT 0 ,
	ZamowionaIlosc smallint NULL DEFAULT 0 
);

CREATE TABLE Zamowienia (
	NumerZamowienia int NOT NULL DEFAULT 0 ,
	DataZamowienia date NULL ,
	DataWysylki date NULL ,
	IDKlienta int NULL DEFAULT 0,
	IDPracownika int NULL DEFAULT 0
);

CREATE TABLE Dostawcy_produktow (
	NumerProduktu int NOT NULL DEFAULT 0 ,
	IDDostawcy int NOT NULL DEFAULT 0 ,
	CenaHurtowa decimal (15, 2) NULL DEFAULT 0 ,
	TerminDostarczenia smallint NULL DEFAULT 0
);

CREATE TABLE Produkty (
	NumerProduktu int NOT NULL DEFAULT 0,
	NazwaProduktu nvarchar (50) NULL ,
	OpisProduktu nvarchar (100) NULL ,
	CenaDetaliczna decimal (15, 2) NULL DEFAULT 0 ,
	StanMagazynowy smallint NULL DEFAULT 0 ,
	IDKategorii int NULL DEFAULT 0
);

CREATE TABLE Dostawcy (
	IDDostawcy int NOT NULL ,
	NazwaDostawcy nvarchar (25) NULL ,
	AdresDostawcy nvarchar (50) NULL ,
	MiastoDostawcy nvarchar (30) NULL ,
	WojSiedzDostawcy nvarchar (2) NULL ,
	KodPocztowyDostawcy nvarchar (10) NULL ,
	TelefonDostawcy nvarchar (20) NULL ,
	FaxDostawcy nvarchar (20) NULL ,
	StronaInterDostawcy text NULL ,
	EmailDostawcy nvarchar (50) NULL 
) ;


ALTER TABLE Kategorie ADD CONSTRAINT Kategorie_PK PRIMARY KEY (IDKategorii);
CREATE INDEX IDKategorii ON Kategorie(IDKategorii);

ALTER TABLE Klienci ADD CONSTRAINT Klienci_PK PRIMARY KEY (IDKlienta);
ALTER TABLE Klienci MODIFY IDKlienta INT AUTO_INCREMENT;
CREATE INDEX KodPocztowyKlienta ON Klienci(KodPocztowyKlienta);

ALTER TABLE Pracownicy ADD CONSTRAINT Pracownicy_PK PRIMARY KEY (IDPracownika);
ALTER TABLE Pracownicy MODIFY IDPracownika INT AUTO_INCREMENT;
CREATE INDEX KodPocztowyPracownika ON Pracownicy(KodPocztowyPracownika);

ALTER TABLE Dane_zamowien ADD CONSTRAINT Dane_zamowien_PK PRIMARY KEY (NumerZamowienia, NumerProduktu);
CREATE INDEX ZamowieniaDaneZamowien ON Dane_zamowien(NumerZamowienia);
CREATE INDEX ProduktyDaneZamowien ON Dane_zamowien(NumerProduktu);

ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_PK PRIMARY KEY (NumerZamowienia);
CREATE INDEX IDKlienta ON Zamowienia(IDKlienta);
CREATE INDEX IDPracownika ON Zamowienia(IDPracownika);

ALTER TABLE Dostawcy_produktow ADD CONSTRAINT Dostawcy_produktow_PK PRIMARY KEY (NumerProduktu, IDDostawcy);
CREATE INDEX ProduktyDostawcyProduktow ON Dostawcy_produktow(NumerProduktu);
CREATE INDEX IDDostawcy ON Dostawcy_produktow(IDDostawcy);

ALTER TABLE Produkty ADD CONSTRAINT Produkty_PK PRIMARY KEY (NumerProduktu);
ALTER TABLE Produkty MODIFY NumerProduktu INT AUTO_INCREMENT;
CREATE INDEX KategorieProdukty ON Produkty(IDKategorii);

ALTER TABLE Dostawcy ADD CONSTRAINT Dostawcy_PK PRIMARY KEY (IDDostawcy);
CREATE INDEX KodPocztowyDostawcy ON Dostawcy(KodPocztowyDostawcy);


ALTER TABLE Dane_zamowien ADD CONSTRAINT Dane_zamowien_FK00 FOREIGN KEY (NumerZamowienia) REFERENCES Zamowienia (NumerZamowienia);
ALTER TABLE Dane_zamowien ADD CONSTRAINT Dane_zamowien_FK01 FOREIGN KEY (NumerProduktu) REFERENCES Produkty (NumerProduktu);

ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_FK00 FOREIGN KEY (IDKlienta) REFERENCES Klienci (IDKlienta);
ALTER TABLE Zamowienia ADD CONSTRAINT Zamowienia_FK01 FOREIGN KEY (IDPracownika) REFERENCES Pracownicy (IDPracownika);

ALTER TABLE Dostawcy_produktow ADD CONSTRAINT Dostawcy_produktow_FK00 FOREIGN KEY (NumerProduktu) REFERENCES Produkty (NumerProduktu);
ALTER TABLE Dostawcy_produktow ADD CONSTRAINT Dostawcy_produktow_FK01 FOREIGN KEY (IDDostawcy) REFERENCES Dostawcy (IDDostawcy);

ALTER TABLE Produkty ADD CONSTRAINT Produkty_FK00 FOREIGN KEY (IDKategorii) REFERENCES Kategorie (IDKategorii);

INSERT INTO Klienci (IDKlienta, ImieKlienta, NazwiskoKlienta, AdresKlienta, MiastoKlienta, WojZamKlienta, KodPocztowyKlienta, TelefonKlienta) VALUES 
(1001, 'Anna', 'Kowalska', 'ul. Złota 44', 'Warszawa', 'MZ', '00-120', '501-111-222'),
(1002, 'Piotr', 'Nowak', 'ul. Długa 5', 'Kraków', 'MP', '31-001','502-333-444'),
(1003, 'Krzysztof', 'Wiśniewski', 'ul. Świdnicka 10', 'Wrocław', 'DS', '50-067', '503-555-666'),
(1004, 'Maria', 'Wójcik', 'ul. Półwiejska 3', 'Poznań', 'WP', '61-888', '504-777-888'),
(1005, 'Andrzej', 'Kowalczyk', 'ul. Długi Targ 15', 'Gdańsk', 'PM', '80-828', '505-999-000'),
(1006, 'Barbara', 'Kamińska', 'ul. Piotrkowska 100', 'Łódź', 'LD', '90-001', '506-111-333'),
(1007, 'Tomasz', 'Lewandowski', 'ul. Niepodległości 12', 'Szczecin', 'ZP', '70-404', '507-222-444'),
(1008, 'Ewa', 'Zielińska', 'ul. Krakowskie Przedm. 5', 'Lublin', 'LU', '20-002', '508-333-555'),
(1009, 'Paweł', 'Szymański', 'ul. Lipowa 4', 'Białystok', 'PD', '15-424', '509-444-666'),
(1010, 'Magdalena', 'Woźniak', 'ul. Mariacka 2', 'Katowice', 'SL', '40-014', '510-555-777'),
(1011, 'Michał', 'Dąbrowski', 'ul. Świętojańska 20', 'Gdynia', 'PM', '81-372', '511-666-888'),
(1012, 'Agnieszka', 'Kozłowska', 'Al. NMP 15', 'Częstochowa', 'SL', '42-200', '512-777-999'),
(1013, 'Janusz', 'Jankowski', 'ul. Żeromskiego 5', 'Radom', 'MZ', '26-600', '513-888-000'),
(1014, 'Krystyna', 'Mazur', 'ul. Szeroka 12', 'Toruń', 'KP', '87-100', '514-999-111'),
(1015, 'Adam', 'Wojciechowski', 'ul. 3 Maja 7', 'Sosnowiec', 'SL', '41-200', '515-000-222'),
(1016, 'Joanna', 'Kwiatkowska', 'ul. Sienkiewicza 8', 'Kielce', 'SK', '25-001', '516-111-333'),
(1017, 'Marek', 'Krawczyk', 'ul. 3 Maja 15', 'Rzeszów', 'PK', '35-030', '517-222-444'),
(1018, 'Zofia', 'Kaczmarek', 'ul. Zwycięstwa 10', 'Gliwice', 'SL', '44-100', '518-333-555'),
(1019, 'Dariusz', 'Piotrowski', 'ul. Wolności 22', 'Zabrze', 'SL', '41-800', '519-444-666'),
(1020, 'Elżbieta', 'Grabowska', 'ul. Dworcowa 1', 'Olsztyn', 'WM', '10-001', '520-555-777'),
(1021, 'Rafał', 'Pawłowski', 'ul. Żywiecka 55', 'Bielsko-Biała', 'SL', '43-300', '521-666-888'),
(1022, 'Monika', 'Michalska', 'ul. Lwowska 1', 'Tarnów', 'MP', '33-100', '522-777-999'),
(1023, 'Grzegorz', 'Nowicki', 'ul. Wrocławska 20', 'Opole', 'OP', '45-001', '523-888-000'),
(1024, 'Teresa', 'Adamczyk', 'ul. Grunwaldzka 10', 'Elbląg', 'WM', '82-300', '524-999-111'),
(1025, 'Marcin', 'Dudek', 'ul. Rynek 1', 'Wałbrzych', 'DS', '58-300', '525-000-222'),
(1026, 'Iwona', 'Zając', 'ul. Tumska 5', 'Płock', 'MZ', '09-400', '526-111-333'),
(1027, 'Wojciech', 'Wieczorek', 'ul. Wyszyńskiego 10', 'Gorzów Wlkp.', 'LB', '66-400', '527-222-444'),
(1028, 'Marlena', 'Wojciechowska', 'ul. Ruda 16/6', 'Gliwice.', 'SL', '44-100', '547-262-484'),
(1029, 'Aleksandra', 'Jabłońska', 'ul. Zjednoczenia 5', 'Zielona Góra', 'LB', '65-001', '528-333-555');

INSERT INTO Pracownicy (IDPracownika, ImiePracownika, NazwiskoPracownika, AdresPracownika, MiastoPracownika, KodPocztowyPracownika, TelefonPracownika, DataUrodzPracownika) VALUES 
(701, 'Katarzyna', 'Wójcik', 'ul. Leśna 10', 'Warszawa', '01-001', '555-123-456', '1971-03-18'),
(702, 'Michał', 'Kamiński', 'ul. Polna 5', 'Pruszków', '05-800', '555-234-567', '2003-06-21'),
(703, 'Agnieszka', 'Lewandowska', 'ul. Słoneczna 8', 'Piaseczno', '05-500', '555-345-678', '1977-11-02'),
(704, 'Tomasz', 'Zieliński', 'ul. Ogrodowa 12', 'Legionowo', '05-120', '555-456-789', '2000-12-23'),
(705, 'Piotr', 'Szymański', 'ul. Krótka 3', 'Otwock', '05-400', '555-567-890', '1998-10-05'),
(706, 'Anna', 'Woźniak', 'ul. Cicha 7', 'Wołomin', '05-200', '555-678-901', '1981-01-01'),
(707, 'Krzysztof', 'Dąbrowski', 'ul. Miodowa 1', 'Marki', '05-270', '555-789-012', '1995-12-12'),
(708, 'Maria', 'Kozłowska', 'ul. Zielona 9', 'Ząbki', '05-091', '555-890-123', '1980-10-15');

INSERT INTO Dostawcy (IDDostawcy, NazwaDostawcy, AdresDostawcy, MiastoDostawcy, WojSiedzDostawcy, KodPocztowyDostawcy, TelefonDostawcy, FaxDostawcy, StronaInterDostawcy, EmailDostawcy) VALUES 
(1, 'Kross S.A.', 'ul. Leszno 46', 'Przasnysz', 'MZ', '06-300', '(29) 752-40-00', '(29) 752-40-01', '#https://www.kross.pl/#', 'biuro@kross.pl'),
(2, 'Romet Sp. z o.o.', 'ul. Podgrodzie 32C', 'Dębica', 'PK', '39-200', '(14) 676-00-00', '(14) 676-00-01', '#https://www.romet.pl/#', 'sekretariat@romet.pl'),
(3, 'Unibike Sp. j.', 'ul. Przemysłowa 15', 'Bydgoszcz', 'KP', '85-758', '(52) 345-00-00', '(52) 345-00-01', '#https://www.unibike.pl/#', 'biuro@unibike.pl'),
(4, 'Tabou', 'ul. Ołowiana 18', 'Bydgoszcz', 'KP', '85-461', '(52) 346-11-22', '(52) 346-11-23', '#https://www.tabou.pl/#', 'kontakt@tabou.pl'),
(6, 'NS Bikes', 'ul. Rakietowa 22', 'Gdańsk', 'PM', '80-298', '(58) 555-99-88', '(58) 555-99-89', NULL, NULL),
(7, 'Embassy Bikes', 'ul. Kampinoska 1', 'Warszawa', 'MZ', '01-999', '(22) 888-77-66', '(22) 888-77-67', NULL, NULL),
(8, 'Creme Cycles', 'ul. Słowackiego 5', 'Gdańsk', 'PM', '80-001', '(58) 321-12-34', '(58) 321-12-35', NULL, NULL),
(9, 'Dartmoor', 'ul. Portowa 8', 'Gliwice', 'SL', '44-100', '(32) 111-22-33', '(32) 111-22-34', NULL, NULL),
(10, 'Accent', 'ul. Pszczyńska 300', 'Gliwice', 'SL', '44-100', '(32) 330-40-50', '(32) 330-40-51', NULL, NULL);

INSERT INTO Kategorie (IDKategorii, OpisKategorii) VALUES 
(1, 'Rowery'),
(2, 'Części rowerowe'),
(3, 'Odzież'),
(4, 'Akcesoria'),
(5, 'Bagażniki samochodowe'),
(6, 'Koła i Opony');

INSERT INTO Produkty (NumerProduktu, NazwaProduktu, OpisProduktu, CenaDetaliczna, StanMagazynowy, IDKategorii) VALUES 
(1, 'Trek 9000 Mountain Bike', 'Pełne wyposażenie do jazdy po szosie i bezdrożach. Wygoda i bezpieczeństwo.', 1200.00, 6, 1),
(2, 'Eagle FS-3 Mountain Bike', 'Pełne wyposażenie do jazdy po szosie i bezdrożach. Wygoda i bezpieczeństwo.', 1800.00, 8, 1),
(3, 'Dog Ear Cycle Computer', 'Komputer podróżny dla zapalonych rowerzystów. Pełna kontrola nad czasem i dystansem.', 75.00, 20, 4),
(4, 'Dog Ear Helmet Mount Mirrors', 'Zestaw lusterek montowanych na kasku dla każdego rowerzysty. Pozwala widzieć wszystko dookoła.', 7.45, 12, 4),
(5, 'Viscount Mountain Bike', 'Pełne wyposażenie do jazdy po szosie i bezdrożach. Wygoda i bezpieczeństwo.', 635.00, 5, 1),
(6, 'Viscount C-500 Wireless Bike Computer', 'Komputer podróżny dla zapalonych rowerzystów. Pełna kontrola nad czasem i dystansem.', 49.00, 30, 4),
(7, 'Kryptonite Advanced 2000 U-Lock', 'Bezpieczeństwo przede wszystkim. Zabezpiecz swój rower przed kradzieżą.', 50.00, 20, 4),
(8, 'Nikoma Lok-Tight U-Lock', 'Bezpieczeństwo przede wszystkim. Zabezpiecz swój rower przed kradzieżą.', 33.00, 12, 4),
(9, 'Viscount Microshell Helmet', 'Zadbaj o swoje zdrowie. Kask rowerowy z atestami.', 36.00, 20, 4),
(10, 'ProFormance ATB All-Terrain Pedal', 'Pedały do jazdy w trudnym terenie. Doskonała przyczepność.', 28.00, 40, 2),
(11, 'ProFormance Toe Klip', 'Noski na pedały. Zwiększają efektywność pedałowania.', 4.00, 60, 2),
(12, 'Shinoman 105 SC Brakes', 'Hamulce Shimano 105. Niezawodność i siła hamowania.', 65.50, 25, 2),
(13, 'Shinoman Dura-Ace Headset', 'Stery kierownicy Shimano Dura-Ace. Najwyższa jakość.', 67.50, 20, 2),
(14, 'Shinoman XTR Derailleur', 'Przerzutka Shimano XTR. Precyzja zmiany biegów.', 90.00, 15, 2),
(15, 'Shinoman Tourney Shifters', 'Manetki zmiany biegów Shimano Tourney. Wygoda obsługi.', 25.00, 30, 2),
(16, 'Cosmic Elite Road Warrior Wheels', 'Koła szosowe dla wymagających. Lekkie i wytrzymałe.', 165.00, 22, 6),
(17, 'AeroFlo ATB Wheels', 'Koła terenowe. Doskonała przyczepność w każdych warunkach.', 180.00, 18, 6),
(18, 'Cosmic Elite Road Warrior Saddle', 'Siodełko szosowe. Komfort podczas długich tras.', 45.00, 25, 2),
(19, 'StaDry Cycling Pants', 'Spodnie rowerowe. Ochrona przed deszczem i wiatrem.', 60.00, 30, 3),
(20, 'Trans-Tex Seamless Jersey', 'Koszulka rowerowa bezszwowa. Komfort termiczny.', 58.00, 40, 3),
(21, 'Chill-Master Winter Cycle Gloves', 'Rękawiczki zimowe. Ochrona dłoni przed zimnem.', 22.00, 35, 3),
(22, 'King Cobra Helmet', 'Kask rowerowy o agresywnym wyglądzie. Bezpieczeństwo.', 135.00, 15, 4),
(23, 'Glide-O-Matic Cycling Helmet', 'Kask rowerowy aerodynamiczny. Dla sprinterów.', 125.00, 18, 4),
(24, 'X-Pro All Weather Tires', 'Opony całoroczne. Niezawodność w każdych warunkach.', 24.00, 50, 6),
(25, 'Turbo Twin Tires', 'Opony bliźniacze. Zwiększona przyczepność.', 20.00, 45, 6),
(26, 'Ultra-Pro Rain Jacket', 'Kurtka przeciwdeszczowa. Ochrona przed ulewą.', 85.00, 25, 3),
(27, 'Kool-Breeze Rocket Top Jersey', 'Koszulka letnia przewiewna. Komfort w upalne dni.', 45.00, 40, 3),
(28, 'Wonder Wool Cycle Socks', 'Skarpetki wełniane. Ciepło i wygoda.', 15.00, 60, 3),
(29, 'True Grip Competition Gloves', 'Rękawiczki zawodnicze. Pewny chwyt kierownicy.', 20.00, 50, 3),
(30, 'Clear Shade 85-T Glasses', 'Okulary rowerowe. Ochrona oczu przed słońcem i owadami.', 45.00, 30, 4),
(31, 'Hitch Rack - 4-Bike', 'Bagażnik na hak holowniczy. Przewozi 4 rowery.', 150.00, 10, 5),
(32, 'MK III Trunk Rack', 'Bagażnik na klapę bagażnika. Łatwy montaż.', 90.00, 15, 5),
(33, 'Rodeo Rack - 2-Bike', 'Bagażnik dachowy na 2 rowery.', 120.00, 12, 5),
(34, 'Aerodynamic Pro-Rack', 'Bagażnik aerodynamiczny. Zmniejsza opory powietrza.', 180.00, 8, 5),
(35, 'Hitch Rack - 2-Bike', 'Bagażnik na hak holowniczy. Przewozi 2 rowery.', 100.00, 15, 5),
(36, 'Eagle FS-3 Mountain Bike', 'Rower górski dla profesjonalistów.', 1800.00, 8, 1),
(37, 'Cosmic Elite Road Warrior Wheels', 'Koła szosowe najwyższej klasy.', 165.00, 22, 6),
(38, 'AeroFlo ATB Wheels', 'Koła terenowe wzmocnione.', 180.00, 18, 6),
(39, 'X-Pro All Weather Tires', 'Opony na każdą pogodę.', 24.00, 50, 6),
(40, 'Men''s bib shorts', 'Spodenki kolarskie męskie z szelkami.', 70.00, 25, 3),
(41, 'Women''s cycling shorts', 'Spodenki kolarskie damskie.', 65.00, 25, 3);


INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (1, '2025-09-01', '2025-09-04', 1018, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (2, '2025-09-01', NULL, 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (3, '2025-09-01', '2025-09-04', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (4, '2025-09-01', '2025-09-03', 1009, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (5, '2025-09-01', '2025-09-01', 1024, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (6, '2025-09-01', '2025-09-05', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (7, '2025-09-01', '2025-09-04', 1001, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (8, '2025-09-01', '2025-09-01', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (9, '2025-09-01', '2025-09-04', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (10, '2025-09-01', '2025-09-04', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (11, '2025-09-02', '2025-09-04', 1020, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (12, '2025-09-02', '2025-09-05', 1024, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (13, '2025-09-02', '2025-09-02', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (14, '2025-09-02', '2025-09-03', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (15, '2025-09-02', '2025-09-06', 1004, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (16, '2025-09-02', '2025-09-06', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (17, '2025-09-02', '2025-09-03', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (18, '2025-09-02', '2025-09-03', 1016, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (19, '2025-09-02', '2025-09-06', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (20, '2025-09-02', '2025-09-02', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (21, '2025-09-03', '2025-09-03', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (22, '2025-09-03', '2025-09-07', 1026, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (23, '2025-09-03', 'NULL', 1017, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (24, '2025-09-03', '2025-09-05', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (25, '2025-09-03', '2025-09-04', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (26, '2025-09-04', '2025-09-08', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (27, '2025-09-04', '2025-09-05', 1014, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (28, '2025-09-04', '2025-09-08', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (29, '2025-09-04', '2025-09-08', 1015, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (30, '2025-09-04', 'NULL', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (31, '2025-09-05', '2025-09-09', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (32, '2025-09-05', '2025-09-09', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (33, '2025-09-05', '2025-09-06', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (34, '2025-09-06', '2025-09-07', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (35, '2025-09-06', '2025-09-06', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (36, '2025-09-06', '2025-09-07', 1007, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (37, '2025-09-07', '2025-09-11', 1027, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (38, '2025-09-07', 'NULL', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (39, '2025-09-07', NULL, 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (40, '2025-09-07', '2025-09-07', 1017, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (41, '2025-09-07', '2025-09-07', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (42, '2025-09-07', '2025-09-10', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (43, '2025-09-07', '2025-09-11', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (44, '2025-09-07', '2025-09-08', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (45, '2025-09-08', '2025-09-08', 1008, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (46, '2025-09-08', '2025-09-09', 1018, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (47, '2025-09-08', '2025-09-10', 1023, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (48, '2025-09-08', '2025-09-11', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (49, '2025-09-08', '2025-09-08', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (50, '2025-09-08', '2025-09-12', 1002, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (51, '2025-09-08', '2025-09-08', 1018, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (52, '2025-09-09', '2025-09-11', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (53, '2025-09-09', '2025-09-09', 1004, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (54, '2025-09-09', '2025-09-09', 1007, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (55, '2025-09-09', '2025-09-11', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (56, '2025-09-09', '2025-09-12', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (57, '2025-09-09', '2025-09-10', 1009, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (58, '2025-09-09', '2025-09-13', 1006, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (59, '2025-09-09', '2025-09-09', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (60, '2025-09-09', '2025-09-13', 1013, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (61, '2025-09-09', '2025-09-10', 1009, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (62, '2025-09-10', '2025-09-13', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (63, '2025-09-10', '2025-09-13', 1023, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (64, '2025-09-10', '2025-09-14', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (65, '2025-09-10', '2025-09-13', 1021, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (66, '2025-09-10', '2025-09-11', 1026, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (67, '2025-09-10', '2025-09-11', 1025, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (68, '2025-09-11', '2025-09-12', 1027, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (69, '2025-09-11', '2025-09-13', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (70, '2025-09-12', '2025-09-16', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (71, '2025-09-12', '2025-09-14', 1016, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (72, '2025-09-12', '2025-09-16', 1003, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (73, '2025-09-12', '2025-09-15', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (74, '2025-09-12', '2025-09-13', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (75, '2025-09-12', '2025-09-14', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (76, '2025-09-12', '2025-09-15', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (77, '2025-09-12', '2025-09-13', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (78, '2025-09-13', '2025-09-16', 1007, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (79, '2025-09-13', '2025-09-17', 1006, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (80, '2025-09-13', '2025-09-16', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (81, '2025-09-13', '2025-09-13', 1006, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (82, '2025-09-13', '2025-09-16', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (83, '2025-09-13', '2025-09-16', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (84, '2025-09-13', '2025-09-13', 1022, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (85, '2025-09-13', '2025-09-15', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (86, '2025-09-13', '2025-09-16', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (87, '2025-09-13', '2025-09-14', 1002, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (88, '2025-09-14', '2025-09-17', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (89, '2025-09-14', '2025-09-17', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (90, '2025-09-14', '2025-09-15', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (91, '2025-09-14', '2025-09-18', 1010, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (92, '2025-09-14', '2025-09-17', 1011, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (93, '2025-09-14', '2025-09-17', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (94, '2025-09-14', '2025-09-14', 1010, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (95, '2025-09-15', '2025-09-19', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (96, '2025-09-15', '2025-09-16', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (97, '2025-09-15', '2025-09-18', 1026, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (98, '2025-09-15', '2025-09-16', 1009, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (99, '2025-09-15', '2025-09-18', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (100, '2025-09-15', '2025-09-16', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (101, '2025-09-15', '2025-09-18', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (102, '2025-09-15', '2025-09-17', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (103, '2025-09-15', '2025-09-16', 1025, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (104, '2025-09-15', '2025-09-15', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (105, '2025-09-16', '2025-09-18', 1005, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (106, '2025-09-16', '2025-09-20', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (107, '2025-09-16', '2025-09-20', 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (108, '2025-09-16', '2025-09-19', 1004, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (109, '2025-09-16', '2025-09-16', 1013, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (110, '2025-09-17', '2025-09-19', 1015, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (111, '2025-09-17', '2025-09-21', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (112, '2025-09-18', '2025-09-19', 1009, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (113, '2025-09-18', '2025-09-22', 1010, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (114, '2025-09-18', '2025-09-22', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (115, '2025-09-19', '2025-09-21', 1003, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (116, '2025-09-19', '2025-09-21', 1004, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (117, '2025-09-20', '2025-09-22', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (118, '2025-09-20', '2025-09-22', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (119, '2025-09-20', '2025-09-20', 1013, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (120, '2025-09-20', '2025-09-21', 1024, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (121, '2025-09-20', '2025-09-21', 1025, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (122, '2025-09-20', '2025-09-24', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (123, '2025-09-20', '2025-09-22', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (124, '2025-09-21', '2025-09-23', 1007, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (125, '2025-09-21', '2025-09-21', 1011, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (126, '2025-09-22', '2025-09-24', 1016, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (127, '2025-09-22', '2025-09-25', 1009, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (128, '2025-09-22', '2025-09-26', 1022, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (129, '2025-09-22', '2025-09-22', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (130, '2025-09-22', '2025-09-24', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (131, '2025-09-22', '2025-09-22', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (132, '2025-09-22', '2025-09-25', 1007, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (133, '2025-09-22', '2025-09-22', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (134, '2025-09-22', '2025-09-24', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (135, '2025-09-23', '2025-09-26', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (136, '2025-09-23', '2025-09-26', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (137, '2025-09-23', '2025-09-23', 1001, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (138, '2025-09-24', '2025-09-27', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (139, '2025-09-24', '2025-09-26', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (140, '2025-09-24', '2025-09-24', 1002, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (141, '2025-09-24', '2025-09-27', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (142, '2025-09-25', '2025-09-29', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (143, '2025-09-25', '2025-09-28', 1021, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (144, '2025-09-25', '2025-09-29', 1018, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (145, '2025-09-26', '2025-09-30', 1027, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (146, '2025-09-26', '2025-09-26', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (147, '2025-09-26', '2025-09-26', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (148, '2025-09-26', '2025-09-30', 1027, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (149, '2025-09-27', '2025-09-28', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (150, '2025-09-27', '2025-09-27', 1024, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (151, '2025-09-27', '2025-09-28', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (152, '2025-09-28', '2025-10-02', 1017, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (153, '2025-09-29', '2025-09-30', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (154, '2025-09-29', '2025-10-02', 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (155, '2025-09-29', '2025-10-03', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (156, '2025-09-29', '2025-09-30', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (157, '2025-09-29', '2025-10-01', 1010, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (158, '2025-09-29', '2025-10-03', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (159, '2025-09-29', '2025-10-03', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (160, '2025-09-30', '2025-09-30', 1021, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (161, '2025-09-30', '2025-09-30', 1011, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (162, '2025-09-30', '2025-10-01', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (163, '2025-09-30', '2025-09-30', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (164, '2025-10-01', '2025-10-04', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (165, '2025-10-02', '2025-10-02', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (166, '2025-10-03', '2025-10-06', 1022, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (167, '2025-10-03', '2025-10-03', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (168, '2025-10-03', '2025-10-05', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (169, '2025-10-03', '2025-10-06', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (170, '2025-10-04', '2025-10-04', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (171, '2025-10-04', '2025-10-05', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (172, '2025-10-04', '2025-10-07', 1018, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (173, '2025-10-04', '2025-10-04', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (174, '2025-10-04', '2025-10-08', 1006, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (175, '2025-10-04', '2025-10-07', 1013, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (176, '2025-10-04', '2025-10-04', 1025, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (177, '2025-10-04', '2025-10-08', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (178, '2025-10-04', '2025-10-07', 1022, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (179, '2025-10-04', '2025-10-08', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (180, '2025-10-05', '2025-10-08', 1015, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (181, '2025-10-05', '2025-10-05', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (182, '2025-10-05', '2025-10-06', 1002, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (183, '2025-10-05', '2025-10-05', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (184, '2025-10-05', '2025-10-09', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (185, '2025-10-05', '2025-10-09', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (186, '2025-10-05', '2025-10-05', 1002, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (187, '2025-10-06', '2025-10-07', 1022, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (188, '2025-10-06', '2025-10-07', 1002, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (189, '2025-10-06', '2025-10-07', 1012, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (190, '2025-10-06', '2025-10-10', 1024, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (191, '2025-10-06', '2025-10-07', 1015, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (192, '2025-10-06', '2025-10-09', 1022, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (193, '2025-10-06', '2025-10-06', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (194, '2025-10-06', '2025-10-08', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (195, '2025-10-07', '2025-10-10', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (196, '2025-10-07', '2025-10-11', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (197, '2025-10-07', '2025-10-10', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (198, '2025-10-07', '2025-10-09', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (199, '2025-10-07', '2025-10-09', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (200, '2025-10-07', '2025-10-08', 1026, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (201, '2025-10-07', '2025-10-08', 1018, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (202, '2025-10-07', '2025-10-09', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (203, '2025-10-08', '2025-10-08', 1023, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (204, '2025-10-08', '2025-10-08', 1026, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (205, '2025-10-08', '2025-10-12', 1006, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (206, '2025-10-08', '2025-10-12', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (207, '2025-10-08', '2025-10-10', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (208, '2025-10-09', '2025-10-11', 1019, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (209, '2025-10-10', '2025-10-11', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (210, '2025-10-10', '2025-10-12', 1024, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (211, '2025-10-10', '2025-10-13', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (212, '2025-10-10', '2025-10-11', 1007, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (213, '2025-10-11', '2025-10-12', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (214, '2025-10-11', '2025-10-11', 1021, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (215, '2025-10-11', '2025-10-11', 1002, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (216, '2025-10-11', '2025-10-11', 1016, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (217, '2025-10-12', '2025-10-14', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (218, '2025-10-12', '2025-10-15', 1014, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (219, '2025-10-12', '2025-10-13', 1018, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (220, '2025-10-12', '2025-10-14', 1014, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (221, '2025-10-12', '2025-10-14', 1008, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (222, '2025-10-12', '2025-10-16', 1007, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (223, '2025-10-12', '2025-10-15', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (224, '2025-10-12', '2025-10-15', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (225, '2025-10-13', '2025-10-13', 1017, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (226, '2025-10-13', '2025-10-15', 1023, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (227, '2025-10-14', '2025-10-17', 1006, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (228, '2025-10-15', '2025-10-15', 1017, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (229, '2025-10-15', '2025-10-18', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (230, '2025-10-15', '2025-10-19', 1008, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (231, '2025-10-15', '2025-10-17', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (232, '2025-10-15', '2025-10-16', 1017, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (233, '2025-10-16', '2025-10-18', 1014, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (234, '2025-10-16', '2025-10-19', 1010, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (235, '2025-10-16', '2025-10-19', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (236, '2025-10-17', '2025-10-19', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (237, '2025-10-17', '2025-10-19', 1027, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (238, '2025-10-17', '2025-10-20', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (239, '2025-10-17', '2025-10-18', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (240, '2025-10-18', '2025-10-18', 1022, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (241, '2025-10-18', '2025-10-18', 1008, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (242, '2025-10-18', '2025-10-20', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (243, '2025-10-18', '2025-10-21', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (244, '2025-10-18', '2025-10-21', 1014, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (245, '2025-10-18', '2025-10-19', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (246, '2025-10-19', '2025-10-22', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (247, '2025-10-19', '2025-10-22', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (248, '2025-10-19', '2025-10-20', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (249, '2025-10-19', '2025-10-22', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (250, '2025-10-19', '2025-10-21', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (251, '2025-10-19', '2025-10-22', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (252, '2025-10-19', '2025-10-20', 1010, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (253, '2025-10-20', '2025-10-20', 1024, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (254, '2025-10-21', '2025-10-25', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (255, '2025-10-21', '2025-10-21', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (256, '2025-10-21', '2025-10-21', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (257, '2025-10-21', '2025-10-21', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (258, '2025-10-22', '2025-10-22', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (259, '2025-10-22', '2025-10-22', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (260, '2025-10-22', '2025-10-22', 1006, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (261, '2025-10-22', '2025-10-26', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (262, '2025-10-22', '2025-10-24', 1020, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (263, '2025-10-22', '2025-10-25', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (264, '2025-10-22', '2025-10-22', 1002, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (265, '2025-10-22', '2025-10-25', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (266, '2025-10-22', '2025-10-26', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (267, '2025-10-22', '2025-10-23', 1004, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (268, '2025-10-23', '2025-10-24', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (269, '2025-10-23', '2025-10-24', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (270, '2025-10-23', '2025-10-26', 1007, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (271, '2025-10-24', '2025-10-24', 1010, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (272, '2025-10-24', '2025-10-26', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (273, '2025-10-24', '2025-10-24', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (274, '2025-10-24', '2025-10-26', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (275, '2025-10-24', '2025-10-28', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (276, '2025-10-24', '2025-10-24', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (277, '2025-10-24', '2025-10-24', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (278, '2025-10-24', '2025-10-25', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (279, '2025-10-25', '2025-10-29', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (280, '2025-10-25', '2025-10-27', 1016, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (281, '2025-10-25', '2025-10-27', 1006, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (282, '2025-10-26', '2025-10-28', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (283, '2025-10-26', '2025-10-27', 1015, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (284, '2025-10-26', '2025-10-30', 1016, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (285, '2025-10-26', '2025-10-27', 1024, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (286, '2025-10-26', '2025-10-27', 1019, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (287, '2025-10-26', '2025-10-29', 1018, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (288, '2025-10-26', '2025-10-30', 1027, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (289, '2025-10-27', '2025-10-31', 1002, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (290, '2025-10-28', '2025-10-28', 1018, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (291, '2025-10-28', '2025-11-01', 1025, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (292, '2025-10-28', '2025-10-28', 1013, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (293, '2025-10-28', '2025-10-29', 1025, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (294, '2025-10-29', '2025-10-30', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (295, '2025-10-29', '2025-10-29', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (296, '2025-10-29', '2025-10-29', 1014, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (297, '2025-10-29', '2025-11-01', 1008, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (298, '2025-10-29', '2025-11-01', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (299, '2025-10-30', '2025-11-03', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (300, '2025-10-30', '2025-10-30', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (301, '2025-10-30', '2025-11-03', 1025, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (302, '2025-10-30', '2025-11-01', 1007, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (303, '2025-10-31', '2025-11-03', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (304, '2025-10-31', '2025-11-04', 1015, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (305, '2025-10-31', '2025-11-04', 1013, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (306, '2025-10-31', '2025-11-02', 1026, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (307, '2025-10-31', '2025-11-01', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (308, '2025-10-31', '2025-11-01', 1002, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (309, '2025-10-31', '2025-11-03', 1020, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (310, '2025-10-31', '2025-11-02', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (311, '2025-11-01', '2025-11-03', 1003, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (312, '2025-11-01', '2025-11-01', 1003, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (313, '2025-11-01', '2025-11-01', 1024, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (314, '2025-11-01', '2025-11-03', 1007, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (315, '2025-11-01', '2025-11-05', 1024, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (316, '2025-11-01', '2025-11-05', 1018, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (317, '2025-11-01', '2025-11-01', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (318, '2025-11-01', '2025-11-02', 1024, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (319, '2025-11-02', '2025-11-03', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (320, '2025-11-02', '2025-11-06', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (321, '2025-11-02', '2025-11-04', 1011, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (322, '2025-11-02', '2025-11-03', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (323, '2025-11-02', '2025-11-04', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (324, '2025-11-02', '2025-11-03', 1016, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (325, '2025-11-02', '2025-11-03', 1002, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (326, '2025-11-02', '2025-11-06', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (327, '2025-11-02', '2025-11-02', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (328, '2025-11-02', '2025-11-05', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (329, '2025-11-03', '2025-11-05', 1004, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (330, '2025-11-03', '2025-11-06', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (331, '2025-11-03', '2025-11-05', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (332, '2025-11-04', '2025-11-04', 1006, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (333, '2025-11-04', '2025-11-06', 1003, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (334, '2025-11-04', '2025-11-08', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (335, '2025-11-04', '2025-11-05', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (336, '2025-11-05', '2025-11-06', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (337, '2025-11-05', '2025-11-06', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (338, '2025-11-05', '2025-11-05', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (339, '2025-11-05', '2025-11-09', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (340, '2025-11-05', '2025-11-09', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (341, '2025-11-06', '2025-11-07', 1022, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (342, '2025-11-07', '2025-11-09', 1013, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (343, '2025-11-07', '2025-11-10', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (344, '2025-11-07', '2025-11-11', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (345, '2025-11-07', '2025-11-10', 1008, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (346, '2025-11-07', '2025-11-11', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (347, '2025-11-08', '2025-11-08', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (348, '2025-11-08', '2025-11-10', 1015, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (349, '2025-11-08', '2025-11-09', 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (350, '2025-11-08', '2025-11-10', 1019, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (351, '2025-11-09', '2025-11-13', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (352, '2025-11-09', '2025-11-10', 1020, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (353, '2025-11-09', '2025-11-13', 1026, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (354, '2025-11-10', '2025-11-11', 1021, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (355, '2025-11-10', '2025-11-11', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (356, '2025-11-10', '2025-11-14', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (357, '2025-11-10', '2025-11-12', 1003, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (358, '2025-11-10', '2025-11-14', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (359, '2025-11-11', '2025-11-12', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (360, '2025-11-11', '2025-11-13', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (361, '2025-11-11', '2025-11-12', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (362, '2025-11-11', '2025-11-12', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (363, '2025-11-11', '2025-11-12', 1010, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (364, '2025-11-11', '2025-11-14', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (365, '2025-11-11', '2025-11-12', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (366, '2025-11-11', '2025-11-12', 1004, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (367, '2025-11-11', '2025-11-11', 1011, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (368, '2025-11-12', '2025-11-13', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (369, '2025-11-12', '2025-11-13', 1003, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (370, '2025-11-12', '2025-11-12', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (371, '2025-11-12', '2025-11-15', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (372, '2025-11-12', '2025-11-14', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (373, '2025-11-12', '2025-11-15', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (374, '2025-11-12', '2025-11-12', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (375, '2025-11-13', '2025-11-15', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (376, '2025-11-13', '2025-11-13', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (377, '2025-11-13', '2025-11-17', 1019, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (378, '2025-11-13', '2025-11-14', 1014, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (379, '2025-11-13', '2025-11-17', 1025, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (380, '2025-11-13', '2025-11-16', 1023, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (381, '2025-11-14', '2025-11-16', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (382, '2025-11-15', '2025-11-15', 1017, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (383, '2025-11-16', '2025-11-19', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (384, '2025-11-16', '2025-11-16', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (385, '2025-11-17', '2025-11-20', 1019, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (386, '2025-11-17', '2025-11-17', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (387, '2025-11-17', '2025-11-21', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (388, '2025-11-17', '2025-11-21', 1008, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (389, '2025-11-17', '2025-11-20', 1005, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (390, '2025-11-17', '2025-11-20', 1016, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (391, '2025-11-17', '2025-11-17', 1024, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (392, '2025-11-17', '2025-11-21', 1006, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (393, '2025-11-18', '2025-11-20', 1011, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (394, '2025-11-18', '2025-11-21', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (395, '2025-11-19', '2025-11-23', 1014, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (396, '2025-11-19', '2025-11-20', 1019, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (397, '2025-11-19', '2025-11-19', 1020, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (398, '2025-11-20', '2025-11-22', 1004, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (399, '2025-11-20', '2025-11-23', 1007, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (400, '2025-11-20', '2025-11-24', 1026, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (401, '2025-11-20', '2025-11-21', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (402, '2025-11-20', '2025-11-22', 1017, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (403, '2025-11-20', '2025-11-20', 1006, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (404, '2025-11-20', '2025-11-21', 1019, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (405, '2025-11-20', '2025-11-23', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (406, '2025-11-21', '2025-11-25', 1012, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (407, '2025-11-22', '2025-11-25', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (408, '2025-11-23', '2025-11-27', 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (409, '2025-11-23', '2025-11-24', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (410, '2025-11-23', '2025-11-24', 1008, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (411, '2025-11-24', '2025-11-25', 1002, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (412, '2025-11-24', '2025-11-27', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (413, '2025-11-24', '2025-11-25', 1001, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (414, '2025-11-24', '2025-11-28', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (415, '2025-11-24', '2025-11-27', 1013, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (416, '2025-11-24', '2025-11-25', 1024, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (417, '2025-11-24', '2025-11-27', 1017, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (418, '2025-11-24', '2025-11-24', 1012, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (419, '2025-11-25', '2025-11-25', 1006, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (420, '2025-11-25', '2025-11-25', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (421, '2025-11-25', '2025-11-28', 1022, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (422, '2025-11-25', '2025-11-26', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (423, '2025-11-25', '2025-11-29', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (424, '2025-11-25', '2025-11-27', 1025, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (425, '2025-11-26', '2025-11-30', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (426, '2025-11-26', '2025-11-29', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (427, '2025-11-26', '2025-11-29', 1020, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (428, '2025-11-26', '2025-11-27', 1024, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (429, '2025-11-26', '2025-11-29', 1016, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (430, '2025-11-26', '2025-11-30', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (431, '2025-11-27', '2025-11-30', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (432, '2025-11-27', '2025-11-30', 1022, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (433, '2025-11-27', '2025-11-27', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (434, '2025-11-27', '2025-11-29', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (435, '2025-11-27', '2025-11-29', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (436, '2025-11-27', '2025-11-30', 1014, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (437, '2025-11-27', '2025-11-29', 1002, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (438, '2025-11-27', '2025-12-01', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (439, '2025-11-28', '2025-12-02', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (440, '2025-11-28', '2025-11-29', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (441, '2025-11-28', '2025-11-28', 1010, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (442, '2025-11-28', '2025-12-01', 1002, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (443, '2025-11-29', '2025-12-02', 1001, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (444, '2025-11-29', '2025-11-30', 1002, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (445, '2025-11-29', '2025-11-30', 1007, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (446, '2025-11-29', '2025-12-03', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (447, '2025-11-29', '2025-11-30', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (448, '2025-11-29', '2025-12-01', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (449, '2025-11-29', '2025-11-29', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (450, '2025-11-30', '2025-12-04', 1004, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (451, '2025-11-30', '2025-12-02', 1003, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (452, '2025-11-30', '2025-12-02', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (453, '2025-11-30', '2025-12-04', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (454, '2025-11-30', '2025-12-02', 1010, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (455, '2025-11-30', '2025-12-01', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (456, '2025-12-01', '2025-12-02', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (457, '2025-12-01', '2025-12-05', 1019, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (458, '2025-12-02', '2025-12-02', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (459, '2025-12-02', '2025-12-03', 1007, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (460, '2025-12-03', '2025-12-05', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (461, '2025-12-03', '2025-12-07', 1021, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (462, '2025-12-03', '2025-12-03', 1004, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (463, '2025-12-04', '2025-12-07', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (464, '2025-12-04', '2025-12-07', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (465, '2025-12-04', '2025-12-04', 1012, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (466, '2025-12-05', '2025-12-06', 1026, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (467, '2025-12-05', '2025-12-05', 1013, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (468, '2025-12-05', '2025-12-06', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (469, '2025-12-05', '2025-12-05', 1011, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (470, '2025-12-05', '2025-12-08', 1014, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (471, '2025-12-05', '2025-12-07', 1025, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (472, '2025-12-05', '2025-12-09', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (473, '2025-12-05', '2025-12-08', 1016, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (474, '2025-12-05', '2025-12-08', 1006, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (475, '2025-12-06', '2025-12-10', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (476, '2025-12-06', '2025-12-10', 1014, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (477, '2025-12-06', '2025-12-06', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (478, '2025-12-06', '2025-12-10', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (479, '2025-12-06', '2025-12-09', 1024, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (480, '2025-12-06', '2025-12-06', 1011, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (481, '2025-12-07', '2025-12-10', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (482, '2025-12-07', '2025-12-07', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (483, '2025-12-07', '2025-12-08', 1005, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (484, '2025-12-08', '2025-12-09', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (485, '2025-12-08', '2025-12-10', 1003, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (486, '2025-12-08', '2025-12-09', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (487, '2025-12-08', '2025-12-10', 1009, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (488, '2025-12-08', '2025-12-10', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (489, '2025-12-08', '2025-12-08', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (490, '2025-12-08', '2025-12-10', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (491, '2025-12-08', '2025-12-09', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (492, '2025-12-09', '2025-12-11', 1008, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (493, '2025-12-09', '2025-12-13', 1005, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (494, '2025-12-09', '2025-12-13', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (495, '2025-12-09', '2025-12-10', 1012, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (496, '2025-12-10', '2025-12-10', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (497, '2025-12-10', '2025-12-11', 1002, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (498, '2025-12-10', '2025-12-12', 1018, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (499, '2025-12-10', '2025-12-14', 1016, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (500, '2025-12-10', '2025-12-10', 1007, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (501, '2025-12-11', '2025-12-14', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (502, '2025-12-11', '2025-12-14', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (503, '2025-12-11', '2025-12-13', 1026, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (504, '2025-12-11', '2025-12-14', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (505, '2025-12-11', '2025-12-15', 1006, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (506, '2025-12-11', '2025-12-13', 1016, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (507, '2025-12-11', '2025-12-11', 1017, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (508, '2025-12-11', '2025-12-14', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (509, '2025-12-12', '2025-12-13', 1010, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (510, '2025-12-12', '2025-12-13', 1015, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (511, '2025-12-12', '2025-12-12', 1026, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (512, '2025-12-12', '2025-12-14', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (513, '2025-12-12', '2025-12-15', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (514, '2025-12-12', '2025-12-14', 1025, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (515, '2025-12-12', '2025-12-15', 1003, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (516, '2025-12-12', '2025-12-16', 1021, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (517, '2025-12-13', '2025-12-15', 1007, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (518, '2025-12-13', '2025-12-14', 1007, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (519, '2025-12-13', '2025-12-15', 1018, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (520, '2025-12-13', '2025-12-17', 1027, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (521, '2025-12-13', '2025-12-17', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (522, '2025-12-13', '2025-12-17', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (523, '2025-12-14', '2025-12-16', 1003, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (524, '2025-12-15', '2025-12-19', 1002, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (525, '2025-12-15', '2025-12-18', 1019, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (526, '2025-12-15', '2025-12-18', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (527, '2025-12-15', '2025-12-19', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (528, '2025-12-16', '2025-12-17', 1026, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (529, '2025-12-16', '2025-12-18', 1013, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (530, '2025-12-16', '2025-12-18', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (531, '2025-12-16', '2025-12-16', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (532, '2025-12-17', '2025-12-18', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (533, '2025-12-17', '2025-12-20', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (534, '2025-12-17', '2025-12-17', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (535, '2025-12-17', '2025-12-18', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (536, '2025-12-17', '2025-12-20', 1020, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (537, '2025-12-17', '2025-12-20', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (538, '2025-12-18', '2025-12-19', 1008, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (539, '2025-12-19', '2025-12-23', 1008, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (540, '2025-12-19', '2025-12-23', 1007, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (541, '2025-12-20', '2025-12-22', 1006, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (542, '2025-12-21', '2025-12-24', 1008, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (543, '2025-12-21', '2025-12-24', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (544, '2025-12-21', '2025-12-21', 1009, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (545, '2025-12-21', '2025-12-25', 1010, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (546, '2025-12-21', '2025-12-21', 1013, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (547, '2025-12-21', '2025-12-21', 1011, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (548, '2025-12-21', '2025-12-23', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (549, '2025-12-21', '2025-12-21', 1024, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (550, '2025-12-22', '2025-12-24', 1003, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (551, '2025-12-23', '2025-12-27', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (552, '2025-12-23', '2025-12-26', 1023, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (553, '2025-12-23', '2025-12-27', 1002, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (554, '2025-12-23', '2025-12-24', 1002, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (555, '2025-12-23', '2025-12-26', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (556, '2025-12-23', '2025-12-27', 1019, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (557, '2025-12-23', '2025-12-23', 1026, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (558, '2025-12-24', '2025-12-25', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (559, '2025-12-24', '2025-12-26', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (560, '2025-12-24', '2025-12-28', 1016, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (561, '2025-12-24', '2025-12-27', 1025, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (562, '2025-12-24', '2025-12-27', 1006, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (563, '2025-12-24', '2025-12-25', 1020, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (564, '2025-12-24', '2025-12-26', 1001, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (565, '2025-12-25', '2025-12-27', 1014, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (566, '2025-12-25', '2025-12-26', 1007, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (567, '2025-12-25', '2025-12-27', 1001, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (568, '2025-12-25', '2025-12-26', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (569, '2025-12-25', '2025-12-27', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (570, '2025-12-25', '2025-12-29', 1022, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (571, '2025-12-26', '2025-12-29', 1019, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (572, '2025-12-26', '2025-12-26', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (573, '2025-12-26', '2025-12-28', 1019, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (574, '2025-12-26', '2025-12-26', 1003, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (575, '2025-12-26', '2025-12-30', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (576, '2025-12-27', '2025-12-27', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (577, '2025-12-27', '2025-12-27', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (578, '2025-12-27', '2025-12-28', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (579, '2025-12-27', '2025-12-31', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (580, '2025-12-27', '2025-12-27', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (581, '2025-12-28', '2025-12-28', 1003, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (582, '2025-12-28', '2025-12-31', 1004, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (583, '2025-12-28', '2025-12-28', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (584, '2025-12-29', '2025-12-31', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (585, '2025-12-29', '2025-12-29', 1009, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (586, '2025-12-29', '2025-12-30', 1023, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (587, '2025-12-29', '2026-01-02', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (588, '2025-12-29', '2025-12-29', 1003, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (589, '2025-12-29', '2025-12-29', 1013, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (590, '2025-12-29', '2026-01-02', 1018, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (591, '2025-12-30', '2026-01-02', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (592, '2025-12-30', '2026-01-01', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (593, '2025-12-30', '2026-01-02', 1026, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (594, '2025-12-30', '2025-12-30', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (595, '2025-12-31', '2026-01-03', 1015, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (596, '2025-12-31', '2026-01-04', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (597, '2025-12-31', '2025-12-31', 1006, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (598, '2025-12-31', '2026-01-01', 1013, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (599, '2026-01-01', '2026-01-01', 1011, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (600, '2026-01-01', '2026-01-05', 1006, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (601, '2026-01-01', '2026-01-02', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (602, '2026-01-01', '2026-01-05', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (603, '2026-01-01', '2026-01-03', 1015, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (604, '2026-01-01', '2026-01-02', 1006, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (605, '2026-01-01', '2026-01-02', 1020, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (606, '2026-01-02', '2026-01-03', 1007, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (607, '2026-01-02', '2026-01-05', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (608, '2026-01-02', '2026-01-06', 1001, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (609, '2026-01-02', '2026-01-06', 1017, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (610, '2026-01-02', '2026-01-02', 1020, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (611, '2026-01-02', '2026-01-04', 1005, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (612, '2026-01-02', '2026-01-03', 1005, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (613, '2026-01-03', '2026-01-05', 1015, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (614, '2026-01-04', '2026-01-05', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (615, '2026-01-05', '2026-01-06', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (616, '2026-01-05', '2026-01-06', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (617, '2026-01-05', '2026-01-05', 1012, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (618, '2026-01-05', '2026-01-09', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (619, '2026-01-05', '2026-01-06', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (620, '2026-01-05', '2026-01-07', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (621, '2026-01-05', '2026-01-08', 1007, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (622, '2026-01-06', '2026-01-06', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (623, '2026-01-06', '2026-01-08', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (624, '2026-01-06', '2026-01-09', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (625, '2026-01-06', '2026-01-08', 1006, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (626, '2026-01-06', '2026-01-10', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (627, '2026-01-06', '2026-01-08', 1027, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (628, '2026-01-06', '2026-01-07', 1026, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (629, '2026-01-07', '2026-01-11', 1014, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (630, '2026-01-07', '2026-01-09', 1026, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (631, '2026-01-07', '2026-01-07', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (632, '2026-01-07', '2026-01-11', 1001, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (633, '2026-01-07', '2026-01-09', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (634, '2026-01-07', '2026-01-11', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (635, '2026-01-07', '2026-01-10', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (636, '2026-01-07', '2026-01-10', 1002, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (637, '2026-01-07', '2026-01-10', 1008, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (638, '2026-01-07', '2026-01-09', 1003, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (639, '2026-01-08', '2026-01-10', 1019, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (640, '2026-01-08', '2026-01-11', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (641, '2026-01-08', '2026-01-11', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (642, '2026-01-08', '2026-01-10', 1012, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (643, '2026-01-08', '2026-01-11', 1011, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (644, '2026-01-08', '2026-01-09', 1021, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (645, '2026-01-08', '2026-01-12', 1024, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (646, '2026-01-08', '2026-01-09', 1017, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (647, '2026-01-09', '2026-01-13', 1014, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (648, '2026-01-09', '2026-01-10', 1015, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (649, '2026-01-09', '2026-01-13', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (650, '2026-01-09', '2026-01-09', 1005, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (651, '2026-01-09', '2026-01-12', 1025, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (652, '2026-01-10', '2026-01-10', 1024, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (653, '2026-01-10', '2026-01-13', 1015, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (654, '2026-01-10', '2026-01-14', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (655, '2026-01-10', '2026-01-14', 1007, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (656, '2026-01-10', '2026-01-10', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (657, '2026-01-10', '2026-01-13', 1001, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (658, '2026-01-10', '2026-01-10', 1010, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (659, '2026-01-10', '2026-01-12', 1023, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (660, '2026-01-11', '2026-01-14', 1027, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (661, '2026-01-11', '2026-01-15', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (662, '2026-01-11', '2026-01-13', 1006, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (663, '2026-01-11', '2026-01-14', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (664, '2026-01-11', '2026-01-11', 1015, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (665, '2026-01-11', '2026-01-11', 1020, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (666, '2026-01-11', '2026-01-13', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (667, '2026-01-11', '2026-01-14', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (668, '2026-01-11', '2026-01-14', 1018, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (669, '2026-01-11', '2026-01-14', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (670, '2026-01-12', '2026-01-16', 1021, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (671, '2026-01-12', '2026-01-12', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (672, '2026-01-12', '2026-01-15', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (673, '2026-01-12', '2026-01-12', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (674, '2026-01-12', '2026-01-12', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (675, '2026-01-12', '2026-01-13', 1016, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (676, '2026-01-12', '2026-01-15', 1002, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (677, '2026-01-13', '2026-01-16', 1005, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (678, '2026-01-13', '2026-01-16', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (679, '2026-01-13', '2026-01-14', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (680, '2026-01-13', '2026-01-16', 1013, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (681, '2026-01-13', '2026-01-14', 1015, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (682, '2026-01-13', '2026-01-15', 1018, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (683, '2026-01-13', '2026-01-13', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (684, '2026-01-14', '2026-01-17', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (685, '2026-01-14', '2026-01-15', 1005, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (686, '2026-01-14', '2026-01-18', 1026, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (687, '2026-01-14', '2026-01-16', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (688, '2026-01-14', '2026-01-18', 1002, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (689, '2026-01-14', '2026-01-15', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (690, '2026-01-14', '2026-01-14', 1016, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (691, '2026-01-14', '2026-01-18', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (692, '2026-01-15', '2026-01-18', 1019, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (693, '2026-01-15', '2026-01-18', 1002, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (694, '2026-01-15', '2026-01-16', 1019, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (695, '2026-01-15', '2026-01-17', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (696, '2026-01-15', '2026-01-16', 1002, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (697, '2026-01-15', '2026-01-15', 1005, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (698, '2026-01-16', '2026-01-17', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (699, '2026-01-17', '2026-01-18', 1013, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (700, '2026-01-17', '2026-01-17', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (701, '2026-01-17', '2026-01-19', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (702, '2026-01-17', '2026-01-20', 1020, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (703, '2026-01-17', '2026-01-19', 1007, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (704, '2026-01-17', '2026-01-21', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (705, '2026-01-17', '2026-01-20', 1015, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (706, '2026-01-17', '2026-01-17', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (707, '2026-01-17', '2026-01-18', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (708, '2026-01-18', '2026-01-21', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (709, '2026-01-18', '2026-01-18', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (710, '2026-01-19', '2026-01-21', 1007, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (711, '2026-01-19', '2026-01-21', 1019, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (712, '2026-01-19', '2026-01-22', 1024, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (713, '2026-01-19', '2026-01-23', 1007, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (714, '2026-01-19', '2026-01-23', 1019, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (715, '2026-01-19', '2026-01-23', 1020, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (716, '2026-01-20', '2026-01-24', 1016, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (717, '2026-01-20', '2026-01-20', 1008, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (718, '2026-01-20', '2026-01-21', 1010, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (719, '2026-01-20', '2026-01-23', 1027, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (720, '2026-01-21', '2026-01-25', 1010, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (721, '2026-01-21', '2026-01-22', 1015, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (722, '2026-01-21', '2026-01-22', 1006, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (723, '2026-01-21', '2026-01-24', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (724, '2026-01-22', '2026-01-22', 1017, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (725, '2026-01-22', '2026-01-24', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (726, '2026-01-22', '2026-01-26', 1015, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (727, '2026-01-22', '2026-01-23', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (728, '2026-01-22', '2026-01-24', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (729, '2026-01-22', '2026-01-24', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (730, '2026-01-22', '2026-01-24', 1023, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (731, '2026-01-22', '2026-01-26', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (732, '2026-01-23', '2026-01-25', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (733, '2026-01-23', '2026-01-24', 1011, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (734, '2026-01-24', '2026-01-26', 1016, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (735, '2026-01-24', '2026-01-24', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (736, '2026-01-24', '2026-01-28', 1003, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (737, '2026-01-24', '2026-01-27', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (738, '2026-01-24', '2026-01-26', 1017, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (739, '2026-01-24', '2026-01-25', 1022, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (740, '2026-01-25', '2026-01-26', 1011, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (741, '2026-01-25', '2026-01-25', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (742, '2026-01-25', '2026-01-28', 1013, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (743, '2026-01-25', '2026-01-27', 1008, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (744, '2026-01-25', '2026-01-28', 1027, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (745, '2026-01-25', '2026-01-29', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (746, '2026-01-25', '2026-01-29', 1013, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (747, '2026-01-25', '2026-01-28', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (748, '2026-01-25', '2026-01-28', 1021, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (749, '2026-01-25', '2026-01-29', 1021, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (750, '2026-01-26', '2026-01-30', 1018, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (751, '2026-01-26', '2026-01-30', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (752, '2026-01-27', '2026-01-31', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (753, '2026-01-27', '2026-01-29', 1013, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (754, '2026-01-27', '2026-01-31', 1014, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (755, '2026-01-28', '2026-01-31', 1010, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (756, '2026-01-28', '2026-01-28', 1005, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (757, '2026-01-28', '2026-01-30', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (758, '2026-01-28', '2026-01-30', 1020, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (759, '2026-01-28', '2026-01-28', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (760, '2026-01-28', '2026-01-31', 1014, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (761, '2026-01-29', '2026-01-30', 1016, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (762, '2026-01-29', '2026-02-02', 1013, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (763, '2026-01-29', '2026-02-01', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (764, '2026-01-29', '2026-01-29', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (765, '2026-01-29', '2026-01-31', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (766, '2026-01-29', '2026-01-30', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (767, '2026-01-30', '2026-01-31', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (768, '2026-01-30', '2026-02-03', 1003, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (769, '2026-01-30', '2026-02-01', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (770, '2026-01-30', '2026-01-30', 1019, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (771, '2026-01-30', '2026-02-01', 1017, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (772, '2026-01-30', '2026-01-31', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (773, '2026-01-30', '2026-02-02', 1019, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (774, '2026-01-31', '2026-02-02', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (775, '2026-01-31', '2026-01-31', 1010, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (776, '2026-01-31', '2026-01-31', 1006, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (777, '2026-01-31', '2026-02-02', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (778, '2026-01-31', '2026-01-31', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (779, '2026-01-31', '2026-01-31', 1004, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (780, '2026-01-31', '2026-01-31', 1003, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (781, '2026-01-31', '2026-02-04', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (782, '2026-01-31', '2026-02-03', 1016, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (783, '2026-01-31', '2026-02-04', 1013, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (784, '2026-02-01', '2026-02-04', 1018, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (785, '2026-02-01', '2026-02-05', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (786, '2026-02-01', '2026-02-01', 1015, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (787, '2026-02-01', '2026-02-03', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (788, '2026-02-01', '2026-02-01', 1026, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (789, '2026-02-01', '2026-02-05', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (790, '2026-02-01', '2026-02-01', 1004, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (791, '2026-02-01', '2026-02-02', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (792, '2026-02-02', '2026-02-05', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (793, '2026-02-02', '2026-02-03', 1026, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (794, '2026-02-02', '2026-02-04', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (795, '2026-02-03', '2026-02-05', 1024, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (796, '2026-02-03', '2026-02-07', 1007, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (797, '2026-02-03', '2026-02-06', 1018, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (798, '2026-02-03', '2026-02-04', 1003, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (799, '2026-02-04', '2026-02-05', 1010, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (800, '2026-02-04', '2026-02-07', 1027, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (801, '2026-02-04', '2026-02-08', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (802, '2026-02-04', '2026-02-04', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (803, '2026-02-05', '2026-02-08', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (804, '2026-02-05', '2026-02-05', 1014, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (805, '2026-02-05', '2026-02-05', 1009, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (806, '2026-02-05', '2026-02-07', 1019, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (807, '2026-02-06', '2026-02-07', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (808, '2026-02-06', '2026-02-07', 1004, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (809, '2026-02-07', '2026-02-11', 1004, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (810, '2026-02-07', '2026-02-07', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (811, '2026-02-07', '2026-02-11', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (812, '2026-02-07', '2026-02-07', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (813, '2026-02-08', '2026-02-08', 1013, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (814, '2026-02-08', '2026-02-08', 1013, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (815, '2026-02-08', '2026-02-12', 1007, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (816, '2026-02-08', '2026-02-11', 1011, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (817, '2026-02-08', '2026-02-08', 1001, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (818, '2026-02-08', '2026-02-10', 1023, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (819, '2026-02-08', '2026-02-12', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (820, '2026-02-08', '2026-02-09', 1019, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (821, '2026-02-08', '2026-02-12', 1023, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (822, '2026-02-08', '2026-02-09', 1004, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (823, '2026-02-09', '2026-02-10', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (824, '2026-02-09', '2026-02-10', 1006, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (825, '2026-02-09', '2026-02-09', 1025, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (826, '2026-02-09', '2026-02-09', 1005, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (827, '2026-02-10', '2026-02-14', 1013, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (828, '2026-02-10', '2026-02-10', 1014, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (829, '2026-02-10', '2026-02-11', 1027, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (830, '2026-02-11', '2026-02-13', 1020, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (831, '2026-02-11', '2026-02-14', 1012, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (832, '2026-02-11', '2026-02-15', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (833, '2026-02-11', '2026-02-15', 1007, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (834, '2026-02-11', '2026-02-11', 1021, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (835, '2026-02-11', '2026-02-13', 1012, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (836, '2026-02-11', '2026-02-14', 1007, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (837, '2026-02-11', '2026-02-13', 1012, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (838, '2026-02-11', '2026-02-13', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (839, '2026-02-12', '2026-02-12', 1012, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (840, '2026-02-12', '2026-02-12', 1001, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (841, '2026-02-12', '2026-02-16', 1017, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (842, '2026-02-12', '2026-02-14', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (843, '2026-02-12', '2026-02-14', 1008, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (844, '2026-02-12', '2026-02-14', 1014, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (845, '2026-02-12', '2026-02-15', 1020, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (846, '2026-02-13', '2026-02-17', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (847, '2026-02-13', '2026-02-15', 1027, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (848, '2026-02-13', '2026-02-16', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (849, '2026-02-13', '2026-02-15', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (850, '2026-02-13', '2026-02-13', 1003, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (851, '2026-02-13', '2026-02-13', 1001, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (852, '2026-02-13', '2026-02-16', 1002, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (853, '2026-02-13', '2026-02-16', 1023, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (854, '2026-02-13', '2026-02-16', 1004, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (855, '2026-02-14', '2026-02-15', 1001, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (856, '2026-02-14', '2026-02-14', 1026, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (857, '2026-02-14', '2026-02-14', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (858, '2026-02-15', '2026-02-19', 1023, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (859, '2026-02-16', '2026-02-16', 1016, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (860, '2026-02-16', '2026-02-19', 1003, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (861, '2026-02-16', '2026-02-16', 1026, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (862, '2026-02-16', '2026-02-20', 1010, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (863, '2026-02-16', '2026-02-17', 1025, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (864, '2026-02-16', '2026-02-16', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (865, '2026-02-16', '2026-02-20', 1024, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (866, '2026-02-16', '2026-02-17', 1022, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (867, '2026-02-16', '2026-02-20', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (868, '2026-02-16', '2026-02-18', 1021, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (869, '2026-02-17', '2026-02-19', 1024, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (870, '2026-02-17', '2026-02-20', 1005, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (871, '2026-02-17', '2026-02-19', 1021, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (872, '2026-02-17', '2026-02-21', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (873, '2026-02-17', '2026-02-18', 1020, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (874, '2026-02-18', '2026-02-21', 1005, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (875, '2026-02-18', '2026-02-22', 1017, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (876, '2026-02-18', '2026-02-18', 1005, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (877, '2026-02-18', '2026-02-18', 1017, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (878, '2026-02-18', '2026-02-21', 1008, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (879, '2026-02-18', '2026-02-19', 1013, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (880, '2026-02-18', '2026-02-22', 1006, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (881, '2026-02-18', '2026-02-20', 1016, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (882, '2026-02-18', '2026-02-22', 1008, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (883, '2026-02-19', '2026-02-22', 1011, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (884, '2026-02-19', '2026-02-22', 1027, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (885, '2026-02-20', '2026-02-23', 1009, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (886, '2026-02-20', '2026-02-21', 1027, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (887, '2026-02-20', '2026-02-23', 1001, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (888, '2026-02-20', '2026-02-23', 1007, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (889, '2026-02-20', '2026-02-24', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (890, '2026-02-20', '2026-02-24', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (891, '2026-02-20', '2026-02-21', 1006, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (892, '2026-02-21', '2026-02-22', 1010, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (893, '2026-02-21', '2026-02-25', 1022, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (894, '2026-02-21', '2026-02-23', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (895, '2026-02-21', '2026-02-21', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (896, '2026-02-21', '2026-02-24', 1025, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (897, '2026-02-21', '2026-02-24', 1027, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (898, '2026-02-21', '2026-02-24', 1001, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (899, '2026-02-21', '2026-02-25', 1009, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (900, '2026-02-22', '2026-02-24', 1020, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (901, '2026-02-22', '2026-02-24', 1013, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (902, '2026-02-22', '2026-02-23', 1006, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (903, '2026-02-22', '2026-02-23', 1021, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (904, '2026-02-22', '2026-02-26', 1009, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (905, '2026-02-22', '2026-02-24', 1024, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (906, '2026-02-22', '2026-02-22', 1012, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (907, '2026-02-23', '2026-02-23', 1014, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (908, '2026-02-23', '2026-02-24', 1025, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (909, '2026-02-24', '2026-02-24', 1024, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (910, '2026-02-24', '2026-02-27', 1019, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (911, '2026-02-24', '2026-02-26', 1023, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (912, '2026-02-24', '2026-02-28', 1025, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (913, '2026-02-24', '2026-02-25', 1025, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (914, '2026-02-24', '2026-02-24', 1022, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (915, '2026-02-24', '2026-02-25', 1016, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (916, '2026-02-24', '2026-02-24', 1025, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (917, '2026-02-24', '2026-02-26', 1013, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (918, '2026-02-25', '2026-02-28', 1025, 703);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (919, '2026-02-25', '2026-02-27', 1014, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (920, '2026-02-26', '2026-03-01', 1008, 708);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (921, '2026-02-26', '2026-02-26', 1018, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (922, '2026-02-26', '2026-02-27', 1004, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (923, '2026-02-26', '2026-03-01', 1009, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (924, '2026-02-26', '2026-03-01', 1002, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (925, '2026-02-26', '2026-02-26', 1025, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (926, '2026-02-26', '2026-02-27', 1005, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (927, '2026-02-27', '2026-02-28', 1007, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (928, '2026-02-27', '2026-03-02', 1017, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (929, '2026-02-27', '2026-02-27', 1020, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (930, '2026-02-27', '2026-03-01', 1023, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (931, '2026-02-27', '2026-02-27', 1001, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (932, '2026-02-27', '2026-02-27', 1012, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (933, '2026-02-27', '2026-02-27', 1026, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (934, '2026-02-27', '2026-02-28', 1021, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (935, '2026-02-27', '2026-03-02', 1020, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (936, '2026-02-28', '2026-03-01', 1025, 704);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (937, '2026-02-28', '2026-03-04', 1014, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (938, '2026-02-28', '2026-02-28', 1011, 705);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (939, '2026-02-28', '2026-02-28', 1021, 701);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (940, '2026-02-28', '2026-03-04', 1007, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (941, '2026-02-28', '2026-02-28', 1019, 702);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (942, '2026-02-28', '2026-03-01', 1002, 706);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (943, '2026-02-28', '2026-03-01', 1026, 707);
INSERT INTO Zamowienia
  (NumerZamowienia, DataZamowienia, DataWysylki, IDKlienta, IDPracownika)
  VALUES (944, '2026-02-28', '2026-03-03', 1020, 702);
 
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (1, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (2, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (2, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (3, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (4, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (4, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (4, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (4, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (4, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (5, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (5, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (5, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 2, 1746, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (6, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (7, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (7, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (8, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (8, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (8, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (8, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (8, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (9, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (10, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (10, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (11, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (12, 10, 36, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (13, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (13, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (13, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (13, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (14, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (14, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (14, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (15, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (15, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (15, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (15, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (15, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (16, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (17, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (18, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (18, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (18, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (18, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (19, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (20, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (20, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (21, 3, 75, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (21, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (21, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (22, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (22, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (22, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (22, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (22, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (23, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (24, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (25, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (25, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (25, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (25, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (25, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (26, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (27, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (28, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (28, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (29, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (30, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (30, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (30, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (30, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (30, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (31, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (32, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (33, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (34, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (34, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (35, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (35, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (35, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (36, 5, 7.45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (37, 8, 50, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (37, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (37, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (37, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (38, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (39, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (40, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (40, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (40, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (41, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (42, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (42, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (42, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (42, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (42, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (43, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (44, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (45, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (46, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (47, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (48, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (48, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (48, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (49, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (49, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (49, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (49, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (49, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (50, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (50, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (50, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (50, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (51, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (52, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (53, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (54, 10, 36, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (55, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (56, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (56, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (56, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (56, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (57, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (58, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (59, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (60, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (61, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (61, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (61, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (61, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (61, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (62, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (62, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (62, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (62, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (62, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (63, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (63, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (64, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (65, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (65, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (65, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (65, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (66, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (67, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (68, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (69, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (69, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (69, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (69, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (70, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (70, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (70, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (71, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (71, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (71, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (72, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (72, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (72, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (72, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (72, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (73, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (74, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (75, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (76, 18, 173.63, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (77, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (78, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (78, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (78, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (78, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (79, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (80, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (81, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (82, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (83, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (83, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (84, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (84, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (84, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (84, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (85, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (85, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (85, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (85, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (85, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (86, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (87, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (87, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (87, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (88, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (89, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (89, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (89, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (90, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (91, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (92, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (92, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (92, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (93, 3, 75, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (94, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (95, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (95, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (95, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (95, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (95, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (96, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (96, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (96, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (96, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (97, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (97, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (97, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (98, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (98, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (99, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (99, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (100, 3, 75, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (100, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (100, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (100, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (100, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (101, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (101, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (101, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (101, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (102, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (102, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (102, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (102, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (102, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (103, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (104, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (104, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 2, 1746, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 8, 50, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (105, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (106, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (107, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (107, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (107, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (107, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (107, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (108, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (109, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (110, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (110, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (110, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (110, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 2, 1746, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (111, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (112, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (112, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (113, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (113, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (113, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (114, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (114, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (115, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (115, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (115, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (115, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (115, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (116, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (116, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (116, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (116, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (116, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (117, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (118, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (119, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (120, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (120, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (120, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (120, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (120, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (121, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (121, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (121, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (122, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (122, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (122, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (122, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (122, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (123, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (124, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (124, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (125, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (125, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (125, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (126, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (127, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (128, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (128, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (129, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (130, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (131, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (131, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (131, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (132, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (132, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (133, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (134, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (134, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (134, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (134, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (134, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (135, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (135, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (135, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (135, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (135, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (136, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (136, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (136, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (136, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (136, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (137, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (137, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (137, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (137, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (138, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (139, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (140, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (141, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (142, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (142, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (143, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (143, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (144, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (144, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (144, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (145, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (145, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (146, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (147, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (147, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (147, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (148, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (149, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (149, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (150, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (150, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (150, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (150, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (151, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 2, 1800, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 12, 23.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (152, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (153, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (153, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (153, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (153, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (153, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (154, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (154, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (155, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (155, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (155, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (155, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (156, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (157, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (157, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (157, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (157, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (158, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (159, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (159, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (159, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (159, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (160, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (161, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (161, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (161, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (162, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (162, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (163, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (164, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (164, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (165, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (166, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (166, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (166, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (166, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (166, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (167, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (167, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (167, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (167, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (167, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (168, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (169, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (170, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (171, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (172, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (172, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (172, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (172, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (173, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (173, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (174, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (174, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (175, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (176, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (176, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (176, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (176, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (177, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (177, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (177, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (177, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (177, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (178, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (178, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (178, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (178, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (179, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (180, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (180, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (181, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (181, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (181, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (181, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (182, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (183, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (184, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (185, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (185, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (185, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (185, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (186, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (186, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (187, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (187, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (188, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (188, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (189, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (189, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (189, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (189, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (190, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (191, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (192, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (192, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (192, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (192, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (193, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (194, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (194, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (194, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (195, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (196, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (197, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (199, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (200, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (201, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (202, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (203, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (204, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (205, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (206, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (206, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (206, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (207, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (207, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (208, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (209, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (209, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (210, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (211, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (212, 3, 75, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (213, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (213, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (214, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (214, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (214, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (215, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (217, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (217, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (217, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (217, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (218, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (219, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (220, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (221, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (221, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (221, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (221, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (221, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (222, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (222, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (222, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (222, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (223, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (223, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (223, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (223, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (224, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (224, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (224, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (224, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (224, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (225, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (226, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (226, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (226, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (227, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (228, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (229, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (229, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (230, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (231, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (232, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (233, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (233, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (234, 10, 36, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (234, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (235, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (235, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (235, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (235, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 5, 7.45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 10, 34.92, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (236, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 2, 1800, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (237, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (238, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (238, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (238, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (239, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (240, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (240, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (240, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (241, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (241, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (241, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (242, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (243, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (244, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (245, 10, 34.92, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (245, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (245, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (245, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (246, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (247, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (247, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (247, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (247, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (247, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (248, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (249, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (250, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (250, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (250, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (251, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (252, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (253, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (253, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (254, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (254, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (254, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (255, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (256, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (257, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (258, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (259, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (260, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (260, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (260, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (260, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (260, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (261, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (261, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (261, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (262, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (263, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (263, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (263, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (263, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (264, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 2, 1800, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (265, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (266, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (266, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (266, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (266, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (266, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (267, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (267, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (267, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (268, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (269, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (270, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (270, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (270, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (270, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (271, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (271, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (271, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (271, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (271, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (272, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (272, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (272, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (272, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (273, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (273, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (273, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (273, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (273, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (274, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (275, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (276, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (276, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (276, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (276, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (276, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (277, 12, 23.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (277, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (277, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (277, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (278, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (278, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (278, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (279, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (279, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (279, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (279, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (280, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (280, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (280, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (281, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (282, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (282, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (282, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (283, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (283, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (284, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (285, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (285, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (285, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (285, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (286, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (286, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (287, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (287, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (288, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (288, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (289, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (289, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (289, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (289, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (290, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (290, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (290, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (291, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (291, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (291, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (292, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (293, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (294, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (295, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (295, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (295, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (295, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (295, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (296, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (296, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (297, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (297, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (298, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (298, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (299, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (299, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (300, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (301, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (301, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (301, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (302, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (302, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (302, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (303, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (304, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (304, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (304, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (304, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (304, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (306, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (306, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (306, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (307, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (308, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (308, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (308, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (308, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (309, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (309, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (309, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (309, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (309, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (310, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (311, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (311, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (311, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (311, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (312, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (312, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (312, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (312, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (312, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (313, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (313, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (313, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (313, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (314, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (314, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (315, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (316, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (317, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (317, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (317, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (317, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (317, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (318, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (319, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (319, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (320, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (321, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (322, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 12, 23.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (323, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (324, 8, 50, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 12, 23.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (325, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (326, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (327, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (327, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (327, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (327, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (327, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (328, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (329, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (330, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (330, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (330, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (330, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (331, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (332, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (332, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (332, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (332, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (333, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (333, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (333, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (333, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (333, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (334, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (335, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (335, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (335, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (335, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (336, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (337, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (337, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (337, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (337, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (338, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (338, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (338, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (338, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (338, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (339, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (340, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (340, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (340, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (341, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (342, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (342, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (342, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (343, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (343, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (343, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (344, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (344, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (344, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (344, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (344, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (345, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (345, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (345, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (345, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (345, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (346, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (346, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (346, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (346, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (346, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (347, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (347, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (347, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (348, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (348, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (348, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (348, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (348, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (349, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (349, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (350, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (351, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (352, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (352, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (352, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (353, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (354, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (355, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (355, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (355, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (355, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (355, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (356, 2, 1800, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (356, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (356, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (356, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (357, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (358, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (359, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (360, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (362, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (363, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (364, 3, 75, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (364, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (364, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (365, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (365, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (366, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (367, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (368, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (368, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (369, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (370, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (370, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (370, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (370, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (370, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (371, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (371, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (371, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (372, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (373, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (374, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (374, 12, 23.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (374, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (374, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 2, 1800, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (375, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (376, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (376, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (376, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (376, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (376, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (377, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 18, 173.63, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (378, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (379, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (379, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (379, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (379, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (380, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (381, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (382, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (383, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (384, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (384, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (385, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (386, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (386, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (386, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (386, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (386, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (387, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (388, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (388, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (388, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (388, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (388, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (389, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (389, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (389, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (389, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (390, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (391, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (392, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (392, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (392, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (392, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (393, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (393, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (394, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (394, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (395, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (396, 5, 7.45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (396, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (396, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (396, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (397, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (398, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (399, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (400, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (401, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (401, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (401, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (401, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (402, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (402, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (402, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (402, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (402, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (403, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (404, 2, 1746, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (405, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (405, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (405, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (405, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (406, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (406, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (406, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (406, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (406, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (407, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (407, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (408, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (409, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (409, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (409, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (410, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (410, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (410, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (411, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (412, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (413, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (413, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (414, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (415, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (415, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (415, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (416, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (417, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (418, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (418, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (418, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (418, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (419, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (420, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (420, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (420, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (420, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (420, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (421, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (421, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (422, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (422, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (423, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (424, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (425, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (425, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (425, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (426, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (426, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (426, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (426, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (427, 5, 7.45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (427, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (427, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (428, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (429, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (430, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (431, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (432, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (432, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (432, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (433, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (434, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (435, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (436, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (436, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (437, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (437, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (437, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (437, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (437, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (438, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (439, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (439, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (439, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (440, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (440, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (441, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (442, 12, 23.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (442, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (442, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (442, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (443, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (443, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (443, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (443, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (443, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (444, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (445, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (445, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (445, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (445, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (445, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (446, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (446, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (447, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (447, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (447, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (447, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (447, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (448, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (448, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (449, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (450, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (451, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (452, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (453, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (454, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (454, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (454, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (455, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (455, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (456, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (457, 2, 1800, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (457, 10, 36, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (457, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (457, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (457, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (458, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (458, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (458, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (458, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (459, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (459, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (459, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (459, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (460, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (461, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (461, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (461, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (461, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (461, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (462, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (462, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (463, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (463, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (464, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (464, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (464, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (465, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (466, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (467, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (467, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (467, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (468, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (468, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (468, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (468, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (468, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (469, 2, 1746, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (469, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (469, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (470, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (470, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (470, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (470, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (471, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (472, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (472, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (473, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (474, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (475, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (475, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (475, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (475, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (475, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (476, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (476, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (477, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (478, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (479, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (480, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (480, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (480, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (480, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (480, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (481, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (481, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (481, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (481, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (482, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (483, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (483, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (483, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (483, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (485, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 5, 7.45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (486, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (487, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (487, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (487, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (487, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (488, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (488, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (489, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (489, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (490, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (490, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (490, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (491, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (492, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (493, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (493, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (494, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (495, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (496, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (496, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (496, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (497, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (498, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (499, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (499, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (499, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (499, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (500, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (500, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (500, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (500, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (501, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (501, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (501, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (501, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (502, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (502, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (502, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (502, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (503, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (503, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (503, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (503, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (503, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (504, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (505, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (506, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (506, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (507, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (507, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (507, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (507, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (508, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (508, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (508, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (508, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (509, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (509, 18, 173.63, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (509, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (509, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (510, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (510, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (510, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (510, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (511, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (511, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (511, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (511, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (512, 8, 48.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (513, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (514, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (514, 10, 36, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (514, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (514, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (514, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (515, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (515, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (515, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (515, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (516, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (516, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (516, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 5, 7.45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 10, 36, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (517, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (518, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (518, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (519, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (519, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (519, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (519, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (520, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (521, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (521, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (522, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (524, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 3, 75, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (525, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (526, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (526, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (527, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (528, 2, 1800, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (528, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (529, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (529, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (529, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (529, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (529, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (530, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (531, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (532, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (532, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (532, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (532, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (532, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (533, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (534, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (534, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (535, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (535, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (535, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (536, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (537, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (537, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (537, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (537, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (538, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (539, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (540, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (540, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (540, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (540, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (540, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (541, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (541, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (541, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (541, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (542, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (542, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (542, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (543, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (544, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (545, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (546, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (546, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (547, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (547, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (547, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (547, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (547, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (548, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (549, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (550, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (551, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (552, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (553, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (553, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (553, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (553, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (554, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (554, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (554, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (554, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (554, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 3, 72.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 8, 50, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (555, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (556, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (556, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (556, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (556, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (556, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (557, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (558, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (559, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (560, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (561, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (562, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (563, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (564, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (564, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (565, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (565, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (566, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (567, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (567, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (568, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (569, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (570, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (570, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (570, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (571, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (571, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (571, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (572, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (572, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (572, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (572, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (572, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (573, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (573, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (573, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (573, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (573, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (574, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (575, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (576, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (577, 12, 23.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (577, 20, 14.55, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (577, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (577, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (578, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (578, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (578, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (578, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (579, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (580, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (580, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (581, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (581, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (581, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (581, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (581, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (582, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (583, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (583, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (583, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (583, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (583, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (584, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (584, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (584, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (584, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (585, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (585, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (585, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (586, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (587, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (587, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (588, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (588, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (588, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (588, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (589, 10, 34.92, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (589, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (590, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (591, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (591, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (591, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (591, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (591, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (592, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (593, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (594, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (594, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (594, 18, 173.63, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (594, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (594, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (595, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (596, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (596, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (596, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (596, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (596, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (597, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (598, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (599, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (599, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (599, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (600, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (601, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (602, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (603, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (603, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (603, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (603, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (604, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (604, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (604, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (605, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (606, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (606, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (606, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (607, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (607, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (608, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (608, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (608, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (608, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (609, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (609, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (609, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (609, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (609, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (610, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (611, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (612, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (613, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (614, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (614, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (614, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (615, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (616, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (616, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (617, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (618, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (618, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (618, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (618, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (619, 3, 75, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 28, 29, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (620, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (621, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (622, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (622, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (622, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (622, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (622, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (623, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (623, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (624, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (624, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (624, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (624, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (625, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (626, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (626, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (626, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (627, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (627, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (628, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (630, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (630, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (630, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (630, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (631, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (633, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (633, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (634, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (634, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (634, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (634, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (635, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (636, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (637, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (638, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (638, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (639, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (640, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (640, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (640, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (641, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (641, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (641, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (641, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (642, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (642, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (642, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (642, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (642, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (643, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (643, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (643, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (643, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (644, 3, 75, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (644, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (644, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (645, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (645, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (646, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (647, 3, 75, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (647, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (647, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (648, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (649, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (649, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (649, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (650, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (650, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (650, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (651, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (652, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (653, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (653, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (654, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (655, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (655, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (655, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (655, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (655, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (656, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (656, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (656, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (656, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (657, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (657, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (657, 30, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (657, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (658, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (658, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (658, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (658, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (658, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (659, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (659, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (659, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (660, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (661, 2, 1800, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (661, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (661, 28, 29, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (662, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (663, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (663, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (663, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (663, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (663, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (664, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (664, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (665, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (665, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (665, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (665, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (666, 2, 1800, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (666, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (667, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (668, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (668, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (668, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (668, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (668, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (669, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (670, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (670, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (670, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (671, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (672, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (672, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (672, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (672, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (672, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (673, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (673, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (673, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (674, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (674, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (675, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (675, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (675, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (675, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (675, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (676, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (677, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (678, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (679, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 8, 48.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (680, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (681, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (681, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (681, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (681, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 12, 23.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (682, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (683, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (684, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (685, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (686, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (687, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (687, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (687, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (687, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (687, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (688, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (688, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (688, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (688, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (688, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (690, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (690, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (690, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (690, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (691, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (692, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (692, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (693, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (693, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (693, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (693, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (694, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (695, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (695, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (696, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (697, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (697, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (697, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (698, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (698, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (698, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (698, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (699, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (699, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (699, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (699, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (700, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (700, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (701, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (701, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (701, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (702, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (703, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (703, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (704, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (704, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (705, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (705, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (706, 8, 50, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (706, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (706, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (706, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (707, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (708, 38, 161.02, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 12, 23.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (709, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (710, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (710, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (710, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (710, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (710, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (711, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (712, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (712, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (712, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (712, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (712, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (713, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (714, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (715, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (716, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (716, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (717, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (718, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (718, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (718, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (719, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (719, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (719, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (720, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (720, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (720, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (721, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (721, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (721, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (721, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (722, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (722, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (722, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (723, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (723, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (723, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (723, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (724, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (724, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (724, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (724, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (724, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (725, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (725, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 3, 75, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 18, 179, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (726, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (727, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (728, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (728, 22, 82, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (728, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (729, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (729, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (729, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (730, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (730, 9, 32.01, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (730, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (730, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (731, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (732, 18, 179, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (732, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (732, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (732, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (733, 8, 50, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (733, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (733, 24, 69, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (733, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (733, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (734, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (735, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (736, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (736, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (736, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (737, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (738, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (738, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (738, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (738, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (739, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (740, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 2, 1800, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 8, 48.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (741, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (742, 5, 7.45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (742, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (742, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (742, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (742, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (743, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (743, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (743, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (743, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (744, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (745, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (746, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (747, 35, 39, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (748, 5, 7.45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (748, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (748, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (748, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (748, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (749, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (750, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (751, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (751, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (751, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (751, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (751, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (752, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (754, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (755, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (756, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (756, 26, 125, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (756, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (757, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (758, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (759, 8, 50, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (759, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (759, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (760, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (761, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (762, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (763, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (763, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (764, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (764, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (765, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (765, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (765, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (765, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (765, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (766, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (766, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (767, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (768, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (769, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (770, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (771, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (771, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (772, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (772, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (772, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (772, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (773, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (774, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (774, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (774, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (774, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (774, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 3, 75, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (775, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (776, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (776, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (776, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (776, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (777, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (777, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (777, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (777, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (778, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (778, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (778, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (779, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 5, 7.45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 10, 34.92, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 15, 4.99, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (780, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (781, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (781, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (781, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (781, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (781, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (782, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (783, 2, 1800, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (783, 10, 34.92, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (783, 18, 173.63, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (783, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (783, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (784, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (784, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (784, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (785, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (785, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (785, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (786, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (786, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (786, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (786, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 32, 31.04, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (787, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (788, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (788, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (788, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (788, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (789, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (789, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (789, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (789, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 25, 139, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (790, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (791, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (791, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (791, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (792, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (792, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (793, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (793, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (793, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (794, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (794, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (794, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (795, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (795, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (795, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (796, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (796, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (796, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (797, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (798, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (798, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (798, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (798, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (799, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (800, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (800, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (800, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (800, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (801, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (802, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (802, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (803, 18, 179, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (803, 38, 161.02, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (804, 5, 7.45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (804, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (804, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (804, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (804, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (805, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (805, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (805, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (806, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (806, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (806, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (806, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (806, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (807, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (807, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (807, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (807, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (808, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (808, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (808, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (809, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (809, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (809, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (809, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (809, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (810, 15, 4.99, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (810, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (810, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (811, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (811, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (812, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (812, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (812, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (812, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (813, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (814, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (815, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (817, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (817, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (817, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (817, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (817, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (818, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (818, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (818, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (818, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (819, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (820, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (821, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (821, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (822, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (822, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (822, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (822, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (822, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (823, 29, 34, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (824, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (824, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (825, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (825, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (825, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 13, 65.47, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (826, 31, 21.34, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (827, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (827, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (827, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (827, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (827, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (828, 40, 180, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 7, 47.53, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 13, 67.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 32, 32, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (829, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (830, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (830, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (831, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (831, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (831, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (832, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (833, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (833, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (833, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (833, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (833, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 12, 23.5, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 22, 82, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (834, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (835, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (835, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (835, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (836, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (836, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (836, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (836, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (837, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (837, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (837, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (837, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 33, 19, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (838, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (839, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (839, 9, 33, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (839, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (839, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (839, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (840, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (840, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (840, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 27, 24, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (841, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (842, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (842, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (843, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (843, 24, 69, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (844, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (844, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (844, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (844, 34, 27, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (845, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (846, 5, 7.23, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (846, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (846, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (846, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (846, 37, 189, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (847, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (848, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (848, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (848, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (848, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (848, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (849, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (849, 27, 23.28, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (850, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (850, 21, 53.35, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (850, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (850, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 29, 32.98, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (851, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 26, 125, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (852, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 16, 28, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (853, 36, 160.05, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (854, 2, 1746, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (855, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (856, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (857, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (858, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (858, 19, 47, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (858, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (858, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (859, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (859, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (859, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (860, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (860, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (860, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (860, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (860, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 12, 23.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (861, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (862, 2, 1746, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (862, 12, 22.8, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (862, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (862, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (863, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 26, 125, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (864, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (865, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (866, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (867, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (867, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (867, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (867, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (867, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (868, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (868, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (868, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (868, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (869, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (869, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (870, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (870, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (870, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (870, 27, 24, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (870, 35, 37.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (871, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (871, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (871, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (871, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 6, 635, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 11, 1600.5, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 21, 55, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (872, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (873, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (873, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (873, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (873, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (874, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (874, 18, 173.63, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (874, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (874, 38, 166, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (875, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (875, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (876, 12, 23.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (876, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (876, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (877, 24, 69, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (878, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (878, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (878, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (879, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (879, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (879, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (879, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (880, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (880, 33, 19, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 14, 139.95, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (881, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (882, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (882, 15, 4.84, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (882, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (882, 39, 175, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (883, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (884, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (885, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (885, 33, 19, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 19, 47, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 29, 32.98, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (886, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (887, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (887, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (887, 26, 125, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (887, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (887, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (888, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (888, 12, 23.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (888, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (888, 28, 28.13, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (888, 36, 165, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (889, 29, 34, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (890, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 21, 55, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (891, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (892, 35, 39, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (893, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (893, 22, 82, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (893, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (894, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (894, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 6, 615.95, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 11, 1600.5, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 33, 19, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (895, 38, 166, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (896, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (896, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (896, 17, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (896, 29, 34, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (896, 37, 189, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 10, 36, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (897, 40, 174.6, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (898, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 14, 139.95, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 24, 69, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 34, 26.19, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (899, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (900, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (900, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (900, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (900, 31, 21.34, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (901, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (901, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (901, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (901, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (902, 2, 1800, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (902, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (903, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (903, 9, 32.01, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (903, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (903, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (903, 40, 180, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (904, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (904, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (904, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (904, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (904, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 10, 36, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 15, 4.99, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 20, 14.55, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 30, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (905, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 13, 67.5, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 19, 47, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 25, 139, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (906, 39, 175, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (907, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (907, 22, 79.54, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (907, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (908, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (908, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (908, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (909, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (909, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (909, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (909, 33, 18.43, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 11, 1650, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 16, 27.16, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 21, 53.35, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 31, 22, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (910, 36, 165, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (911, 14, 135.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (911, 34, 27, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 7, 49, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 28, 29, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 34, 27, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (912, 40, 180, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (913, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (913, 28, 28.13, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (914, 21, 55, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (915, 16, 28, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 7, 49, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 13, 65.47, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 19, 45.59, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (916, 37, 189, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (917, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (917, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (917, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (917, 25, 134.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (917, 35, 39, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (918, 36, 165, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 6, 615.95, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 27, 23.28, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 32, 31.04, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (919, 37, 183.33, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (920, 5, 7.23, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (921, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (921, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (921, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (921, 31, 22, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (922, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (922, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (922, 17, 45, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (922, 25, 139, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (922, 33, 18.43, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 5, 7.45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 10, 34.92, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 15, 4.99, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 20, 15, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 25, 139, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (923, 35, 39, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (924, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (924, 39, 175, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 12, 22.8, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 18, 179, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 24, 66.93, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 30, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (925, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 1, 1200, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 6, 635, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 20, 15, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 25, 134.83, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 30, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 35, 37.83, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (926, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (927, 8, 50, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (927, 16, 27.16, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (927, 24, 66.93, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (927, 32, 32, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (927, 40, 174.6, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (928, 7, 47.53, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (928, 17, 43.65, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (928, 27, 24, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (928, 37, 183.33, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (929, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (929, 14, 139.95, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (929, 36, 160.05, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (930, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (931, 20, 15, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (931, 40, 180, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (932, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (932, 17, 45, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (932, 30, 45, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (933, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (933, 27, 24, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (934, 7, 49, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (934, 15, 4.84, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (934, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (934, 39, 175, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (935, 1, 1200, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (935, 11, 1650, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (935, 22, 82, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (935, 32, 32, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (936, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (936, 9, 33, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (936, 20, 15, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (936, 28, 29, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (936, 36, 165, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 13, 67.5, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 19, 47, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 31, 22, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (937, 37, 189, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (938, 1, 1164, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (938, 7, 49, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (938, 13, 67.5, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (938, 19, 45.59, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (938, 31, 22, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (939, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (939, 14, 139.95, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (939, 22, 79.54, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (939, 30, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (939, 38, 166, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 6, 635, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 11, 1650, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 16, 28, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 21, 55, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 26, 121.25, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 34, 26.19, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (940, 39, 169.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 6, 635, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 11, 1650, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 16, 28, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 29, 34, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (941, 39, 169.75, 5);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (942, 1, 1200, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (942, 14, 135.75, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (942, 38, 166, 4);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (943, 1, 1200, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (943, 9, 33, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (943, 17, 45, 1);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (943, 26, 121.25, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (943, 34, 27, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (944, 1, 1164, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (944, 9, 33, 3);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (944, 17, 43.65, 6);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (944, 32, 32, 2);
INSERT INTO Dane_zamowien
  (NumerZamowienia, NumerProduktu, CenaZakupu, ZamowionaIlosc)
  VALUES (944, 40, 180, 2);
 
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (1, 4, 804, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (1, 9, 854.22, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (2, 6, 1269, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (2, 9, 1477.81, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (3, 7, 54.19, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (3, 9, 57.27, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (4, 6, 44.22, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (4, 9, 41.62, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (5, 7, 5.38, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (5, 9, 5.87, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (6, 2, 403.22, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (6, 9, 448.73, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (7, 2, 31.12, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (8, 8, 39.32, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (8, 9, 37.88, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (9, 3, 21.53, 4);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (10, 2, 22.86, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (11, 3, 1076.62, 4);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (11, 9, 1178.65, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (12, 1, 14.51, 2);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (12, 6, 15.44, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (12, 9, 15.02, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (13, 1, 41.68, 2);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (13, 6, 43.99, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (13, 9, 43.77, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (14, 6, 98.66, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (14, 9, 101.22, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (15, 4, 3.34, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (15, 6, 3.79, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (15, 9, 3.88, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (16, 4, 18.76, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (16, 6, 19.33, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (16, 9, 19.33, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (17, 1, 27.79, 2);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (17, 6, 28.55, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (17, 9, 28.55, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (18, 2, 113.66, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (19, 2, 29.84, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (20, 7, 10.84, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (20, 9, 11.54, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (21, 7, 39.74, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (21, 9, 41.5, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (22, 10, 63.55, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (23, 6, 69.54, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (23, 9, 64.39, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (24, 6, 55.91, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (24, 7, 53.88, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (24, 9, 52.27, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (25, 9, 105.29, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (25, 10, 101.58, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (26, 3, 81.56, 4);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (26, 6, 79.88, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (27, 3, 15.66, 4);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (27, 6, 16.88, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (27, 9, 15.88, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (28, 3, 18.92, 4);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (28, 6, 20.56, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (28, 9, 19.04, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (29, 6, 24.44, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (29, 9, 23.99, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (30, 8, 33.3, 12);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (30, 9, 35.32, 8);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (30, 10, 32.87, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (31, 7, 15.85, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (31, 8, 16.28, 12);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (31, 9, 16.93, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (31, 10, 16.9, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (32, 6, 24.77, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (32, 7, 24.12, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (32, 8, 23.68, 12);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (33, 6, 15.23, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (33, 8, 14.06, 12);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (34, 6, 19.04, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (34, 9, 23.86, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (34, 10, 19.32, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (35, 6, 27.49, 9);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (35, 9, 28.22, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (36, 6, 122.88, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (36, 7, 119.21, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (36, 9, 122.78, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (37, 2, 120.02, 3);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (37, 6, 125.99, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (37, 9, 124.89, 14);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (38, 9, 136.98, 6);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (38, 10, 128.65, 15);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (39, 6, 137.55, 7);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (39, 7, 126.44, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (40, 6, 154.87, 10);
INSERT INTO Dostawcy_produktow
  (NumerProduktu, IDDostawcy, CenaHurtowa, TerminDostarczenia)
  VALUES (40, 9, 136.35, 14);