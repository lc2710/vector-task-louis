#!/usr/bin/python3

from kafka import KafkaConsumer
import json
import psycopg2
from insert import insert
from update import update
from delete import delete

database = 'vectordb'
user = 'louis'

try:
    conn = psycopg2.connect(database='vectordb', user='louis')
    consumer = KafkaConsumer('myjson1',
        bootstrap_servers='localhost:9092',
        value_deserializer=lambda m: json.loads(m.decode('utf-8'))
                             )

    for message in consumer:
        
        if message.value["action"] == "insert":
            insert(message.value, conn)

        elif message.value["action"] == "update":
            update(message.value, conn)

        elif message.value["action"] == "delete":
            delete(message.value, conn)

except Exception as e:
    print(e)
    conn.close()
    
