create DATABASE shop3;
use shop3;


#3

create table company(
    name varchar(50),
    companyLicense BIGINT(18),
    establishDay BIGINT(2),
    establishMonth BIGINT(2),
    establishYear BIGINT(4),
    province varchar(150),
    city varchar(150),
    street varchar(150),
    primary key (companyLicense)
);

create table brand(
    brandName varchar(150),
    daySettingUp BIGINT(2),
    monthSettingUp BIGINT(2),
    yearSettingUp BIGINT(4),
    companyLicense BIGINT(18),
    primary key (brandName),
    foreign key (companyLicense) references company(companyLicense)
);

create table product(
    barcode BIGINT(12),
    weight FLOAT,
    name varchar(150),
    brandName varchar(150),
    primary key (barcode),
    foreign key (brandName) references brand(brandName)
);

create table type(
    typeName varchar(150),
    barcode BIGINT(12),
    primary key (typeName, barcode),
    foreign key (barcode) references product(barcode)
);

create table supply(
    id BIGINT(15),
    typeName varchar(150),
    brandName varchar(150),
    UNIQUE (typeName, brandName),
    primary key (id),
    foreign key (typeName) references type(typeName),
    foreign key (brandName) references brand(brandName)
);

create table distributor(
    distName varchar(150),
    email varchar(150),
    province varchar(150),
    city varchar(150),
    street varchar(150),
    hourOfWork BIGINT(15),
    primary key (distName)
);

/*relation*/
create table distribution(
    id BIGINT(15),
    barcode BIGINT(12),
    distName varchar(150),
    amount BIGINT(30),
    price FLOAT,
    UNIQUE (barcode, distName),
    primary key (id),
    foreign key (barcode) references product(barcode),
    foreign key (distName) references distributor(distName)
);

create table sell(
    id BIGINT(15),
    distName varchar(150),
    companyLicense BIGINT(18),
    UNIQUE (distName, companyLicense),
    primary key (id),
    foreign key (distName) references distributor(distName),
    foreign key (companyLicense) references company(companyLicense)
);

create table customer(
    nationalId BIGINT(15),
    custFerstName varchar(150),
    custLastname varchar(150),
    phone BIGINT(15),
    state varchar(150),
    city varchar(150),
    street varchar(150),
    primary key (nationalId)
);

create table purchased(
    id BIGINT(15),
    distName varchar(150),
    nationalId BIGINT(15),
    UNIQUE (distName, nationalId),
    primary key (id),
    foreign key (distName) references distributor(distName),
    foreign key (nationalId) references customer(nationalId)
);

create table ordered(
    orderId BIGINT(15),
    orderDay BIGINT(2),
    orderMonth BIGINT(2),
    orderYear BIGINT(4),
    nationalId BIGINT(15),
    primary key (orderId),
    foreign key (nationalId) references customer(nationalId)
);

create table preparing(
   orderId BIGINT(15),
   distName varchar(150),
   primary key (orderId),
   foreign key (orderId) references ordered(orderId),
   foreign key (distName) references distributor(distName)
);

create table order_product(
    id BIGINT(15),
    orderId BIGINT(15),
    barcode BIGINT(12),
    UNIQUE (orderId, barcode),
    primary key (id),
    foreign key (orderId) references ordered(orderId),
    foreign key (barcode) references product(barcode)
);


INSERT INTO company VALUES ('sh1', 123123123123123123, 10, 01, 2001, 'p1', 'c1', 's1');
INSERT INTO company VALUES ('sh2', 456456456456456456, 10, 02, 2002, 'p2', 'c2', 's2');
INSERT INTO company VALUES ('sh3', 678678678678678678, 10, 01, 2001, 'p3', 'c3', 's3');
INSERT INTO company VALUES ('sh4', 789789789789789789, 14, 03, 2003, 'p4', 'c4', 's4');
INSERT INTO company VALUES ('sh5', 890890890890890890, 15, 05, 2005, 'p1', 'c5', 's5');
INSERT INTO company VALUES ('sh6', 345345345345345345, 16, 06, 2006, 'p5', 'c6', 's5');

INSERT INTO brand VALUES ('br1', 12, 02, 2012, 123123123123123123);
INSERT INTO brand VALUES ('br2', 13, 03, 2013, 678678678678678678);
INSERT INTO brand VALUES ('br3', 13, 03, 2013, 456456456456456456);
INSERT INTO brand VALUES ('br4', 14, 04, 2014, 789789789789789789);
INSERT INTO brand VALUES ('br5', 15, 05, 2015, 789789789789789789);
INSERT INTO brand VALUES ('br6', 16, 06, 2016, 890890890890890890);
INSERT INTO brand VALUES ('br7', 17, 07, 2017, 345345345345345345);
INSERT INTO brand VALUES ('br8', 13, 03, 2013, 456456456456456456);

INSERT INTO product VALUES (111111111111, 10, 'a', 'br1');
INSERT INTO product VALUES (222222222222, 11, 'b', 'br2');
INSERT INTO product VALUES (333333333333, 12, 'c', 'br3');
INSERT INTO product VALUES (444444444444, 1, 'd', 'br4');
INSERT INTO product VALUES (555555555555, 2, 'e', 'br1');
INSERT INTO product VALUES (666666666666, 3, 'a', 'br5');
INSERT INTO product VALUES (777777777777, 11, 'c', 'br6');
INSERT INTO product VALUES (888888888888, 4, 'g', 'br1');
INSERT INTO product VALUES (999999999999, 5.6, 'r', 'br2');
INSERT INTO product VALUES (121212121212, 7, 'b', 'br7');
INSERT INTO product VALUES (232323232323, 8, 'l', 'br6');
INSERT INTO product VALUES (343434343434, 10, 'n', 'br8');

INSERT INTO type VALUES ('n1', 111111111111);
INSERT INTO type VALUES ('n2', 222222222222);
INSERT INTO type VALUES ('n3', 333333333333);
INSERT INTO type VALUES ('n4', 444444444444);
INSERT INTO type VALUES ('n5', 777777777777);
INSERT INTO type VALUES ('n6', 555555555555);
INSERT INTO type VALUES ('n7', 666666666666);
INSERT INTO type VALUES ('n8', 888888888888);
INSERT INTO type VALUES ('n9', 232323232323);
INSERT INTO type VALUES ('n10', 999999999999);

INSERT INTO supply VALUES (1, 'n1', 'br1');
INSERT INTO supply VALUES (2, 'n2', 'br2');
INSERT INTO supply VALUES (3, 'n3', 'br3');
INSERT INTO supply VALUES (4, 'n4', 'br1');
INSERT INTO supply VALUES (5, 'n5', 'br5');
INSERT INTO supply VALUES (6, 'n6', 'br4');
INSERT INTO supply VALUES (7, 'n7', 'br6');
INSERT INTO supply VALUES (8, 'n8', 'br7');
INSERT INTO supply VALUES (9, 'n9', 'br6');
INSERT INTO supply VALUES (10, 'n10', 'br8');

INSERT INTO distributor VALUES ('u1', 'e1', 'p1', 'c1', 's1', 12);
INSERT INTO distributor VALUES ('u2', 'e2', 'p2', 'c2', 's2', 44);
INSERT INTO distributor VALUES ('u3', 'e3', 'p1', 'c3', 's3', 100);
INSERT INTO distributor VALUES ('u4', 'e4', 'p3', 'c4', 's4', 50);

INSERT INTO distribution VALUES (1, 111111111111, 'u1', 12, 1);
INSERT INTO distribution VALUES (2, 222222222222, 'u1', 10, 2);
INSERT INTO distribution VALUES (3, 111111111111, 'u2', 5, 2);
INSERT INTO distribution VALUES (4, 777777777777, 'u3', 8, 5);
INSERT INTO distribution VALUES (5, 666666666666, 'u4', 10, 3);

INSERT INTO sell VALUES (1, 'u1', 123123123123123123);
INSERT INTO sell VALUES (2, 'u1', 678678678678678678);
INSERT INTO sell VALUES (3, 'u2', 456456456456456456);
INSERT INTO sell VALUES (4, 'u1', 456456456456456456);
INSERT INTO sell VALUES (5, 'u3', 890890890890890890);
INSERT INTO sell VALUES (6, 'u4', 345345345345345345);
INSERT INTO sell VALUES (7, 'u2', 789789789789789789);

INSERT INTO customer VALUES (10000000000, 'aa', 'ls1', 01, 'p1', 'c1', 's1');
INSERT INTO customer VALUES (20000000000, 'bb', 'ls2', 02, 'p2', 'c2', 's2');
INSERT INTO customer VALUES (30000000000, 'cc', 'ls3', 03, 'p3', 'c3', 's3');
INSERT INTO customer VALUES (40000000000, 'aa', 'ls4', 04, 'p1', 'c4', 's4');
INSERT INTO customer VALUES (50000000000, 'dd', 'ls5', 05, 'p4', 'c5', 's5');

INSERT INTO purchased VALUES (1, 'u1', 10000000000);
INSERT INTO purchased VALUES (2, 'u1', 30000000000);
INSERT INTO purchased VALUES (3, 'u2', 10000000000);
INSERT INTO purchased VALUES (4, 'u3', 40000000000);
INSERT INTO purchased VALUES (5, 'u4', 30000000000);
INSERT INTO purchased VALUES (6, 'u4', 20000000000);

INSERT INTO ordered VALUES (1, 01, 01, 2020, 10000000000);
INSERT INTO ordered VALUES (2, 02, 02, 2021, 30000000000);
INSERT INTO ordered VALUES (3, 01, 01, 2020, 20000000000);

INSERT INTO preparing VALUES (1, 'u1');
INSERT INTO preparing VALUES (2, 'u4');
INSERT INTO preparing VALUES (3, 'u3');

INSERT INTO order_product VALUES (1, 1, 111111111111);
INSERT INTO order_product VALUES (2, 1, 222222222222);
INSERT INTO order_product VALUES (3, 2, 333333333333);
INSERT INTO order_product VALUES (4, 3, 111111111111);
INSERT INTO order_product VALUES (5, 3, 444444444444);