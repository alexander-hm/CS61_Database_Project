#1: Which funds performed best over the period of time?
/*
SELECT fund_symbol, fund_long_name, ROUND((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21, 4) AS avg_yearly_return
FROM returns r
INNER JOIN general g ON r.fund_id = g.fund_id
ORDER BY avg_yearly_return DESC
LIMIT 10;
*/

#2: Which funds have the highest average daily trading volume?
/*
SELECT fund_symbol, ROUND(AVG(volume), 0) average_volume
FROM daily_performance dp
INNER JOIN general g ON dp.fund_id = g.fund_id
GROUP BY fund_symbol
ORDER BY average_volume DESC
LIMIT 10;
#*/

#3: What is the largest single-day growth experienced by a fund?
/*
SELECT fund_symbol, price_date, ROUND((close - open)/open, 4) AS daily_change
FROM 
(
	select daily_performance.*, MAX(ROUND((close - open)/open, 4)) OVER(PARTITION BY fund_id) as max_change
	from daily_performance
) AS dp
INNER JOIN general g ON dp.fund_id = g.fund_id
WHERE ROUND((close - open)/open, 4) = max_change
ORDER BY daily_change DESC;
#*/

#4: What is the average yearly growth of funds? By how much are the top funds able to outperform the average?
# Total average fund return
/*
SELECT ROUND(AVG((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21), 4) AS total_avg_yearly_return
FROM returns r
INNER JOIN general g ON r.fund_id = g.fund_id
#*/
# Average fund returns by category
/*
SELECT fund_category, ROUND(AVG((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21), 4) AS category_avg_yearly_return
FROM returns r
INNER JOIN general g ON r.fund_id = g.fund_id
INNER JOIN category c ON g.category_id = c.category_id
GROUP BY fund_category
ORDER BY category_avg_yearly_return DESC;
#*/
