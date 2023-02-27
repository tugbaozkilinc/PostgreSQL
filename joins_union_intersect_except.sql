-----------------------------------
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

-----------------------------------
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

--5000’den az maas alip Honda’da calismayanlarin isimlerini ve sirketlerini yazdirin  
select isim, sirket from personel where maas<5000
except
select isim, sirket from personel where sirket='Honda';

--Ismi Mehmet Ozturk olup Istanbul’da calismayanlarin isimlerini ve sehirlerini listeleyin
select isim, sehir from personel where isim='Mehmet Ozturk'
except 
select isim, sehir from personel where sehir='Istanbul';

-----------------------------------
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

--
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler left join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

--
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler right join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

--
select sirketler.sirket_isim, siparisler.siparis_id, siparisler.siparis_tarihi from sirketler full join siparisler
on sirketler.sirket_id=siparisler.sirket_id;

----------------------------------
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



