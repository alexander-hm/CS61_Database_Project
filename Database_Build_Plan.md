# Database Build Plan
## Schema and Tables
The creation of schema and tables is done in accordance with the [entity relationship diagram](ERD.md). Table names, attributes, and data types are all described there. The tables without foreign keys (region, currency, family, category, timezone, investment_type, and size) are created first. The second round of tables will reference these (exchange, general, category_returns). Then, the remaining tables are created (daily_performance, indicators, returns, ratios, averages, 52_week_performance). This will allow the foreign keys to be instantiated when the table is first created.


## Data Input
#### Pre-Import
#### Import Processes
#### Post-Import
