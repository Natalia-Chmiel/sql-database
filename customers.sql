import mysql.connector
import random
from datetime import datetime, timedelta

# Połączenie z bazą danych
con = mysql.connector.connect(
    host="giniewicz.it",
    user="team10",
    password="te@mzaio",
    database="team10"
)

mycursor = con.cursor()

def generate_customers(n):
    # Przykładowe dane imion, nazwisk, emaili i adresów
    first_names = ["Jan", "Anna", "Piotr", "Maria", "Krzysztof", "Agnieszka", "Michał", "Katarzyna", "Jakub", "Monika"]
    last_names = ["Kowalski", "Nowak", "Wiśniewski", "Wójcik", "Dąbrowski", "Lewandowski", "Zieliński", "Szymański", "Kamiński", "Jankowski"]
    domains = ["example.com", "testmail.com", "company.pl", "email.pl"]

    # Generowanie danych klientów
    for _ in range(n):
        first_name = random.choice(first_names)
        last_name = random.choice(last_names)
        email = f"{first_name.lower()}.{last_name.lower()}@{random.choice(domains)}"
        address = f"{random.randint(1, 100)} {random.choice(['ul. Pięciomorgowa', 'ul. Słowiańska', 'ul. Wodna', 'ul. Złota'])}, {random.choice(['Warszawa', 'Kraków', 'Gdańsk', 'Wrocław'])}"
        
        # Wstawianie danych do tabeli customers
        mycursor.execute('''
            INSERT INTO customers (first_name, last_name, email, address)
            VALUES (%s, %s, %s, %s)
        ''', (first_name, last_name, email, address))

    # Potwierdzenie zmian
    con.commit()

# Generowanie 1000 klientów
generate_customers(1000)

# Zamykanie połączenia
mycursor.close()
con.close()