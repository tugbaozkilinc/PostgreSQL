--Practice 0:
create table ogrenciler
(
id char(3) primary key, adres varchar(20), tarih date 
);

create table ogrenci_notlar as select id, adres from ogrenciler; 

select * from ogrenciler;
select * from ogrenci_notlar;

insert into ogrenciler values(123, 'Izmir', now());
insert into ogrenciler values(234, 'Ankara', '2022-12-07');
insert into ogrenciler(id, adres) values(567, 'Istanbul');

select adres from ogrenciler;

--Practice 1:
create table tedarikciler1
(
tedarikci_id char(7), tedarikci_ismi varchar(10), tedarikci_adres varchar(10), ulasim_tarihi date
);

create table tedarikci_ziyaret1 as select tedarikci_ismi, ulasim_tarihi from tedarikciler1;

--Practice 2:
create table ogretmenler
(
kimlik_no char(5), isim varchar(10), brans varchar(10), cinsiyet varchar(10)
);

insert into ogretmenler values('12345', 'Ayse', 'Matematik', 'Kadin');
insert into ogretmenler(kimlik_no, isim) values('23456', 'Fatma');

select * from ogretmenler;

--Practice 3:
create table sehirler1
(
alan_kodu char(3) primary key, isim varchar(20) not null, nufus int 	
);

insert into sehirler1(alan_kodu, nufus) values(232, 800000); --null value in column "isim" of relation "sehirler1" violates not-null constraint, eklenemez

--Practice 4:
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

--Practice 5:
create table calisanlar
(
id char(10), isim varchar(20) unique, maas int not null, ise_baslama date, constraint calisanlar_k primary key(id)
);

create table adresler
(
adres_id varchar(30), sokak varchar(15), cadde varchar(15), sehir varchar(15), constraint adresler_k foreign key(adres_id) references calisanlar(id)
);

INSERT INTO calisanlar VALUES('10002', 'Mehmet Yılmaz', 12000, '2018-04-14');  
INSERT INTO calisanlar VALUES('10008', null, 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10010', 'Mehmet Yılmaz', 5000, '2018-04-14'); --duplicate key value violates unique constraint "calisanlar_isim_key", eklenemez 
INSERT INTO calisanlar VALUES('10004', 'Veli Han', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10005', 'Mustafa Ali', 5000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('10006', 'Canan Yaş', NULL, '2019-04-12'); --null value in column "maas" of relation "calisanlar" violates not-null constraint, eklenemez 
INSERT INTO calisanlar VALUES('10003', 'CAN', 5000, '2018-04-14');
INSERT INTO calisanlar VALUES('10007', 'CAN', 5000, '2018-04-14'); --duplicate key value violates unique constraint "calisanlar_isim_key", eklenemez 
INSERT INTO calisanlar VALUES('10009', 'cem', '', '2018-04-14'); --syntax hatasi 
INSERT INTO calisanlar VALUES('', 'osman', 2000, '2018-04-14'); 
INSERT INTO calisanlar VALUES('', 'osman can', 2000, '2018-04-14'); --duplicate key value violates unique constraint "calisanlar_k", eklenemez
INSERT INTO calisanlar VALUES('10002', 'ayse Yılmaz' ,12000, '2018-04-14'); --duplicate key value violates unique constraint "calisanlar_k", eklenemez
INSERT INTO calisanlar VALUES( null, 'filiz ' ,12000, '2018-04-14'); --null value in column "id" of relation "calisanlar" violates not-null constraint, eklenemez

INSERT INTO adresler VALUES('10003', 'Mutlu Sok', '40.Cad.', 'IST');
INSERT INTO adresler VALUES('10003', 'Can Sok', '50.Cad.', 'Ankara');  
INSERT INTO adresler VALUES('10002', 'Ağa Sok', '30.Cad.', 'Antep');
INSERT INTO adresler VALUES('10012', 'Ağa Sok', '30.Cad.', 'Antep'); --insert or update on table "adresler" violates foreign key constraint "adresler_k", eklenemez
INSERT INTO adresler VALUES(NULL, 'Ağa Sok', '30.Cad.', 'Antep'); 
INSERT INTO adresler VALUES(NULL, 'Ağa Sok', '30.Cad.', 'Maraş');

--SUBQUERIES
CREATE TABLE calisanlar3
(
id int, isim VARCHAR(50), sehir VARCHAR(50), maas int, isyeri VARCHAR(20)
);

CREATE TABLE markalar1  
(
marka_id int, marka_isim VARCHAR(20), calisan_sayisi int
);

INSERT INTO calisanlar3 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');  
INSERT INTO calisanlar3 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki'); 
INSERT INTO calisanlar3 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar3 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');  
INSERT INTO calisanlar3 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas'); 
INSERT INTO calisanlar3 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin'); 
INSERT INTO calisanlar3 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');

INSERT INTO markalar1 VALUES(100, 'Vakko', 12000);
INSERT INTO markalar1 VALUES(101, 'Pierre Cardin', 18000);  
INSERT INTO markalar1 VALUES(102, 'Adidas', 10000);  
INSERT INTO markalar1 VALUES(103, 'LCWaikiki', 21000);
select * from markalar1;
select * from calisanlar3;

--Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve  maaşlarini listeleyin.
select isim, maas, isyeri from calisanlar3 where isyeri in(select marka_isim from markalar1 where calisan_sayisi>15000);

--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
select isim, maas, sehir from calisanlar3 where isyeri in(select marka_isim from markalar1 where marka_id>101);

--Ankara da calisani olan markaların marka id lerini ve calisan sayilarini listeleyiniz.
select marka_id, calisan_sayisi from markalar1 where marka_isim in(select isyeri from calisanlar3 where sehir='Ankara'); 

--SUBQUERIES AGGREGATE METOT
--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz.
select marka_id, marka_isim, (select count(sehir) from calisanlar3 where isyeri=marka_isim) from markalar1;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
select marka_isim, calisan_sayisi, (select sum(maas) from calisanlar3 where isyeri=marka_isim) from markalar1;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
select marka_isim, calisan_sayisi, (select max(maas) from calisanlar3 where isyeri=marka_isim), (select min(maas) from calisanlar3 where marka_isim=isyeri) from markalar1;

--VIEW KULLANIMI
create view max_ve_min_maas as
select marka_isim, calisan_sayisi, (select max(maas) from calisanlar3 where isyeri=marka_isim), (select min(maas) from calisanlar3 where marka_isim=isyeri) from markalar1;

select * from max_ve_min_maas;

--EXISTS CONDITION
--EXISTS Condition subquery’ler ile kullanilir. IN ifadesinin kullanımına benzer olarak, EXISTS ve NOT EXISTS ifadeleri de alt sorgudan getirilen değerlerin
--içerisinde bir değerin olması veya olmaması durumunda işlem yapılmasını sağlar.
CREATE TABLE mart1
(
urun_id int, musteri_isim varchar(50),  urun_isim varchar(50)
);

CREATE TABLE nisan1  
(
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO mart1 VALUES(10, 'Mark', 'Honda');  
INSERT INTO mart1 VALUES(20, 'John', 'Toyota');  
INSERT INTO mart1 VALUES(30, 'Amy', 'Ford'); 
INSERT INTO mart1 VALUES(20, 'Mark', 'Toyota'); 
INSERT INTO mart1 VALUES(10, 'Adam', 'Honda');
INSERT INTO mart1 VALUES(40, 'John', 'Hyundai');  
INSERT INTO mart1 VALUES(20, 'Eddie', 'Toyota');

INSERT INTO nisan1 VALUES(10, 'Hasan', 'Honda'); 
INSERT INTO nisan1 VALUES(10, 'Kemal', 'Honda'); 
INSERT INTO nisan1 VALUES(20, 'Ayse', 'Toyota'); 
INSERT INTO nisan1 VALUES(50, 'Yasar', 'Volvo'); 
INSERT INTO nisan1 VALUES(20, 'Mine', 'Toyota');

select * from mart1;
select * from nisan1;

--MART VE NİSAN aylarında aynı URUN_ID ile satılan ürünlerin URUN_ID’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan MUSTERI_ISIM 'lerini listeleyen bir sorgu yazınız.
select musteri_isim, urun_id from mart1 where exists(select urun_id from nisan1 where mart1.urun_id=nisan1.urun_id); 

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select urun_isim, musteri_isim from nisan1 where exists(select urun_isim from mart1 where mart1.urun_isim=nisan1.urun_isim); 

--UPDATE SET
CREATE TABLE tedarikciler4
(
vergi_no int PRIMARY KEY, firma_ismi VARCHAR(50), irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler4 VALUES(101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler4 VALUES(102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler4 VALUES(103, 'Erikson', 'Maki Tammen'); 
INSERT INTO tedarikciler4 VALUES(104, 'Apple', 'Adam Eve');

drop table if exists urunler;
CREATE TABLE urunler 
(
ted_vergino int, urun_id int, urun_isim VARCHAR(50), musteri_isim VARCHAR(50), CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no) on delete cascade
);

INSERT INTO urunler VALUES(101, 1001,'Laptop', 'Ayşe Can');  
INSERT INTO urunler VALUES(102, 1002,'Phone', 'Fatma Aka');  
INSERT INTO urunler VALUES(102, 1003,'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004,'Laptop', 'Veli Han');  
INSERT INTO urunler VALUES(103, 1005,'Phone', 'Canan Ak');  
INSERT INTO urunler VALUES(104, 1006,'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007,'Phone', 'Aslan Yılmaz');

select * from tedarikciler4;
select * from urunler;

--vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler4 set firma_ismi='Vestel' where vergi_no=102; 

--vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler4 set firma_ismi='Casper', irtibat_ismi='Ali Veli' where vergi_no=101;

--urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.  
update urunler set urun_isim='Telefon' where urun_isim='Phone';

--urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi'Adam Eve' olan firmanın ismi ile degistiriniz.
update urunler set urun_isim=(select firma_ismi from tedarikciler4 where irtibat_ismi='Adam Eve') where musteri_isim='Ali Bak';

--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.  
update urunler set musteri_isim=(select irtibat_ismi from tedarikciler4 where firma_ismi='Apple') where urun_isim='Laptop';

--ALIASES
--Aliases kodu ile tablo yazdirilirken, field isimleri sadece o cikti icin degistirilebilir
drop table calisanlar cascade;
CREATE TABLE calisanlar
(
calisan_id char(9), calisan_isim varchar(50), calisan_dogdugu_sehir varchar(50)
);

INSERT INTO calisanlar VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO calisanlar VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO calisanlar VALUES(345678901, 'Mine Bulut', 'Izmir');

select * from calisanlar;

--Field lari id, isim, dogum yeri olarak degistirin
select calisan_id as id, calisan_isim as isim, calisan_dogdugu_sehir as sehir from calisanlar; 

--calisan_isim ve calisan_dogdugu_sehir field larini tek bir sutunda birlestirin
select calisan_id as id, calisan_isim||' '||calisan_dogdugu_sehir as isim_ve_sehir from calisanlar;
select calisan_id as id, concat(calisan_isim, ' ', calisan_dogdugu_sehir) as isim_ve_sehir from calisanlar;

--IS NULL CONDITION
drop table insanlar cascade;
CREATE TABLE insanlar  
(
ssn char(9), isim varchar(50), adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali Can', 'Istanbul'); 
INSERT INTO insanlar VALUES(234567890, 'Veli Cem', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Mine Bulut', 'Izmir'); 
INSERT INTO insanlar(ssn, adres) VALUES(456789012, 'Bursa'); 
INSERT INTO insanlar(ssn, adres) VALUES(567890123, 'Denizli');

select * from insanlar;

--ismi null olan verileri listeleyiniz
select * from insanlar where isim is null;

--ismi null olan verileri isim girilmemis olarak guncelleyiniz
update insanlar set isim='Isim girilmemis' where isim is null;

--ORDER BY
--ORDER BY komutu belli bir field’a gore NATURAL ORDER olarak siralama yapmak icin kullanilir, sadece SELECT komutu Ile kullanilir
drop table insanlar;
CREATE TABLE insanlar 
(
ssn char(9), isim varchar(50), soyisim varchar(50),	adres varchar(50)
);

INSERT INTO insanlar VALUES(123456789, 'Ali','Can', 'Istanbul');  
INSERT INTO insanlar VALUES(234567890, 'Veli','Cem', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Mine','Bulut', 'Ankara'); 
INSERT INTO insanlar VALUES(256789012, 'Mahmut','Bulut', 'Istanbul');
INSERT INTO insanlar VALUES(344678901, 'Mine','Yasa', 'Ankara'); 
INSERT INTO insanlar VALUES(345678901, 'Veli','Yilmaz', 'Istanbul');

select * from insanlar;

--Insanlar tablosundaki datalari adres’e gore siralayin
select * from insanlar order by adres;
select * from insanlar order by adres asc;
select * from insanlar order by adres desc;

--Insanlar tablosundaki ismi Mine olanlari SSN sirali olarak listeleyin
select * from insanlar where isim='Mine' order by ssn;

--Insanlar tablosundaki soyismi Bulut olanlari isim sirali olarak listeleyin  
select * from insanlar where soyisim='Bulut' order by 2;

--Insanlar tablosundaki tum kayitlari SSN numarasi buyukten kucuge olarak siralayin
select * from insanlar order by ssn desc;

--Insanlar tablosundaki tum kayitlari isimler Natural sirali, Soyisimler ters sirali olarak listeleyin
select * from insanlar order by isim, soyisim desc;
select * from insanlar order by isim asc, soyisim desc;

--İsim ve soyisim değerlerini soyisim kelime uzunluklarına göre sıralayınız
select isim, soyisim from insanlar order by length(soyisim);

--Tüm isim ve soyisim değerlerini aynı sutunda çağırarak her bir sütun değerini uzunluğuna göre sıralayınız
select isim||' '||soyisim as isim_soyisim from insanlar order by length(isim) + length(soyisim) desc;
select concat(isim, ' ',soyisim) as isim_soyisim from insanlar order by length(isim||' '||soyisim);

--GROUP BY
drop table manav;
CREATE TABLE manav
(
isim varchar(50), Urun_adi varchar(50), Urun_miktar int
);

INSERT INTO manav VALUES('Veli', 'Elma', 2);  
INSERT INTO manav VALUES('Hasan', 'Uzum', 4);  
INSERT INTO manav VALUES('Ali', 'Armut', 2);  
INSERT INTO manav VALUES('Ayse', 'Elma', 3); 
INSERT INTO manav VALUES('Veli', 'Uzum', 5); 
INSERT INTO manav VALUES('Ali', 'Armut', 2); 
INSERT INTO manav VALUES('Veli', 'Elma', 3); 
INSERT INTO manav VALUES('Ayse', 'Uzum', 2);
INSERT INTO manav VALUES('Ali', 'Elma', 5);
INSERT INTO manav VALUES('Ayse', 'Armut', 3);

select * from manav;

--Isme gore alinan toplam urunleri bulun
select isim, sum(urun_miktar) from manav group by isim;

--Urun ismine gore urunu alan toplam kisi sayisi
select urun_adi, count(isim) from manav group by urun_adi;

--Alinan kilo miktarina gore musteri sayisi
select urun_miktar, count(isim) as urun_miktarini_alan_kisi_sayisi from manav group by urun_miktar;

------------------------------
drop table personel
CREATE TABLE personel 
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456789012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel;

--Isme gore toplam maaslari bulun
select isim, sum(maas) as toplam_maas from personel group by isim;

--sehre gore toplam personel sayisini bulun
select sehir, count(isim) from personel group by sehir;

--Sirketlere gore maasi 5000 liradan fazla olan personel sayisini bulun
select sirket, count(isim) from personel where maas>5000 group by sirket;

--Her sirket icin Min ve Max maasi bulun
select sirket, min(maas) as min_maas, max(maas) as max_maas from personel group by sirket;

--HAVING KULLANIMI IN GROUP BY
drop table personel
CREATE TABLE personel 
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES(456789012, ' Mehmet Ozturk ', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, ' Mehmet Ozturk ', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456789012, ' Veli Sahin ', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500,	'Honda');

select * from personel;

--1) Her sirketin MIN maaslarini eger 2000’den buyukse goster
select sirket, min(maas) as min_maas from personel group by sirket having min(maas)>2000;

--2) Ayni isimdeki kisilerin aldigi toplam gelir 10000 liradan fazla ise ismi ve toplam maasi gosteren sorgu yaziniz
select isim, sum(maas) from personel group by isim having sum(maas)>10000; 

--3) Eger bir sehirde calisan personel sayisi 1’den coksa sehir ismini ve personel sayisini veren sorgu yaziniz  
select sehir, count(isim) from personel group by sehir having count(isim)>1;

--4) Eger bir sehirde alinan MAX maas 5000’den dusukse sehir ismini ve MAX maasi veren sorgu yaziniz
select sehir, max(maas) as max_maas from personel group by sehir having max(maas)<5000;

--UNION OPERATOR
--Iki farkli sorgulamanin sonucunu birlestiren islemdir. Secilen Field SAYISI ve DATA TYPE’i ayni olmalidir.
--NOT: Union islemi yaparken Her 2 QUERY’den elde edeceginiz tablolarin sutun sayilari esit olmali. Alt alta gelecek sutunlarin data type’lari ayni olmali

drop table personel cascade;
create table personel
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500,	'Honda');
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');
INSERT INTO personel VALUES(456789012, 'Veli Sahin ', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500,	'Honda');

select * from personel;

--1) Maasi 4000’den cok olan isci isimlerini ve 5000 liradan fazla maas alinan sehirleri gosteren sorguyu yaziniz
select isim as isim_ve_sehir, maas from personel where maas>4000
union
select sehir, maas from personel where maas>5000 order by maas;

--2) Mehmet Ozturk ismindeki kisilerin aldigi maaslari ve Istanbul’daki personelin maaslarini bir tabloda gosteren sorgu yaziniz
select isim as mehmet_ve_digerleri, maas from personel where isim='Mehmet Ozturk'
union
select isim, maas from personel where sehir='Istanbul';

--3) Sehirlerden odenen ucret 3000’den fazla olanlari ve personelden ucreti 5000’den az olanlari bir tabloda maas miktarina gore sirali olarak gosteren sorguyu yaziniz
select sehir as sehir_ve_isim, maas from personel where maas>3000
union
select isim, maas from personel where maas<5000 order by maas;

--UNION İKİ TABLO BİRLESTİRME
drop table personel cascade;
CREATE TABLE personel 
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20), CONSTRAINT personel_pk1 PRIMARY KEY(id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

drop table personel_bilgi;
CREATE TABLE personel_bilgi
(
id int, tel char(10) UNIQUE, cocuk_sayisi int, CONSTRAINT personel_bilgi_fk FOREIGN KEY(id) REFERENCES personel(id)
);

INSERT INTO personel_bilgi VALUES(234567890, '5422345678', 4);
INSERT INTO personel_bilgi VALUES(345678901, '5354561245', 3);
INSERT INTO personel_bilgi VALUES(456789012, '5411452659', 3);
INSERT INTO personel_bilgi VALUES(567890123, '5551253698', 2);
INSERT INTO personel_bilgi VALUES(456789012, '5524578574', 2);
INSERT INTO personel_bilgi VALUES(123456710, '5537488585', 1);

select * from personel;
select * from personel_bilgi;

--id’si 12345678 olan personelin Personel tablosundan sehir ve maasini, personel_bilgi tablosundan da tel ve cocuk sayisini yazdirin
select sehir as sehir_ve_tel, maas as maas_ve_cocuk_sayisi from personel where id=12345678
union
select tel, cocuk_sayisi from personel_bilgi where id=12345678;

--INTERSECT
--Personel tablosundan Istanbul veya Ankara’da calisanlarin, Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
select id from personel where sehir in('Ankara', 'Istanbul')
intersect
select id from personel_bilgi where cocuk_sayisi in(2,3);

--Maasi 4800’den az olanlar veya 5000’den cok olanlarin id’lerini listeleyin, Personel_bilgi tablosundan 2 veya 3 cocugu olanlarin id lerini yazdirin
select id from personel where maas not between 4800 and 5000
intersect
select id from personel_bilgi where cocuk_sayisi in(2,3);

--Honda,Ford ve Tofas’ta calisan ortak isimde personel varsa listeleyin
select isim from personel where sirket='Honda'
intersect
select isim from personel where sirket='Ford'
intersect
select isim from personel where sirket='Tofas'

--EXCEPT
--5000’den az maas alip Honda’da calismayanlarin isimlerini ve sirketlerini yazdirin  
select isim, sirket from personel where maas<5000
except
select isim, sirket from personel where sirket='Honda';

--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin
select isim, sehir from personel where isim='Mehmet Ozturk'
except 
select isim, sehir from personel where sehir='Istanbul';

--JOINS
--INNER JOINS
--Su ana kadar gordugumuz Union,Intersect ve Except(Minus) sorgu sonuclari icin kullanilir. Tablolar icin ise JOIN kullanilir.
drop table sirketler cascade;
drop table siparisler cascade;
CREATE TABLE sirketler 
(
sirket_id int, sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES(100, 'Toyota'); 
INSERT INTO sirketler VALUES(101, 'Honda');  
INSERT INTO sirketler VALUES(102, 'Ford'); 
INSERT INTO sirketler VALUES(103, 'Hyundai');

CREATE TABLE siparisler 
(
siparis_id int, sirket_id int, siparis_tarihi date
);

INSERT INTO siparisler VALUES(11, 101, '17-Apr-2020'); 
INSERT INTO siparisler VALUES(22, 102, '18-Apr-2020'); 
INSERT INTO siparisler VALUES(33, 103, '19-Apr-2020'); 
INSERT INTO siparisler VALUES(44, 104, '20-Apr-2020'); 
INSERT INTO siparisler VALUES(55, 105, '21-Apr-2020');

select * from sirketler;
select * from siparisler;

--Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler 
inner join siparisler on sirketler.sirket_id=siparisler.sirket_id;

--LEFT JOINS
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler left join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

--RIGHT JOINS
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler right join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

--FULL JOINS
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler full join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

--SELF JOINS
drop table personel cascade;
CREATE TABLE personel
(
id int, isim varchar(20), title varchar(60), yonetici_id int
);

INSERT INTO personel VALUES(1, 'Ali Can', 'SDET', 2);  
INSERT INTO personel VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel VALUES(4, 'Fatma Can', 'CEO', 5);

select * from personel;
--Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
select p1.isim as personel_isim, p2.isim as yonetici_isim from personel p1 inner join personel p2 on p1.yonetici_id=p2.id;

--LIKE CONDITION
drop table musteriler cascade;
CREATE TABLE musteriler 
(
id int UNIQUE, isim varchar(50) NOT NULL, gelir int
);

INSERT INTO musteriler(id, isim, gelir) VALUES(1001, 'Ali', 62000);
INSERT INTO musteriler(id, isim, gelir) VALUES(1002, 'Ayse', 57500);  
INSERT INTO musteriler(id, isim, gelir) VALUES(1003, 'Feride', 71000); 
INSERT INTO musteriler(id, isim, gelir) VALUES(1004, 'Fatma', 42000);
INSERT INTO musteriler(id, isim, gelir) VALUES(1005, 'Kasim',	44000);

select * from musteriler;

--SORU: Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like 'A%';
select * from musteriler where isim ilike 'A%';

--SORU: Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim, gelir from musteriler where isim ~~ '%e';

--SORU: Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim, gelir from musteriler where isim ~~* '%er%';

--SORU: Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim ~~* '_atma';

--SORU: Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like '_a%';

--SORU: Ilk harfi F olan en az 4 harfli musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler where isim like 'F___%';

--REGEXP_LIKE 
drop table kelimeler;
CREATE TABLE kelimeler  
(
id int UNIQUE, kelime varchar(50) NOT NULL, Harf_sayisi int
);

INSERT INTO kelimeler VALUES(1001, 'hot', 3); 
INSERT INTO kelimeler VALUES(1002, 'hat', 3); 
INSERT INTO kelimeler VALUES(1003, 'hit', 3); 
INSERT INTO kelimeler VALUES(1004, 'hbt', 3); 
INSERT INTO kelimeler VALUES(1008, 'hct', 3); 
INSERT INTO kelimeler VALUES(1005, 'adem', 4); 
INSERT INTO kelimeler VALUES(1006, 'selim', 5); 
INSERT INTO kelimeler VALUES(1007, 'yusuf', 5);

select * from kelimeler;

--SORU: Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~ 'h[ai]t';

--SORU: Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* 'h[a-k]t';

--SORU: Icinde m veya i olan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~ '[mi]';

--SORU: a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~ '^[as]';

--SORU: m veya f ile biten kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~ '[mf]$';

--NOT LIKE
--SORU: ilk harfi h olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like 'h%';

--SORU: ikinci ve ucuncu harfi ‘de’ olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime not like '_de%';

--SORU: 2. harfi e,i veya o olmayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime !~* '[_eio]';

--UPPER-LOWER-INITCAP
select upper(kelime) from kelimeler;
select lower(kelime) from kelimeler;
select initcap(kelime) from kelimeler;

--DISTINCT
drop table musteri_urun;
CREATE TABLE musteri_urun 
(
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO musteri_urun VALUES(10, 'Ali', 'Portakal');  
INSERT INTO musteri_urun VALUES(10, 'Ali', 'Portakal');  
INSERT INTO musteri_urun VALUES(20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES(30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES(20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES(10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES(40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES(20, 'Elif', 'Elma');

select * from musteri_urun;

--Musteri_urun tablosundan urun isimlerini tekrarsiz listeleyiniz
select distinct(urun_isim) from musteri_urun; --distinct ile cozumu
select urun_isim from musteri_urun group by urun_isim;

--Tabloda kac farkli meyve vardir?
select urun_isim, count(urun_isim) from musteri_urun group by urun_isim; --group by ile cozumu
select urun_isim, count(distinct(urun_isim)) from musteri_urun group by urun_isim;

--FETCH NEXT(SAYI) ROW ONLY- OFFSET(SAYI) ROW/OFFSET- LIMIT
--Tabloyu urun_id ye gore siralayiniz ve sirali tablodan ilk 3 kaydi listeleyin
select * from musteri_urun order by urun_id limit(3);
select * from musteri_urun order by urun_id fetch next(3) row only;

--Sirali tablodan 4. kayittan 7.kayida kadar olan kayitlari listeleyin
select * from musteri_urun order by urun_id offset(3) limit(4);
SELECT * FROM musteri_urun ORDER BY urun_id OFFSET(3) ROW FETCH NEXT(4) ROW ONLY;

--ALTER TABLE STATEMENT
drop table isciler;
CREATE TABLE personel  
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20), CONSTRAINT personel_pk3 PRIMARY KEY(id)
);

INSERT INTO personel VALUES(123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda'); 
INSERT INTO personel VALUES(234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota'); 
INSERT INTO personel VALUES(345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda'); 
INSERT INTO personel VALUES(456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford'); 
INSERT INTO personel VALUES(567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas'); 
INSERT INTO personel VALUES(456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford'); 
INSERT INTO personel VALUES(123456710, 'Hatice Sahin', 'Bursa', 4500,	'Honda');

select * from personel;

--1) ADD default deger ile tabloya bir field ekleme
alter table personel add ulke_isim varchar(20) default 'Turkiye';
alter table personel add column veli_isim varchar(20), add column zipcode int;

--3) DROP tablodan sutun silme
alter table personel drop column ulke_isim;
alter table personel drop veli_isim, drop zipcode;

--4) RENAME COLUMN sutun adi degistirme
alter table personel rename column sehir to il;
alter table personel rename isim to name;

--5) RENAME tablonun ismini degistirme
alter table personel rename to isciler;

select * from isciler;

--6) TYPE/SET sutunlarin ozelliklerini degistirme
alter table isciler alter column il type varchar(30), alter column maas set not null;
alter table isciler alter il type varchar(40), alter sirket set not null;
--Not: Numerik bir data türünü String bir data turune dönüştürmek istersek;
alter table isciler alter column id type varchar(20) using(id::varchar(20));

--TRANSACTION (BEGIN-SAVEPOINT-ROLLBACK-COMMIT)
drop table ogrenciler2 cascade;
CREATE TABLE ogrenciler2  
(
id serial, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu real
);

BEGIN;
INSERT INTO ogrenciler2 VALUES(default, 'Ali Can', 'Hasan',75.5); 
INSERT INTO ogrenciler2 VALUES(default, 'Merve Gul', 'Ayse',85.3); 
savepoint x;
INSERT INTO ogrenciler2 VALUES(default, 'Kemal Yasa', 'Hasan',85.6); 
INSERT INTO ogrenciler2 VALUES(default, 'Nesibe Yilmaz', 'Ayse',95.3); 
savepoint y;
INSERT INTO ogrenciler2 VALUES(default, 'Mustafa Bak', 'Can',99); 
INSERT INTO ogrenciler2 VALUES(default, 'Can Bak', 'Ali', 67.5); 
ROLLBACK to x;
COMMIT;

select * from ogrenciler2;
delete from ogrenciler2;
drop table ogrenciler2;


