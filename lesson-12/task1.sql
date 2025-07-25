DECLARE @temp TABLE(
    DatabaseName varchar(50),
    SchemaName varchar(50),
    ColoumnName varchar(50),
    DataType VARCHAR(50)
)

DECLARE @Databases TABLE(
    database_id int IDENTITY(1, 1),
    name VARCHAR(255)
)


INSERT into @Databases(name)
SELECT [name] 
from sys.databases
WHERE [name] not in ('master', 'tempdb', 'model', 'msdb')
ORDER BY database_id

select * from @Databases

DECLARE @i int;
Declare @numberOfDatabases int;
DECLARE @databaseName VARCHAR(255);

SELECT @numberOfDatabases = COUNT(*) from @Databases;


while @i <= @numberOfDatabases
begin
    SELECT @databaseName = name from @Databases WHERE database_id = @i
    
    DECLARE @sql_query VARCHAR(max) = '
    Select
        Table_Catalog as [DatabaseName]
        Table_Schema as [SchemaName]
        Coloumn_name as [ColoumnName]
        Concat(Data_Type,
                ''('' + 
                    IIF(Cast(CHARACTER_MAXIMUM_LENGTH AS VARCHAR) = ''-1'', ''max'', Cast(CHARACTER_MAXIMUM_LENGTH AS VARCHAR))
                    + '')'') as DataType
    From  ' + QUOTENAME(@databaseName) + '.INFORMATION_SCHEMA_COlUMNS;';

    INSERT INTO @temp
        EXEC sp_executesql @sql_query
    
    set @i = @i + 1
end;

SELECT * from @temp
