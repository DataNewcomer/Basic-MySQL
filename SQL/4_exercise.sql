USE world;


# No.1 
WITH 
    Total_Bahasa AS (
        SELECT 
            C.Name AS Country_Name,
            COUNT(CL.Language) AS Total_Language
        FROM 
            Country C
        JOIN 
            Countrylanguage CL ON C.Code = CL.CountryCode
        GROUP BY Country_Name)

SELECT * 
FROM Total_Bahasa
WHERE Total_Language > (SELECT AVG(Total_Language) FROM Total_Bahasa)
ORDER BY Total_Language DESC
LIMIT 10;

#------------------------------------------------------------------------------
# No.2
SELECT 
    Name,
    GovernmentForm,
    SUM(Population) OVER() AS World_Population,
    Population,
    Population / SUM(Population) OVER() * 100 AS Pop_Percentage,
    ROW_NUMBER() OVER() AS Row_Index
FROM 
    Country
ORDER BY 
    Pop_Percentage DESC
;



#------------------------------------------------------------------------------
# No.3
WITH 
    City_Count AS (
        SELECT 
			co.Code,
            co.Name,
			COUNT(ci.Name) AS Number_of_City
        FROM City ci
        JOIN Country co ON ci.CountryCode = co.Code
        GROUP BY CountryCode)

SELECT 
    C.Continent,
    C.Region,
    SUM(CT.Number_of_City) AS Number_of_City,
    ROW_NUMBER() OVER (PARTITION BY C.Continent) AS Row_Group
FROM 
    Country C, 
    City_Count CT
WHERE 
    C.Code = CT.Code 
AND 
	C.Continent IN ('Asia', 'Europe')
GROUP BY Region
;




#------------------------------------------------------------------------------
# No.3 Cara lain

SELECT 
    co.Continent,
    co.Region,
    count(ci.Name) AS Number_of_City,
    ROW_NUMBER() OVER (PARTITION BY co.Continent) AS Row_Group
    # RANK() OVER(PARTITION BY continent ORDER BY count(ci.Name) DESC)  as Rank_Number_of_City
FROM 
    Country co    
JOIN 
	City ci
	ON co.Code = ci.CountryCode 
GROUP BY co.Region
HAVING 
	co.Continent IN ('Asia', 'Europe')
;

SELECT *
FROM Country co    
JOIN City ci ON co.Code = ci.CountryCode 
;


#------------------------------------------------------------------------------
# No.4

SELECT 
    co.Continent,
    SUM(ci.Population) AS Total_Capital_Population,
    AVG(co.GNP) AS Average_GNP,
    RANK() OVER (ORDER BY SUM(ci.Population) DESC) AS Rank_Population,
    RANK() OVER (ORDER BY AVG(co.GNP) DESC) AS Rank_GNP
FROM 
    City ci 
JOIN 
    Country co
    ON co.Capital = ci.Id
GROUP BY Continent
ORDER BY Rank_Population, Rank_GNP
;


#------------------------------------------------------------------------------
# No. 5

WITH 
    GNP_Table AS (
        SELECT 
            Name AS Country_Name,            
            GNP,
            SUM(GNP) OVER() as Total_GNP,
            ROUND(GNP / SUM(GNP) OVER () * 100, 2) AS GNP_Percentage
        FROM 
            Country
        ORDER BY 
            GNP_Percentage DESC
        )

SELECT 
    Country_Name,
    GNP_Percentage,
    ROUND(SUM(GNP_Percentage) OVER (ORDER BY GNP_Percentage DESC ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW), 2) AS Cumulative_GNP,
    RANK() OVER (ORDER BY GNP_Percentage DESC) AS GNP_Rank,
    NTILE(4) OVER () AS Market_Priority_1234 
FROM 
    GNP_Table
WHERE 
	GNP_Percentage > 1
;

