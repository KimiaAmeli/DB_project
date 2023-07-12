create DATABASE shop7_2;
use shop7_2;

#7

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
    is_sold BOOLEAN DEFAULT 0,
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

INSERT INTO product VALUES (111111111111, 20, 'p1', 'b1',0);
INSERT INTO product VALUES (222222222222, 30, 'p2', 'b1',0);
INSERT INTO product VALUES (333333333333, 30, 'p3', 'b1',0);

INSERT INTO customer VALUES (500000000000,'fc5','lc5' , 19132876541, 'p5','c5','s5');
INSERT INTO customer VALUES (400000000000,'fc4','lc4' , 19980876541, 'p4','c2','s4');

INSERT INTO ordered VALUES (1,09,02 , 2023, 500000000000);
INSERT INTO order_product VALUES (1,1, 111111111111);

UPDATE product
SET is_sold = 1
WHERE product.barcode IN (SELECT barcode
                          FROM order_product);


create view product_update as
    select *
    from product;

INSERT INTO distributor VALUES ('d1', 'e1', 'pr1', 'ci1','st1',23);
INSERT INTO distribution VALUES (1, 111111111111, 'd1', 10, 3);
INSERT INTO distribution VALUES (2, 222222222222, 'd1', 14, 4);




START TRANSACTION;

SAVEPOINT before_order;

SELECT *
FROM product  natural join order_product
WHERE  order_product.barcode = product.barcode AND is_sold = 0 FOR UPDATE;


IF is_sold = 1 THEN
    ROLLBACK TO SAVEPOINT before_order;
END IF;


INSERT INTO ordered (orderId, orderDay, orderMonth, orderYear, nationalId)
VALUES (2,2,5,2023,400000000000);
INSERT INTO order_product VALUES (2,2,222222222222 );


UPDATE product
SET is_sold = 1
WHERE barcode = 222222222222;

UPDATE distribution
SET amount = amount - 1
WHERE barcode = 222222222222 AND distName = 'd1';

COMMIT;


create view after_transaction_update as
    select *
    from product;

create view final_amount as
    select distribution.barcode,distribution.amount
    FROM distribution;
