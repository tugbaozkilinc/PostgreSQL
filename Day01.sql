--DATABASE OLUSTURMA
create database db_name;
create database tugba;

--DDL(create) TABLE OLUSTURMA
create table ogrenciler2
(
ogrenci_no char(7), isim varchar(20), soyisim varchar(25), not_ort real, kayit_tarih date
);

--VAROLAN TABLODAN YENI BIR TABLO OLUSTURMA
create table ogrenci_notlari as select isim, soyisim, not_ort from ogrenciler2;

--DML(insert) VERI EKLEME
insert into ogrenciler2 values('1234567', 'Ece', 'Can', 85.0, now());
insert into ogrenciler2 values('1234567', 'Ece', 'Can', 85.0, '2022-12-11');
insert into ogrenciler2(isim, soyisim) values('Osman', 'Ece');

--DQL(select)
select * from ogrenciler2;





