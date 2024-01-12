CREATE TABLE students
(
ogrenci_no char(7), isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date, unique(soyisim, not_ort), PRIMARY KEY(ogrenci_no, isim)  --COMPOSİTE PK
);
select * from students;

--ALIASES
--Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir.
CREATE TABLE calisanlar1 
(
calisan_id char(9), calisan_isim varchar(50), calisan_dogdugu_sehir varchar(50)
);

INSERT INTO calisanlar1 VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO calisanlar1 VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO calisanlar1 VALUES(345678901, 'Mine Bulut', 'Izmir');
select * from calisanlar1;
select calisan_id as id from calisanlar1;

--Eger iki sutunun verilerini birlestirmek istersek concat || sembolu ya da concat() method u kullanırız
--1. yol:
select calisan_id as id, calisan_isim||calisan_dogdugu_sehir as calisan_bilgisi from calisanlar1;
select calisan_id as id, calisan_isim||' '||calisan_dogdugu_sehir as calisan_bilgisi from calisanlar1;

--2. yol:
select calisan_id as id, concat(calisan_isim, ' ', calisan_dogdugu_sehir) as calisan_bilgisi from calisanlar1;

--IS NULL CONDITION arama yapilan field’da NULL degeri almis kayitlari getirir
drop table if exists insanlar;
CREATE TABLE insanlar
(
ssn char(9), name varchar(50), adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir');  
INSERT INTO insanlar(ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar(ssn, adres) VALUES(567890123, 'Denizli');
select * from insanlar;

--Name sutununda null olan degerleri listeleyelim
select name from insanlar where name is null;

--Insanlar tablosunda sadece null olmayan degerleri listeleyiniz
select name from insanlar where name is not null;

--Insanlar tablosunda null deger almıs verileri no name olarak degistiriniz
update insanlar set name='no_name' where name is null;

--ORDER BY CLAUSE
--ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama yapmak icin kullanilir ORDER BY komutu sadece SELECT komutu Ile kullanilir
drop table if exists insanlar
CREATE TABLE insanlar
(
ssn char(9), isim varchar(50), soyisim varchar(50), adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara');  
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul'); 
INSERT INTO insanlar VALUES(344678901, 'Mine','Yasa', 'Ankara');  
INSERT INTO insanlar VALUES(345678901, 'Veli','Yilmaz', 'Istanbul');

--Insanlar tablosundaki datalari adres’e gore siralayin
select * from insanlar order by adres;
select * from insanlar order by adres asc;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim='Mine' order by ssn;

--NOT: Order By komutundan sonra field ismi yerine field numarasi da kullanilabilir
--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin
select * from insanlar where soyisim='Bulut' order by 2;

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn desc;

--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim asc, soyisim desc;
select * from insanlar order by isim, soyisim desc;

--İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
select isim, soyisim from insanlar order by length(soyisim)+length(isim);
select isim, soyisim from insanlar order by length(soyisim) desc;

--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim||' '||soyisim as isim_soyisim from insanlar order by length(isim||soyisim); --1. yol
select isim||' '||soyisim as isim_soyisim from insanlar order by length(isim)+length(soyisim); --2. yol
select concat(isim, ' ', soyisim) as isim_soyisim from insanlar order by length(isim)+length(soyisim); --3. yol
select isim||' '||soyisim as isim_soyisim from insanlar order by length(concat(isim, soyisim)); --4. yol

--GROUP BY CLAUSE
--Group By komutu sonuçları bir veya daha fazla sütuna göre gruplamak için SELECT komutuyla birlikte kullanılır.
CREATE TABLE manav
(
isim varchar(50), Urun_adi varchar(50), Urun_miktar int
);

INSERT INTO manav VALUES('Ali', 'Elma', 5);
INSERT INTO manav VALUES('Ayse', 'Armut', 3);
INSERT INTO manav VALUES('Veli', 'Elma', 2);
INSERT INTO manav VALUES('Hasan', 'Uzum', 4);
INSERT INTO manav VALUES('Ali', 'Armut', 2);
INSERT INTO manav VALUES('Ayse', 'Elma', 3);
INSERT INTO manav VALUES('Veli', 'Uzum', 5);
INSERT INTO manav VALUES('Ali', 'Armut', 2);
INSERT INTO manav VALUES('Veli', 'Elma', 3);
INSERT INTO manav VALUES('Ayse', 'Uzum', 2);
select * from manav;

--Isme gore alınan toplam urunleri listeleyiniz
select isim, sum(urun_miktar) from manav group by isim;

--Isme gore alinan toplam urunleri bulun ve bu urunleri buyukten kucuge listeleyiniz
select isim, sum(urun_miktar) as alinan_toplam_urun from manav group by isim order by alinan_toplam_urun desc;
select isim, sum(urun_miktar) from manav group by isim order by sum(urun_miktar) desc;

--Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi, count(isim) from manav group by urun_adi;

--Kişiye gore toplam alinan urun miktari
select isim, count(urun_adi) from manav group by isim;







