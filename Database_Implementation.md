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
The decomposition of data from the `etfs` table into the small tables `region, currency, family, category, timezone, investment_type, size` resembled the following:

```sql
INSERT INTO region (region)
SELECT etfs.region
FROM etfs;
```

This method ensures that data from the larger table is extracted and organized into smaller, more focused tables which aids in more efficient querying and data management. Additionally, the new table automatically indexes new columns entered into the table to create a unique `id` for each. Following post-import decompositions were more complex, such as the `general` table. These decompositions/insertions required joining the table with the previous tables to match the correct id for each `region, currency, family, etc.` object. Additionally, the `DECIMAL` fields had to be cast because the original data was of the type `TEXT`. 

`general` Table
```sql
INSERT INTO general (fund_symbol, region_id, fund_short_name, fund_long_name, currency_id, category_id, family_id, exchange_id, total_net_assets, investment_strategy, fund_yield, inception_date, annual_holdings_turnover, investment_type_id, size_id)
SELECT etfs.fund_symbol, region.region_id, etfs.fund_short_name, etfs.fund_long_name, currency.currency_id, category.category_id, family.family_id, exchange.exchange_id, etfs.total_net_assets, etfs.investment_strategy, DEC_5_4(fund_yield), etfs.inception_date, DEC_5_4(annual_holdings_turnover), investment_type.investment_type_id, size.size_id
FROM etfs
INNER JOIN region ON etfs.region = region.region
INNER JOIN currency ON etfs.currency = currency.currency
INNER JOIN category ON etfs.fund_category = category.fund_category
INNER JOIN family ON etfs.fund_family = family.fund_family
INNER JOIN exchange ON etfs.exchange_code = exchange.code
INNER JOIN investment_type ON etfs.investment_type = investment_type.investment_type
INNER JOIN size ON etfs.size_type = size.size_type
ORDER BY fund_symbol;
```

`indicators` Table
```SQL
INSERT INTO indicators (fund_id, asset_stocks, asset_bonds, fund_sector_basic_materials, fund_sector_communication_services, fund_sector_consumer_cyclical, fund_sector_consumer_defensive, fund_sector_energy, fund_sector_financial_services, fund_sector_healthcare, fund_sector_industrials, fund_sector_real_estate, fund_sector_technology, fund_sector_utilities, fund_price_book_ratio, fund_price_cashflow_ratio, fund_price_earning_ratio, fund_price_sales_ratio, fund_bond_maturity, fund_bond_duration, fund_bonds_us_government, fund_bonds_aaa, fund_bonds_aa, fund_bonds_a, fund_bonds_bbb, fund_bonds_bb, fund_bonds_b, fund_bonds_below_b, fund_bonds_others, top10_holdings, top10_holdings_total_assets)
SELECT g.fund_id, DEC_5_4(asset_stocks), DEC_5_4(asset_bonds), DEC_5_4(fund_sector_basic_materials), DEC_5_4(fund_sector_communication_services), DEC_5_4(fund_sector_consumer_cyclical), DEC_5_4(fund_sector_consumer_defensive), DEC_5_4(fund_sector_energy), DEC_5_4(fund_sector_financial_services), DEC_5_4(fund_sector_healthcare), DEC_5_4(fund_sector_industrials), DEC_5_4(fund_sector_real_estate), DEC_5_4(fund_sector_technology), DEC_5_4(fund_sector_utilities), DEC_7_4(fund_price_book_ratio), DEC_7_4(fund_price_cashflow_ratio), DEC_7_4(fund_price_earning_ratio), DEC_7_4(fund_price_sales_ratio), DEC_7_4(fund_bond_maturity), DEC_7_4(fund_bond_duration), DEC_5_4(fund_bonds_us_government), DEC_5_4(fund_bonds_aaa), DEC_5_4(fund_bonds_aa), DEC_5_4(fund_bonds_a), DEC_5_4(fund_bonds_bbb), DEC_5_4(fund_bonds_bb), DEC_5_4(fund_bonds_b), DEC_5_4(fund_bonds_below_b), DEC_5_4(fund_bonds_others), top10_holdings, DEC_5_4(top10_holdings_total_assets)
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;
```

By adopting these methods for data import and manipulation, we were able to transform raw, unprocessed data into a structured, organized database that serves as a robust foundation for our further analyses.

---

**SQL Functions**: In order to cast many different attributes to various `DECIMAL` types, I created functions to make the code faster and cleaner. Additionally, it allowed me to debug more efficiently because I could make single changes in the function that affected the numerous calls to the function in each `INSERT` query.

The functions were defined as follows and can be seen in the INSERT statements on this page and in the `.sql` file.

DEC_5_4 (cast `TEXT` input as `DECIMAL(5,4)`):
```sql
CREATE DEFINER=`root`@`localhost` FUNCTION `DEC_5_4`(val TEXT) RETURNS decimal(5,4)
    DETERMINISTIC
BEGIN
IF CAST(val AS DOUBLE) > 1
THEN RETURN 0;
ELSE 
	RETURN ROUND(CAST(COALESCE(NULLIF(TRIM(val), ''), 0) AS DECIMAL(5,4)), 4);
END IF;
END
```

DEC_7_4 (cast `TEXT` input as `DECIMAL(7,4)`);
```sql
CREATE DEFINER=`root`@`localhost` FUNCTION `DEC_7_4`(val TEXT) RETURNS decimal(7,4)
    DETERMINISTIC
BEGIN
IF CAST(val AS DOUBLE) >= 1000
THEN RETURN 0;
ELSE 
	RETURN ROUND(CAST(COALESCE(NULLIF(TRIM(val), ''), 0) AS DECIMAL(7,4)), 4);
END IF;
END
```
