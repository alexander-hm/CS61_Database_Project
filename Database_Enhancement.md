# Database Enhancement
This markdown document illustrates the enhancements made to a MySQL database to incorporate Python visualization. By accessing the MySQL database in Python, we can gather essential data and visualize it using Python's visualization libraries like matplotlib and seaborn.

### Accessing a MySQL Database in Python
To retrieve data from the MySQL database, we first establish a connection to the server. The MySQL connector for Python is used for this purpose. Here's how we do it:

```python
import mysql.connector

# Connect to MySQL server
mydb = mysql.connector.connect(
    host='localhost',
    user='root',
    password='LillyNoelle1!',
    database='us_funds'
)
mycursor = mydb.cursor()
```

After successfully connecting to the database, various SQL queries are executed to fetch data corresponding to different research questions. This data is then stored in Python data structures for further visualization.

### Plotting the Data
Once the data is available in Python, it's straightforward to plot using libraries like matplotlib and seaborn. Below are the highlights of the visualizations:

#### 1. Highest Average Yearly Returns:
- This graph presents the top 10 funds based on their average yearly returns.
- SQL query aggregates the yearly returns across 21 years and computes their average.
- Data is represented as a bar graph, with fund symbols on the x-axis and average yearly returns on the y-axis.

#### 2. Highest Average Daily Volume:
- This graph showcases the top 10 funds based on their average daily volume.
- A SQL query calculates the average volume of funds.
- The data is visualized as a bar graph, with fund symbols on the x-axis and average volume on the y-axis.

#### 3. Highest Daily Price Change:
- This graph depicts the top 10 funds with the highest daily price change.
- The date corresponding to each change is also incorporated for clarity.
- Data is represented as a bar graph with concatenated fund symbols and dates on the x-axis and daily change percentages on the y-axis.

#### 4. Highest Average Return by Category:
- This visualization displays the top 10 fund categories based on their average yearly returns.
- The SQL query aggregates returns across funds and categorizes them.
- The data is presented as a bar graph, with fund categories on the x-axis and average returns on the y-axis.

### Takeaways
By integrating Python with MySQL, it becomes convenient to use Python's data visualization capabilities directly on database data.

The visualizations help in drawing immediate insights from the data. For instance, stakeholders can quickly identify top-performing funds or understand trends in fund categories.

Always make sure that sensitive information, like database passwords, is handled securely and never hardcoded directly in scripts.

This enhancement not only aids in data analysis but also in presenting complex data in an easily digestible format to stakeholders.
