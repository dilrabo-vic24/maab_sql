-- **Calendar Table Query with Sunday as First Column**  

-- You will create an SQL Server query that generates 
-- a tabular representation of a given month, 
-- displaying the days of each week in separate 
-- columns, with Sunday as the first column and 
-- Saturday as the last column.

DECLARE @inputDate date = GETDATE(); 

;WITH cte AS (
    SELECT  DATEFROMPARTS(YEAR(@inputDate), MONTH(@inputDate), 1) AS [date]
    UNION ALL
    SELECT DATEADD(day, 1, [date])
    FROM cte
    WHERE [date] < EOMONTH(@inputDate)
)
SELECT
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Sunday'    THEN DAY([date]) END) AS Sunday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Monday'    THEN DAY([date]) END) AS Monday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Tuesday'   THEN DAY([date]) END) AS Tuesday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Wednesday' THEN DAY([date]) END) AS Wednesday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Thursday'  THEN DAY([date]) END) AS Thursday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Friday'    THEN DAY([date]) END) AS Friday,
    MAX(CASE WHEN DATENAME(weekday, [date]) = 'Saturday'  THEN DAY([date]) END) AS Saturday
FROM cte
GROUP BY DATEPART(week, [date])