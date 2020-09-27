-- Unique countries
SELECT DISTINCT country_name FROM international_debt;

--  Number of unique countries
SELECT COUNT(DISTINCT country_name) AS total_countries FROM international_debt;

-- What are type of debts and number of occurence
SELECT indicator_name, COUNT(indicator_name) AS number_of_debt_names FROM international_debt
GROUP BY indicator_name
HAVING COUNT(indicator_name) != 0
ORDER BY number_of_debt_names DESC;

-- What are type of debts in 2019

-- What are the top 10 type of debts in 2019 for each country


--  Total Debt
SELECT country_name, SUM(year_1970+year_1971+year_1972+year_1973+year_1974+year_1975+
	year_1976+year_1977+year_1978+year_1979+year_1980+year_1981+year_1982+year_1983+
	year_1984+year_1985+year_1986+year_1987+year_1988+year_1989+year_1990+year_1991+
	year_1992+year_1993+year_1994+	year_1995+	year_1996+	year_1997+year_1998+
	year_1999+year_2000+year_2001+year_2002+year_2003+year_2004+year_2005+year_2006+	
	year_2007+year_2008+year_2009+year_2010+year_2011year_2012+year_2013+year_2014+
	year_2015+year_2016+year_2017+year_2018+year_2019) 
AS total_debt FROM international_debt
GROUP BY country_name
ORDER BY total_debt DESC;