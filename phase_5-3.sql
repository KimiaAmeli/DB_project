create DATABASE shop5_6;
use shop5_6;

# bakhsh 3

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
    id BIGINT(15),
   orderId BIGINT(15),
   distName varchar(150),
   primary key (id),
   UNIQUE (orderId,distName),
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


INSERT INTO customer VALUES (100000000000,'fc1','lc1' , 19191876541, 'p1','c1','s1');
INSERT INTO customer VALUES (200000000000,'fc2','lc2' , 19197646541, 'p2','c2','s2');
INSERT INTO customer VALUES (300000000000,'fc3','lc3' , 19191236541, 'p3','c3','s3');
INSERT INTO customer VALUES (400000000000,'fc4','lc4' , 19980876541, 'p4','c2','s4');

INSERT INTO company VALUES ('c1', 180000000000000000, 02, 03, 2000, 'p1','c1','s1');
INSERT INTO brand VALUES ('b1', 01, 02, 2001, 180000000000000000);


INSERT INTO product VALUES (111111111111, 20, 'p1', 'b1');
INSERT INTO product VALUES (222222222222, 30, 'p2', 'b1');
INSERT INTO product VALUES (333333333333, 30, 'p3', 'b1');
INSERT INTO product VALUES (444444444444, 24, 'p4', 'b1');
INSERT INTO product VALUES (555555555555, 23, 'p5', 'b1');
INSERT INTO product VALUES (666666666666, 22, 'p6', 'b1');

INSERT INTO ordered VALUES (1,04,01 , 2023, 100000000000);
INSERT INTO ordered VALUES (2,05,08 , 2023, 200000000000);
INSERT INTO ordered VALUES (3,02,07 , 2023, 300000000000);

INSERT INTO ordered VALUES (4,03,02 , 2002, 100000000000);
INSERT INTO ordered VALUES (5,07,06 , 2010, 400000000000);


INSERT INTO order_product VALUES (1,1, 111111111111);
INSERT INTO order_product VALUES (2,1, 222222222222);
INSERT INTO order_product VALUES (3,1, 333333333333);
INSERT INTO order_product VALUES (4,1, 444444444444);
INSERT INTO order_product VALUES (5,2, 333333333333);
INSERT INTO order_product VALUES (6,2, 222222222222);
INSERT INTO order_product VALUES (7,2, 444444444444);
INSERT INTO order_product VALUES (8,3, 555555555555);
INSERT INTO order_product VALUES (9,3, 333333333333);
INSERT INTO order_product VALUES (10,4, 555555555555);
INSERT INTO order_product VALUES (11,5, 555555555555);



INSERT INTO distributor VALUES ('d1', 'e1', 'pr1', 'ci1','st1',23);
INSERT INTO distributor VALUES ('d2', 'e2', 'pr2', 'ci2','st2',31);
INSERT INTO distributor VALUES ('d3', 'e3', 'pr3', 'ci3','st3',21);
INSERT INTO distributor VALUES ('d4', 'e4', 'pr4', 'ci4','st4',3);
INSERT INTO distributor VALUES ('d5', 'e5', 'pr5', 'ci5','st5',11);
INSERT INTO distributor VALUES ('d6', 'e6', 'pr6', 'ci6','st6',32);


INSERT INTO distribution VALUES (1, 111111111111, 'd1', 10, 3);
INSERT INTO distribution VALUES (2, 222222222222, 'd1', 15, 2);
INSERT INTO distribution VALUES (3, 222222222222, 'd2', 14, 4);
INSERT INTO distribution VALUES (4, 333333333333, 'd3', 16, 2);
INSERT INTO distribution VALUES (5, 444444444444, 'd4', 18, 5);
INSERT INTO distribution VALUES (6, 333333333333, 'd4', 13, 3);
INSERT INTO distribution VALUES (7, 555555555555, 'd5', 10, 6);
INSERT INTO distribution VALUES (8, 333333333333, 'd5', 15, 6);
INSERT INTO distribution VALUES (9, 555555555555, 'd6', 12, 1);

#3

SELECT distribution.distName, count(order_product.orderId) as total_amount
FROM ordered
JOIN order_product ON ordered.orderId = order_product.orderId AND ordered.orderYear = 2023
JOIN distribution ON order_product.barcode = distribution.barcode
GROUP BY distribution.distName
ORDER BY total_amount DESC
LIMIT 5;
