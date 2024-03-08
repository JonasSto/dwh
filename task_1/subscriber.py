import os
import psycopg2
import paho.mqtt.client as mqtt
import time
import json

# read password from environment variables
mqtt_connection = False
db_password = os.environ.get('PG_PASSWORD')

print(db_password)

# connect to database
try:
    conn = psycopg2.connect(
        dbname="postgres",
        user="postgres",
        password=db_password,
        host="localhost",
        port="15432"
    )
    print("Verbindung zur Datenbank hergestellt!")
except psycopg2.OperationalError as e:
    print(f"Fehler beim Verbinden mit der Datenbank: {e}")

def on_message(client, userdata, message):
    # read message from broker and insert into table
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
