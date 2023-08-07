# Database Build Plan
## Schema and Tables
The creation of schema and tables is done in accordance with the [entity relationship diagram](ERD.md). Table names, attributes, and data types are all described there. The tables without foreign keys (```region, currency, family, category, timezone, investment_type, size```) are created first. The second round of tables will reference these (```exchange, general, category_returns```). Then, the remaining tables are created (```daily_performance, indicators, returns, ratios, averages, 52_week_performance```). This will allow the foreign keys to be referenced when the table is first created.

Sample code for creating the ```general``` table is as follows:
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
#### Pre-Import
#### Import Processes
#### Post-Import
