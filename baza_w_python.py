import mysql.connector

con = mysql.connector.connect(
    host = "giniewicz.it",
    user = "team10",
    password = "te@mzaio",
    database = "team10"
)

cursor = con.cursor()

#finance
#cursor.execute("""
               #UPADTE finance f
               #JOIN Offers o ON f.offer_id = o.Offers_id
               #SET f.overall_price = o.overall_price
               #""")


#finance
mycursor = con.cursor()
mycursor.execute('''           
INSERT INTO finance (offer_id)
SELECT offer_id FROM offers;
               ''')

mucursor = con.cursor()
mycursor.execute('''
UPDATE finance f
JOIN offers o ON f.offer_id = o.offer_id
SET f.balance = o.overall_price - o.original_price;
                 ''')

#salary
mucursor = con.cursor()
mycursor.execute('''
INSERT INTO salary (staff_id)
SELECT staff_id FROM staff;
                 ''')

mucursor = con.cursor()
mycursor.execute('''
INSERT INTO salary (staff_id,salary)
VALUES 
        (NULL, 5000),
        (NULL, 7000),
        (NULL, 6500),         
        (NULL, 5500),
        (NULL, 7500), 
        (NULL, 5500)                 
                 ''')

#country
mycursor = con.cursor()

mycursor.execute('''INSERT INTO country (country_id, country) 
            VALUES 
(NULL, 'Polska'),
(NULL, 'Anglia'),
(NULL, 'Hiszpania'),
(NULL, 'Włochy'),
(NULL, 'Niemcy'),
(NULL, 'Grecja')''')

#city
mycursor = con.cursor()

mycursor.execute('''INSERT INTO city (city_id, city, country_id)
                 VALUES
(NULL, 'Warszawa', 1),
(NULL, 'Kraków', 1),
(NULL, 'Londyn', 2),
(NULL, 'Manchester', 2),
(NULL, 'Madryt', 3),
(NULL, 'Alicante', 3),
(NULL, 'Mediolan', 4),
(NULL, 'Wenecja', 4),
(NULL, 'Berlin', 5),
(NULL, 'Hamburg', 5),
(NULL, 'Ateny', 6),
(NULL, 'Sparta', 6);

''')

con.commit()
cursor.close()
con.close()
