create DATABASE shop6;
use shop6;

# 6

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



INSERT INTO distributor VALUES ('d1', 'e1', 'pr1', 'ci1','st1',23);
INSERT INTO distributor VALUES ('d2', 'e2', 'pr2', 'ci2','st2',31);
INSERT INTO distributor VALUES ('d3', 'e3', 'pr3', 'ci3','st3',21);


INSERT INTO company VALUES ('c1', 180000000000000000, 02, 03, 2000, 'p1','c1','s1');
INSERT INTO brand VALUES ('b1', 01, 02, 2001, 180000000000000000);

INSERT INTO product VALUES (111111111111, 20, 'p1', 'b1');
INSERT INTO product VALUES (222222222222, 30, 'p2', 'b1');
INSERT INTO product VALUES (333333333333, 30, 'p3', 'b1');


INSERT INTO distribution VALUES (1, 111111111111, 'd1', 10, 3);
INSERT INTO distribution VALUES (2, 222222222222, 'd2', 14, 4);
INSERT INTO distribution VALUES (3, 333333333333, 'd1', 16, 3);
INSERT INTO distribution VALUES (4, 111111111111, 'd3', 18, 5);

create view distributor_distributes as
    SELECT distributor.distName,distributor.email,distributor.province,distributor.city,distributor.street,distributor.hourOfWork,
           product.barcode,product.weight,product.name,product.brandName
    FROM distributor
    JOIN distribution ON distributor.distName = distribution.distName
    JOIN product ON distribution.barcode = product.barcode;


INSERT INTO customer VALUES (100000000000,'fc1','lc1' , 19191876541, 'p1','c1','s1');
INSERT INTO customer VALUES (200000000000,'fc2','lc2' , 19197646541, 'p2','c2','s2');
INSERT INTO customer VALUES (300000000000,'fc3','lc3' , 19191236541, 'p3','c3','s3');

INSERT INTO ordered VALUES (1,01,02 , 2000, 200000000000);
INSERT INTO ordered VALUES (2,03,02 , 2002, 100000000000);
INSERT INTO ordered VALUES (3,07,06 , 2010, 300000000000);
INSERT INTO ordered VALUES (4,02,04 , 2013, 300000000000);


INSERT INTO order_product VALUES (1,1, 111111111111);
INSERT INTO order_product VALUES (2,2, 222222222222);
INSERT INTO order_product VALUES (3,3, 333333333333);
INSERT INTO order_product VALUES (4,4, 111111111111);

create view customer_orders as
    SELECT customer.nationalId, customer.custFerstName,customer.custLastname,customer.phone,customer.state,customer.city,customer.street,
          order_product.barcode,ordered.orderDay,ordered.orderMonth,ordered.orderYear
    FROM customer
    natural join (ordered natural join order_product);

INSERT INTO type VALUES ('A', 111111111111);
INSERT INTO type VALUES ('A+', 222222222222);
INSERT INTO type VALUES ('A++', 333333333333);


CREATE VIEW product_type_brand_company AS
SELECT p.barcode, p.weight, p.name AS product_name,
       b.brandname, b.daySettingUp, b.monthSettingUp, b.yearSettingUp,
       c.companyLicense, c.establishDay, c.establishMonth, c.establishYear,
       c.province, c.city, c.street,
       t.typename
FROM product p
JOIN brand b ON p.brandname = b.brandname
JOIN company c ON b.companylicense = c.companyLicense
JOIN type t ON t.barcode = p.barcode;



