import mysql.connector

con = mysql.connector.connect(
    host = "giniewicz.it",
    user = "team10",
    password = "te@mzaio",
    database = "team10"
)

if(con):
    print("Połączenie udane")
else:
    print("Połączenie nieudane")

con.close()