# Database Build Plan
## Schema and Tables
Create a 'us_funds' database in MySQL using the ```sql CREATE DATABASE``` command. The creation of schema and tables is done in accordance with the [entity relationship diagram](ERD.md). Table names, attributes, and data types are all described there. The tables without foreign keys (```region, currency, family, category, timezone, investment_type, size```) are created first. The second round of tables will reference these (```exchange, general, category_returns```). Then, the remaining tables are created (```daily_performance, indicators, returns, ratios, averages, 52_week_performance```). This will allow the foreign keys to be referenced when the table is first created.

Sample code for creating the 'general' table:
```sql
CREATE TABLE general (
    fund_id INT NON NULL AUTO_INCREMENT,
    fund_symbol VARCHAR(10) NUN NULL,
    region_id INT,
    fund_short_name VARCHAR(45),
    fund_long_name VARCHAR(45),
    currency_id INT,
    category_id INT,
    family_id INT,
    exchange_id INT,
    total_net_assets INT,
    investment_strategy TEXT,
    fund_yield DECIMAL(5,4),
    inception_date DATE,
    annual_holdings_turnover DECIMAL(5,4),
    investment_type_id INT,
    size_id INT,
    PRIMARY KEY (fund_id, fund_symbol),
    FOREIGN KEY (region_id) REFERENCES region(region_id),
    FOREIGN KEY (currency_id) REFERENCES currency(currency_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (exchange_id) REFERENCES exchange(exchange_id),
    FOREIGN KEY (investment_type_id) REFERENCES investment_type(investment_type_id),
    FOREIGN KEY (size_id) REFERENCES size(size_id)
);
```

## Data Input
After the tables are created, the dataset is imported into MySQL and formatted into the respective tables. 

### Pre-Import Manipulation/Transformation
Prior to importing the dataset to MySQL, the data will be cleaned up from the .CSV files in Excel. Specific alterations include:
- Delete the quote_type attribute from the etf.csv table because it is obsolete (all 'ETF' for the subset of the dataset being used).
- Delete the AAA fund from the etf_prices.csv table because it does not exist in the etf.csv table.
- Review data from the etf.csv table for discrepancies from alignment issues from 'fund_short_name, fund_long_name,' and 'fund_family' as described in the discussion on [Kaggle](https://www.kaggle.com/datasets/stefanoleone992/mutual-funds-and-etfs/discussion/329929).
### Import Processes
Load the two .csv files into the created 'us_funds' database using the Table Data Import Wizard.
### Post-Import Manipulation/Transformation
Using the 'INSERT INTO' command, populate the 16 tables with data from the two .CSV tables. Similar to creating the tables, populating the tables should be done in the same order so that successive tables can reference data such as 'region' and 'region_id'.

Sample code for importing data into the 'region' table:
```sql
INSERT INTO region (region)
SELECT DISTINCT etfs.region_id
FROM etfs;
```

Sample code for importing data into the 'general' table:
```sql
INSERT INTO general (fund_symbol, region_id, fund_short_name, fund_long_name, currency_id, category_id, family_id, exchange_id, total_net_assets, investment_strategy, fund_yield, inception_date, annual_holdings_turnover, investment_type_id, size_id)
SELECT etfs.fund_symbol, region.region_id, etfs.fund_short_name, etfs.fund_long_name, currency.currency_id, category.category_id, family.family_id, exchange.exchange_id, etfs.total_net_assets, etfs.investment_strategy, etfs.fund_yield, etfs.inception_date, etfs.annual_holdings_turnover, investment_type.investment_type_id, size.size_id)
FROM etfs
INNER JOIN region ON etfs.region = region.region
INNER JOIN currency ON etfs.currency = currency.currency
INNER JOIN category ON etfs.fund_category = category.fund_category
INNER JOIN family ON etfs.fund_family = family.fund_family
INNER JOIN exchange ON etfs.exchange_code = exchange.code
INNER JOIN investment_type ON etfs.investment_type = investment_type.investment_type
INNER JOIN size ON etfs.size_type = size.size_type;
```
