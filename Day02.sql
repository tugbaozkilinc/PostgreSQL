create table ogrenciler5
(
ogrenci_no char(7), isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date
);

create table notlar as select isim, not_ort from ogrenciler5;

select * from notlar;
select * from ogrenciler5;

insert into notlar values ('Ece Nur', 85.0);
insert into notlar values ('Mete Han', 95.0);
insert into notlar values ('Ali Kemal', 85.0);
insert into notlar values ('Secil Cicek', 75.0);
insert into notlar values ('Hakan Tan', 80.0);

select isim from notlar;

create table talebeler
(
isim varchar(10), notlar real 
);

insert into talebeler values ('Ayca', 85.0);
insert into talebeler values ('Mete', 95.0);
insert into talebeler values ('Ali', 85.0);
insert into talebeler values ('Secil', 75.0);
insert into talebeler values ('Hakan', 80.0);

-- CONSTRAINT
-- UNIQUE
create table ogrenciler6
(
ogrenci_no char(7) unique, isim varchar(20) not null, soyisim varchar(25), not_ort real, kayit_tarih date
);

select * from ogrenciler6;

create table ogrenciler7
(
ogrenci_no char(7) unique, isim varchar(20) not null, soyisim varchar(25), not_ort real, kayit_tarih date
);

select * from ogrenciler7;

insert into ogrenciler7 values ('1234567', 'Osman', 'Evren', 75.0, now());
insert into ogrenciler7 values ('1234567', 'Ali', 'Veli', 75.0, now()); -- unique constraint, bu yuzden eklenemez
insert into ogrenciler7 values ('1234568', 'Ali', 'Veli', 75.0, now());
insert into ogrenciler7 (ogrenci_no, soyisim, not_ort) values ('1234569', 'Can', 55.5); -- not null constraint, bu yuzden eklenemez

-- PRIMARY KEY ATAMASI 1. yol
create table ogrenciler8
(
ogrenci_no char(7) PRIMARY KEY, isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date
);

-- PRIMARY KEY ATAMASI 2. yol
create table ogrenciler9
(
ogrenci_no char(7), isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date, CONSTRAINT ogr primary key (ogrenci_no)
);

-- PRIMARY KEY ATAMASI 3. yol
create table ogrenciler10
(
ogrenci_no char(7), isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date, primary key (ogrenci_no)
);

-- FOREIGN KEY
/*
“tedarikciler3” isimli bir tablo olusturun. Tabloda “tedarikci_id”, “tedarikci_ismi”, “iletisim_isim” field’lari olsun ve “tedarikci_id” yi Primary Key yapin.
“urunler” isminde baska bir tablo olusturun “tedarikci_id” ve “urun_id” field’lari olsun ve
“tedarikci_id” yi Foreign Key yapin.
*/
create table tedarikciler3
(
tedarikci_id char(5) primary key, tedarikci_ismi varchar(20), iletisim_isim varchar(20)
);

create table urunler
(
tedarikci_id char(5), urun_id char(5),
foreign key (tedarikci_id) references tedarikciler3 (tedarikci_id)
);

select * from tedarikciler3;
select * from urunler;

/*
“calisanlar” isimli bir Tablo olusturun. Icinde “id”, “isim”, “maas”, “ise_baslama” field’lari olsun. “id” yi Primary Key yapin, “isim” i Unique, “maas” i Not Null yapın.
“adresler” isminde baska bir tablo olusturun.Icinde “adres_id”, “sokak”, “cadde” ve “sehir” fieldlari olsun. “adres_id” field‘i ile Foreign Key oluşturun.
*/
create table calisanlar
(
id varchar(15) PRIMARY KEY, isim varchar(30) UNIQUE, maas int NOT NULL, ise_baslama date
);

create table adresler
(
adres_id varchar(30), sokak varchar(30), cadde varchar(30), sehir varchar(30), FOREIGN KEY (adres_id) REFERENCES calisanlar(id)
);

INSERT INTO calisanlar VALUES ('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- unique constraint, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ('10004', 'Veli Han', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10005', 'Mustafa Ali', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10006', 'Canan Yaş', NULL, '2019-04-12'); -- not null constraint, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10007', 'CAN', 5000, '2018-04-14'); -- unique constraint, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ('10009', 'cem', '', '2018-04-14'); -- syntax hatasi, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ('', 'osman', 2000, '2018-04-14'); -- primary key hiclik kabul eder
INSERT INTO calisanlar VALUES ('', 'osman can', 2000, '2018-04-14'); -- primary key duplicate sorunu, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ( '10002', 'ayse Yılmaz', 12000, '2018-04-14'); -- primary key duplicate sorunu, bu yuzden eklenemez
INSERT INTO calisanlar VALUES ( null, 'filiz ' ,12000, '2018-04-14'); -- primary key null kabul etmez, bu yuzden eklenemez

INSERT INTO adresler VALUES ('10003', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES ('10003', 'Can Sok', '50.Cad.', 'Ankara');
INSERT INTO adresler VALUES ('10002', 'Ağa Sok', '30.Cad.', 'Antep');

-- Parent tabloda olmayan id ile child a ekleme yapamayiz
INSERT INTO adresler VALUES ('10012', 'Ağa Sok', '30.Cad.', 'Antep');

-- FK'ye null değeri atanabilir.
INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Maraş');
INSERT INTO adresler VALUES ('', 'Ağa Sok', '30.Cad.', 'Maraş');

select * from calisanlar;
select * from adresler;

-- CHECK CONSTRAINT
create table calisanlar1
(
id varchar(15) PRIMARY KEY, isim varchar(30) UNIQUE, maas int check (maas>1000) not null, ise_baslama date
);

insert into calisanlar1 values ('10002', 'Mehmet Yilmaz', 9000, '2018-04-14');
insert into calisanlar1 values ('10002', 'Mehmet Yilmaz', 900, '2018-04-14'); -- check constraint,  bu yuzden eklenemez
select * from calisanlar1;

create table calisanlar2
(
id varchar(15) PRIMARY KEY, isim varchar(30) UNIQUE, maas int check (maas>1000) not null, ise_baslama date
);

-- DQL WHERE KULLANIMI
select * from calisanlar;
select isim from calisanlar;

-- calisanlar tablosundan maasi 5000 den buyuk olan isimleri listeleyiniz
select isim from calisanlar WHERE maas>5000;

-- calisanlar tablosundan maasi 5000 den buyuk olan isimleri ve maaslari listeleyiniz
select isim, maas from calisanlar WHERE maas>5000;

-- calisanlar tablosundan ismi Veli Han olan tum verileri listeleyiniz
select * from calisanlar WHERE isim='Veli Han';

-- calisanlar tablosundan maasi 5000 olan tum verileri listeleyiniz
select * from calisanlar WHERE maas=5000;

-- DML DELETE
delete from calisanlar; -- eger parent table baska bir child table ile iliskili ise once child table silinmelidir
delete from adresler;
select * from adresler;

INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Maraş');
INSERT INTO adresler VALUES ('10003', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES ('10003', 'Can Sok', '50.Cad.', 'Ankara');
INSERT INTO adresler VALUES ('10002', 'Ağa Sok', '30.Cad.', 'Antep');
select * from adresler;

-- adresler tablosundan sehri Antep olan verileri silelim
delete from adresler where sehir='Antep';

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayıtları silelim.
CREATE TABLE ogrenciler3
(
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int
);

select * from ogrenciler3;

INSERT INTO ogrenciler3 VALUES (123, 'Ali Can', 'Hasan', 75);
INSERT INTO ogrenciler3 VALUES (124, 'Merve Gul', 'Ayse', 85);
INSERT INTO ogrenciler3 VALUES (125, 'Kemal Yasa', 'Hasan', 85);
INSERT INTO ogrenciler3 VALUES (126, 'Nesibe Yilmaz', 'Ayse', 95);
INSERT INTO ogrenciler3 VALUES (127, 'Mustafa Bak', 'Can', 99);
INSERT INTO ogrenciler3 VALUES (127, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler3 VALUES (129, 'Ali Can', 'Ayse', 95);
INSERT INTO ogrenciler3 VALUES (121, 'Omer Faruk', 'Can', 99);
INSERT INTO ogrenciler3 VALUES (128, 'Veli Tan', 'Ali', 99);

-- ismi Nesibe Yilmaz veya Mustafa Bak olan kayitlari silelim
delete from ogrenciler3 where isim='Nesibe Yilmaz' or isim='Mustafa Bak';

-- ismi Ali Can ve id si 123 olan kaydi siliniz 
delete from ogrenciler3 where isim='Ali Can' and id=123;

-- id si 124 ten buyuk olan kayitlari silelim
delete from ogrenciler3 where id>124;

-- id si 121, 125 veya 126 olanlari silelim
delete from ogrenciler3 where id=121 or id=125 or id=126;



































