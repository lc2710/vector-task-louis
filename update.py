#!/usr/bin/python3

def update(args, conn):

    cur = conn.cursor()
    for arg in args:
        if arg not in ["table", "action", "id"] and args[arg] != None:
            if type(args[arg]) == str:
                cur.execute(f'update {args["table"]} set {arg} = \'{args[arg]}\' where id = \'{args["id"]}\';')
                print(f'updated table: {args["table"]} set: {arg} = \'{args[arg]}\' where id = \'{args["id"]}\';')

            elif type(args[arg]) == int:
                cur.execute(f'update {args["table"]} set {arg} = {args[arg]} where id = \'{args["id"]}\';')
                print(f'updated table: {args["table"]} set: {arg} = \'{args[arg]}\' where id = \'{args["id"]}\';')

    conn.commit()
