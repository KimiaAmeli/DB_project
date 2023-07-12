create DATABASE shop5_5;
use shop5_5;

# bakhsh 4

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



INSERT INTO company VALUES ('c1', 180000000000000000, 02, 03, 2000, 'p1','c1','s1');
INSERT INTO brand VALUES ('b1', 01, 02, 2001, 180000000000000000);

INSERT INTO product VALUES (111111111111, 20, 'golMohammadY', 'b1');
INSERT INTO product VALUES (222222222222, 30, 'crossan', 'b1');

INSERT INTO type VALUES ('cake', 111111111111);
INSERT INTO type VALUES ('cake', 222222222222);



INSERT INTO customer VALUES (100000000000,'fc1','lc1' , 19191876541, 'p1','c1','s1');
INSERT INTO customer VALUES (200000000000,'fc2','lc2' , 19197646541, 'p2','c2','s2');
INSERT INTO customer VALUES (300000000000,'fc3','lc3' , 19194536541, 'p3','c3','s3');


INSERT INTO ordered VALUES (1,01,02 , 2000, 100000000000);
INSERT INTO ordered VALUES (2,07,01 , 2020, 200000000000);
INSERT INTO ordered VALUES (3,04,06 , 2010, 300000000000);



INSERT INTO order_product VALUES (1,1, 111111111111);
INSERT INTO order_product VALUES (2,2, 222222222222);
INSERT INTO order_product VALUES (3,2, 111111111111);
INSERT INTO order_product VALUES (4,3, 111111111111);
INSERT INTO order_product VALUES (5,3, 222222222222);


INSERT INTO distributor VALUES ('d1', 'e1', 'pr1', 'ci1','st1',23);
INSERT INTO distributor VALUES ('d2', 'e2', 'pr2', 'ci2','st2',31);
INSERT INTO distributor VALUES ('d3', 'e3', 'pr3', 'ci3','st3',34);


INSERT INTO preparing VALUES (1,1,'d3');
INSERT INTO preparing VALUES (2,1,'d1');
INSERT INTO preparing VALUES (3,2,'d1');
INSERT INTO preparing VALUES (4,2,'d2');
INSERT INTO preparing VALUES (5,3,'d3');

#4


SELECT count(distinct preparing.distName),preparing.distName
FROM preparing
JOIN order_product ON preparing.orderId = order_product.orderId
JOIN product ON order_product.barcode = product.barcode
JOIN type ON product.barcode = type.barcode
WHERE type.typename = 'cake'
GROUP BY preparing.distName
HAVING SUM(product.name = 'golMohammadY') > SUM(product.name = 'crossan')
