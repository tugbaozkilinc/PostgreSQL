create table sehirler
(
isim varchar(20) not null, alan_kodu char(3), nufus int, constraint sehir primary key (alan_kodu)
);

insert into sehirler values ('Izmir', '232', 6000000);
insert into sehirler values ('Ankara', '235', 10000000);
insert into sehirler values ('Istanbul', '236', 16000000);
insert into sehirler values ('Eskisehir', '', '2700000');
insert into sehirler (alan_kodu, nufus) values ('236', 3000000); -- not null constraint, bu yuzden eklenemez

select * from sehirler;

create table ilceler
(
ilce_isim varchar(15), alan_kodu char(3), ilce_nufus int, constraint FK foreign key (alan_kodu) references sehirler (alan_kodu)
);

insert into ilceler values ('Odemis', '232', '250000');
insert into ilceler values ('Alsancak', '232', '550000');
insert into ilceler values ('Kecioren', '235', '270000');
insert into ilceler values ('Kecioren', '239', '270000'); -- primary key, bu yuzden eklenemez
insert into ilceler values ('Beylikduzu', null, '270000');
insert into ilceler values ('Beylikduzu', null, '270000');
insert into ilceler values ('Besiktas', '', '650000');

select * from ilceler;
select * from sehirler;



