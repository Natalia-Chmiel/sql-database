import mysql.connector
import random

def load_addresses(file_name):
    """
    Ładuje listę adresów z pliku tekstowego.
    """
    with open(file_name, 'r', encoding='utf-8') as file:
        return [line.strip() for line in file.readlines()]

def fill_address_table(n):
    # Połączenie z bazą danych
    conn = mysql.connector.connect(
        user='team10',
        password="te@mzaio",
        host="giniewicz.it",
        database="team10",
        auth_plugin="mysql_native_password"
    )
    cursor = conn.cursor()

    # Ładowanie adresów z plików
    addresses_polska = load_addresses("UlicaP.txt")  # Polska (city_id: 1, 2)
    addresses_anglia = load_addresses("UlicaA.txt")  # Anglia (city_id: 3, 4)
    addresses_hiszpania = load_addresses("UlicaH.txt")  # Hiszpania (city_id: 5, 6)
    addresses_wlochy = load_addresses("UlicaW.txt")  # Włochy (city_id: 7, 8)
    addresses_niemcy = load_addresses("UlicaN.txt")  # Niemcy (city_id: 9, 10)
    addresses_grecja = load_addresses("UlicaG.txt")  # Grecja (city_id: 11, 12)

    # Mapowanie city_id na listy adresów
    addresses_by_city = {
        1: addresses_polska, 2: addresses_polska,
        3: addresses_anglia, 4: addresses_anglia,
        5: addresses_hiszpania, 6: addresses_hiszpania,
        7: addresses_wlochy, 8: addresses_wlochy,
        9: addresses_niemcy, 10: addresses_niemcy,
        11: addresses_grecja, 12: addresses_grecja,
    }

    generated_count = 0

    while generated_count < n:
        # Losuj city_id
        city_id = random.randint(1, 12)
        
        # Pobierz listę adresów dla wybranego city_id
        address_list = addresses_by_city.get(city_id, [])
        if not address_list:
            # Jeśli lista adresów dla miasta jest pusta, załaduj ponownie
            file_name_map = {
                (1, 2): "UlicaP.txt",
                (3, 4): "UlicaA.txt",
                (5, 6): "UlicaH.txt",
                (7, 8): "UlicaW.txt",
                (9, 10): "UlicaN.txt",
                (11, 12): "UlicaG.txt",
            }
            for ids, file_name in file_name_map.items():
                if city_id in ids:
                    address_list.extend(load_addresses(file_name))
                    break

        # Pobierz pierwszy dostępny adres z listy
        address = address_list.pop(0)

        # Generuj kod pocztowy i numer telefonu
        postal_code = f"{random.randint(10, 99)}-{random.randint(100, 999)}"
        phone_number = f"+{random.randint(1, 99)} {random.randint(100, 999)}-{random.randint(1000, 9999)}"

        # Wstaw dane do tabeli address
        cursor.execute("""
            INSERT INTO address (city_id, address, postal_code, phone)
            VALUES (%s, %s, %s, %s)
        """, (city_id, address, postal_code, phone_number))

        generated_count += 1

    conn.commit()
    print(f"Wstawiono {n} rekordów do tabeli address.")

    cursor.close()
    conn.close()

# Wywołanie funkcji dla 100 adresów
fill_address_table(291)