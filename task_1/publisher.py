import json
import random
import time
import paho.mqtt.client as mqtt

mqttc = mqtt.Client(
    mqtt.CallbackAPIVersion.VERSION2,
    "aHR0cHM6Ly9naXRodWIuY29tL0pvbmFzU3RvL2R3aC5naXQ=",
    clean_session=False,
)

mqttc.connect("broker.hivemq.com", 1883, 60)


# send message every 5 seconds
while True:
    message = {
        "fin": "FFRZG4CB5CJQ2KQLU",
        "zeit": int(time.time()),
        "geschwindigkeit": random.randint(0, 50),
    }
    mqttc.publish("DataMgmt", json.dumps(message), qos=1)
    # sleep for 5 seconds
    time.sleep(5)
