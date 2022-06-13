preprocessor = make_column_transformer(
    (StandardScaler(),
     make_column_selector(dtype_include=np.number)),
    (OneHotEncoder(sparse=False),
     make_column_selector(dtype_include=object)),
)


SELECT DATE_PART('year',DATE_TRUNC('year', occurred_at)) AS Ano, 
SUM(total_amt_usd) AS "Total anual" 
FROM orders
GROUP BY DATE_TRUNC('year', occurred_at)
ORDER BY 2;

SELECT DATE_PART('month', DATE_TRUNC('month', occurred_at)) AS Mes,                            
DATE_PART('year', DATE_TRUNC('month', occurred_at)) AS Ano,                                           
SUM(total_amt_usd) AS "Total anual" 
FROM orders
GROUP BY DATE_TRUNC('month', occurred_at)
ORDER BY 3 DESC;

SELECT DATE_PART('year', DATE_TRUNC('year', occurred_at)), count(*) 
FROM orders
GROUP BY DATE_TRUNC('year', occurred_at)
ORDER BY 2 DESC;

SELECT DATE_PART('month', DATE_TRUNC('month', occurred_at)), count(*) 
FROM orders
GROUP BY DATE_TRUNC('month', occurred_at)
ORDER BY 2 DESC;

SELECT a.name, DATE_PART('year', DATE_TRUNC('month', occurred_at)) mes, DATE_PART('month', DATE_TRUNC('month', occurred_at)) ano, SUM(gloss_amt_usd)
FROM accounts a
INNER JOIN orders o
on a.id = o.account_id
WHERE a.name = 'Walmart'
GROUP BY 1, DATE_TRUNC('month', occurred_at)
ORDER BY 4 DESC
LIMIT (1);




SELECT id, total_amt_usd, 
CASE
	WHEN (total_amt_usd > 3000) THEN 'Large'
	ELSE 'Small'
END
FROM orders;


SELECT CASE WHEN total >= 2000 THEN 'At Least 2000'
   WHEN total >= 1000 AND total < 2000 THEN 'Between 1000 and 2000'
   ELSE 'Less than 1000' END AS order_category,
COUNT(*) AS order_count
FROM orders
GROUP BY 1;


SELECT a.name as "Client_NAME", 
SUM(o.total_amt_usd) as "TOTAL_SALES_ORDERS", 
CASE
	WHEN SUM(o.total_amt_usd) > 200000 THEN 'TOP'
    WHEN SUM(o.total_amt_usd) >100000 THEN 'MIDDLE'
    WHEN SUM(o.total_amt_usd) < 100000 THEN 'LOW'
END
FROM accounts a
INNER JOIN orders o
on o.account_id = a.id
GROUP BY 1
ORDER BY 2 DESC;


SELECT a.name as "Client_NAME", 
SUM(o.total_amt_usd) as "TOTAL_SALES_ORDERS", 
CASE
	WHEN SUM(o.total_amt_usd) > 200000 THEN 'TOP'
    WHEN SUM(o.total_amt_usd) >100000 THEN 'MIDDLE'
    WHEN SUM(o.total_amt_usd) < 100000 THEN 'LOW'
END
FROM accounts a
INNER JOIN orders o
on o.account_id = a.id
WHERE o.occurred_at BETWEEN '2016-01-01' AND '2017-12-31'
GROUP BY 1
ORDER BY 2 DESC;

SELECT sr.name, count(o.*) as "TOTAL_ORDERS",
CASE
	WHEN count(o.*) > 200 THEN 'TOP'
    ELSE 'NOT'
END as "TOP or NOT"
FROM orders o
INNER JOIN accounts a
on a.id = o.account_id
INNER JOIN sales_reps sr
on a.sales_rep_id = sr.id
GROUP BY sr.name
ORDER BY 2 DESC;

SELECT sr.name, count(o.*) as "TOTAL_ORDERS", SUM(o.total_amt_usd) "TOTAL_SALES", 
CASE
	WHEN count(o.*) > 200 OR SUM(o.total_amt_usd) > 750000 THEN 'TOP'
    WHEN  count(o.*) > 150 OR SUM(o.total_amt_usd) > 500000 THEN 'MIDDLE'
    ELSE 'LOW'
END as "TOP, MIDDLE or LOW"
FROM orders o
INNER JOIN accounts a
on a.id = o.account_id
INNER JOIN sales_reps sr
on a.sales_rep_id = sr.id
GROUP BY sr.name
ORDER BY 2 DESC;




SELECT DATE_TRUNC('day', occurred_at) as DIA, channel, COUNT (*)
FROM web_events
GROUP BY 2, 1
ORDER BY 3 DESC;


SELECT channel, AVG(total)
FROM
(SELECT DATE_TRUNC('day', occurred_at) as DIA, channel, COUNT (*) as total
FROM web_events
GROUP BY 2, 1) sub1
GROUP BY 1
ORDER BY 2 DESC;


SELECT AVG(gloss_qty) AS GLOSS_AVG, AVG(standard_qty) AS STD_AVG , AVG(poster_qty) AS POSTER_AVG
FROM orders o
WHERE DATE_PART('month', occurred_at) =
	DATE_PART('month', (SELECT DATE_TRUNC('month', 	   occurred_at)
	FROM orders o
	ORDER BY 1
	LIMIT (1))) 
AND DATE_PART('year', occurred_at) = 	
    DATE_PART('year', (SELECT DATE_TRUNC('year', 	   occurred_at) FROM orders o
	ORDER BY 1
	LIMIT (1))) 
	
	
	
	
	
SELECT sub2.region, sub3.name, sub2.max FROM
(SELECT region, MAX(sum) FROM
	(SELECT r.name Region, sr.name, SUM(o.total_amt_usd)
	  FROM sales_reps sr
	  INNER JOIN region r
	  ON r.id = sr.region_id
	  INNER JOIN accounts a
	  ON a.sales_rep_id = sr.id
	  INNER JOIN orders o
	  ON o.account_id = a.id
	  GROUP BY r.name,  sr.name
	 ORDER BY 3 desc) sub1
GROUP BY 1) sub2
INNER JOIN
(SELECT name, Region, MAX(sum) FROM
	(SELECT r.name Region, sr.name, SUM(o.total_amt_usd)
	  FROM sales_reps sr
	  INNER JOIN region r
	  ON r.id = sr.region_id
	  INNER JOIN accounts a
	  ON a.sales_rep_id = sr.id
	  INNER JOIN orders o
	  ON o.account_id = a.id
	  GROUP BY r.name,  sr.name
	 ORDER BY 3 desc) sub1
GROUP BY 1, 2) sub3
ON sub2.max = sub3.max AND sub2.Region = sub3.Region
ORDER BY 3 DESC


SELECT  count(o.*) 
FROM sales_reps sr
	  INNER JOIN region r
	  ON r.id = sr.region_id
	  INNER JOIN accounts a
	  ON a.sales_rep_id = sr.id
	  INNER JOIN orders o
	  ON o.account_id = a.id
WHERE r.name = SELECT region FROM
(SELECT sub2.region, sub3.name, sub2.max FROM
(SELECT region, MAX(sum) FROM
	(SELECT r.name Region, sr.name, SUM(o.total_amt_usd)
	  FROM sales_reps sr
	  INNER JOIN region r
	  ON r.id = sr.region_id
	  INNER JOIN accounts a
	  ON a.sales_rep_id = sr.id
	  INNER JOIN orders o
	  ON o.account_id = a.id
	  GROUP BY r.name,  sr.name
	 ORDER BY 3 desc) sub1
GROUP BY 1) sub2
INNER JOIN
(SELECT name, Region, MAX(sum) FROM
	(SELECT r.name Region, sr.name, SUM(o.total_amt_usd)
	  FROM sales_reps sr
	  INNER JOIN region r
	  ON r.id = sr.region_id
	  INNER JOIN accounts a
	  ON a.sales_rep_id = sr.id
	  INNER JOIN orders o
	  ON o.account_id = a.id
	  GROUP BY r.name,  sr.name
	 ORDER BY 3 desc) sub1
GROUP BY 1, 2) sub3
ON sub2.max = sub3.max AND sub2.Region = sub3.Region
ORDER BY 3 DESC
LIMIT (1)) s4


SELECT  COUNT(a.*) 
FROM accounts a
INNER JOIN orders o 
ON o.account_id = accounts.id
WHERE  o.total  >  (SELECT o.total, MAX(o.standard_qty)
  FROM orders o
  GROUP BY  o.total
  ORDER BY 2 DESC
  LIMIT (1)) sub1


SELECT COUNT (a.*) 
FROM accounts a
INNER JOIN orders o 
ON o.account_id = a.id
WHERE  o.total  >  (SELECT total FROM 
  (SELECT a.name, o.total, SUM(o.standard_qty)
  FROM orders o
  INNER JOIN accounts a
  ON a.id = o.account_id
  GROUP BY  1, 2
  ORDER BY 3 DESC
  LIMIT (1)) sub1)
  
  
  
  SELECT name, SUM(total)  AS "total_sum"
  FROM accounts a
INNER JOIN orders o
  ON a.id = o.account_id
  WHERE name = (SELECT name FROM
 ( SELECT name, SUM(o.standard_qty) AS "sum_std_qty"
  FROM accounts a
  INNER JOIN orders o
  ON a.id = o.account_id
  GROUP BY name
  ORDER BY 2 DESC
  LIMIT (1)) sub1)
  GROUP BY 1
  ORDER BY 2 DESC
  
  SELECT COUNT(*) FROM
(SELECT a.name, COUNT (*), SUM(o.total) 
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
HAVING SUM(o.total) > (SELECT total_sum FROM (  SELECT name, SUM(total)  AS "total_sum"
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
WHERE name = (SELECT name FROM
( SELECT name, SUM(o.standard_qty) AS "sum_std_qty"
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY name
ORDER BY 2 DESC
LIMIT (1)) sub1)
GROUP BY 1
ORDER BY 2 DESC) sub2)) sub3
44750

SELECT a.name, COUNT (*), SUM(o.total) 
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name
ORDER BY 3 DESC



SELECT account_id, total_amt_usd
FROM orders a
INNER JOIN accounts a



SELECT id FROM (SELECT a.name, a.id, SUM(o.total_amt_usd)
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY a.name, a.id
ORDER BY 3 DESC
LIMIT (1)) sub1

SELECT channel, COUNT(we.*)
FROM web_events we
INNER JOIN accounts a
ON a.id = we.account_id
WHERE we.account_id = (SELECT id FROM (SELECT a.name, a.id, SUM(o.total_amt_usd)
												FROM accounts a
												INNER JOIN orders o
												ON a.id = o.account_id
												GROUP BY a.name, a.id
												ORDER BY 3 DESC
												LIMIT (1)) sub1)
GROUP BY channel
ORDER BY count DESC





SELECT AVG(sum)
FROM (SELECT  a.name, SUM(o.total_amt_usd)
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY 1
ORDER BY 2 DESC
) top10_acc




SELECT  a.name, SUM(o.total_amt_usd)
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total_amt_usd) > (SELECT AVG(sum)
															FROM (SELECT  a.name, SUM(o.total_amt_usd)
															FROM accounts a
															INNER JOIN orders o
															ON a.id = o.account_id
															GROUP BY 1
															ORDER BY 2 DESC
															) top10_acc)
ORDER BY 2 DESC

SELECT AVG(sum)
FROM (
SELECT  a.name, SUM(o.total_amt_usd)
FROM accounts a
INNER JOIN orders o
ON a.id = o.account_id
GROUP BY 1
HAVING SUM(o.total_amt_usd) > (SELECT AVG(sum)
															FROM (SELECT  a.name, SUM(o.total_amt_usd)
															FROM accounts a
															INNER JOIN orders o
															ON a.id = o.account_id
															GROUP BY 1
															ORDER BY 2 DESC
															) top10_acc)
ORDER BY 2 DESC) above_average



WITh domains AS(SELECT RIGHT(website, 3) AS DOMAIN
FROM accounts)
SELECT  domain, count(*)
from domains
group by domain
ORDER BY 2 DESC;


WITH "1st_letter" AS
	(SELECT left(name,1) as "1stletter" from accounts)
	SELECT "1stletter", COUNT(*)
	FROM "1st_letter"
	GROUP BY 1
	ORDER BY 2 DESC;

	WITH alfa_num AS (SELECT name, 
	CASE WHEN LEFT(name,1) IN ('0','1','2','3','4','5','6','7','8','9') THEN 'NUM'
			 ELSE 'ALFA'
		END "NUM/ALFA"
	FROM accounts)

	SELECT "NUM/ALFA", COUNT (*)
	from alfa_num
	GROUP BY 1

	WITH vowel AS (SELECT name, 
	CASE WHEN LEFT(name,1) IN ('A','E','I','O','U') THEN 'VOWEL'
			 ELSE 'OTHER'
		END "VOWEL/ELSE"
	FROM accounts)

	SELECT "VOWEL/ELSE", COUNT (*)
	from vowel
	GROUP BY 1

	POSITION(',' IN city_state)
	STRPOS(city_state, ',')


	SELECT LEFT(primary_poc, STRPOS(primary_poc, ' ')) AS FIRST_NAME, 
	RIGHT(primary_poc, LENGTH(primary_poc) - POSITION(' ' IN primary_poc)), 
	primary_poc, POSITION(' ' IN primary_poc)
FROM accounts

SELECT * 
FROM sf_crime_data
LIMIT (10);


SELECT date, SUBSTR(date,4,2) AS DAY,
SUBSTR(date, 7,4) AS YEAR,
LEFT(date, 2) AS MONTH,
SUBSTR(date, 7,4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date,4,2) AS CONC_DATE,
CAST(SUBSTR(date, 7,4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date,4,2) AS DATE) AS PROPER_DATE
FROM sf_crime_data
LIMIT (20)


SELECT date, SUBSTR(date,4,2) AS DAY,
SUBSTR(date, 7,4) AS YEAR,
LEFT(date, 2) AS MONTH,
SUBSTR(date, 7,4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date,4,2) AS CONC_DATE,
(SUBSTR(date, 7,4) || '-' || LEFT(date, 2) || '-' || SUBSTR(date,4,2)):: date AS PROPER_DATE
FROM sf_crime_data
LIMIT (20)

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;



SELECT standard_amt_usd, occurred_at,
SUM(standard_amt_usd) OVER (ORDER BY occurred_at)
FROM orders


SELECT standard_amt_usd, DATE_TRUNC('year', occurred_at),
SUM(standard_amt_usd) OVER (PARTITION BY DATE_TRUNC('year', occurred_at) ORDER BY occurred_at)
FROM orders

SELECT id, account_id, total,
RANK() OVER (PARTITION BY account_id ORDER BY total DESC) as total_rank
FROM orders


SELECT id,
       account_id,
       standard_qty,
       DATE_TRUNC('month', occurred_at) AS month,
       DENSE_RANK() OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS dense_rank,
       SUM(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS sum_std_qty,
       COUNT(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS count_std_qty,
       AVG(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS avg_std_qty,
       MIN(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS min_std_qty,
       MAX(standard_qty) OVER (PARTITION BY account_id ORDER BY DATE_TRUNC('month',occurred_at)) AS max_std_qty
FROM orders


SELECT id,
       account_id,
       DATE_TRUNC('year',occurred_at) AS year,
       DENSE_RANK() OVER account_year_window AS dense_rank,
       total_amt_usd,
       SUM(total_amt_usd) OVER account_year_window AS sum_total_amt_usd,
       COUNT(total_amt_usd) OVER account_year_window AS count_total_amt_usd,
       AVG(total_amt_usd) OVER account_year_window AS avg_total_amt_usd,
       MIN(total_amt_usd) OVER account_year_window AS min_total_amt_usd,
       MAX(total_amt_usd) OVER account_year_window AS max_total_amt_usd
FROM orders
WINDOW account_year_window AS (PARTITION BY account_id ORDER BY DATE_TRUNC('year',occurred_at))



SELECT occurred_at,
       total_amt_usd,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) AS lead,
       LEAD(total_amt_usd) OVER (ORDER BY occurred_at) - total_amt_usd AS LEAD_DIFFERENCE
FROM (
SELECT occurred_at, 
      SUM(total_amt_usd) AS total_amt_usd
  FROM orders 
 GROUP BY 1
 ) sub




SELECT account_id, occurred_at, standard_qty,
NTILE(4) OVER (PARTITION BY account_id ORDER BY standard_qty) AS standard_quartile
FROM orders
ORDER BY 1;


SELECT account_id, occurred_at, gloss_qty,
NTILE(2) OVER (PARTITION BY account_id ORDER BY gloss_qty) AS gloss_half
FROM orders
ORDER BY 1;


SELECT account_id, occurred_at, total_amt_usd,
NTILE(100) OVER (PARTITION BY account_id ORDER BY total_amt_usd) AS total_percentile
FROM orders
ORDER BY 1;


CONECTAR BD AO PYTHON

pip install sqlalchemy
pip install pymysql

from sqlalchemy import create_engine

db_host
username
user_pass
db_name


connection = create_engine('mysql+pymysql://'+username+':'+user_pass+'@'+db_host+'/'+db_name)
connection.table_names()

query = 'select * from orders'

pd.read_sql(query, connection) 


