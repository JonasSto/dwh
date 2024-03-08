import os
import psycopg2

# Lese das Passwort aus der Umgebungsvariable
db_password = os.environ.get('PG_PASSWORD')

print(db_password)

# Verbinde dich mit der Datenbank
try:
    conn = psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password=db_password,
        host="localhost",
        port="5432"
    )
    print("Verbindung zur Datenbank hergestellt!")
    # Führe hier deine Datenbankoperationen durch
except psycopg2.OperationalError as e:
    print(f"Fehler beim Verbinden mit der Datenbank: {e}")
