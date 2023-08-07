# Create and use us_funds database 
CREATE DATABASE us_funds;
USE us_funds;

# Make region table
CREATE TABLE region
(
	region_id	INT unsigned NOT NULL AUTO_INCREMENT,
    region		VARCHAR(45),
    PRIMARY KEY	(region_id)
);

# Make currency table
CREATE TABLE currency
(
	currency_id		INT unsigned NOT NULL AUTO_INCREMENT,
    currency		VARCHAR(45),
    PRIMARY KEY	(currency_id)
);

# Make family table
CREATE TABLE family
(
	family_id		INT unsigned NOT NULL AUTO_INCREMENT,
	fund_family		VARCHAR(45),
    PRIMARY KEY	(family_id)
);

# Make category table
CREATE TABLE category
(
	category_id		INT unsigned NOT NULL AUTO_INCREMENT,
	fund_category	VARCHAR(45),
    PRIMARY KEY	(category_id)
);

# Make timezone table
CREATE TABLE timezone
(
	timezone_id	INT unsigned NOT NULL AUTO_INCREMENT,
	timezone 	VARCHAR(45),
    PRIMARY KEY	(timezone_id)
);

# Make investment_type table
CREATE TABLE investment_type
(
	investment_type_id	INT unsigned NOT NULL AUTO_INCREMENT,
    investment_type VARCHAR(45),
    PRIMARY KEY	(investment_type_id)
);

# Make size table
CREATE TABLE size
(
	size_id	INT unsigned NOT NULL AUTO_INCREMENT,
    size_type	VARCHAR(45),
    PRIMARY KEY	(size_id)
);

# Make exchange table
CREATE TABLE exchange
(
	exchange_id INT unsigned NOT NULL AUTO_INCREMENT,
    code 		VARCHAR(45),
    name 		VARCHAR(45),
    timezone_id INT unsigned,
    PRIMARY KEY (exchange_id),
    FOREIGN KEY (timezone_id) REFERENCES timezone(timezone_id)
);

# Make general table
CREATE TABLE general 
(
    fund_id INT unsigned NOT NULL AUTO_INCREMENT,
    fund_symbol VARCHAR(10) NOT NULL,
    region_id INT unsigned,
    fund_short_name VARCHAR(45),
    fund_long_name VARCHAR(45),
    currency_id INT unsigned,
    category_id INT unsigned,
    family_id INT unsigned,
    exchange_id INT  unsigned,
    total_net_assets INT,
    investment_strategy TEXT,
    fund_yield DECIMAL(5,4),
    inception_date DATE,
    annual_holdings_turnover DECIMAL(5,4),
    investment_type_id INT unsigned,
    size_id INT unsigned,
    PRIMARY KEY (fund_id, fund_symbol),
    FOREIGN KEY (region_id) REFERENCES region(region_id),
    FOREIGN KEY (currency_id) REFERENCES currency(currency_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id),
    FOREIGN KEY (family_id) REFERENCES family(family_id),
    FOREIGN KEY (exchange_id) REFERENCES exchange(exchange_id),
    FOREIGN KEY (investment_type_id) REFERENCES investment_type(investment_type_id),
    FOREIGN KEY (size_id) REFERENCES size(size_id)
);

# Make category_returns table
CREATE TABLE category_returns
(
	category_id 			INT unsigned NOT NULL,
    returns_as_of_date 		DATE,
    category_return_ytd 	DECIMAL(5,4),
    category_return_1month	DECIMAL(5,4),
	category_return_3months DECIMAL(5,4),
	category_return_1year 	DECIMAL(5,4),
	category_return_3years 	DECIMAL(5,4),
	category_return_5years 	DECIMAL(5,4),
	category_return_10years	DECIMAL(5,4),
	category_return_2020 	DECIMAL(5,4),
	category_return_2019 	DECIMAL(5,4),
	category_return_2018 	DECIMAL(5,4),
	category_return_2017 	DECIMAL(5,4),
	category_return_2016 	DECIMAL(5,4),
	category_return_2015 	DECIMAL(5,4),
	category_return_2014 	DECIMAL(5,4),
	category_return_2013	DECIMAL(5,4),
	category_return_2012 	DECIMAL(5,4),
	category_return_2011 	DECIMAL(5,4),
	category_return_2010 	DECIMAL(5,4),
	category_return_2009 	DECIMAL(5,4),
	category_return_2008 	DECIMAL(5,4),
	category_return_2007 	DECIMAL(5,4),
	category_return_2006 	DECIMAL(5,4),
	category_return_2005 	DECIMAL(5,4),
	category_return_2004 	DECIMAL(5,4),
	category_return_2003 	DECIMAL(5,4),
	category_return_2002 	DECIMAL(5,4),
	category_return_2001 	DECIMAL(5,4),
	category_return_2000 	DECIMAL(5,4),
    PRIMARY KEY (category_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

# Make daily_performance table
CREATE TABLE daily_performance
(
	fund_id			INT unsigned NOT NULL,
    price_date		DATE,
    open			DECIMAL(7,3),
    high			DECIMAL(7,3),
    low				DECIMAL(7,3),
    close			DECIMAL(7,3),
    adj_close		DECIMAL(7,3),
    volume			INT,
    PRIMARY KEY (fund_id, price_date),
    FOREIGN KEY (fund_id) REFERENCES general(fund_id)
);

# Make indicators table
CREATE TABLE indicators
(
	fund_id							INT unsigned NOT NULL,
    asset_stocks					DECIMAL(5,4),
	asset_bonds						DECIMAL(5,4),
	fund_sector_basic_materials 	DECIMAL(5,4),
	fund_sector_communication_services	DECIMAL(5,4),
	fund_sector_consumer_cyclical	DECIMAL(5,4),
	fund_sector_consumer_defensive	DECIMAL(5,4),
	fund_sector_energy				DECIMAL(5,4),
	fund_sector_financial_services	DECIMAL(5,4),
	fund_sector_healthcare			DECIMAL(5,4),
	fund_sector_industrials			DECIMAL(5,4),
	fund_sector_real_estate			DECIMAL(5,4),
	fund_sector_technology			DECIMAL(5,4),
	fund_sector_utilities			DECIMAL(5,4),
	fund_price_book_ratio			DECIMAL(5,4),
	fund_price_cashflow_ratio		DECIMAL(5,4),
	fund_price_earning_ratio		DECIMAL(5,4),
	fund_price_sales_ratio			DECIMAL(5,4),
	fund_bond_maturity				DECIMAL(5,4),
	fund_bond_duration				DECIMAL(5,4),
	fund_bonds_us_government		DECIMAL(5,4),
	fund_bonds_aaa					DECIMAL(5,4),
	fund_bonds_aa					DECIMAL(5,4),
	fund_bonds_a					DECIMAL(5,4),
	fund_bonds_bbb					DECIMAL(5,4),
	fund_bonds_bb					DECIMAL(5,4),
	fund_bonds_b					DECIMAL(5,4),
	fund_bonds_below_b				DECIMAL(5,4),
	fund_bonds_others				DECIMAL(5,4),
	top10_holdings					TEXT,
	top10_holdings_total_assets		DECIMAL(5,4)
);

# Make returns table
CREATE TABLE returns
(
	fund_id					INT unsigned NOT NULL,
    returns_as_of_date 		DATE,
    fund_return_ytd 		DECIMAL(5,4),
    fund_return_1month		DECIMAL(5,4),
	fund_return_3months 	DECIMAL(5,4),
	fund_return_1year 		DECIMAL(5,4),
	fund_return_3years 		DECIMAL(5,4),
	fund_return_5years 		DECIMAL(5,4),
	fund_return_10years		DECIMAL(5,4),
    years_up				INT,
    years_down				INT,
	fund_return_2020 		DECIMAL(5,4),
	fund_return_2019 		DECIMAL(5,4),
	fund_return_2018 		DECIMAL(5,4),
	fund_return_2017 		DECIMAL(5,4),
	fund_return_2016 		DECIMAL(5,4),
	fund_return_2015 		DECIMAL(5,4),
	fund_return_2014 		DECIMAL(5,4),
	fund_return_2013		DECIMAL(5,4),
	fund_return_2012 		DECIMAL(5,4),
	fund_return_2011 		DECIMAL(5,4),
	fund_return_2010 		DECIMAL(5,4),
	fund_return_2009 		DECIMAL(5,4),
	fund_return_2008 		DECIMAL(5,4),
	fund_return_2007 		DECIMAL(5,4),
	fund_return_2006 		DECIMAL(5,4),
	fund_return_2005 		DECIMAL(5,4),
	fund_return_2004 		DECIMAL(5,4),
	fund_return_2003 		DECIMAL(5,4),
	fund_return_2002 		DECIMAL(5,4),
	fund_return_2001 		DECIMAL(5,4),
	fund_return_2000 		DECIMAL(5,4),
    PRIMARY KEY (fund_id),
    FOREIGN KEY (fund_id) REFERENCES general(fund_id)
);

# Make ratios table
CREATE TABLE ratios
(
	fund_id 				INT unsigned NOT NULL,
    fund_alpha_3years				DECIMAL(4,2),
	fund_beta_3years				DECIMAL(4,2),
	fund_mean_annual_return_3years	DECIMAL(4,2),
	fund_r_squared_3years			DECIMAL(4,2),
	fund_stdev_3years				DECIMAL(4,2),
	fund_sharpe_ratio_3years		DECIMAL(4,2),
	fund_treynor_ratio_3years		DECIMAL(4,2),
	fund_alpha_5years				DECIMAL(4,2),
	fund_beta_5years				DECIMAL(4,2),
	fund_mean_annual_return_5years	DECIMAL(4,2),
	fund_r_squared_5years			DECIMAL(4,2),
	fund_stdev_5years				DECIMAL(4,2),
	fund_sharpe_ratio_5years		DECIMAL(4,2),
	fund_treynor_ratio_5years		DECIMAL(4,2),
	fund_alpha_10years				DECIMAL(4,2),
	fund_beta_10years				DECIMAL(4,2),
	fund_mean_annual_return_10years	DECIMAL(4,2),
	fund_r_squared_10years			DECIMAL(4,2),
	fund_stdev_10years				DECIMAL(4,2),
	fund_sharpe_ratio_10years		DECIMAL(4,2),
	fund_treynor_ratio_10years		DECIMAL(4,2),
	PRIMARY KEY (fund_id),
    FOREIGN KEY (fund_id) REFERENCES general(fund_id)
);

# Make averages table
CREATE TABLE averages
(
	fund_id					INT unsigned NOT NULL,
	avg_vol_3month			INT,
	avg_vol_10day			INT,
	day50_moving_average	DECIMAL(7,3),
	day200_moving_average	DECIMAL(7,3),
	PRIMARY KEY (fund_id),
    FOREIGN KEY (fund_id) REFERENCES general(fund_id)
);

# Make 52_week_performance table
CREATE TABLE 52_week_performance
(
	fund_id				INT unsigned NOT NULL,
	week52_high_low_change		DECIMAL(7,3),
	week52_high_low_change_perc DECIMAL(7,3),
	week52_high					DECIMAL(7,3),
	week52_high_change			DECIMAL(7,3),
	week52_high_change_perc		DECIMAL(7,3),
	week52_low					DECIMAL(7,3),
	week52_low_change			DECIMAL(7,3),
	week52_low_change_perc		DECIMAL(7,3),
	PRIMARY KEY (fund_id),
    FOREIGN KEY (fund_id) REFERENCES general(fund_id)
);