create database if not exists jpetstore;
use jpetstore;

create table if not exists supplier (
   suppid int not null, 
    name varchar(80) null,
    status varchar(2) not null,
    addr1 varchar(80) null,
    addr2 varchar(80) null,
    city varchar(80) null,
    state varchar(80) null,
    zip varchar(5) null,
    phone varchar(80) null,  
primary key (suppid)) 
engine=innodb 
min_rows=0 
max_rows=1000 
pack_keys=default 
row_format=default 
comment='cadastro de fornecedores';

create table if not exists signon (
    username varchar(25) not null,
    password varchar(25)  not null,  
primary key (username)) 
engine=innodb 
min_rows=0 
max_rows=1000  
pack_keys=default 
row_format=default 
comment='cadastro de usu�rios';

create table if not exists account (
    userid varchar(80) not null,
    email varchar(80) not null,
    firstname varchar(80) not null,
    lastname varchar(80) not null,
    status varchar(2)  null,
    addr1 varchar(80) not null,
    addr2 varchar(40) null,
    city varchar(80) not  null,
    state varchar(80) not null,
    zip varchar(20) not null,
    country varchar(20) not null,
    phone varchar(80) not null,
primary key (userid) )
engine=innodb
min_rows=0 
max_rows=1000  
pack_keys=default 
row_format=default 
comment='cadastro de contas';

create table if not exists profile (
    userid varchar(80) not null,
    langpref varchar(80) not null,
    favcategory varchar(30),
    mylistopt bool,
    banneropt bool,
primary key (userid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='cadastro de perfis';

create table if not exists bannerdata (
    favcategory varchar(80) not null,
    bannername varchar(255)  null, 
primary key (favcategory))
engine=innodb 
pack_keys=default 
row_format=default 
comment='banner data';

create table if not exists orders (
      orderid int not null,
      userid varchar(80) not null,
      orderdate date not null,
      shipaddr1 varchar(80) not null,
      shipaddr2 varchar(80) null,
      shipcity varchar(80) not null,
      shipstate varchar(80) not null,
      shipzip varchar(20) not null,
      shipcountry varchar(20) not null,
      billaddr1 varchar(80) not null,
      billaddr2 varchar(80)  null,
      billcity varchar(80) not null,
      billstate varchar(80) not null,
      billzip varchar(20) not null,
      billcountry varchar(20) not null,
      courier varchar(80) not null,
      totalprice decimal(10,2) not null,
      billtofirstname varchar(80) not null,
      billtolastname varchar(80) not null,
      shiptofirstname varchar(80) not null,
      shiptolastname varchar(80) not null,
      creditcard varchar(80) not null,
      exprdate varchar(7) not null,
      cardtype varchar(80) not null,
      locale varchar(80) not null,
primary key (orderid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='cadastro de pedidos';

create table if not exists orderstatus (
      orderid int not null,
      linenum int not null,
      timestamp date not null,
      status varchar(2) not null,
primary key (orderid, linenum) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='status de pedidos';

create table if not exists lineitem (
      orderid int not null,
      linenum int not null,
      itemid varchar(10) not null,
      quantity int not null,
      unitprice decimal(10,2) not null,
primary key (orderid, linenum) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='line item';

create table if not exists category (
	catid varchar(10) not null,
	name varchar(80) null,
	descn varchar(255) null,
primary key (catid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='categorias';

create table if not exists product (
    productid varchar(10) not null,
    category varchar(10) not null,
    name varchar(80) null,
    descn varchar(255) null,
primary key (productid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='categorias';

alter table product 
	add index productcat(category);

alter table product 
	add index productname(name);

alter table category 
	add index ixcategoryproduct(catid);

alter table product  add foreign key (category) 
         references category(catid) 
         on delete restrict 
         on update restrict;

create table if not exists item (
    itemid varchar(10) not null,
    productid varchar(10) not null,
    listprice decimal(10,2) null,
    unitcost decimal(10,2) null,
    supplier int null,
    status varchar(2) null,
    attr1 varchar(80) null,
    attr2 varchar(80) null,
    attr3 varchar(80) null,
    attr4 varchar(80) null,
    attr5 varchar(80) null,
primary key (itemid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='itens';

alter table item 
	add index itemprod(productid);

alter table item add foreign key (productid) 
         references product(productid) 
         on delete restrict 
         on update restrict;

alter table item add foreign key (supplier) 
         references supplier(suppid) 
         on delete restrict 
         on update restrict;

create table if not exists inventory (
    itemid varchar(10) not null,
    qty int not null,
primary key (itemid) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='inventory';

create table if not exists sequence (
    name               varchar(30)  not null,
    nextid             int          not null,
primary key (name) )
engine=innodb 
pack_keys=default 
row_format=default 
comment='inventory';

use jpetstore;

INSERT INTO sequence VALUES ('ordernum', 1000);
INSERT INTO sequence VALUES ('linenum', 1000);

INSERT INTO signon VALUES ('j2ee','j2ee');
INSERT INTO signon VALUES ('ACID','ACID');

INSERT INTO account VALUES ('j2ee','yourname@yourdomain.com','ABC', 'XYX', 'OK', '901 San Antonio Road', 'MS UCUP02-206', 'Palo Alto', 'CA', '94303', 'USA',  '555-555-5555');
INSERT INTO account VALUES ('ACID','acid@yourdomain.com','ABC', 'XYX', 'OK', '901 San Antonio Road', 'MS UCUP02-206', 'Palo Alto', 'CA', '94303', 'USA',  '555-555-5555');

INSERT INTO profile VALUES ('j2ee','english','DOGS','1','1');
INSERT INTO profile VALUES ('ACID','english','CATS','1','1');

INSERT INTO bannerdata VALUES ('FISH','<image src="../images/banner_fish.gif">');
INSERT INTO bannerdata VALUES ('CATS','<image src="../images/banner_cats.gif">');
INSERT INTO bannerdata VALUES ('DOGS','<image src="../images/banner_dogs.gif">');
INSERT INTO bannerdata VALUES ('REPTILES','<image src="../images/banner_reptiles.gif">');
INSERT INTO bannerdata VALUES ('BIRDS','<image src="../images/banner_birds.gif">');

INSERT INTO category VALUES ('FISH','Fish','<image src="../images/fish_icon.gif"><font size="5" color="blue"> Fish</font>');
INSERT INTO category VALUES ('DOGS','Dogs','<image src="../images/dogs_icon.gif"><font size="5" color="blue"> Dogs</font>');
INSERT INTO category VALUES ('REPTILES','Reptiles','<image src="../images/reptiles_icon.gif"><font size="5" color="blue"> Reptiles</font>');
INSERT INTO category VALUES ('CATS','Cats','<image src="../images/cats_icon.gif"><font size="5" color="blue"> Cats</font>');
INSERT INTO category VALUES ('BIRDS','Birds','<image src="../images/birds_icon.gif"><font size="5" color="blue"> Birds</font>');

INSERT INTO product VALUES ('FI-SW-01','FISH','Angelfish','<image src="../images/fish1.jpg">Salt Water fish from Australia');
INSERT INTO product VALUES ('FI-SW-02','FISH','Tiger Shark','<image src="../images/fish4.gif">Salt Water fish from Australia');
INSERT INTO product VALUES ('FI-FW-01','FISH', 'Koi','<image src="../images/fish3.gif">Fresh Water fish from Japan');
INSERT INTO product VALUES ('FI-FW-02','FISH', 'Goldfish','<image src="../images/fish2.gif">Fresh Water fish from China');
INSERT INTO product VALUES ('K9-BD-01','DOGS','Bulldog','<image src="../images/dog1.gif">Friendly dog from England');
INSERT INTO product VALUES ('K9-PO-02','DOGS','Poodle','<image src="../images/dog6.gif">Cute dog from France');
INSERT INTO product VALUES ('K9-DL-01','DOGS', 'Dalmation','<image src="../images/dog5.gif">Great dog for a Fire Station');
INSERT INTO product VALUES ('K9-RT-01','DOGS', 'Golden Retriever','<image src="../images/dog4.gif">Great family dog');
INSERT INTO product VALUES ('K9-RT-02','DOGS', 'Labrador Retriever','<image src="../images/dog5.gif">Great hunting dog');
INSERT INTO product VALUES ('K9-CW-01','DOGS', 'Chihuahua','<image src="../images/dog2.gif">Great companion dog');
INSERT INTO product VALUES ('RP-SN-01','REPTILES','Rattlesnake','<image src="../images/snake1.gif">Doubles as a watch dog');
INSERT INTO product VALUES ('RP-LI-01','REPTILES','Iguana','<image src="../images/lizard1.gif">Friendly green friend');
INSERT INTO product VALUES ('RP-LI-02','REPTILES','Rabbit','<image src="../images/rabbit1.jpg">A bunny for your home');
INSERT INTO product VALUES ('FL-DSH-01','CATS','Manx','<image src="../images/cat3.gif">Great for reducing mouse populations');
INSERT INTO product VALUES ('FL-DLH-02','CATS','Persian','<image src="../images/cat2.gif">Friendly house cat, doubles as a princess');
INSERT INTO product VALUES ('AV-CB-01','BIRDS','Amazon Parrot','<image src="../images/bird4.gif">Great companion for up to 75 years');
INSERT INTO product VALUES ('AV-SB-02','BIRDS','Finch','<image src="../images/bird1.gif">Great stress reliever');

INSERT INTO supplier VALUES (1,'XYZ Pets','AC','600 Avon Way','','Los Angeles','CA','94024','212-947-0797');
INSERT INTO supplier VALUES (2,'ABC Pets','AC','700 Abalone Way','','San Francisco ','CA','94024','415-947-0797');

INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-1','FI-SW-01',16.50,10.00,1,'P','Large');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-2','FI-SW-01',16.50,10.00,1,'P','Small');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-3','FI-SW-02',18.50,12.00,1,'P','Toothless');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-4','FI-FW-01',18.50,12.00,1,'P','Spotted');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-5','FI-FW-01',18.50,12.00,1,'P','Spotless');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-6','K9-BD-01',18.50,12.00,1,'P','Male Adult');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-7','K9-BD-01',18.50,12.00,1,'P','Female Puppy');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-8','K9-PO-02',18.50,12.00,1,'P','Male Puppy');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-9','K9-DL-01',18.50,12.00,1,'P','Spotless Male Puppy');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-10','K9-DL-01',18.50,12.00,1,'P','Spotted Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-11','RP-SN-01',18.50,12.00,1,'P','Venomless');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-12','RP-SN-01',18.50,12.00,1,'P','Rattleless');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-13','RP-LI-02',18.50,12.00,1,'P','Rex Red Adult');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-14','FL-DSH-01',58.50,12.00,1,'P','Tailless');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-15','FL-DSH-01',23.50,12.00,1,'P','With tail');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-16','FL-DLH-02',93.50,12.00,1,'P','Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-17','FL-DLH-02',93.50,12.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-18','AV-CB-01',193.50,92.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-19','AV-SB-02',15.50, 2.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-20','FI-FW-02',5.50, 2.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-21','FI-FW-02',5.29, 1.00,1,'P','Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-22','K9-RT-02',135.50, 100.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-23','K9-RT-02',145.49, 100.00,1,'P','Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-24','K9-RT-02',255.50, 92.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-25','K9-RT-02',325.29, 90.00,1,'P','Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-26','K9-CW-01',125.50, 92.00,1,'P','Adult Male');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-27','K9-CW-01',155.29, 90.00,1,'P','Adult Female');
INSERT INTO item (itemid, productid, listprice, unitcost, supplier, status, attr1) VALUES ('EST-28','K9-RT-01',155.29, 90.00,1,'P','Adult Female');

INSERT INTO inventory (itemid, qty ) VALUES ('EST-1',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-2',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-3',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-4',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-5',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-6',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-7',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-8',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-9',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-10',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-11',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-12',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-13',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-14',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-15',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-16',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-17',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-18',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-19',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-20',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-21',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-22',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-23',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-24',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-25',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-26',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-27',10000);
INSERT INTO inventory (itemid, qty ) VALUES ('EST-28',10000);
