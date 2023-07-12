create DATABASE shop5_3;
use shop5_3;

# bakhsh 5

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


INSERT INTO type VALUES ('n1', 111111111111);
INSERT INTO type VALUES ('n2', 111111111111);
INSERT INTO type VALUES ('n3', 111111111111);
INSERT INTO type VALUES ('n1', 222222222222);
INSERT INTO type VALUES ('n2', 222222222222);
INSERT INTO type VALUES ('n5', 222222222222);
INSERT INTO type VALUES ('n1', 333333333333);
INSERT INTO type VALUES ('n3', 333333333333);
INSERT INTO type VALUES ('n4', 333333333333);
INSERT INTO type VALUES ('milk', 111111111111);
INSERT INTO type VALUES ('milk', 222222222222);
INSERT INTO type VALUES ('milk', 333333333333);

INSERT INTO customer VALUES (100000000000,'fc1','lc1' , 19197646541, 'p1','c1','s1');
INSERT INTO customer VALUES (200000000000,'fc2','lc2' , 19197646971, 'p2','c2','s2');
INSERT INTO customer VALUES (300000000000,'fc3','lc3' , 19197641231, 'p3','c3','s3');


INSERT INTO ordered VALUES (1,05,08 , 2023, 100000000000);
INSERT INTO ordered VALUES (2,04,05 , 2021, 200000000000);
INSERT INTO ordered VALUES (3,01,07 , 2023, 300000000000);

INSERT INTO order_product VALUES (1,1, 111111111111);
INSERT INTO order_product VALUES (2,2, 222222222222);
INSERT INTO order_product VALUES (3,3, 333333333333);


#5

SELECT type.typename, COUNT(*) AS total_sales
FROM product
JOIN type ON product.barcode = type.barcode
JOIN order_product ON product.barcode = order_product.barcode
JOIN ordered ON order_product.orderid = ordered.orderid
WHERE type.typename != 'milk'
GROUP BY type.typename
ORDER BY total_sales DESC
LIMIT 3;