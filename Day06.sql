-- JOINS
-- INNER JOIN
CREATE TABLE sirketler 
(
sirket_id int, sirket_isim varchar(20)
);

INSERT INTO sirketler VALUES (100, 'Toyota'); 
INSERT INTO sirketler VALUES (101, 'Honda'); 
INSERT INTO sirketler VALUES (102, 'Ford');
INSERT INTO sirketler VALUES (103, 'Hyundai');

CREATE TABLE siparisler 
(
siparis_id int, sirket_id int, siparis_tarihi date
);
INSERT INTO siparisler VALUES (11, 101, '2020-04-17');  
INSERT INTO siparisler VALUES (22, 102, '2020-04-18'); 
INSERT INTO siparisler VALUES (33, 103, '2020-04-19'); 
INSERT INTO siparisler VALUES (44, 104, '2020-04-20'); 
INSERT INTO siparisler VALUES (55,  105, '2020-04-21');

select * from sirketler;
select * from siparisler;

-- SORU 1: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler inner join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

-- NOT :
-- 1) Select’ten sonra tabloda gormek istediginiz sutunlari yazarken Tablo_adi.field_adi seklinde yazin
-- 2) From’dan sonra tablo ismi yazarken 1.Tablo ismi + INNER JOIN + 2.Tablo ismi yazmaliyiz
-- 3) Join’i hangi kurala gore yapacaginizi belirtmelisiniz. Bunun icin ON+ kuralimiz yazilmali
 
-- LEFT JOIN
-- SORU 2: Iki Tabloda sirket_id’si ayni olanlarin sirket_ismi, siparis_id ve siparis_tarihleri ile yeni bir tablo olusturun
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler left join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from siparisler left join sirketler
on sirketler.sirket_id=siparisler.sirket_id;

-- RIGHT JOIN
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler right join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

-- FULL JOINS
-- NOT :
-- 1) FULL Join’de iki tabloda var olan tum record’lar gosterilir.
-- 2) Bir tabloda olup otekinde olmayan data’lar bos kalir
*/
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi
from sirketler full join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

-- SELF JOINS
CREATE TABLE personel5 
(
id int, isim varchar(20), title varchar(60), yonetici_id int
);

INSERT INTO personel5 VALUES(1, 'Ali Can', 'SDET', 2);
INSERT INTO personel5 VALUES(2, 'Veli Cem', 'QA', 3);
INSERT INTO personel5 VALUES(3, 'Ayse Gul', 'QA Lead', 4); 
INSERT INTO personel5 VALUES(4, 'Fatma Can', 'CEO', 5);

select * from personel5;

-- Her personelin yanina yonetici ismini yazdiran bir tablo olusturun
select isim from personel5
select p.isim as personel_isim, y.isim as yonetici_isim from personel5 p inner join personel5 y on p.yonetici_id=y.id;
-- ayni iki hayali isim verilemiyor

-- LIKE CONDITION
/*
	LIKE condition WHERE ile kullanilarak SELECT, INSERT, UPDATE, veya DELETE
	statement ile calisan wildcards’a(özel sembol) izin verir.. Ve bize pattern matching yapma
	imkani verir.
*/

CREATE TABLE musteriler1  
(
id int UNIQUE, isim varchar(50) NOT NULL, gelir int
);

INSERT INTO musteriler1 (id, isim, gelir) VALUES (1001, 'Ali', 62000); 
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1002, 'Ayse', 57500);  
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1003, 'Feride', 71000);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1004, 'Fatma', 42000); 
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1005, 'Kasim', 44000);
INSERT INTO musteriler1 (id, isim, gelir) VALUES (1006, 'ahmet', 82000); 

select * from musteriler1;

-- 1) % => 0 veya birden fazla karakter belirtir
-- SORU : Ismi A harfi ile baslayan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler1 where isim like 'A%';
select * from musteriler1 where isim ilike 'A%';
select * from musteriler1 where isim ~~* 'A%';
--%A: Son harfin 'A' olduğu char.
--A%: İlk harfin 'A' olduğu char.
--%A%: Ortasında A'ya sahip olan char.
/*
LIKE kullanımında büyük küçük harf gözetmeksizin sonuç almak istersek ILIKE kullanırız
LIKE yerine ~~ sembollerini kullanabiliriz. Eğer büyük küçük harf gözetmeksizin kullanmak istersek ~~* sembollerini kullanırız
*/
-- SORU : Ismi e harfi ile biten musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim, gelir from musteriler1 where isim like '%e';

-- Isminin icinde er olan musterilerin isimlerini ve gelir’lerini yazdiran QUERY yazin
select isim, gelir from musteriler1 where isim like '%er%';

-- 2) _=> sadece bir karakteri gosterir.
-- SORU : Ismi 5 harfli olup son 4 harfi atma olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler1 where isim ~~'_atma';

-- Ikinci harfi a olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler1 where isim like '_a%';

-- Ucuncu harfi s olan musterilerin tum bilgilerini yazdiran QUERY yazin
select * from musteriler1 where isim ~~ '__s%';

/*
	3) REGEXP_LIKE =>Daha karmaşık sorgular için herhangi bir kod, metin icerisinde istenilen yazi
	veya kod parcasinin aranip bulunmasini saglayan kendine ait soz dizimi olan bir yapidir.
	(REGEXP_LIKE) PostgreSQL de ‘’ ~ ‘’ karekteri ile kullanilir
*/

CREATE TABLE kelimeler 
(
id int UNIQUE, kelime varchar(50) NOT NULL, Harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);  
INSERT INTO kelimeler VALUES (1002, 'hat', 3);  
INSERT INTO kelimeler VALUES (1003, 'hit', 3);  
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);  
INSERT INTO kelimeler VALUES (1008, 'hct', 3);  
INSERT INTO kelimeler VALUES (1005, 'adem', 4); 
INSERT INTO kelimeler VALUES (1006, 'selim', 5); 
INSERT INTO kelimeler VALUES (1007, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hAt', 5); 

select * from kelimeler;

-- SORU : Ilk harfi h,son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* 'h[ai]t';

-- SORU : Ilk harfi h,son harfi t olup 2.harfi a ile k arasinda olan 3 harfli kelimelerin  tum bilgilerini  yazdiran QUERY yazin
select * from kelimeler where kelime

-- SORU : a veya s ile baslayan kelimelerin tum bilgilerini yazdiran QUERY yazin
select * from kelimeler where kelime ~* '^[as]'

select * from kelimeler where kelime * ''



























