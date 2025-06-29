select * from marketing_campaign
where education = 'graduation'

select * from marketing_campaign
where education = 'graduation'
order by year_birth

select year_birth,count(1) from marketing_campaign
where education = 'graduation'
group by year_birth
order by year_birth

SELECT 
    MIN(income) AS min_income,
    MAX(income) AS max_income,
    AVG(income) AS avg_income,
    PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY income) AS median_income
FROM marketing_campaign;

SELECT 
    education, 
    ROUND(AVG(income),2) AS avg_income
FROM marketing_campaign
GROUP BY education
ORDER BY avg_income DESC;

SELECT 
    marital_status, 
    ROUND(AVG(
        mntwines + mntfruits + mntmeatproducts + 
        mntfishproducts + mntsweetproducts + mntgoldprods
    ), 2) AS avg_total_spent
FROM marketing_campaign
GROUP BY marital_status
ORDER BY avg_total_spent DESC;

SELECT 
    'numstorepurchases' AS purchase_type, SUM(numstorepurchases) AS total
FROM marketing_campaign
UNION
SELECT 'numwebpurchases', SUM(numwebpurchases)
FROM marketing_campaign
UNION
SELECT 'numcatalogpurchases', SUM(numcatalogpurchases)
FROM marketing_campaign

SELECT 
    id, 
    recency,
    (mntwines + mntfruits + mntmeatproducts + 
     mntfishproducts + mntsweetproducts + mntgoldprods) AS total_spent
FROM marketing_campaign
WHERE recency > 90
  AND (mntwines + mntfruits + mntmeatproducts + 
       mntfishproducts + mntsweetproducts + mntgoldprods) < 100;

CREATE VIEW customer_profile AS
SELECT 
    id,
    income,
    (mntwines + mntfruits + mntmeatproducts + 
     mntfishproducts + mntsweetproducts + mntgoldprods) AS total_spent,
    recency,
    education,
    marital_status
FROM marketing_campaign;

SELECT * FROM customer_profile WHERE total_spent > 1000 ORDER BY income DESC;

CREATE INDEX idx_recency ON marketing_campaign(recency);
CREATE INDEX idx_education ON marketing_campaign(education);
CREATE INDEX idx_marital_status ON marketing_campaign(marital_status);
