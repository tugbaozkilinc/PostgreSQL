-- DISTINCT çağrılan terimlerden tekrarlı olanların sadece birincisini alır.

CREATE TABLE musteri_urun 
(
urun_id int, musteri_isim varchar(50), urun_isim varchar(50) 
);

INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (10, 'Ali', 'Portakal'); 
INSERT INTO musteri_urun VALUES (20, 'Veli', 'Elma'); 
INSERT INTO musteri_urun VALUES (30, 'Ayse', 'Armut'); 
INSERT INTO musteri_urun VALUES (20, 'Ali', 'Elma'); 
INSERT INTO musteri_urun VALUES (10, 'Adem', 'Portakal'); 
INSERT INTO musteri_urun VALUES (40, 'Veli', 'Kaysi'); 
INSERT INTO musteri_urun VALUES (20, 'Elif', 'Elma');

select * from musteri_urun;

-- musteri_urun tablosundan urun isimlerini tekrarsız listeleyiniz(gruplayınız)
select urun_isim from musteri_urun group by urun_isim; -- group by ile cozumu
select distinct(urun_isim) from musteri_urun; -- distinct ile cozumu

-- Tabloda kac farkli meyve vardir ?
select urun_isim, count(urun_isim) from musteri_urun group by urun_isim;
select urun_isim, count(distinct urun_isim) from musteri_urun group by urun_isim;

-- FETCH NEXT (SAYI) ROW ONLY- OFFSET- LIMIT
-- Tabloyu urun_id ye gore siralayiniz, musteri urun tablosundan ilk 3 kaydi listeleyin
select * from musteri_urun order by urun_id fetch next(3) row only;
select * from musteri_urun order by urun_id limit(3);

-- Musteri urun tablosundan ilk kaydı listeleyiniz.
select * from musteri_urun order by urun_id limit 1;

-- Musteri urun tablosundan son uc kaydi listeleyiniz
select * from musteri_urun order by urun_id desc limit 3;

CREATE TABLE maas 
(
id int, musteri_isim varchar(50), maas int 
);

INSERT INTO maas VALUES (10, 'Ali', 5000); 
INSERT INTO maas VALUES (10, 'Ali', 7500); 
INSERT INTO maas VALUES (20, 'Veli', 10000); 
INSERT INTO maas VALUES (30, 'Ayse', 9000); 
INSERT INTO maas VALUES (20, 'Ali', 6500); 
INSERT INTO maas VALUES (10, 'Adem', 8000); 
INSERT INTO maas VALUES (40, 'Veli', 8500); 
INSERT INTO maas VALUES (20, 'Elif', 5500);

select * from maas;

-- En yuksek maası alan musteriyi listeleyiniz
select * from maas order by maas desc limit 1;

-- En yuksek ikinci maasi listeleyiniz
select * from maas order by maas desc limit 1 offset 1;
select * from maas order by maas desc offset 1 limit 1;
select * from maas order by maas desc offset(1) row fetch next(1) row only;

-- Maas tablosundan en dusuk dorduncu maasi listeleyiniz
select * from maas order by maas offset 3 limit 1;

-- ALTER TABLE statement tabloda add, Type(modify)/Set, Rename veya drop columns islemleri icin kullanilir.
-- ALTER TABLE statement tablolari yeniden isimlendirmek icin de kullanilir.

CREATE TABLE personel 
(
id int, isim varchar(50), sehir varchar(50), maas int, sirket varchar(20), CONSTRAINT personel_pk PRIMARY KEY (id)
);

INSERT INTO personel VALUES (123456789, 'Ali Yilmaz', 'Istanbul', 5500, 'Honda');  
INSERT INTO personel VALUES (234567890, 'Veli Sahin', 'Istanbul', 4500, 'Toyota');  
INSERT INTO personel VALUES (345678901, 'Mehmet Ozturk', 'Ankara', 3500, 'Honda');  
INSERT INTO personel VALUES (456789012, 'Mehmet Ozturk', 'Izmir', 6000, 'Ford');  
INSERT INTO personel VALUES (567890123, 'Mehmet Ozturk', 'Ankara', 7000, 'Tofas');  
INSERT INTO personel VALUES (456715012, 'Veli Sahin', 'Ankara', 4500, 'Ford');  
INSERT INTO personel VALUES (123456710, 'Hatice Sahin', 'Bursa', 4500, 'Honda');

select * from personel;

-- 1) ADD default deger ile tabloya bir field ekleme
ALTER TABLE personel add zipcode varchar(30);
ALTER TABLE personel ADD adres varchar(50) DEFAULT 'Turkiye' -- DEFAULT yazarsak oluşturduğumuz sütüna belirttiğimiz veriyi tüm satırlara girer

-- 2) DROP tablodan sutun silme
alter table personel drop column zipcode;
alter table personel drop adres, drop sirket;

-- 3) RENAME COLUMN sutun adi degistirme
alter table personel rename column sehir to il;

-- 4) RENAME tablonun ismini degistirme
alter table personel rename to isci;
select * from isci;

-- 5) TYPE/SET(modify) sutunlarin ozelliklerini degistirme
alter table isci alter column il type varchar(30), alter column maas set not null;
-- Eger numeric data type a sahip bir sutunun data type ina String bir data type atamak istersek type varchar(30) using (maas::varchar(30)) formatini kullaniriz
alter table isci alter column maas type varchar(30) using (maas::varchar(30));

-- TRANSACTION (begin, savepoint, rollback, commit)
-- Transaction baslatmak icin BEGIN komutu kullanmamiz gerekir ve Transaction'i sonlandirmak icin COMMIT komutunu calistirmaliyiz.
-- Serial data turu otomatik olarak birden baslayarak sirali olarak sayi atamasi yapar
-- INSERT INTO ile tabloya veri eklerken serial data turunu kullandigim veri degeri yerine DEFAULT yazariz
drop table if exists ogrenciler2;
CREATE TABLE ogrenciler2
(
id serial, isim VARCHAR(50), veli_isim VARCHAR(50), yazili_notu real       
);

BEGIN;
INSERT INTO ogrenciler2 VALUES (default, 'Ali Can', 'Hasan', 75.5);
INSERT INTO ogrenciler2 VALUES (default, 'Merve Gul', 'Ayse', 85.3);
savepoint x;
INSERT INTO ogrenciler2 VALUES (default, 'Kemal Yasa', 'Hasan', 85.6);
INSERT INTO ogrenciler2 VALUES (default, 'Nesibe Yilmaz', 'Ayse', 95.3);
savepoint y;
INSERT INTO ogrenciler2 VALUES (default, 'Mustafa Bak', 'Can', 99);
INSERT INTO ogrenciler2 VALUES (default, 'Can Bak', 'Ali', 67.5);
ROLLBACK to x;
COMMIT;

select * from ogrenciler2; 
delete from ogrenciler2;
drop table ogrenciler2;



























