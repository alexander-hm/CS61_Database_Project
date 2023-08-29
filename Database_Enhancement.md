# Database Enhancement
## [Python File](/Resources/Enhancements.py)
This markdown document illustrates the enhancements made to a MySQL database to incorporate data visualization and statistical analysis with Python. By accessing the MySQL database in Python, we can gather essential data and visualize it using Python's visualization libraries like `matplotlib` and `seaborn` as well as conduct statistical analysis with `pandas` and `numpy`.

# Data Visualization with Python

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

### Results

The data visuals can be seen in the [Research Analysis](Research_Analysis.md) page.

# Statistical Analysis with Python

In addition to the data visualization, a small statistical analysis was run to find a correlation between the attributes of research question 1 and 2. This enhancement used the `pandas` and `numpy` library in addition to the others. Additionally, the code and methods for accessing the MySQL database were cleaned up in this part of the database enhancement.

### Queries:
The original four queries for the research questions were parameterized into four SQL queries (Query1, Query2, Query3, Query4). Additionally, two more queries, Query1NL and Query2NL were added. They slightly modified versions of Query1 and Query2 with no `LIMIT`. This allows for all data points to be included in the scatter plot analysis, which allows data from the same fund to be matched up to create the maximum amount of data points.

### Establishing Database Connection:
The code connects to a MySQL database with given credentials (host, user, password, and database) as before.

### Fetching Data:
A function named fetch_data(query) is defined to:
- Execute the SQL query.
- Fetch all the results.
- Convert these results into a pandas DataFrame.
- Return the DataFrame.

```python
# Function to fetch data and return as DataFrame
def fetch_data(query):
    mycursor.execute(query)
    result = mycursor.fetchall()
    return pd.DataFrame(result, columns=mycursor.column_names)
```

### Data Analysis:
Two sets of data are fetched using the fetch_data function: `avg_yearly_return_data` and `avg_daily_volume_data`.
The two fetched DataFrames are merged on the column `fund_symbol`.

```python
# Fetch average yearly return and average volume data
avg_yearly_return_data = fetch_data(Query1NL)  # SQL for average yearly return
avg_daily_volume_data = fetch_data(Query2NL)   # SQL for average daily volume

# Merge the two DataFrames on fund_symbol
merged_data = pd.merge(avg_yearly_return_data, avg_daily_volume_data, on="fund_symbol")
```

After merging, the data types of the columns `avg_yearly_return` and `average_volume` are explicitly converted to numeric types (with any non-convertible entries set as NaN with errors='coerce').

```python
# Convert to numeric types
merged_data['avg_yearly_return'] = pd.to_numeric(merged_data['avg_yearly_return'], errors='coerce')
merged_data['average_volume'] = pd.to_numeric(merged_data['average_volume'], errors='coerce')
```

The code then calculates the correlation between `avg_yearly_return` and `average_volume` using the `corr` method. This correlation measures the linear relationship between these two variables. The computed correlation coefficient is then printed.

```python
correlation = merged_data['avg_yearly_return'].corr(merged_data['average_volume'])
print(f"Correlation between average yearly return and average volume: {correlation:.2f}")
```

### Visualization:
A scatter plot is created to visually see the relationship between the average yearly return (`avg_yearly_return`) and average volume (`average_volume`). This plot can help in understanding the data's distribution and if there's any visible pattern or relationship between the two variables.

```python
plt.figure(figsize=(10, 6))
sns.scatterplot(data=merged_data, x='avg_yearly_return', y='average_volume')
plt.title("Scatter plot of Average Yearly Return vs Average Volume")
plt.show()
```

![Stat Analysis Scatter Plot](/Resources/Scatter_Plot_1.png)

### Clean-Up:
A `finally` block ensures that the database connection and the cursor are closed regardless of whether the previous code ran without errors or not.

### Key Takeaway:
This script connects to the MySQL database, fetches specific data, analyzes this data, and then visualizes the relationships in the data. I do not have experience with these applications of Python or these libraries and the database enhancement took a great deal of research, testing, troubleshooting, and pretty much learning of it.

### Results:
The code printed the following correlation:
`Correlation between average yearly return and average volume: -0.01`

**-0.01**

This showed that there was little to no relationship between a fund's average yearly return and its average trading volume. This same method can be used as a model to search for correlations between other attributes and computed data from the database as well.
