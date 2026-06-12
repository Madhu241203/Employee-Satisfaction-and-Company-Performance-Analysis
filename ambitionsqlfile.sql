SHOW DATABASES;
CREATE database ambitionbox;
USE ambitionbox;
SELECT DATABASE();
DROP TABLE company_reviews;
CREATE TABLE IF NOT EXISTS company_reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    company_name VARCHAR(255),
    rating FLOAT,
    reviews INT,
    salaries INT,
    interviews INT,
    jobs INT,
    benefits INT,
    rating_category VARCHAR(50),
    Pros_Sentiment VARCHAR(20),
    Cons_Sentiment VARCHAR(20)
);

DESCRIBE company_reviews;

SHOW TABLES;

-- Most Reviewed Companies
SELECT company_name,AVG(rating) avg_rating FROM company_reviews GROUP BY company_name ORDER BY avg_rating DESC LIMIT 10;

-- Average Rating Category
SELECT company_name,
SUM(reviews)

FROM company_reviews

GROUP BY company_name

ORDER BY SUM(reviews) DESC;

-- Most common Pros Sentiments
SELECT Pros_Sentiment, COUNT(*) AS count
FROM company_reviews
GROUP BY Pros_Sentiment
ORDER BY count DESC;

-- Most common Cons Sentiments
SELECT Cons_Sentiment, COUNT(*) AS count
FROM company_reviews
GROUP BY Cons_Sentiment
ORDER BY count DESC;



-- Average Rating Company
SELECT rating_category,
COUNT(*)

FROM company_reviews

GROUP BY rating_category;

-- Total Number of Companies
SELECT COUNT(DISTINCT company_name) AS total_companies FROM company_reviews;

-- Companies with “Good” or positive Pros sentiment
SELECT company_name, Pros_Sentiment, rating
FROM company_reviews
WHERE Pros_Sentiment IN ('Good', 'Great', 'Excellent')
ORDER BY rating DESC;



-- Average Company Rating
SELECT ROUND(AVG(rating),2) AS avg_rating
FROM company_reviews;

-- Top 10 Rated Companies
SELECT company_name,
       ROUND(AVG(rating),2) AS avg_rating
FROM company_reviews
GROUP BY company_name
ORDER BY avg_rating DESC
LIMIT 10;

-- Top 10 companies by reviews
SELECT company_name,
       SUM(reviews) AS total_reviews
FROM company_reviews
GROUP BY company_name
ORDER BY total_reviews DESC
LIMIT 10;

--  Companies having Rating Above Average
SELECT company_name,
       rating
FROM company_reviews
WHERE rating >
(
    SELECT AVG(rating)
    FROM company_reviews
);

-- Highest Salary Offering companies
SELECT company_name,
       salaries
FROM company_reviews
ORDER BY salaries DESC
LIMIT 10;

-- Companies with most Job openings
SELECT company_name,
       jobs
FROM company_reviews
ORDER BY jobs DESC
LIMIT 10;

-- Companies with Benefits Above Average
SELECT company_name,
       benefits
FROM company_reviews
WHERE benefits >
(
    SELECT AVG(benefits)
    FROM company_reviews
);

-- Top Companies by Interviews
SELECT company_name,
       interviews
FROM company_reviews
ORDER BY interviews DESC
LIMIT 10;

-- Rank Companies by Rating
SELECT company_name,
       rating,
       RANK() OVER(ORDER BY rating DESC) AS ranking
FROM company_reviews;

-- Companies with Reviews greater than 1000
SELECT company_name,
       reviews
FROM company_reviews
WHERE reviews > 1000;

-- Find Companies having Both Ratings and Reviews
SELECT company_name,
       rating,
       reviews
FROM company_reviews
WHERE rating > 4
AND reviews > 1000
ORDER BY rating DESC;

-- Top5 Companies in Each Rating Category
SELECT *
FROM
(
    SELECT company_name,
           rating_category,
           rating,
           ROW_NUMBER() OVER(
               PARTITION BY rating_category
               ORDER BY rating DESC
           ) AS rn
    FROM company_reviews
) t
WHERE rn <= 5;

-- Dashboard KPI Query
SELECT
COUNT(DISTINCT company_name) AS Total_Companies,
ROUND(AVG(rating),2) AS Avg_Rating,
SUM(reviews) AS Total_Reviews,
SUM(jobs) AS Total_Jobs
FROM company_reviews;


-- classify companies based on their ratings

SELECT
company_name,
rating,
reviews,
jobs,
CASE
    WHEN rating >= 4 THEN 'Excellent'
    WHEN rating >= 3 THEN 'Good'
    ELSE 'Poor'
END AS company_performance
FROM company_reviews
ORDER BY rating DESC;

SELECT * FROM company_reviews;