-- Unique countries
SELECT DISTINCT country_name FROM international_debt
ORDER BY country_name ;

-- Delete 
-- IDA only (International Development Association (IDA))
-- Bosnia and Herzegovina, East Asia & Pacific(excluding high income)
-- Europe & Central Asia (excluding high income), Latin America & Caribbean (excluding high income)
--  Middle East & North Africa (excluding high income)
-- Sub-Saharan Africa (excluding high income)
DELETE FROM international_debt
WHERE country_name IN ('IDA only','Bosnia and Herzegovina', 'East Asia & Pacific (excluding high income)',
 'Europe & Central Asia (excluding high income)', 'Latin America & Caribbean (excluding high income)',
 'Middle East & North Africa (excluding high income)','Sub-Saharan Africa (excluding high income)', 'South Asia');

-- Removing repayment, payment, disbursements interested in debts owed
DELETE FROM international_debt
WHERE indicator_name LIKE ('%repayments%')
OR indicator_name LIKE ('%payment%')
OR indicator_name LIKE ('%Disbursements%');


-- Group/Create new table with income
-- Low & middle income, low income, lower middle income, middle income, upper iddle income
SELECT * INTO income_table
FROM international_debt
WHERE country_name IN ('Low & middle income', 'Low income', 'Lower middle income', 'Middle income', 'Upper middle income');

DELETE FROM international_debt
WHERE country_name IN ('Low & middle income', 'Low income', 'Lower middle income', 'Middle income', 'Upper middle income');

-- Removing grouped incomes
DELETE FROM income_table
WHERE country_name IN ('Low & middle income');

-- Removing repayment, payment, disbursements interested in debts owed
DELETE FROM income_table
WHERE indicator_name LIKE ('%repayments%')
OR indicator_name LIKE ('%payment%')
OR indicator_name LIKE ('%Disbursements%');

-- Create new table with 
-- Least developed countries: UN classification
SELECT * INTO least_developed
FROM international_debt
WHERE country_name IN ('Least developed countries: UN classification');


DELETE FROM international_debt
WHERE country_name IN ('Least developed countries: UN classification');


-- TABLE: international_debt --
-- Count of unique countries
SELECT COUNT(DISTINCT country_name ) FROM international_debt


-- Categorizing private and public debts
-- Source Link for private and public debt breakdown: https://blogs.worldbank.org/opendata/international-debt-statistics-2020-promoting-debt-transparency-through-newly-published
SELECT indicator_name,
CASE 
	WHEN indicator_name LIKE ('%private%') 
		OR indicator_name LIKE ('%stock%') 
		OR indicator_name LIKE ('%commercial%') THEN 'private debt'
	WHEN (indicator_name LIKE ('%public%')) 
		OR (indicator_name LIKE ('%bonds%')) 
		OR (indicator_name LIKE ('%official creditors%')) 
		OR (indicator_name LIKE ('%multilateral%'))
		OR (indicator_name LIKE ('%bilateral%')) THEN 'public debt'
	ELSE 'Other'
END AS type_of_debt
FROM international_debt
GROUP BY indicator_name
ORDER BY type_of_debt DESC;



-- What are type of debts in 2019
SELECT indicator_name, year_2019 FROM international_debt
WHERE year_2019 IS NOT NULL
GROUP BY indicator_name, year_2019
ORDER BY year_2019 DESC;


-- What are the top 10 type of debts in 2019 for each country
SELECT country_name, indicator_name, year_2019 FROM international_debt
WHERE year_2019 IS NOT NULL
GROUP BY country_name, indicator_name, year_2019
ORDER BY year_2019 DESC
LIMIT 10;

-- 


--  Total Debt
SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
	year_1992+year_1993+year_1994+year_1995+year_1996+	year_1997+year_1998+
	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
	year_2007+year_2008+year_2009+year_2010+year_2011+year_2012+year_2013+year_2014+
	year_2015+year_2016+year_2017+year_2018+year_2019) 
AS total_debt FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC;


-- -- Which country has the highest debt? Lowest?
-- SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
-- 	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
-- 	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
-- 	year_1992+year_1993+year_1994+year_1995+year_1996+	year_1997+year_1998+
-- 	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
-- 	year_2007+year_2008+year_2009+year_2010+year_2011+year_2012+year_2013+year_2014+
-- 	year_2015+year_2016+year_2017+year_2018+year_2019) 
-- AS total_debt FROM international_debt
-- GROUP BY country_name
-- ORDER BY total_debt DESC
-- LIMIT 1;


-- SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
-- 	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
-- 	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
-- 	year_1992+year_1993+year_1994+year_1995+year_1996+	year_1997+year_1998+
-- 	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
-- 	year_2007+year_2008+year_2009+year_2010+year_2011+year_2012+year_2013+year_2014+
-- 	year_2015+year_2016+year_2017+year_2018+year_2019) 
-- AS total_debt FROM international_debt
-- GROUP BY country_name
-- ORDER BY total_debt 
-- LIMIT 1;

-- -- Find the highest debt in each county. Lowest?
-- SELECT country_name, MAX(GREATEST(year_1970,year_1971,year_1972,year_1973,year_1974,year_1975,
-- 	year_1976,year_1977,year_1978,year_1979,year_1980,year_1981,year_1982,year_1983,
-- 	year_1984,year_1985,year_1986,year_1987,year_1988,year_1989,year_1990,year_1991,
-- 	year_1992,year_1993,year_1994,year_1995,year_1996, year_1997,year_1998,
-- 	year_1999,year_2000,year_2001,year_2002,year_2003,year_2004,year_2005,year_2006,	
-- 	year_2007,year_2008,year_2009,year_2010,year_2011,year_2012,year_2013,year_2014,
-- 	year_2015,year_2016,year_2017,year_2018,year_2019)) AS debt
-- 	FROM international_debt
-- 	GROUP BY country_name
-- 	ORDER BY debt DESC;


-- TABLE income_table

-- What are the top 10 type of debts in 2019 for each income level
SELECT indicator_name, year_2019 FROM income_table
WHERE year_2019 IS NOT NULL
GROUP BY indicator_name, year_2019
ORDER BY year_2019 DESC;


-- For the top type of debt in 2019, where does each income level stand?
SELECT country_name, year_2019 FROM income_table
WHERE indicator_name = 'PPG, private creditors (AMT, current US$)'
ORDER BY year_2019 DESC;

-- -- Which income level has the highest debt? Lowest?
-- SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
-- 	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
-- 	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
-- 	year_1992+year_1993+year_1994+year_1995+year_1996+	year_1997+year_1998+
-- 	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
-- 	year_2007+year_2008+year_2009+year_2010+year_2011+year_2012+year_2013+year_2014+
-- 	year_2015+year_2016+year_2017+year_2018+year_2019) 
-- AS total_debt FROM income_table
-- GROUP BY country_name
-- ORDER BY total_debt DESC
-- LIMIT 1;


-- SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
-- 	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
-- 	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
-- 	year_1992+year_1993+year_1994+year_1995+year_1996+	year_1997+year_1998+
-- 	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
-- 	year_2007+year_2008+year_2009+year_2010+year_2011+year_2012+year_2013+year_2014+
-- 	year_2015+year_2016+year_2017+year_2018+year_2019) 
-- AS total_debt FROM income_table
-- GROUP BY country_name
-- ORDER BY total_debt
-- LIMIT 1;




