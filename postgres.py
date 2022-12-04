import psycopg2 as pg

conn = pg.connect(host="localhost", database="postgres", user="postgres", password="whatever")

get_query = """
    SELECT * FROM "user_id_1-500".photos
"""

cursor = conn.cursor()

# not optimised; for prototype; use bulk insert to optimise it
for i in range(100000):
    insert_query = f'INSERT INTO "user_id_1-500".photos (name) VALUES ({str(i)})'
    cursor.execute(insert_query)
    conn.commit()

cursor.execute(query=get_query)

res = cursor.fetchall()
print(res)
