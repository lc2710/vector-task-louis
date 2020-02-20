# vector-task-louis

DB Setup
1) Install postgres

2) Instantiate database with:
createdb vectordb;
create user louis;
grant all privileges on all tables in schema public to louis;
psql -d vectordb -a -f db_init.sql


3) Inserting/updating/deleting:
run python3 insert.py/update.py/delete.py with args e.g. 
python3 insert.py -t continents -a 1000 -n Europe -p 100000000

4) Installing kafka
brew cask install java
brew cask install homebrew/cask-versions/adoptopenjdk8
brew cask install kafka
pip3 install kafka-python

5) Run Zookeepe, Kafka server and kafka consumer 
zkServer start
kafka-server-start /usr/local/etc/kafka/server.properties
python3 kafka-consumer.py

6) Send db commands using kafka producer:
python3 kafka-producer.py -args
e.g.
python3 kafka-producer.py -ac insert -tab continents -ar 1000 -n Asia -p 100000000
python3 kafka-producer.py -ac insert -tab countries -ar 1000 -n Thailand -p 100000000 -hc 10 -nc 20 -rc 4 -sc 90 -con Asia
python3 kafka-producer.py -ac insert -tab cities -ar 1000 -n Bangkok -p 100000000 -hc 10 -roc 20 -tc 4 -sc 90 -spc 10 -coun Thailand
python3 kafka-producer.py -ac update -tab cities -n Bangkokie -id 6aafbc0a-b529-46b3-b00d-383122faab0b
python3 kafka-producer.py -ac delete -tab cities -id 3db9c76e-3a60-48a3-a68f-674b5e341ff1







