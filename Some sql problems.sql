--ques 1
SELECT
	app_id,
	SUM(IF (event_id = 'click', 1, 0))/ SUM( IF(event_id = 'impression', 1,0)) AS CTR 
FROM events
WHERE timestamp > 01-01-2019
	AND timestamp < 01-01-2020
GROUP BY
	1;
	
--ques 2
SELECT
	u.city,
	COUNT(DISTINCT t.order_id) AS num_orders
FROM users u JOIN trades t
ON u.user_id = t.user_id
WHERE t.status = 'complete'
GROUP BY u.city
ORDER BY num_orders DESC
LIMIT 3;

--ques 3
SELECT
	user_id,
	SUM(IF (device_type = 'laptop', 1, 0)) AS laptop_viewership,
	SUM(IF (device_type IN ('phone', 'tablet') 1, 0)) AS mobile_viewership
FROM viewership;

--ques 4
SELECT 
	trans_date,
	product_id,
	SUM(spend) OVER(
	PARTITION BY product_id
	ORDER BY trans_date) 
	AS cumulative_spend
FROM 
	total_trans
ORDER BY 
	product_id,
	trans_date;
	
--ques 5
SELECT
	user_id,
	COUNT(product_id) AS num_products
FROM 
	user_transactions
GROUP BY 
	user_id
HAVING 
	SUM(spend) > 1000
ORDER BY 
	num_products DESC
LIMIT 10;

--ques 6
WITH user_post_count AS(
	SELECT
		users.user_id,
		COUNT(post_id) AS num_posts
	FROM users LEFT JOIN posts
	ON users.user_id = posts.user_id
	GROUP BY 1
)

SELECT
	num_posts,
	COUNT(*) AS num_users
FROM
	user_post_count
GROUP BY
	1;

--ques 7
SELECT
	num_tweets AS tweet_bucket,
	COUNT(*) AS num_users
FROM (
	SELECT 
		user_id,
		COUNT(tweet_id) AS num_tweets
	FROM
		tweets
	WHERE 
		tweet_date BETWEEN '01-01-2020' AND '31-12-2020'
	GROUP BY
		user_id
)AS user_tweet_count
GROUP BY 
	1
ORDER BY num_tweets;

--ques 8
SELECT
	COUNT(DISTINCT user_id)
FROM (
	SELECT
	user_id,
	RANK() OVER(
	PARTITION BY user_id,
		product_id
	ORDER BY 
		CAST(purchase_time AS DATE)
	)
	FROM purchases
) t
WHERE purchase_no = 2;

--ques 9
WITH job_listing_ranks AS(
	SELECT
		company_id,
		title,
		description,
		ROW_NUMBER() OVER (
		PARTITION BY company_id,
					title,
					description
		ORDER BY post_date
		)AS rank
	FROM job_listings
)

SELECT
	COUNT(DISTINCT company_id)
FROM(
	SELECT
		company_id
	FROM
		job_listings_ranks
	WHERE
		MAX(rank) > 1
);






























