SELECT * FROM road_accident.accident_data;
-- 1. How many total records are there in the accident database?
SELECT 
    COUNT(Accident_ID) AS Total_Accident
FROM
    accident_data;
    
-- Display the top 5 records(Casualties_Count)
SELECT 
    *
FROM
    accident_data
ORDER BY Casualties_Count DESC
LIMIT 5;
use Road_Accident;
-- 3 How many accidents occurred each year?
SELECT 
    YEAR(STR_TO_DATE(Date_Time, '%m/%d/%Y %h:%i:%s %p')) AS Year,
    COUNT(Accident_ID) AS TotalAccident
FROM
    accident_data
GROUP BY Year
ORDER BY Year;

-- 3. How many accidents happened in the morning (6 AM - 12 PM), afternoon (12 PM - 6 PM), and night (6 PM - 6 AM)?
SELECT 
    CASE
        WHEN HOUR(STR_TO_DATE(Date_Time, '%m/%d/%Y %h:%i:%s %p')) BETWEEN 6 AND 11 THEN 'Morning (6am to 12 pm)'
        WHEN HOUR(STR_TO_DATE(Date_Time, '%m/%d/%Y %h:%i:%s %p')) BETWEEN 12 AND 17 THEN 'Afternoon (12pm to 6 pm)'
        ELSE 'Night (6 pm to 6am)'
    END AS Time_period,
    COUNT(Accident_ID) AS Total_Count
FROM
    accident_data
WHERE
    Date_Time IS NOT NULL
GROUP BY Time_period
ORDER BY FIELD(Time_Period,
        'Morning (6 AM - 12 PM)','Afternoon (12 PM - 6 PM)','Night (6 PM - 6 AM)');
        
-- 	How many accidents are categorized by severity (Minor, Moderate, Severe)?
SELECT 
    Severity, COUNT(Severity) TotalCount
FROM
    accident_data
GROUP BY Severity;

-- 	In which months did the most severe accidents occur?
SELECT 
    MONTHNAME(STR_TO_DATE(Date_Time, '%m/%d/%Y %h:%i:%s %p')) AS Month,
    COUNT(Accident_ID) AS Total_Accident
FROM
    accident_data
GROUP BY Month
order by Total_Accident desc;

-- 	Which city had the highest number of accidents?
SELECT 
    Location, COUNT(Accident_ID) AS Total_Accident
FROM
    accident_data
GROUP BY Location
ORDER BY Total_Accident DESC
LIMIT 1;

-- Which location had the least number of accidents?
SELECT 
    Location, COUNT(Accident_ID) AS Total_Accident
FROM
    accident_data
GROUP BY Location
ORDER BY Total_Accident asc
LIMIT 1;
-- During which weather condition did the most accidents occur?
select Weather_Condition , COUNT(Accident_ID) AS Total_Accident
from accident_data
group by Weather_Condition
order by Total_Accident desc
limit 1;

-- o	What is the accident ratio on wet roads vs. dry roads?
SELECT 
    SUM(CASE
        WHEN Road_Condition = 'Wet' THEN 1
        ELSE 0
    END) AS Wet_Road_Condition,
    SUM(CASE
        WHEN Road_Condition = 'Dry' THEN 1
        ELSE 0
    END) AS Dry_Road_Condition,
    ROUND(SUM(CASE
                WHEN Road_Condition = 'Wet' THEN 1
                ELSE 0
            END) / SUM(CASE
                WHEN Road_Condition = 'Dry' THEN 1
                ELSE 0
            END),
            2) AS Ratio
FROM
    accident_data;
    
    -- 	Which vehicle type was involved in the most accidents?
    SELECT 
    Vehicle_Type, COUNT(Accident_ID) AS Total_Accident
FROM
    accident_data
GROUP BY Vehicle_Type
ORDER BY Total_Accident DESC;
-- o	What is the accident pattern based on driver age groups? (e.g., 18-25, 26-40, 41-60)
select
case
when Driver_Age between 18 and 25 then '18 to 25'
when Driver_Age between 26 and 40 then '26 to 40'
when Driver_Age between 41 and 60 then '41 to 60'
else '60+'
end as Age_Group,
COUNT(Accident_ID) AS Total_Accident
From accident_data
group by Age_Group
order by Total_Accident desc;

-- o	How many accidents resulted in 3 or more casualties?
SELECT 
    COUNT(Casualties_Count) AS Casualties_Count
FROM
    accident_data
WHERE
    Casualties_Count >= 3;
    
    -- o	Which accident cause led to the highest number of casualties?
    SELECT 
    Casualties_Count, COUNT(Casualties_Count) AS NoOfcasualties
FROM
    accident_data
GROUP BY Casualties_Count
ORDER BY NoOfcasualties DESC;