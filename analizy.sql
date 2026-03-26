--hania dzika
--Ktory pracownik najlepiej zarobił dla firmy, a który najgorzej
SELECT 
    staff_id, 
    SUM(finance.balance) AS 'zysk firmy od jednego pracownika'
FROM 
    orders
JOIN 
    finance ON orders.offer_id = finance.offer_id
GROUP BY 
    staff_id
ORDER BY 
    SUM(finance.balance) DESC
LIMIT 1;

-- Znajdź klienta, który wydał w firmie najwięcej. Wypisz 10 najbardziej zasłużonych klientów, aby przydzielić im rabat 5%.
SELECT customer_id, SUM(overall_price) AS 'ile wydał klient'
    FROM orders 
    JOIN offers ON orders.offer_id = offers.offer_id
    GROUP BY customer_id
    ORDER BY SUM(overall_price) DESC
    LIMIT 10;

--julka
--Znajdź najpopularniejsze rodzaje wycieczek, porównaj 
--koszta i zyski, czy są opłacalne?
WITH 
PopTrips AS (SELECT offers.offer_id, COUNT(orders.order_id) AS number_of_orders,
SUM(offers.overall_price) AS total FROM orders 
JOIN offers ON offers.offer_id = orders.offer_id GROUP BY orders.offer_id),

OfferCosts AS (SELECT offer_id, 
    plane_price + attractions_price + hotel_price 
    AS total_cost FROM offers),

Profit AS (SELECT PopTrips.offer_id, PopTrips.number_of_orders,
    PopTrips.total, OfferCosts.total_cost,
    (PopTrips.total - OfferCosts.total_cost) AS profit
    FROM PopTrips JOIN OfferCosts ON PopTrips.offer_id = OfferCosts.offer_id)

SELECT 
    Profit.offer_id,
    Profit.number_of_orders,
    Profit.total,
    Profit.total_cost,
    Profit.profit,
    CASE 
        WHEN Profit.profit > 0 THEN 'Profitable'
        ELSE 'Not Profitable'
    END AS profitability
FROM Profit ORDER BY Profit.number_of_orders DESC;
--Która sieć hoteli ma najwiekszy zysk, a która najmniejszy. 
--Z którym hotelem firma powinna rozwiązać kontrakt.
WITH 
HotelProfits AS (
    SELECT 
        offers.hotel_name, 
        COUNT(orders.order_id) AS total_orders,
        SUM(offers.overall_price) AS total_revenue,
        SUM(offers.plane_price + offers.attractions_price + offers.hotel_price) AS total_cost,
        (SUM(offers.overall_price) - SUM(offers.plane_price + offers.attractions_price + offers.hotel_price)) AS profit
    FROM orders
    JOIN offers ON orders.offer_id = offers.offer_id
    GROUP BY offers.hotel_name
),

RankedProfits AS (
    SELECT 
        hotel_name, 
        total_orders,
        total_revenue, 
        total_cost,
        profit, 
        RANK() OVER (ORDER BY profit DESC) AS profit_rank_desc,
        RANK() OVER (ORDER BY profit ASC) AS profit_rank_asc
    FROM HotelProfits
)

SELECT 
    hp.hotel_name AS hotel_with_highest_profit,
    hp.profit AS highest_profit,
    lp.hotel_name AS hotel_with_lowest_profit,
    lp.profit AS lowest_profit,
    lp.hotel_name AS hotel_to_terminate
FROM (SELECT * FROM RankedProfits WHERE profit_rank_desc = 1) hp
JOIN (SELECT * FROM RankedProfits WHERE profit_rank_asc = 1) lp;