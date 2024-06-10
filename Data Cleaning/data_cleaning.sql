--Cleaning Nest table and inputing into a new table Nest_Clean
SELECT * into [CEIP].[dbo].[Nest_Clean]
FROM [CEIP].[dbo].[Nest] 
WHERE
    dCropUtil != 0 AND dCropUtil IS NOT NULL AND 
    dPartArea != 0 AND dPartArea IS NOT NULL AND 
    dTrueArea != 0 AND dTrueArea IS NOT NULL AND 
    dLengthUsed != 0 AND dLengthUsed IS NOT NULL AND 
    dWidthUsed != 0 AND dWidthUsed IS NOT NULL AND
    cParts != 0 AND cParts IS NOT NULL AND
	dArea != 0 AND dArea IS NOT NULL AND
	dWidthUsed > 0 AND dLengthUsed > 0 AND
	fStrategies IN (0, 1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024, 2048, 4096, 8192, 16384, -2147483648); 
--(6758657 rows affected)

--Cleaning Part table and inputing into a new table Part_Clean
SELECT * INTO Part_Clean
FROM [CEIP].[dbo].[Part] 
WHERE
    dLength != 0 AND dLength IS NOT NULL AND 
    dWidth != 0 AND dWidth IS NOT NULL AND 
    dArea != 0 AND dArea IS NOT NULL AND 
    cnested != 0 AND cNested IS NOT NULL AND
	dWidth > 0 AND dLength > 0 AND dArea > 0 AND cNested > 0;
--(22931580 rows affected)

--------------------------------------------------------------------------------------------
--In some rows, dLengthUsed and dWidthUsed is more than the dLength and dWidth, so I�m choosing 
--a tolerance of 2 and deleting rows where the deviation is more than this
DELETE FROM Nest_Clean
WHERE dLengthUsed > dLength + 2
--(20166 rows affected)

DELETE FROM Nest_Clean
WHERE dWidthUsed > dWidth + 2
--(16610 rows affected)

--------------------------------------------------------------------------------------------
--Setting dLengthUsed = dLength and dWidthUsed = dWidth if difference is less than 2, 
--also setting dTrueArea = dArea (if dLengthUsed = dLength and dWidthUsed = dWidth)
UPDATE [CEIP].[dbo].[Nest_Clean]
SET dWidthUsed = dWidth
where dWidthUsed != dWidth and dWidthUsed - dWidth < 2.0 and dWidthUsed - dWidth > 0
--(265165 rows affected)

UPDATE [CEIP].[dbo].[Nest_Clean]
SET dLengthUsed = dLength
where dLengthUsed != dLength and dLengthUsed - dLength < 2.0 and dLengthUsed - dLength >  0 
--(156744 rows affected)

--------------------------------------------------------------------------------------------
--Now Altering the Table to set rectified values of dTrueArea and dArea
ALTER TABLE [CEIP].[dbo].[Nest_Clean]
ADD dTrueAreaRectified FLOAT;

UPDATE [CEIP].[dbo].[Nest_Clean]
SET dTrueAreaRectified = dLengthUsed * dWidthUsed;
--(6721881 rows affected)

ALTER TABLE [CEIP].[dbo].[Nest_Clean]
ADD dAreaRectified FLOAT;

UPDATE [CEIP].[dbo].[Nest_Clean]
SET dAreaRectified = dLength * dWidth;
--(6721881 rows affected)

--------------------------------------------------------------------------------------------
--Now Altering the Table to set rectified values of dCroputil
--[In ixNest 6296, dCropUtil = dPartArea/dArea
--But in ixNest 80719, dCropUtil = dPartArea/dTrueArea]


ALTER TABLE [CEIP].[dbo].[Nest_Clean]
ADD dCropUtilRectified FLOAT;

UPDATE [CEIP].[dbo].[Nest_Clean]
SET dCropUtilRectified = dPartArea / dTrueAreaRectified;
UPDATE [CEIP].[dbo].[Nest_Clean]
SET dCropUtilRectified = dCropUtilRectified * 100;
--(6721881 rows affected)


--------------------------------------------------------------------------------------------
--Small Analysis: This proves that for around half of the parts dCropUtil is calculated using dArea 
--and for around half it is calculated using dTrueArea

SeLECt count(*) from [CEIP].[dbo].[Nest_Clean]
--6721881

SeLECt count(*) from [CEIP].[dbo].[Nest_Clean]
where dCropUtil = (dPartArea/dArea)*100 
--84675

SeLECt count(*) from [CEIP].[dbo].[Nest_Clean]
where ABS (dCropUtil - ((dPartArea/dTrueArea)*100)) < 2
--4277882

SeLECt count(*) from [CEIP].[dbo].[Nest_Clean]
where ABS (dCropUtil - ((dPartArea/dArea)*100)) < 2
--5872195

SeLECt count(*) from [CEIP].[dbo].[Nest_Clean]
where dArea = dTrueArea
--3601170
--------------------------------------------------------------------------------------------

--Some columns where dPartArea is greater than dTrueAreaRectified � doesn�t make sense so removing it
SELECT * FROM [CEIP].[dbo].[Nest_Clean]
WHERE dPartArea > dTrueAreaRectified;
--I�m getting 10,833 rows

DELETE FROM Nest_Clean
WHERE dPartArea > dTrueAreaRectified
--(10833 rows affected)

--------------------------------------------------------------------------------------------
--In Some jobs there are multiple strategies used, so removing them
--Eg. 
SELECT *
FROM [CEIP].[dbo].[Nest_Clean]
where ixJobSummary = 873526

SELECT ixJobSummary FROM
(SELECT ixJob_Grouped_strategy_wise.ixJobSummary, COUNT(ixJobSummary) AS fStrategies_Count
FROM 
(SELECT ixJobSummary, fStrategies
FROM [CEIP].[dbo].[Nest_Clean]
GROUP BY ixJobSummary, fStrategies) AS ixJob_Grouped_strategy_wise
GROUP BY ixJob_Grouped_strategy_wise.ixJobSummary) AS ixJob_Grouped_strategy_wise_With_Count
where ixJob_Grouped_strategy_wise_With_Count.fStrategies_Count>1

--This returns 203,000 rows, so there are a total of 203,000 jobs which utilizes more than 1 nesting strategy
--Removing these records
DELETE from [CEIP].[dbo].[Nest_Clean]
where ixJobSummary IN (
SELECT ixJobSummary FROM
(SELECT ixJob_Grouped_strategy_wise.ixJobSummary, COUNT(ixJobSummary) AS fStrategies_Count
FROM 
(SELECT ixJobSummary, fStrategies
FROM [CEIP].[dbo].[Nest_Clean]
GROUP BY ixJobSummary, fStrategies) AS ixJob_Grouped_strategy_wise
GROUP BY ixJob_Grouped_strategy_wise.ixJobSummary) AS ixJob_Grouped_strategy_wise_With_Count
where ixJob_Grouped_strategy_wise_With_Count.fStrategies_Count>1)
--(1599861 rows affected)

--------------------------------------------------------------------------------------------

--Final cleaning, matching number of parts for a job in Part table and Nest table
--matching area of parts in a job in Part table and Nest table

--Creating two tables with the filtered jobs based on above described logic
SELECT Parts_Clean.ixJobSummary INTO [CEIP].[dbo].[ixJobSummary_Final_numParts]
FROM
(Select ixJobSummary, SUM(cNested) as Num_Parts_Nested
FROM [CEIP].[dbo].[Part_Clean]
GROUP BY ixJobSummary) AS Parts_Clean
INNER JOIN
(SELECT ixJobSummary, SUM(cParts) as cParts_In_Nest
	FROM [CEIP].[dbo].[Nest_Clean]
	GROUP by ixJobSummary) AS Nests_Clean
	ON Parts_Clean.ixJobSummary = Nests_Clean.ixJobSummary AND Parts_Clean.Num_Parts_Nested = Nests_Clean.cParts_In_Nest
	ORDER BY Parts_Clean.ixJobSummary

SELECT Parts_Clean.ixJobSummary INTO [CEIP].[dbo].[ixJobSummary_Final_Area]
FROM
(Select ixJobSummary, SUM(cNested*dArea) as Num_Parts_Nested
FROM [CEIP].[dbo].[Part_Clean]
GROUP BY ixJobSummary) AS Parts_Clean
INNER JOIN
(SELECT ixJobSummary, SUM(dPartArea) as cParts_In_Nest
	FROM [CEIP].[dbo].[Nest_Clean]
	GROUP by ixJobSummary) AS Nests_Clean
	ON Parts_Clean.ixJobSummary = Nests_Clean.ixJobSummary AND ABS(Parts_Clean.Num_Parts_Nested-Nests_Clean.cParts_In_Nest) < 0.1
	ORDER BY Parts_Clean.ixJobSummary


--Combining [ixJobSummary_Final_Area] And [ixJobSummary_Final_numParts] into one table [ixJobSummary_Final]
SELECT [ixJobSummary_Final_numParts].ixJobSummary into [CEIP].[dbo].[ixJobSummary_Final]
FROM
[CEIP].[dbo].[ixJobSummary_Final_numParts]
INNER JOIN
[CEIP].[dbo].[ixJobSummary_Final_Area]
	ON [ixJobSummary_Final_numParts].ixJobSummary = [ixJobSummary_Final_Area].ixJobSummary

--(1790936 rows affected)

--------------------------------------------------------------------------------------------
--Creating cleaned Nest and Part tables based on this
select * into [CEIP].[dbo].[Nest_Clean_Filtered]
from [CEIP].[dbo].[Nest_Clean]
where ixJobSummary in (Select ixJobSummary from [CEIP].[dbo].[ixJobSummary_Final])

--(3803109 rows affected)

select * into [CEIP].[dbo].[Part_Clean_Filtered]
from [CEIP].[dbo].[Part_Clean]
where ixJobSummary in (Select ixJobSummary from [CEIP].[dbo].[ixJobSummary_Final]) 
--(11649316 rows affected)

--------------------------------------------------------------------------------------------
--Extra cleaning for LSTM model
--Generating Nest and Parts Table where num of parts in a job is <=100
Select * 
INTO [CEIP].[dbo].[Nest_Csv_Max100Parts]
FROM [CEIP].[dbo].[Nest_Csv]
WHERE ixJobSummary IN (
Select ixJobSummary
FROM [CEIP].[dbo].[Part_Clean_Filtered]
GROUP BY ixJobSummary
HAVING SUM(cNested) < 101);

--(1545653 rows affected)

Select * 
INTO [CEIP].[dbo].[Part_Csv_Max100Parts]
FROM [CEIP].[dbo].[Part_Csv]
WHERE ixJobSummary IN (
Select ixJobSummary
FROM [CEIP].[dbo].[Part_Clean_Filtered]
GROUP BY ixJobSummary
HAVING SUM(cNested) < 101)
ORDER BY ixJobSummary, dArea DESC;

--(6343710 rows affected)
