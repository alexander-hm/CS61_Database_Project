INSERT INTO region (region)
SELECT DISTINCT etfs.region
FROM etfs;

INSERT INTO currency (currency)
SELECT DISTINCT etfs.currency
FROM etfs;

INSERT INTO family (fund_family)
SELECT DISTINCT etfs.fund_family
FROM etfs;

INSERT INTO category (fund_category)
SELECT DISTINCT etfs.fund_category
FROM etfs;

INSERT INTO timezone (timezone)
SELECT DISTINCT etfs.exchange_timezone
FROM etfs;

INSERT INTO investment_type (investment_type)
SELECT DISTINCT etfs.investment_type
FROM etfs;

INSERT INTO size (size_type)
SELECT DISTINCT etfs.size_type
FROM etfs;

INSERT INTO exchange (code, name, timezone_id)
SELECT DISTINCT etfs.exchange_code, etfs.exchange_name, timezone.timezone_id
FROM etfs
INNER JOIN timezone ON etfs.exchange_timezone = timezone.timezone;

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

INSERT INTO category_returns (category_id, returns_as_of_date, category_return_ytd, category_return_1month, category_return_3months, category_return_1year, category_return_3years, category_return_5years, category_return_10years, category_return_2020, category_return_2019, category_return_2018, category_return_2017, category_return_2016, category_return_2015, category_return_2014, category_return_2013, category_return_2012, category_return_2011, category_return_2010, category_return_2009, category_return_2008, category_return_2007, category_return_2006, category_return_2005, category_return_2004, category_return_2003, category_return_2002, category_return_2001, category_return_2000)
SELECT DISTINCT category.category_id, MIN(etfs.returns_as_of_date), CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_ytd)), ''), 0) AS DECIMAL(5,4)) AS category_return_ytd, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_1month)), ''), 0) AS DECIMAL(5,4)) AS category_return_1month, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_3months)), ''), 0) AS DECIMAL(5,4)) AS category_return_3months, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_1year)), ''), 0) AS DECIMAL(5,4)) AS category_return_1year, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_3years)), ''), 0) AS DECIMAL(5,4)) AS category_return_3years, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_5years)), ''), 0) AS DECIMAL(5,4)) AS category_return_5years, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_10years)), ''), 0) AS DECIMAL(5,4)) AS category_return_10years, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2020)), ''), 0) AS DECIMAL(5,4)) AS category_return_2020, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2019)), ''), 0) AS DECIMAL(5,4)) AS category_return_2019, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2018)), ''), 0) AS DECIMAL(5,4)) AS category_return_2018, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2017)), ''), 0) AS DECIMAL(5,4)) AS category_return_2017, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2016)), ''), 0) AS DECIMAL(5,4)) AS category_return_2016, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2015)), ''), 0) AS DECIMAL(5,4)) AS category_return_2015, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2014)), ''), 0) AS DECIMAL(5,4)) AS category_return_2014, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2013)), ''), 0) AS DECIMAL(5,4)) AS category_return_2013, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2012)), ''), 0) AS DECIMAL(5,4)) AS category_return_2012, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2011)), ''), 0) AS DECIMAL(5,4)) AS category_return_2011, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2010)), ''), 0) AS DECIMAL(5,4)) AS category_return_2010, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2009)), ''), 0) AS DECIMAL(5,4)) AS category_return_2009, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2008)), ''), 0) AS DECIMAL(5,4)) AS category_return_2008, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2007)), ''), 0) AS DECIMAL(5,4)) AS category_return_2007, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2006)), ''), 0) AS DECIMAL(5,4)) AS category_return_2006, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2005)), ''), 0) AS DECIMAL(5,4)) AS category_return_2005, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2004)), ''), 0) AS DECIMAL(5,4)) AS category_return_2004, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2003)), ''), 0) AS DECIMAL(5,4)) AS category_return_2003, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2002)), ''), 0) AS DECIMAL(5,4)) AS category_return_2002, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2001)), ''), 0) AS DECIMAL(5,4)) AS category_return_2001, CAST(COALESCE(NULLIF(TRIM(MIN(etfs.category_return_2000)), ''), 0) AS DECIMAL(5,4)) AS category_return_2000
FROM etfs
INNER JOIN category ON etfs.fund_category = category.fund_category
GROUP BY category.category_id;

INSERT INTO daily_performance (fund_id, price_date, open, high, low, close, adj_close, volume)
SELECT g.fund_id, ep.price_date, ep.open, ep.high, ep.low, ep.close, ep.adj_close, ep.volume
FROM `etf prices` ep
INNER JOIN general g ON ep.fund_symbol = g.fund_symbol;  

INSERT INTO indicators (fund_id, asset_stocks, asset_bonds, fund_sector_basic_materials, fund_sector_communication_services, fund_sector_consumer_cyclical, fund_sector_consumer_defensive, fund_sector_energy, fund_sector_financial_services, fund_sector_healthcare, fund_sector_industrials, fund_sector_real_estate, fund_sector_technology, fund_sector_utilities, fund_price_book_ratio, fund_price_cashflow_ratio, fund_price_earning_ratio, fund_price_sales_ratio, fund_bond_maturity, fund_bond_duration, fund_bonds_us_government, fund_bonds_aaa, fund_bonds_aa, fund_bonds_a, fund_bonds_bbb, fund_bonds_bb, fund_bonds_b, fund_bonds_below_b, fund_bonds_others, top10_holdings, top10_holdings_total_assets)
SELECT g.fund_id, DEC_5_4(asset_stocks), DEC_5_4(asset_bonds), DEC_5_4(fund_sector_basic_materials), DEC_5_4(fund_sector_communication_services), DEC_5_4(fund_sector_consumer_cyclical), DEC_5_4(fund_sector_consumer_defensive), DEC_5_4(fund_sector_energy), DEC_5_4(fund_sector_financial_services), DEC_5_4(fund_sector_healthcare), DEC_5_4(fund_sector_industrials), DEC_5_4(fund_sector_real_estate), DEC_5_4(fund_sector_technology), DEC_5_4(fund_sector_utilities), DEC_7_4(fund_price_book_ratio), DEC_7_4(fund_price_cashflow_ratio), DEC_7_4(fund_price_earning_ratio), DEC_7_4(fund_price_sales_ratio), DEC_7_4(fund_bond_maturity), DEC_7_4(fund_bond_duration), DEC_5_4(fund_bonds_us_government), DEC_5_4(fund_bonds_aaa), DEC_5_4(fund_bonds_aa), DEC_5_4(fund_bonds_a), DEC_5_4(fund_bonds_bbb), DEC_5_4(fund_bonds_bb), DEC_5_4(fund_bonds_b), DEC_5_4(fund_bonds_below_b), DEC_5_4(fund_bonds_others), top10_holdings, DEC_5_4(top10_holdings_total_assets)
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;

INSERT INTO returns (fund_id, returns_as_of_date, fund_return_ytd, fund_return_1month, fund_return_3months, fund_return_1year, fund_return_3years, fund_return_5years, fund_return_10years, years_up, years_down, fund_return_2020, fund_return_2019, fund_return_2018, fund_return_2017, fund_return_2016, fund_return_2015, fund_return_2014, fund_return_2013, fund_return_2012, fund_return_2011, fund_return_2010, fund_return_2009, fund_return_2008, fund_return_2007, fund_return_2006, fund_return_2005, fund_return_2004, fund_return_2003, fund_return_2002, fund_return_2001, fund_return_2000)
SELECT g.fund_id, returns_as_of_date, fund_return_ytd, DEC_5_4(fund_return_1month), DEC_5_4(fund_return_3months), DEC_5_4(fund_return_1year), DEC_5_4(fund_return_3years), DEC_5_4(fund_return_5years), DEC_5_4(fund_return_10years), CAST(COALESCE(NULLIF(TRIM(years_up), ''), '0') AS UNSIGNED), CAST(COALESCE(NULLIF(TRIM(years_down), ''), '0') AS UNSIGNED), DEC_5_4(fund_return_2020), DEC_5_4(fund_return_2019), DEC_5_4(fund_return_2018), DEC_5_4(fund_return_2017), DEC_5_4(fund_return_2016), DEC_5_4(fund_return_2015), DEC_5_4(fund_return_2014), DEC_5_4(fund_return_2013), DEC_5_4(fund_return_2012), DEC_5_4(fund_return_2011), DEC_5_4(fund_return_2010), DEC_5_4(fund_return_2009), DEC_5_4(fund_return_2008), DEC_5_4(fund_return_2007), DEC_5_4(fund_return_2006), DEC_5_4(fund_return_2005), DEC_5_4(fund_return_2004), DEC_5_4(fund_return_2003), DEC_5_4(fund_return_2002), DEC_5_4(fund_return_2001), DEC_5_4(fund_return_2000)
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;

INSERT INTO ratios (fund_id, fund_alpha_3years, fund_beta_3years, fund_mean_annual_return_3years, fund_r_squared_3years, fund_stdev_3years, fund_sharpe_ratio_3years, fund_treynor_ratio_3years, fund_alpha_5years, fund_beta_5years, fund_mean_annual_return_5years, fund_r_squared_5years, fund_stdev_5years, fund_sharpe_ratio_5years, fund_treynor_ratio_5years, fund_alpha_10years, fund_beta_10years, fund_mean_annual_return_10years, fund_r_squared_10years, fund_stdev_10years, fund_sharpe_ratio_10years, fund_treynor_ratio_10years)
SELECT g.fund_id, DEC_4_2(fund_alpha_3years), DEC_4_2(fund_beta_3years), DEC_4_2(fund_mean_annual_return_3years), DEC_4_2(fund_r_squared_3years), DEC_4_2(fund_stdev_3years), DEC_4_2(fund_sharpe_ratio_3years), DEC_4_2(fund_treynor_ratio_3years), DEC_4_2(fund_alpha_5years), DEC_4_2(fund_beta_5years), DEC_4_2(fund_mean_annual_return_5years), DEC_4_2(fund_r_squared_5years), DEC_4_2(fund_stdev_5years), DEC_4_2(fund_sharpe_ratio_5years), DEC_4_2(fund_treynor_ratio_5years), DEC_4_2(fund_alpha_10years), DEC_4_2(fund_beta_10years), DEC_4_2(fund_mean_annual_return_10years), DEC_4_2(fund_r_squared_10years), DEC_4_2(fund_stdev_10years), DEC_4_2(fund_sharpe_ratio_10years), DEC_4_2(fund_treynor_ratio_10years)
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;

INSERT INTO averages(fund_id, avg_vol_3month, avg_vol_10day, day50_moving_average, day200_moving_average)
SELECT g.fund_id, avg_vol_3month, avg_vol_10day, day50_moving_average, day200_moving_average
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;

INSERT INTO 52_week_performance (fund_id, week52_high_low_change, week52_high_low_change_perc, week52_high, week52_high_change, week52_high_change_perc, week52_low, week52_low_change, week52_low_change_perc)
SELECT g.fund_id, DEC_7_3(week52_high_low_change), DEC_7_3(week52_high_low_change_perc), DEC_7_3(week52_high), DEC_7_3(week52_high_change), DEC_7_3(week52_high_change_perc), DEC_7_3(week52_low), DEC_7_3(week52_low_change), DEC_7_3(week52_low_change_perc)
FROM etfs e
INNER JOIN general g ON e.fund_symbol = g.fund_symbol;