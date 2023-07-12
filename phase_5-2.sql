create DATABASE shop5_10;
use shop5_10;

# bakhsh 2

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

INSERT INTO product VALUES (111111111111, 20, 'p1', 'b1');
INSERT INTO product VALUES (222222222222, 30, 'p2', 'b1');
INSERT INTO product VALUES (333333333333, 30, 'p3', 'b1');
INSERT INTO product VALUES (444444444444, 24, 'p4', 'b1');
INSERT INTO product VALUES (555555555555, 23, 'p1', 'b1');
INSERT INTO product VALUES (666666666666, 22, 'p5', 'b1');
INSERT INTO product VALUES (777777777777, 21, 'p6', 'b1');
INSERT INTO product VALUES (888888888888, 2, 'p7', 'b1');
INSERT INTO product VALUES (999999999999, 24, 'p4', 'b1');
INSERT INTO product VALUES (101010101010, 25, 'p3', 'b1');
INSERT INTO product VALUES (121212121212, 50, 'p9', 'b1');
INSERT INTO product VALUES (141414141414, 53, 'p10', 'b1');
INSERT INTO product VALUES (151515151515, 52, 'p12', 'b1');
INSERT INTO product VALUES (171717171717, 51, 'p13', 'b1');


INSERT INTO customer VALUES (100000000000,'fc1','lc1' , 19191876541, 'p1','c1','s1');
INSERT INTO customer VALUES (200000000000,'fc2','lc2' , 19197646541, 'p2','c2','s2');
INSERT INTO customer VALUES (300000000000,'fc3','lc3' , 19191236541, 'p3','c3','s3');
INSERT INTO customer VALUES (400000000000,'fc4','lc4' , 19980876541, 'p4','c2','s4');
INSERT INTO customer VALUES (500000000000,'fc5','lc5' , 19132876541, 'p5','c5','s5');

INSERT INTO ordered VALUES (1,01,02 , 2000, 200000000000);
INSERT INTO ordered VALUES (2,03,02 , 2002, 400000000000);
INSERT INTO ordered VALUES (3,07,06 , 2010, 500000000000);

INSERT INTO order_product VALUES (1,1, 111111111111);
INSERT INTO order_product VALUES (2,1, 222222222222);
INSERT INTO order_product VALUES (3,1, 333333333333);
INSERT INTO order_product VALUES (4,1, 444444444444);
INSERT INTO order_product VALUES (5,1, 555555555555);
INSERT INTO order_product VALUES (6,1, 777777777777);
INSERT INTO order_product VALUES (7,1, 121212121212);
INSERT INTO order_product VALUES (8,1, 151515151515);
INSERT INTO order_product VALUES (9,1, 666666666666);
INSERT INTO order_product VALUES (10,1, 888888888888);
INSERT INTO order_product VALUES (11,1, 171717171717 );
INSERT INTO order_product VALUES (12,1, 101010101010);

INSERT INTO order_product VALUES (13,2, 111111111111);
INSERT INTO order_product VALUES (14,2, 444444444444);
INSERT INTO order_product VALUES (15,2, 555555555555);
INSERT INTO order_product VALUES (16,2, 666666666666);
INSERT INTO order_product VALUES (17,2, 777777777777);
INSERT INTO order_product VALUES (18,2, 151515151515);
INSERT INTO order_product VALUES (19,2, 888888888888);
INSERT INTO order_product VALUES (20,2, 171717171717);
INSERT INTO order_product VALUES (21,2, 101010101010);
INSERT INTO order_product VALUES (22,2, 121212121212);

INSERT INTO order_product VALUES (23,3, 111111111111);
INSERT INTO order_product VALUES (24,3, 222222222222);
INSERT INTO order_product VALUES (25,3, 555555555555);
INSERT INTO order_product VALUES (26,3, 666666666666);
INSERT INTO order_product VALUES (28,3, 444444444444);
INSERT INTO order_product VALUES (29,3, 777777777777);
INSERT INTO order_product VALUES (31,3, 333333333333);
INSERT INTO order_product VALUES (32,3, 171717171717);
INSERT INTO order_product VALUES (33,3, 101010101010);
INSERT INTO order_product VALUES (34,3, 121212121212);
INSERT INTO order_product VALUES (35,3, 999999999999);
INSERT INTO order_product VALUES (36,3, 888888888888);


/* 2 */


SELECT customer.city, product.name, count(product.name) as total_amount
FROM ordered
JOIN order_product ON ordered.orderId = order_product.orderId
JOIN customer ON ordered.nationalId = customer.nationalId
JOIN product ON order_product.barcode = product.barcode
GROUP BY customer.city, product.name
HAVING (count(customer.city) < 10)
ORDER BY customer.city, total_amount DESC;



