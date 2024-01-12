create table tedarikciler
(
tedarikci_id char(8), tedarikci_ismi varchar(30), tedarikci_adres varchar(30), ulasim_tarihi date
);
--char(8) buraya 7 karakter girersen kalan karakter sayısı boşlukla doldurulur, fakat 9 karakter girersen hata alırsın

create table tedarikci_ziyaret as select tedarikci_ismi, ulasim_tarihi from tedarikciler;

insert into tedarikciler values(1234567, 'Ali Can', 'Izmir', now());
insert into tedarikciler(tedarikci_id, tedarikci_ismi) values(2345678, 'Mete Selen');

insert into tedarikci_ziyaret values('Ayse Sıla', '2022-12-23');
insert into tedarikci_ziyaret values('Omer Can', '2022-02-23');
insert into tedarikciler(tedarikci_id, tedarikci_adres) values(3456789, 'Ankara');

select * from tedarikciler;
select * from tedarikci_ziyaret;




