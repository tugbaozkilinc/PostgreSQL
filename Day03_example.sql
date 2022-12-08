-- Practice 0:
create table ogrenciler
(
id char(3) primary key, adres varchar(20), tarih date 
);
create table ogrenci_notlar as select id, adres from ogrenciler; 

select * from ogrenciler;
select * from ogrenci_notlar;

insert into ogrenciler values (123, 'Izmir', now());
insert into ogrenciler values (234, 'Ankara', '2022-12-07');
insert into ogrenciler (id, adres) values (567, 'Istanbul');

select adres from ogrenciler;

-- Practice 1:
create table tedarikciler1
(
tedarikci_id char(7), tedarikci_ismi varchar(10), tedarikci_adres varchar(10), ulasim_tarihi date
);
create table tedarikci_ziyaret1 as select tedarikci_ismi, ulasim_tarihi from tedarikciler1;

-- Practice 2:
create table ogretmenler
(
kimlik_no char(5), isim varchar(10), brans varchar(10), cinsiyet varchar(10)
);

insert into ogretmenler values ('12345', 'Ayse', 'Matematik', 'Kadin');
insert into ogretmenler (kimlik_no, isim) values ('23456', 'Fatma');

select * from ogretmenler;

-- Practice 3:
create table sehirler1
(
alan_kodu char(3) primary key, isim varchar(20) not null, nufus int 	
);

insert into sehirler1 (alan_kodu, nufus) values (232, 800000); -- null value in column "isim" of relation "sehirler1" violates not-null constraint, eklenemez

-- Practice 4:
create table tedarikciler2
(
tedarikci_id char(7), tedarikci_isim varchar(20), iletisim_isim varchar(20), constraint p_k primary key(tedarikci_id)
);
drop table tedarikciler2 cascade;
drop table urunler;

create table urunler
(
tedarikci_id char(7), urun_id char(3), constraint f_k foreign key(tedarikci_id) references tedarikciler2(tedarikci_id)
); 

select * from tedarikciler2;
select * from urunler;

-- Practice 5:
create table calisanlar
(
id char(10), isim varchar(20) unique, maas int not null, ise_baslama date, constraint calisanlar_k primary key(id)
);

create table adresler
(
adres_id varchar(30), sokak varchar(15), cadde varchar(15), sehir varchar(15), constraint adresler_k foreign key(adres_id) references calisanlar(id)
);

INSERT INTO calisanlar VALUES ('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');  
INSERT INTO calisanlar VALUES ('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); -- duplicate key value violates unique constraint "calisanlar_isim_key", eklenemez 
INSERT INTO calisanlar VALUES ('10004', 'Veli Han', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES ('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES ('10006', 'Canan Yaş', NULL, '2019-04-12'); -- null value in column "maas" of relation "calisanlar" violates not-null constraint, eklenemez 
INSERT INTO calisanlar VALUES ('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES ('10007', 'CAN', 5000, '2018-04-14'); -- duplicate key value violates unique constraint "calisanlar_isim_key", eklenemez 
INSERT INTO calisanlar VALUES ('10009', 'cem', '', '2018-04-14'); -- syntax hatasi 
INSERT INTO calisanlar VALUES ('', 'osman', 2000, '2018-04-14'); 
INSERT INTO calisanlar VALUES ('', 'osman can', 2000, '2018-04-14'); -- duplicate key value violates unique constraint "calisanlar_k", eklenemez
INSERT INTO calisanlar VALUES ('10002', 'ayse Yılmaz' ,12000, '2018-04-14'); -- duplicate key value violates unique constraint "calisanlar_k", eklenemez
INSERT INTO calisanlar VALUES ( null, 'filiz ' ,12000, '2018-04-14'); -- null value in column "id" of relation "calisanlar" violates not-null constraint, eklenemez

INSERT INTO adresler VALUES ('10003', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES ('10003', 'Can Sok', '50.Cad.', 'Ankara');  
INSERT INTO adresler VALUES ('10002', 'Ağa Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES ('10012', 'Ağa Sok', '30.Cad.', 'Antep'); -- insert or update on table "adresler" violates foreign key constraint "adresler_k", eklenemez
INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Antep'); 
INSERT INTO adresler VALUES (NULL, 'Ağa Sok', '30.Cad.', 'Maraş');

-- SUBQUERIES
CREATE TABLE calisanlar3
(
id int, isim VARCHAR(50), sehir VARCHAR(50), maas int, isyeri VARCHAR(20)
);

CREATE TABLE markalar1  
(
marka_id int, marka_isim VARCHAR(20), calisan_sayisi int
);

INSERT INTO calisanlar3 VALUES (123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');  
INSERT INTO calisanlar3 VALUES (234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki'); 
INSERT INTO calisanlar3 VALUES (345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES (456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');  
INSERT INTO calisanlar3 VALUES (567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas'); 
INSERT INTO calisanlar3 VALUES (456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin'); 
INSERT INTO calisanlar3 VALUES (123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

INSERT INTO markalar1 VALUES (100, 'Vakko', 12000);
INSERT INTO markalar1 VALUES (101, 'Pierre Cardin', 18000);  
INSERT INTO markalar1 VALUES (102, 'Adidas', 10000);  
INSERT INTO markalar1 VALUES (103, 'LCWaikiki', 21000);

select * from markalar1;
select * from calisanlar3;

-- Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve  maaşlarini listeleyin.
select isim, maas, isyeri from calisanlar3 where isyeri in (select marka_isim from markalar1 where calisan_sayisi>15000);

-- marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
select isim, maas, sehir from calisanlar3 where isyeri in (select marka_isim from markalar1 where marka_id>101);

-- Ankara da calisani olan markaların marka id lerini ve calisan sayilarini listeleyiniz.
select marka_id, calisan_sayisi from markalar1 where marka_isim in (select isyeri from calisanlar3 where sehir='Ankara'); 

-- SUBQUERIES AGGREGATE METOT
-- Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id, marka_isim, (select count(sehir) from calisanlar3 where isyeri=marka_isim) from markalar1;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar3 where isyeri=marka_isim) from markalar1;

-- Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim, calisan_sayisi, (select max(maas) from calisanlar3 where isyeri=marka_isim), (select min(maas) from calisanlar3 where marka_isim=isyeri) from markalar1;

-- VIEW KULLANIMI
create view max_ve_min_maas as
select marka_isim, calisan_sayisi, (select max(maas) from calisanlar3 where isyeri=marka_isim), (select min(maas) from calisanlar3 where marka_isim=isyeri) from markalar1;

select * from max_ve_min_maas;

-- EXISTS CONDITION
-- EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin
-- içerisinde bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar.
CREATE TABLE mart1
(
urun_id int, musteri_isim varchar(50),  urun_isim varchar(50)
);

CREATE TABLE nisan1  
(
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO mart1 VALUES (10, 'Mark', 'Honda');  
INSERT INTO mart1 VALUES (20, 'John', 'Toyota');  
INSERT INTO mart1 VALUES (30, 'Amy', 'Ford'); 
INSERT INTO mart1 VALUES (20, 'Mark', 'Toyota'); 
INSERT INTO mart1 VALUES (10, 'Adam', 'Honda');
INSERT INTO mart1 VALUES (40, 'John', 'Hyundai');  
INSERT INTO mart1 VALUES (20, 'Eddie', 'Toyota');

INSERT INTO nisan1 VALUES (10, 'Hasan', 'Honda'); 
INSERT INTO nisan1 VALUES (10, 'Kemal', 'Honda'); 
INSERT INTO nisan1 VALUES (20, 'Ayse', 'Toyota'); 
INSERT INTO nisan1 VALUES (50, 'Yasar', 'Volvo'); 
INSERT INTO nisan1 VALUES (20, 'Mine', 'Toyota');




























































