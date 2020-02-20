#!/usr/bin/python3

from kafka import KafkaProducer
import argparse
import json

parser = argparse.ArgumentParser()
parser.add_argument("--action", "-ac", type=str)
parser.add_argument("--table", "-tab", type=str)
parser.add_argument("--name", "-n", type=str)
parser.add_argument("--id", "-id", type=str)
parser.add_argument("--population", "-p", type=int)
parser.add_argument("--area", "-ar", type=int)
parser.add_argument("--hospital_count", "-hc", type=int)
parser.add_argument("--national_park_count", "-nc", type=int)
parser.add_argument("--river_count", "-rc", type=int)
parser.add_argument("--school_count", "-sc", type=int)
parser.add_argument("--road_count", "-roc", type=int)
parser.add_argument("--tree_count", "-tc", type=int)
parser.add_argument("--shop_count", "-spc", type=int)
parser.add_argument("--continent", "-con", type=str)
parser.add_argument("--country", "-coun", type=str)

args = parser.parse_args()
argparse_dict = vars(args)

producer = KafkaProducer(value_serializer=lambda m: json.dumps(m).encode('utf-8'), bootstrap_servers='localhost:9092')
producer.send('myjson1', argparse_dict)
producer.flush()
producer.close()




