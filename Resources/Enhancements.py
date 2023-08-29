# Fund Analysis Setup

# Press Shift+F10 to execute it or replace it with your code.
# Press Double Shift to search everywhere for classes, files, tool windows, actions, and settings.
# Use a breakpoint in the code line below to debug your script.
# Press Ctrl+F8 to toggle the breakpoint.
# See PyCharm help at https://www.jetbrains.com/help/pycharm/

# import python libraries
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
import matplotlib.style as style
import mysql.connector
color = sns.color_palette()
from pandas.plotting import table
from datetime import datetime

# Queries
Query1 = "SELECT fund_symbol, fund_long_name, ROUND((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21, 4) AS avg_yearly_return FROM returns r INNER JOIN general g ON r.fund_id = g.fund_id ORDER BY avg_yearly_return DESC LIMIT 10;"
Query2 = "SELECT fund_symbol, ROUND(AVG(volume), 0) average_volume FROM daily_performance dp INNER JOIN general g ON dp.fund_id = g.fund_id GROUP BY fund_symbol ORDER BY average_volume DESC LIMIT 10;"
Query3 = "SELECT fund_symbol, price_date, ROUND((close - open)/open, 4) AS daily_change FROM (SELECT daily_performance.*, MAX(ROUND((close - open)/open, 4)) OVER(PARTITION BY fund_id) as max_change from daily_performance) AS dp INNER JOIN general g ON dp.fund_id = g.fund_id WHERE ROUND((close - open)/open, 4) = max_change ORDER BY daily_change DESC LIMIT 10;"
Query4 = "SELECT fund_category, ROUND(AVG((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21), 4) AS category_avg_yearly_return FROM returns r INNER JOIN general g ON r.fund_id = g.fund_id INNER JOIN category c ON g.category_id = c.category_id GROUP BY fund_category ORDER BY category_avg_yearly_return DESC LIMIT 10;"

Query1NL = "SELECT fund_symbol, fund_long_name, ROUND((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21, 4) AS avg_yearly_return FROM returns r INNER JOIN general g ON r.fund_id = g.fund_id ORDER BY avg_yearly_return DESC;"
Query2NL = "SELECT fund_symbol, ROUND(AVG(volume), 0) average_volume FROM daily_performance dp INNER JOIN general g ON dp.fund_id = g.fund_id GROUP BY fund_symbol ORDER BY average_volume DESC;"

# Connect to MySQL server
mydb=mysql.connector.connect(host='localhost',user='root',password='********',database='us_funds')
mycursor=mydb.cursor()


# ----- Research Question 1 -----
# Selects columns 'fund_symbol', 'fund_long_name', and avg_yearly_return
mycursor.execute(Query1)
result = mycursor.fetchall

# save query results into arrays
symbol = []
yearly_return = []
for i in mycursor:
    symbol.append(i[0])
    yearly_return.append(i[2])

# plot a bar graph with the query results
plt.bar(symbol, yearly_return)

# set labels and title of graph
plt.xlabel("Fund Symbol")
plt.ylabel("Average Yearly Return")
plt.title("Highest Average Yearly Returns")

# display the graph
plt.show()



# ----- Research Question 2 -----
# Selects columns 'fund_symbol' and 'average_volume'
mycursor.execute(Query2)
result = mycursor.fetchall

fund_symbol = []
average_volume = []

for i in mycursor:
    fund_symbol.append(i[0])
    average_volume.append(i[1])

# plot a bar graph with the query results
plt.bar(fund_symbol, average_volume)

# set labels and title of graph
plt.xlabel("Fund Symbol")
plt.ylabel("Average Volume")
plt.title("Highest Average Daily Volume")

# display the graph
plt.show()

# ----- Research Question 3 -----
# Selects columns 'fund_symbol', 'price_date', and 'daily_change'
mycursor.execute(Query3)
result = mycursor.fetchall

fund_symbol = []
price_date = []
daily_change = []

for i in mycursor:
    fund_symbol.append(i[0])
    price_date.append(i[1])
    daily_change.append(i[2])

symbol_date = []

for i in range(len(fund_symbol)) :
    fund_symbol[i] = fund_symbol[i] + '\n' + price_date[i].strftime('%m/%d/%Y')

# plot a bar graph with the query results
plt.bar(fund_symbol, daily_change)

# set labels and title of graph
plt.xlabel("Fund Symbol")
plt.ylabel("Daily Change")
plt.title("Highest Daily Price Change")
plt.xticks(rotation=25, horizontalalignment='right')
plt.tight_layout()
# display the graph
plt.show()



# ----- Research Question 4 -----
# Selects columns 'fund_category' and 'category_avg_yearly_return'
mycursor.execute(Query4)
result = mycursor.fetchall

fund_category = []
category_avg_yearly_return = []

for i in mycursor:
    fund_category.append(i[0])
    category_avg_yearly_return.append(i[1])

# plot a bar graph with the query results
plt.bar(fund_category, category_avg_yearly_return)

# set labels and title of graph
plt.xlabel("Fund Category")
plt.ylabel("Average Return")
plt.title("Highest Average Return by Category")
plt.xticks(rotation=25, horizontalalignment='right')
plt.tight_layout()
# display the graph
plt.show()


# ---------- STATISTICAL ANALYSIS ----------

# Setup
sns.set_style("whitegrid")
color = sns.color_palette()

# Connect to MySQL server
try:
    mydb = mysql.connector.connect(host='localhost', user='root', password='********', database='us_funds')
    mycursor = mydb.cursor()

    # Function to fetch data and return as DataFrame
    def fetch_data(query):
        mycursor.execute(query)
        result = mycursor.fetchall()
        return pd.DataFrame(result, columns=mycursor.column_names)

    # Fetch average yearly return and average volume data
    avg_yearly_return_data = fetch_data(Query1NL)  # SQL for average yearly return
    avg_daily_volume_data = fetch_data(Query2NL)   # SQL for average daily volume

    # Merge the two DataFrames on fund_symbol
    merged_data = pd.merge(avg_yearly_return_data, avg_daily_volume_data, on="fund_symbol")

    print(avg_yearly_return_data.shape)
    print(avg_daily_volume_data.shape)
    print(merged_data.shape)

    # Convert to numeric types
    merged_data['avg_yearly_return'] = pd.to_numeric(merged_data['avg_yearly_return'], errors='coerce')
    merged_data['average_volume'] = pd.to_numeric(merged_data['average_volume'], errors='coerce')

    # print(merged_data['avg_yearly_return'].dtype)
    # print(merged_data['average_volume'].dtype)

    # Calculate the correlation between avg_yearly_return and average_volume
    correlation = merged_data['avg_yearly_return'].corr(merged_data['average_volume'])
    print(f"Correlation between average yearly return and average volume: {correlation:.2f}")

    # Plotting a scatter plot to visually see the correlation
    plt.figure(figsize=(10, 6))
    sns.scatterplot(data=merged_data, x='avg_yearly_return', y='average_volume')
    plt.title("Scatter plot of Average Yearly Return vs Average Volume")
    plt.show()
finally:
    # Close the connection
    if mycursor:
        mycursor.close()
    if mydb:
        mydb.close()
