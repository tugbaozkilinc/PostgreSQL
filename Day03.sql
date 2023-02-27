CREATE TABLE ogrenciler20
(
id int, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int
);

select * from ogrenciler20;

INSERT INTO ogrenciler20 VALUES(123, 'Ali Can', 'Hasan', 75);
INSERT INTO ogrenciler20 VALUES(124, 'Merve Gul', 'Ayse', 85);
INSERT INTO ogrenciler20 VALUES(125, 'Kemal Yasa', 'Hasan', 85);
INSERT INTO ogrenciler20 VALUES(126, 'Nesibe Yilmaz', 'Ayse', 95);
INSERT INTO ogrenciler20 VALUES(127, 'Mustafa Bak', 'Can', 99);
INSERT INTO ogrenciler20 VALUES(127, 'Mustafa Bak', 'Ali', 99);
INSERT INTO ogrenciler20 VALUES(129, 'Ali Can', 'Ayse', 95);
INSERT INTO ogrenciler20 VALUES(121, 'Omer Faruk', 'Can', 99);
INSERT INTO ogrenciler20 VALUES(128, 'Veli Tan', 'Ali', 99);

--TRUNCATE bir tablodaki tum verileri geri alamayacagimiz sekilde siler, sartli silme yapmaz
truncate table ogrenciler20;
truncate ogrenciler20;

--ON DELETE CASCADE
DROP TABLE if exists talebeler; --eger tablo varsa tabloyu siler

CREATE TABLE talebeler1
(
id CHAR(3) primary key, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu int
);

INSERT INTO talebeler1 VALUES('123', 'Ali Can', 'Hasan', 75);
INSERT INTO talebeler1 VALUES('124', 'Merve Gul', 'Ayse', 85);
INSERT INTO talebeler1 VALUES('125', 'Kemal Yasa', 'Hasan', 85);
INSERT INTO talebeler1 VALUES('126', 'Nesibe Yılmaz', 'Ayse', 95);
INSERT INTO talebeler1 VALUES('127', 'Mustafa Bak', 'Can', 99);

CREATE TABLE notlar2
(
talebe_id char(3), ders_adi varchar(30), yazili_notu int, CONSTRAINT notlar_fk FOREIGN KEY(talebe_id) REFERENCES talebeler1(id) on delete cascade
);

INSERT INTO notlar2 VALUES('123','kimya', 75);
INSERT INTO notlar2 VALUES('124', 'fizik', 65);
INSERT INTO notlar2 VALUES('125', 'tarih', 90);
INSERT INTO notlar2 VALUES('126', 'Matematik', 90);

select * from talebeler1;
select * from notlar2;

--notlar tablosundan talebe_id si 123 olan data yı silelim
delete from notlar2 where talebe_id='123';

--talebeler tablosundan id si 126 olan datayi silelim
delete from talebeler1 where id='126';

/*
Her defasında önce child tablodaki verileri silmek yerine ON DELETE CASCADE silme özelliği ile parent tablo dan da veri silebiliriz. ON DELETE CASCADE komutu 
kullanımında parent tablodan sildiğimiz data child tablo dan da silinir
*/

--IN CONDITION
DROP TABLE if exists musteriler;
CREATE TABLE musteriler 
(
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO musteriler VALUES(10, 'Mark', 'Orange'); 
INSERT INTO musteriler VALUES(10, 'Mark', 'Orange');  
INSERT INTO musteriler VALUES(20, 'John', 'Apple'); 
INSERT INTO musteriler VALUES(30, 'Amy', 'Palm'); 
INSERT INTO musteriler VALUES(20, 'Mark', 'Apple'); 
INSERT INTO musteriler VALUES(10, 'Adem', 'Orange'); 
INSERT INTO musteriler VALUES(40, 'John', 'Apricot'); 
INSERT INTO musteriler VALUES(20, 'Eddie', 'Apple');

select * from musteriler;

--Musteriler tablosundan urun ismi orange, apple veya apricot olan tum verileri listeleyiniz
select * from musteriler where urun_isim='Orange' or urun_isim='Apple' or urun_isim='Apricot';
select * from musteriler where urun_isim in('Orange', 'Apple', 'Apricot');

--Musteriler tablosundan urun ismi orange ve urun_id si 10 olan tum verileri listeleyiniz
select * from musteriler where urun_isim='Orange' and urun_id=10;

--NOT IN CONDITION
select * from musteriler where urun_isim not in('Orange', 'Apple', 'Apricot');

--BETWEEN CONDITION
--musteriler tablosundan id si 20 ile 40 arasında olan tum verileri listeliyiniz
select * from musteriler where urun_id>=20 and urun_id<=40;
select * from musteriler where urun_id between 20 and 40; --20 ve 40 dahil

--NOT BETWEEN CONDITION
select * from musteriler where urun_id not between 20 and 40;

--Practice 6: 
--id'si 10 ile 30 arasında olan tum verileri listeleyiniz
select * from musteriler where urun_id between 10 and 30;

--D ile Y arasındaki musteri isimlerini listeleyiniz
select musteri_isim from musteriler where musteri_isim between 'D' and 'Y';

--D ile Y arasında olmayan musterilerin tum bilgilerini listeleyiniz
select * from musteriler where musteri_isim not between 'D' and 'Y';

--Musteri isim Amy ve urun ismi Palm olan personeli listeleyiniz
select * from musteriler where urun_isim='Palm' and musteri_isim='Amy';

--SUBQUERIES
DROP TABLE if exists calisanlar2;
CREATE TABLE calisanlar2
(
id int, isim VARCHAR(50), sehir VARCHAR(50), maas int, isyeri VARCHAR(20)
);

INSERT INTO calisanlar2 VALUES(123456789, 'Ali Seker', 'Istanbul', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(234567890, 'Ayse Gul', 'Istanbul', 1500, 'LCWaikiki');
INSERT INTO calisanlar2 VALUES(345678901, 'Veli Yilmaz', 'Ankara', 3000, 'Vakko');
INSERT INTO calisanlar2 VALUES(456789012, 'Veli Yilmaz', 'Izmir', 1000, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(567890123, 'Veli Yilmaz', 'Ankara', 7000, 'Adidas');
INSERT INTO calisanlar2 VALUES(456789012, 'Ayse Gul', 'Ankara', 1500, 'Pierre Cardin');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', 2500, 'Vakko');
INSERT INTO calisanlar2 VALUES(123456710, 'Fatma Yasa', 'Bursa', null, 'Vakko');

CREATE TABLE markalar
(
marka_id int, marka_isim VARCHAR(20), calisan_sayisi int
);

INSERT INTO markalar VALUES(100, 'Vakko', 12000);
INSERT INTO markalar VALUES(101, 'Pierre Cardin', 18000);
INSERT INTO markalar VALUES(102, 'Adidas', 10000);
INSERT INTO markalar VALUES(103, 'LCWaikiki', 21000);
INSERT INTO markalar VALUES(104, 'Nike', 19000);

select * from calisanlar2;
select * from markalar;

--Çalisan sayisi 15.000’den cok olan markalarin isimlerini ve bu markada calisanlarin isimlerini ve maaşlarini listeleyin.
SELECT isim, maas, isyeri FROM calisanlar2
WHERE isyeri IN(SELECT marka_isim FROM MARKALAR WHERE calisan_sayisi>15000); --Nike i isyeri ile iliski kurmadigi icin getirmedi

--marka_id’si 101’den büyük olan marka çalişanlarinin isim, maaş ve şehirlerini listeleyiniz.
select isim, maas, sehir from calisanlar2 
where isyeri in(select marka_isim from markalar where marka_id>101);

--ÖDEV Ankara’da calisani olan markalarin marka id'lerini ve calisan sayilarini listeleyiniz.
select marka_id, calisan_sayisi from markalar 
where marka_isim in(select isyeri from calisanlar2 where sehir='Ankara');

--AGGREGATE METHOD
--calisanlar tablosundan en yuksek maasi listeleyelim
select max(maas) from calisanlar2;
select max(maas) as maksimum_maas from calisanlar2; --Eger bir sutuna gecici olarak bir isim vermek istersek as komutunu yazdiktan sonra vermek istedigimiz ismi yazariz

--calisanlar tablosundan en dusuk maasi listeleyelim
select min(maas) as minimum_maas from calisanlar2;

--calisanlar tablosundaki maas larin toplamini listeleyiniz
select sum(maas) from calisanlar2;

--calisanlar tablosundaki maas larin ortalamasini listeleyiniz
select avg(maas) from calisanlar2;
select round(avg(maas)) from calisanlar2;
select round(avg(maas), 2) from calisanlar2;

--calisanlar tablosundaki maas larin sayisini listeleyiniz
select count(maas) from calisanlar2; --7 null i saymadi
select count(*) from calisanlar2; --8

select * from markalar;
select * from calisanlar2;

--AGGREGATE METHOD LARDA SUBQUERY
--Her markanin id’sini, ismini ve toplam kaç şehirde bulunduğunu listeleyen bir SORGU yaziniz
select marka_id, marka_isim, (select count(sehir) as sehir_sayisi from calisanlar2 where marka_isim=isyeri) from markalar;

--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin toplam maaşini listeleyiniz
create view toplam_maas
as
select marka_isim, calisan_sayisi, (select sum(maas) as toplam_maas from calisanlar2 where marka_isim=isyeri) from markalar;

select * from toplam_maas;
--Her markanin ismini, calisan sayisini ve o markaya ait calisanlarin maksimum ve minumum maaşini listeleyen bir Sorgu yaziniz.
--1. yol
select marka_isim, calisan_sayisi, 
(select max(maas) from calisanlar2 where marka_isim=isyeri) as en_yuksek_maas, 
(select min(maas) from calisanlar2 where marka_isim=isyeri) as en_dusuk_maas
from markalar;
--2. yol
select marka_isim, calisan_sayisi, (select max(maas) as max_maas from calisanlar2 where marka_isim=isyeri),
(select min(maas) as min_maas from calisanlar2 where marka_isim=isyeri) from markalar;

--VIEW KULLANIMI 
--yaptigimiz sorgulari hafizaya alir ve tekrar bizden istenen sorgulama yerine view e atadigimiz ismi select komutuyla cagiririz
create view max_min_maas 
as
select marka_isim, calisan_sayisi, 
(select max(maas) from calisanlar2 where marka_isim=isyeri) as en_yuksek_maas, 
(select min(maas) from calisanlar2 where marka_isim=isyeri) as en_dusuk_maas
from markalar;

select * from max_min_maas;

--EXISTS CONDITION
CREATE TABLE mart1
(   
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO mart1 VALUES(10, 'Mark', 'Honda');
INSERT INTO mart1 VALUES(20, 'John', 'Toyota');
INSERT INTO mart1 VALUES(30, 'Amy', 'Ford');
INSERT INTO mart1 VALUES(20, 'Mark', 'Toyota');
INSERT INTO mart1 VALUES(10, 'Adam', 'Honda');
INSERT INTO mart1 VALUES(40, 'John', 'Hyundai');

CREATE TABLE nisan1 
(   
urun_id int, musteri_isim varchar(50), urun_isim varchar(50)
);

INSERT INTO nisan1 VALUES(10, 'Hasan', 'Honda');
INSERT INTO nisan1 VALUES(10, 'Kemal', 'Honda');
INSERT INTO nisan1 VALUES(20, 'Ayse', 'Toyota');
INSERT INTO nisan1 VALUES(50, 'Yasar', 'Volvo');
INSERT INTO nisan1 VALUES(20, 'Mine', 'Toyota');
INSERT INTO nisan1 VALUES(20, 'Eddie', 'Toyota');

select * from mart1;
select * from nisan1;

--MART VE NİSAN aylarında aynı urun_id ile satılan ürünlerin urun_id’lerini listeleyen ve aynı zamanda bu ürünleri MART ayında alan musteri_isim 'lerini listeleyen bir sorgu yazınız.
select urun_id, musteri_isim from mart1 where exists(select urun_id from nisan1 where mart1.urun_id=nisan1.urun_id);

--Her iki ayda birden satılan ürünlerin URUN_ISIM'lerini ve bu ürünleri NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select urun_isim, musteri_isim from nisan1 where exists(select urun_isim from mart1 where mart1.urun_isim=nisan1.urun_isim);

--ODEV Her iki ayda ortak satilmayan ürünlerin URUN_ISIM'lerini ve  bu ürünleri NİSAN ayında satın alan MUSTERI_ISIM'lerini listeleyen bir sorgu yazınız.
select musteri_isim, urun_isim from nisan1 where not exists(select urun_isim from mart1 where mart1.urun_isim=nisan1.urun_isim);

--DML UPDATE
DROP TABLE if exists tedarikciler;
CREATE TABLE tedarikciler --parent
(
vergi_no int PRIMARY KEY, firma_ismi VARCHAR(50), irtibat_ismi VARCHAR(50)
);

INSERT INTO tedarikciler VALUES(101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES(102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES(103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES(104, 'Apple', 'Adam Eve');

DROP TABLE if exists tedarikciler;
CREATE TABLE urunler --child
(
ted_vergino int, urun_id int, urun_isim VARCHAR(50), musteri_isim VARCHAR(50), CONSTRAINT fk_urunler FOREIGN KEY(ted_vergino) REFERENCES tedarikciler(vergi_no) on delete cascade
);   

INSERT INTO urunler VALUES(101, 1001, 'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002, 'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003, 'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004, 'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005, 'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006, 'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007, 'Phone', 'Aslan Yılmaz');

select * from tedarikciler;
select * from urunler;

--vergi_no’su 102 olan tedarikcinin firma ismini 'Vestel' olarak güncelleyeniz.
update tedarikciler set firma_ismi='Vestel' where vergi_no=102;

--vergi_no’su 101 olan tedarikçinin firma ismini 'casper' ve irtibat_ismi’ni 'Ali Veli' olarak güncelleyiniz.
update tedarikciler set firma_ismi='Casper', irtibat_ismi='Ali Veli' where vergi_no=101; 

--urunler tablosundaki 'Phone' değerlerini 'Telefon' olarak güncelleyiniz.
update urunler set urun_isim='Telefon' where urun_isim='Phone';

--urunler tablosundaki urun_id değeri 1004'ten büyük olanların urun_id’sini 1 arttırın.
update urunler set urun_id=urun_id+1 where urun_id>1004;

--urunler tablosundaki tüm ürünlerin urun_id değerini ted_vergino sutun değerleri ile toplayarak güncelleyiniz
update urunler set urun_id=urun_id+ted_vergino;

delete from urunler;
delete from tedarikciler;  

INSERT INTO urunler VALUES(101, 1001, 'Laptop', 'Ayşe Can');
INSERT INTO urunler VALUES(102, 1002, 'Phone', 'Fatma Aka');
INSERT INTO urunler VALUES(102, 1003, 'TV', 'Ramazan Öz');
INSERT INTO urunler VALUES(102, 1004, 'Laptop', 'Veli Han');
INSERT INTO urunler VALUES(103, 1005, 'Phone', 'Canan Ak');
INSERT INTO urunler VALUES(104, 1006, 'TV', 'Ali Bak');
INSERT INTO urunler VALUES(104, 1007, 'Phone', 'Aslan Yılmaz');

INSERT INTO tedarikciler VALUES(101, 'IBM', 'Kim Yon');
INSERT INTO tedarikciler VALUES(102, 'Huawei', 'Çin Li');
INSERT INTO tedarikciler VALUES(103, 'Erikson', 'Maki Tammen');
INSERT INTO tedarikciler VALUES(104, 'Apple', 'Adam Eve');

select * from tedarikciler;
select * from urunler;

--urunler tablosundan Ali Bak’in aldigi urunun ismini, tedarikci tablosunda irtibat_ismi 'Adam Eve' olan firmanın ismi (firma_ismi) ile degistiriniz.
UPDATE urunler SET urun_isim=(select firma_ismi from tedarikciler WHERE irtibat_ismi='Adam Eve') WHERE musteri_isim='Ali Bak';

--Urunler tablosunda laptop satin alan musterilerin ismini, firma_ismi Apple’in irtibat_isim'i ile degistirin.
update urunler set musteri_isim=(select irtibat_ismi from tedarikciler where firma_ismi='Apple') where urun_isim='Laptop';

