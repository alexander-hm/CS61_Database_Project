# Database Implementation
---
## Schema Implementation and .SQL File

The .sql file for the database and schema implementations can be found here: [SQL Implementation](Resources/US_Funds_DB_Implementation.sql)

The tables created with this command are shown below from the `SHOW TABLES` command: (except the etfs and etf_prices tables, which were imported from the dataset).

![Database Tables](Resources/Tables.png)

---
## Schema Descriptions
Schema descriptions from the `DESCRIBE` function are here: [Schema](Schema.md).

---
## Documentation
### Import Method
The `Table Data Import Wizard` tool (provided by MySQL Workbench) was used for the data transfer from the CSV files into the database. This allowed for an easy and quick transfer of data.


### Data Preparation
#### _Pre-Import_:
**Column Selection**: Even though the CSV files contained unnecessary columns, there was no need to drop them in Excel or any other spreadsheet software. This decision was based on the rationale that the redundant tables wouldn't hinder the post-import processes. They just weren't referenced in queries to decompose the tables.

**Data Discrepancies**: On reviewing the dataset, I observed discrepancies between the short fund name and the long fund name columns. After a meticulous manual examination, I altered the three discrepancies in Excel to ensure the data's accuracy.

#### _Post-Import_:
**Data Decomposition**: After importing the data from the two extensive CSV files, the objective was to refine the database structure for optimal querying and analytics. Thus, the two primary tables were decomposed into sixteen separate tables. The process was carried out using SQL's INSERT INTO command.
For instance, if we wanted to decompose data from a the `etfs` table into a new table called `regions`, the SQL command is as follows:

```sql
INSERT INTO region (region)
SELECT etfs.region
FROM etfs;
```

This method ensures that data from the larger table is extracted and organized into smaller, more focused tables which aids in more efficient querying and data management. Additionally, the new region table automatically indexes new regions entered into the table to create a unique `region_id` for each. Later post import decompositions were more complex, such as the `general` table:

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

By adopting these methods for data import and manipulation, we were able to transform raw, unprocessed data into a structured, organized database that serves as a robust foundation for our further analyses.


