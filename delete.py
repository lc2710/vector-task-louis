#!/usr/bin/python3

def delete(args, conn):
    cur = conn.cursor()
    cur.execute(f'delete from {args["table"]} where id = \'{args["id"]}\';')
    conn.commit()
    print(f'Deleted item with id: + {args["id"]} + from table: {args["table"]}')

