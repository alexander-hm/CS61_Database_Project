# RESEARCH QUESTION 1
SELECT fund_symbol, fund_long_name, ROUND((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21, 4) AS avg_yearly_return
FROM returns r
INNER JOIN general g ON r.fund_id = g.fund_id
ORDER BY avg_yearly_return DESC
LIMIT 10;