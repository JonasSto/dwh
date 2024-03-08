import os
import psycopg2
import paho.mqtt.client as mqtt
import time
import json

# Lese das Passwort aus der Umgebungsvariable
mqtt_connection = False
db_password = os.environ.get('PG_PASSWORD')

print(db_password)

# Verbinde dich mit der Datenbank
try:
    conn = psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password=db_password,
        host="localhost",
        port="15432"
    )
    print("Verbindung zur Datenbank hergestellt!")
    # Führe hier deine Datenbankoperationen durch
except psycopg2.OperationalError as e:
    print(f"Fehler beim Verbinden mit der Datenbank: {e}")

# def on_connect(client, userdata, flags, rc):
#     if rc == 0:
#         print("Connected to MQTT Broker")
#         mqtt_connection = True
#     else:
#         print("Connection failed")

def on_message(client, userdata, message):
    # <JSON Message in DB-Tabelle staging.messung schreiben>
    print(message.payload)
    try:
        resp = json.loads(message.payload)
    except:
        print('failed to parse message')

    cur = conn.cursor()
    cur.execute('INSERT INTO staging.messung(payload) VALUES (%s)', (json.dumps(resp),))
    conn.commit()
    cur.close()

mqttc = mqtt.Client(
    mqtt.CallbackAPIVersion.VERSION2, 
    "Z2l0QGdpdGh1Yi5jb206Sm9uYXNTdG8vZHdoLmdpdA==", 
    clean_session=False
)

# mqttc.on_connect = on_connect
mqttc.on_message = on_message
mqttc.connect("broker.hivemq.com", 1883, 60)

mqttc.loop_start()

mqttc.subscribe("DataMgmt", qos=1)

while True:
    try:
        time.sleep(5)
    except KeyboardInterrupt:
        print("exiting")
        mqttc.disconnect()
        mqttc.loop_stop()
        exit(0)
