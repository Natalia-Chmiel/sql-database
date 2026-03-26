DROP TABLE IF EXISTS finance;
DROP TABLE IF EXISTS salary;
DROP TABLE IF EXISTS customers;
DROP TABLE IF EXISTS staff;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS offers;
DROP TABLE IF EXISTS address;
DROP TABLE IF EXISTS city;
DROP TABLE IF EXISTS country;


CREATE TABLE customers (
    customer_id int,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    address_id int,
    order_id int,
    active TINYINT
)

CREATE TABLE staff (
    staff_id int,
    first_name varchar(255),
    last_name varchar(255),
    email varchar(255),
    address_id int,
    order_id int,
)

CREATE TABLE orders (
    order_id int,
    trip_id int,
    order_time TIMESTAMP
)

CREATE TABLE addresses (
    address_id int,
    address varchar(255),
    city_id int,
    country_id int,
    postal_code varchar(15),
    phone varchar(15),
    phone_relative varchar(15) -- telefon do osoby bliskiej
)

CREATE TABLE city (
    city_id int,
    city varchar(255)
)

CREATE TABLE country (
    country_id int,
    country varchar(15)
)

CREATE TABLE trips (
    order_id int,
    trip_id int,
    city_id int,
    country_id int,
    trip_type varchar(255), -- gory, morze, wspinaczka, zwiedzanie
    is_dangerous int,
    start_trip TIMESTAMP,
    end_trip TIMESTRAMP,
    duration DAYS, -- nie wiem czy bedzie dzialac
    price int
)

CREATE TABLE finance (
    order_id int,
    price int
    flight_price int,
    accomodation_price int,
    museum_price int,
    staff_payout int,
    data_transakcji
    balance int --balans po jednej wycieczce

)

CREATE TABLE salary (
    staff_id int AUTO_INCREMENT PRIMARY KEY,
    salary int
)




