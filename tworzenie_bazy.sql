USE team10;

DROP TABLE IF EXISTS finance;
DROP VIEW IF EXISTS finance_view;

CREATE TABLE finance (
    offer_id int(11) AUTO_INCREMENT PRIMARY KEY,
    balance int 
);

INSERT INTO finance (offer_id)
SELECT offer_id FROM offers;

CREATE VIEW finance_view 
as SELECT 
    finance.offer_id,
    balance = COALESCE(offers.overall_price, 1) - COALESCE(offers.original_price, 1)
FROM finance
  join offers on offers.offer_id = finance.offer_id 
  join orders on orders.offer_id = finance.offer_id;




SELECT 
    offers.offer_id,
    orders.overall_price AS income,
    offers.overall_price AS outcome
FROM offers
JOIN orders ON orders.offer_id = offers.offer_id;


CREATE VIEW finance_view 
as SELECT 
    finance.offer_id,
    balance = orders.overall_price - offers.overall_price
FROM finance
  join offers on offers.offer_id = finance.offer_id 
  join orders on orders.offer_id = finance.offer_id;

DESCRIBE offers;
DESCRIBE orders;

SELECT * FROM finance_view;


INSERT INTO finance (offer_id, balance)
SELECT offers.offer_id,offers.overall_price - orders.overall_price
FROM offers, orders;




INSERT INTO finance (offer_id)
SELECT offers.offer_id
FROM offers

--zależność kolumy od innych kolumn
UPDATE finance
SET balance = income - outcome;