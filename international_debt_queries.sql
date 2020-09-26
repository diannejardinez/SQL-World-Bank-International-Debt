-- Unique countries
SELECT DISTINCT country_name FROM international_debt

--  Number of unique countries
SELECT COUNT(DISTINCT country_name) AS total_countries FROM international_debt;

-- What are type of debts and number of occurence
SELECT indicator_name, COUNT(indicator_name) AS number_of_debt_names FROM international_debt
GROUP BY indicator_name
ORDER BY number_of_debt_names DESC;