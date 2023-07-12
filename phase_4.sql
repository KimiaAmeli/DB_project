create DATABASE shop4;
use shop4;

#4

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


INSERT INTO customer
VALUES (123456781011, 'Harry', 'Kane', 44796268462, 'London', 'London', '212 Baker Street');


INSERT INTO ordered
VALUES (1, 01, 02, 2023, 123456781011);

INSERT INTO company
VALUES ('s1', 123456789101112131, 21, 03, 2003, 'p1', 'c3', 's2');

INSERT INTO brand
VALUES ('b1', 10, 03, 2013, 123456789101112131);

INSERT INTO product
VALUES (211111111111, 20, 'f', 'b1');

INSERT INTO order_product
VALUES (1, 1, 211111111111);


UPDATE customer
SET phone = 447342780080 WHERE nationalId = 123456781011;


INSERT INTO customer
VALUES (243512436518, 'Amir', 'Armany', 44356512411, 'tehran', 'tehran', 'Street1');

INSERT INTO customer
VALUES (768765465745, 'Maryam', 'Amiry', 22135434251, 'tehran', 'tehran', 'street2');

INSERT INTO customer
VALUES (961232323241, 'Iman', 'Morady', 22316578901, 'shiraz', 'shiraz', 'street5');



INSERT INTO ordered
VALUES (2, 02 , 01 , 2001, 243512436518 );

INSERT INTO ordered
VALUES (3, 01 , 05 , 2003, 768765465745 );



delete from customer
where not exists(select *
                 from ordered
                 where ordered.nationalId = customer.nationalId);