# Research Analysis

### Research Questions
- Which funds performed best over the period of time?
- Which funds have the highest average daily trading volume?
- What is the largest single-day growth experienced by a fund? Month? Year?
- What is the average yearly growth of funds? By how much are the top funds able to outperform the average?

## #1: Which funds performed best over the period of time?
#### Query
```sql
SELECT fund_symbol, ROUND((fund_return_2020 + fund_return_2019 + fund_return_2018 + fund_return_2017 + fund_return_2016 + fund_return_2015 + fund_return_2014 + fund_return_2013 + fund_return_2012 + fund_return_2011 + fund_return_2010 + fund_return_2009 + fund_return_2008 + fund_return_2007 + fund_return_2006 + fund_return_2005 + fund_return_2004 + fund_return_2003 + fund_return_2002 + fund_return_2001 + fund_return_2000) / 21, 4) AS avg_yearly_return
FROM returns r
INNER JOIN general g ON r.fund_id = g.fund_id
ORDER BY avg_yearly_return DESC
LIMIT 10;
```
### Results
![Query 1 Results](/Resources/Query_1_Results.png)

### Findings
The best performing ETF in the dataset is the 'BlackRock International Impact Fund Investor A' (UCC) which averaged an 18.27% return over its lifetime. The next best performing funds were 'Auxier Focus Fund Institutional' (PNQI) and 'Brown Advisory Small-Cap Fundamental Value Fund Institutional Shares' (RXL), which averaged returns of 16.79% and 14.67%, respectively.
