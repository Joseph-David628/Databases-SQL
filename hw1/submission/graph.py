#!/usr/bin/python
import psycopg2
import numpy as np
import plotly.express as px
from math import log

def main():
	try:
	    conn = psycopg2.connect("dbname='dblp' user='joseph' host='localhost' password=''")
	except psycopg2.Error.e:
	    print("I am unable to connect to the database")

	cur = conn.cursor()

	cur.execute("select count(distinct y.authorid) from Authored x, Authored y where x.pubid = y.pubid and x.authorid != y.authorid group by x.authorid;")

	rows = cur.fetchall()

	fig = px.histogram(rows, log_y = True)
	fig.show()
	
	cur.execute("select count(*) from Authored group by authorid;")

	rows2 = cur.fetchall()
	fig2 = px.histogram(rows2, log_y = True)
	fig2.show()

	conn.close()
	cur.close()

if __name__ == "__main__":
	main()


