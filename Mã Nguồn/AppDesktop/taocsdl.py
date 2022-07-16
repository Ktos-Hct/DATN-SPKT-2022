import sqlite3
from sqlite3.dbapi2 import connect
conn =sqlite3.connect('Dulieu.db')
c=conn.cursor()
c.execute("""CREATE TABLE node (
                ID integer,
                Name text,
                Node text,
                Lat float,
                Lon float,
                NgayLapDat text
                )""")
c.execute("INSERT INTO Node VALUES (1,'Quan 11','TramPhat1',10.762622,106.660172,'9/4/2022')")
c.execute("INSERT INTO Node VALUES (2,'Thu Duc','TramPhat2',10.826561,106.760897,'9/4/2022')")
c.execute("INSERT INTO Node VALUES (3,'Quan 1','TramPhat3',10.776111,106.695833,'9/4/2022')")
c.execute("INSERT INTO Node VALUES (4,'Quan 2','TramPhat4',10.778556,106.757523,'9/4/2022')")
c.execute("INSERT INTO Node VALUES (5,'Quan 9','TramPhat5',10.839978,106.770706,'9/4/2022')")
conn.commit()
conn.close()