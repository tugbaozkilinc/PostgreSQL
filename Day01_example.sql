create table tedarikciler
(
tedarikci_id char(8), tedarikci_ismi varchar(30), tedarikci_adres varchar(30), ulasim_tarihi date
);

create table tedarikci_ziyaret as select tedarikci_ismi, ulasim_tarihi from tedarikciler;

insert into tedarikciler values('1234567', 'Ali Can', 'Izmir', now());
insert into tedarikciler(tedarikci_id, tedarikci_ismi) values('2345678', 'Mete Han');

select * from tedarikciler;
select tedarikci_ismi from tedarikci_ziyaret;

insert into tedarikci_ziyaret values('Ayse Nur', '2022-12-23');
insert into tedarikci_ziyaret values('Omer Faruk', '2022-02-23');
insert into tedarikciler(tedarikci_id, tedarikci_adres) values ('3456789', '2022-06-25');

select * from tedarikciler;
select * from tedarikci_ziyaret;