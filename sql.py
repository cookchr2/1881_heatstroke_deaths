# -*- coding: utf-8 -*-
"""
Created on Tue Jul  9 12:50:59 2019

@author: tophe
"""

import sqlite3 as sql
import csv

with open(r'C:\Users\tophe\OneDrive\Documents\GitHub\1881_heatstroke_deaths\heatstroke_death1881.csv') as infile:
    rows = list(csv.reader(infile))

try:
    with sql.connect('heatstroke.db') as conn:
        cur = conn.cursor()
        cur.execute("DROP TABLE heatstroke")
        cur.execute("CREATE TABLE heatstroke (Date TEXT,Deaths INTEGER,max_temp REAL,min_temp REAL,mean_temp REAL,barometer REAL,humidity REAL,rainfall REAL,tot_deaths INTEGER,state_of_weather TEXT)")
        rows = rows[1:]
        cur.executemany("INSERT INTO heatstroke Values(?,?,?,?,?,?,?,?,?,?);", rows)
        for row in cur.execute("SELECT * FROM heatstroke;"):
            print(row)
finally:
    conn.close()
