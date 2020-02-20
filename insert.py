#!/usr/bin/python3

def insert(args, conn):
    cur = conn.cursor()
    if args["table"] == 'continents':
        cur.execute(f'insert into {args["table"]} (name, population, area) values (\'{args["name"]}\', {args["population"]}, {args["area"]});')
        print(f'insert into {args["table"]} (name, population, area, hospital_count, national_park_count, river_count, school_count, \
                        continent_id) values (\'{args["name"]}\', {args["population"]}, {args["area"]}, {args["hospital_count"]}, {args["national_park_count"]}, {args["river_count"]}, \
                        {args["school_count"]}, \'{continent_id}\');')
        
    elif args["table"] == 'countries':
        cur.execute(f'select id from continents where name = \'{args["continent"]}\'')
        continent_id = cur.fetchone()[0]
        cur.execute(f'insert into {args["table"]} (name, population, area, hospital_count, national_park_count, river_count, school_count, \
                        continent_id) values (\'{args["name"]}\', {args["population"]}, {args["area"]}, {args["hospital_count"]}, {args["national_park_count"]}, {args["river_count"]}, \
                        {args["school_count"]}, \'{continent_id}\');')
        print(f'insert into {args["table"]} (name, population, area, hospital_count, national_park_count, river_count, school_count, \
                        continent_id) values (\'{args["name"]}\', {args["population"]}, {args["area"]}, {args["hospital_count"]}, {args["national_park_count"]}, {args["river_count"]}, \
                        {args["school_count"]}, \'{continent_id}\');')

    elif args["table"] == 'cities':
        cur.execute(f'select id from countries where name = \'{args["country"]}\'')
        country_id = cur.fetchone()[0]
        cur.execute(f'insert into {args["table"]} (name, population, area, road_count, tree_count, shop_count, school_count, \
                        country_id) values (\'{args["name"]}\', {args["population"]}, {args["area"]}, {args["road_count"]}, {args["tree_count"]}, {args["shop_count"]}, \
                        {args["school_count"]}, \'{country_id}\');')
        print(f'insert into {args["table"]} (name, population, area, road_count, tree_count, shop_count, school_count, \
                        country_id) values (\'{args["name"]}\', {args["population"]}, {args["area"]}, {args["road_count"]}, {args["tree_count"]}, {args["shop_count"]}, \
                        {args["school_count"]}, \'{country_id}\');')

    conn.commit()







        
