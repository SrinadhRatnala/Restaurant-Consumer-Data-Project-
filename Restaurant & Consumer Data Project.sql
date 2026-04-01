CREATE TABLE consumers (
    Consumer_ID VARCHAR(10) PRIMARY KEY,
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Smoker VARCHAR(20),
    Drink_Level VARCHAR(50),
    Transportation_Method VARCHAR(50),
    Marital_Status VARCHAR(50),
    Children VARCHAR(50),
    Age INT,
    Occupation VARCHAR(100),
    Budget VARCHAR(20)
);

CREATE TABLE restaurants (
    Restaurant_ID INT PRIMARY KEY,
    Name VARCHAR(150),
    City VARCHAR(100),
    State VARCHAR(100),
    Country VARCHAR(100),
    Zip_Code VARCHAR(20),
    Latitude DECIMAL(9,6),
    Longitude DECIMAL(9,6),
    Alcohol_Service VARCHAR(50),
    Smoking_Allowed VARCHAR(50),
    Price VARCHAR(20),
    Franchise VARCHAR(20),
    Area VARCHAR(50),
    Parking VARCHAR(50)
);

CREATE TABLE consumer_preferences (
    Consumer_ID VARCHAR(10),
    Preferred_Cuisine VARCHAR(100),
    PRIMARY KEY (Consumer_ID, Preferred_Cuisine),
    FOREIGN KEY (Consumer_ID) REFERENCES consumers(Consumer_ID)
);

CREATE TABLE restaurant_cuisines (
    Restaurant_ID INT,
    Cuisine VARCHAR(100),
    PRIMARY KEY (Restaurant_ID, Cuisine),
    FOREIGN KEY (Restaurant_ID) REFERENCES restaurants(Restaurant_ID)
);

CREATE TABLE ratings (
    Consumer_ID VARCHAR(10),
    Restaurant_ID INT,
    Overall_Rating INT,
    Food_Rating INT,
    Service_Rating INT,
    PRIMARY KEY (Consumer_ID, Restaurant_ID),
    FOREIGN KEY (Consumer_ID) REFERENCES consumers(Consumer_ID),
    FOREIGN KEY (Restaurant_ID) REFERENCES restaurants(Restaurant_ID)
);

SELECT COUNT(*) FROM consumers;

SELECT COUNT(*) FROM consumer_preferences;
SELECT COUNT(*) FROM restaurant_cuisines;
SELECT COUNT(*) FROM ratings;
SELECT COUNT(*) FROM restaurants;

SELECT * FROM consumers
WHERE CITY = 'Cuernavaca';

SELECT * FROM consumers;

SELECT Consumer_ID, Age, Occupation
From consumers
WHERE Occupation = 'Student' AND
Smoker = 'Yes';

SELECT * FROM restaurants;

SELECT Name, City, Alcohol_Service, Price
FROM restaurants
WHERE Alcohol_Service = 'Wine & Beer' AND Price = 'Medium'; 

SELECT Name, City
FROM restaurants
WHERE Franchise = 'Yes';

SELECT * FROM ratings;

SELECT Consumer_ID, Restaurant_ID, Overall_Rating
FROM ratings
WHERE Overall_Rating = '2';


SELECT DISTINCT r.Name, r.City
FROM restaurants r
JOIN Ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rt.Overall_Rating = 2;


SELECT DISTINCT c.Consumer_ID, c.Age
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
JOIN Restaurants rest ON r.Restaurant_ID = rest.Restaurant_ID
WHERE rest.city = 'San Luis Potosi';


SELECT * FROM restaurant_cuisines; 


SELECT DISTINCT r.Name
FROM restaurants r 
JOIN restaurant_cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
JOIN ratings rt ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
AND rt.Consumer_ID = 'U1001';

SELECT * FROM restaurant_cuisines;

SELECT c.*, cp.Preferred_Cuisine
FROM consumers c
JOIN consumer_preferences cp ON c.Consumer_ID = cp.Consumer_ID
WHERE cp.Preferred_Cuisine = 'American' 
  AND c.Budget = 'Medium';
  
SELECT Name, City
FROM restaurants
WHERE Restaurant_ID IN (
    SELECT Restaurant_ID
    FROM ratings
    WHERE Food_Rating < (SELECT AVG(Food_Rating) FROM ratings)
);

SELECT DISTINCT c.Consumer_ID, c.Age, c.Occupation
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Consumer_ID NOT IN (
    SELECT DISTINCT r2.Consumer_ID
    FROM ratings r2
    JOIN restaurant_cuisines rc ON r2.Restaurant_ID = rc.Restaurant_ID
    WHERE rc.Cuisine = 'Italian'
);

SELECT DISTINCT res.Name
FROM restaurants res
JOIN ratings rat ON res.Restaurant_ID = rat.Restaurant_ID
JOIN consumers con ON rat.Consumer_ID = con.Consumer_ID
WHERE con.Age > 30;

SELECT DISTINCT c.Consumer_ID, c.Occupation
FROM consumers c
JOIN consumer_preferences cp ON c.Consumer_ID = cp.Consumer_ID
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE cp.Preferred_Cuisine = 'Mexican'
  AND r.Overall_Rating = 0;
  
SELECT DISTINCT r.Name, r.City
FROM restaurants r
JOIN restaurant_cuisines rc ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rc.Cuisine = 'Pizzeria'
AND r.City IN (
    SELECT DISTINCT City
    FROM consumers
    WHERE Occupation = 'Student'
);

SELECT DISTINCT c.Consumer_ID, c.Age
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
JOIN restaurants res ON r.Restaurant_ID = res.Restaurant_ID
WHERE c.Drink_Level = 'Social Drinker'
  AND res.Parking = 'None';
  
SELECT c.Consumer_ID, COUNT(r.Restaurant_ID) AS Rated_Count
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Occupation = 'Student'
GROUP BY c.Consumer_ID
HAVING COUNT(r.Restaurant_ID) > 2;

SELECT Consumer_ID, Age, (Age / 10) AS Engagement_Score
FROM consumers
WHERE (Age / 10) = 2 
  AND Transportation_Method = 'Public';
  
SELECT res.Name, res.City, AVG(rat.Overall_Rating) AS Avg_Overall_Rating
FROM restaurants res
JOIN ratings rat ON res.Restaurant_ID = rat.Restaurant_ID
WHERE res.City = 'Cuernavaca'
GROUP BY res.Name, res.City
HAVING AVG(rat.Overall_Rating) > 1.0;

SELECT DISTINCT c.Consumer_ID, c.Age
FROM consumers c
JOIN ratings r ON c.Consumer_ID = r.Consumer_ID
WHERE c.Marital_Status = 'Married'
  AND r.Food_Rating = r.Service_Rating
  AND r.Overall_Rating = 2;
  
SELECT DISTINCT
    c.Consumer_ID,
    c.Age,
    r.Name AS Restaurant_Name
FROM consumers c
JOIN ratings rt
    ON c.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
    ON rt.Restaurant_ID = r.Restaurant_ID
WHERE c.Occupation = 'Employed'
  AND rt.Food_Rating = 0
  AND r.City = 'Ciudad Victoria';
  
WITH SanLuisConsumers AS (
    SELECT Consumer_ID, Age
    FROM consumers
    WHERE City = 'San Luis Potosi'
)

SELECT DISTINCT
    s.Consumer_ID,
    s.Age,
    r.Name AS Restaurant_Name
FROM SanLuisConsumers s
JOIN ratings rt
    ON s.Consumer_ID = rt.Consumer_ID
JOIN restaurants r
    ON rt.Restaurant_ID = r.Restaurant_ID
JOIN restaurant_cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
WHERE rt.Overall_Rating = 2
  AND rc.Cuisine = 'Mexican';
  
SELECT 
    c.Occupation,
    AVG(c.Age) AS Average_Age
FROM consumers c
JOIN (
    SELECT DISTINCT Consumer_ID
    FROM ratings
) r
ON c.Consumer_ID = r.Consumer_ID
GROUP BY c.Occupation;

WITH CuernavacaRatings AS (
    SELECT 
        r.Restaurant_ID,
        r.Consumer_ID,
        r.Overall_Rating
    FROM ratings r
    JOIN restaurants res
        ON r.Restaurant_ID = res.Restaurant_ID
    WHERE res.City = 'Cuernavaca'
)

SELECT
    Restaurant_ID,
    Consumer_ID,
    Overall_Rating,
    RANK() OVER (
        PARTITION BY Restaurant_ID
        ORDER BY Overall_Rating DESC
    ) AS RatingRank
FROM CuernavacaRatings;

SELECT
    Consumer_ID,
    Restaurant_ID,
    Overall_Rating,
    AVG(Overall_Rating) OVER (
        PARTITION BY Consumer_ID
    ) AS Avg_Overall_Rating_By_Consumer
FROM ratings;

WITH LowBudgetStudents AS (
    SELECT Consumer_ID
    FROM consumers
    WHERE Budget = 'Low'
      AND Occupation = 'Student'
)

SELECT *
FROM (
    SELECT
        cp.Consumer_ID,
        cp.Preferred_Cuisine,
        ROW_NUMBER() OVER (
            PARTITION BY cp.Consumer_ID
            ORDER BY cp.Consumer_ID, cp.Preferred_Cuisine
        ) AS CuisineRank
    FROM consumer_preferences cp
    JOIN LowBudgetStudents lbs
        ON cp.Consumer_ID = lbs.Consumer_ID
) ranked
WHERE CuisineRank <= 3;

SELECT
    Restaurant_ID,
    Overall_Rating,
    LEAD(Overall_Rating) OVER (
        ORDER BY Restaurant_ID
    ) AS Next_Overall_Rating
FROM (
    SELECT
        Restaurant_ID,
        Overall_Rating
    FROM ratings
    WHERE Consumer_ID = 'U1008'
) AS ConsumerRatings;

DROP VIEW HighlyRatedMexicanRestaurants;

CREATE VIEW HighlyRatedMexicanRestaurants AS
SELECT
    r.Restaurant_ID,
    r.Name,
    r.City
FROM restaurants r
JOIN restaurant_cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
JOIN ratings rt
    ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(rt.Overall_Rating) > 1.5;

SELECT * FROM highlyratedmexicanrestaurants;


CREATE OR REPLACE VIEW HighlyRatedMexicanRestaurants AS
SELECT
    r.Restaurant_ID,
    r.Name,
    r.City
FROM restaurants r
JOIN restaurant_cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
JOIN ratings rt
    ON r.Restaurant_ID = rt.Restaurant_ID
WHERE rc.Cuisine = 'Mexican'
GROUP BY r.Restaurant_ID, r.Name, r.City
HAVING AVG(rt.Overall_Rating) > 1.5;


SELECT * FROM HighlyRatedMexicanRestaurants;

SELECT DISTINCT Consumer_ID
FROM consumer_preferences
WHERE Preferred_Cuisine = 'Mexican';

SELECT DISTINCT r.Consumer_ID
FROM ratings r
JOIN HighlyRatedMexicanRestaurants h
ON r.Restaurant_ID = h.Restaurant_ID;

SELECT COUNT(*)
FROM (
    SELECT DISTINCT Consumer_ID
    FROM consumer_preferences
    WHERE Preferred_Cuisine = 'Mexican'
) m;

SELECT COUNT(DISTINCT r.Consumer_ID)
FROM ratings r
JOIN HighlyRatedMexicanRestaurants h
    ON r.Restaurant_ID = h.Restaurant_ID
WHERE r.Consumer_ID IN (
    SELECT Consumer_ID
    FROM consumer_preferences
    WHERE Preferred_Cuisine = 'Mexican'
);

DELIMITER //

DROP PROCEDURE IF EXISTS GetRestaurantRatingsAboveThreshold;

DELIMITER //

CREATE PROCEDURE GetRestaurantRatingsAboveThreshold (
    IN p_Restaurant_ID VARCHAR(10),
    IN p_Min_Overall_Rating INT
)
BEGIN
    SELECT 
        Consumer_ID,
        Overall_Rating,
        Food_Rating,
        Service_Rating
    FROM ratings
    WHERE Restaurant_ID = p_Restaurant_ID
      AND Overall_Rating >= p_Min_Overall_Rating;
END //

DELIMITER ;

CALL GetRestaurantRatingsAboveThreshold('R101', 2);

WITH RestaurantAvgRatings AS (
    SELECT
        rc.Cuisine,
        r.Restaurant_ID,
        r.Name AS Restaurant_Name,
        r.City,
        AVG(rt.Overall_Rating) AS Avg_Overall_Rating
    FROM restaurants r
    JOIN restaurant_cuisines rc
        ON r.Restaurant_ID = rc.Restaurant_ID
    JOIN ratings rt
        ON r.Restaurant_ID = rt.Restaurant_ID
    GROUP BY rc.Cuisine, r.Restaurant_ID, r.Name, r.City
)

SELECT
    Cuisine,
    Restaurant_Name,
    City,
    Avg_Overall_Rating
FROM (
    SELECT *,
           DENSE_RANK() OVER (
               PARTITION BY Cuisine
               ORDER BY Avg_Overall_Rating DESC
           ) AS RatingRank
    FROM RestaurantAvgRatings
) ranked
WHERE RatingRank <= 2;

CREATE OR REPLACE VIEW ConsumerAverageRatings AS
SELECT
    Consumer_ID,
    AVG(Overall_Rating) AS Avg_Overall_Rating
FROM ratings
GROUP BY Consumer_ID;

WITH TopConsumers AS (
    SELECT
        Consumer_ID,
        Avg_Overall_Rating,
        DENSE_RANK() OVER (
            ORDER BY Avg_Overall_Rating DESC
        ) AS RatingRank
    FROM ConsumerAverageRatings
)

SELECT
    tc.Consumer_ID,
    tc.Avg_Overall_Rating,
    COUNT(DISTINCT r.Restaurant_ID) AS Mexican_Restaurants_Rated
FROM TopConsumers tc
LEFT JOIN ratings r
    ON tc.Consumer_ID = r.Consumer_ID
LEFT JOIN restaurant_cuisines rc
    ON r.Restaurant_ID = rc.Restaurant_ID
    AND rc.Cuisine = 'Mexican'
WHERE tc.RatingRank <= 5
GROUP BY tc.Consumer_ID, tc.Avg_Overall_Rating
ORDER BY tc.Avg_Overall_Rating DESC;

DELIMITER //

CREATE PROCEDURE GetConsumerSegmentAndRestaurantPerformance (
    IN p_Consumer_ID VARCHAR(10)
)
BEGIN

    -- Step 1: Determine Spending Segment
    SELECT 
        Consumer_ID,
        CASE 
            WHEN Budget = 'Low' THEN 'Budget Conscious'
            WHEN Budget = 'Medium' THEN 'Moderate Spender'
            WHEN Budget = 'High' THEN 'Premium Spender'
            ELSE 'Unknown Budget'
        END AS Spending_Segment
    FROM consumers
    WHERE Consumer_ID = p_Consumer_ID;


    -- Step 2: Restaurant performance analysis
    SELECT
        r.Name AS Restaurant_Name,
        rt.Overall_Rating AS Consumer_Rating,
        AVG(all_rt.Overall_Rating) AS Restaurant_Avg_Rating,

        CASE
            WHEN rt.Overall_Rating > AVG(all_rt.Overall_Rating)
                THEN 'Above Average'
            WHEN rt.Overall_Rating = AVG(all_rt.Overall_Rating)
                THEN 'At Average'
            ELSE 'Below Average'
        END AS Performance_Flag,

        DENSE_RANK() OVER (
            ORDER BY rt.Overall_Rating DESC
        ) AS Rating_Rank

    FROM ratings rt
    JOIN restaurants r
        ON rt.Restaurant_ID = r.Restaurant_ID

    -- Join again to calculate overall restaurant average
    JOIN ratings all_rt
        ON rt.Restaurant_ID = all_rt.Restaurant_ID

    WHERE rt.Consumer_ID = p_Consumer_ID

    GROUP BY
        r.Restaurant_ID,
        r.Name,
        rt.Overall_Rating

    ORDER BY Rating_Rank;

END //

DELIMITER ;