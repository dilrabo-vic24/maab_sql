IF OBJECT_ID('dbo.usp_GetProcedureAndFunctions', 'P') IS NOT NULL
    DROP PROCEDURE dbo.usp_GetProcedureAndFunctions;
GO

create proc usp_GetProcedureAndFunctions @DatabaseName NVARCHAR(255) = Null
as 
begin
    Declare @temp TABLE(
        DatabaseName VARCHAR(255),
        SchemaName VARCHAR(255),
        ObjectName VARCHAR(255),
        ObjectType VARCHAR(60)
    )

    DECLARE @Databases TABLE(
        database_id INT IDENTITY(1, 1),
        name VARCHAR(255)
    )

    if @DatabaseName is NULL
    begin
        INSERT into @Databases(name)
        select name from sys.databases
        WHERE name not in ('master', 'tempdb', 'model', 'msdb')
        ORDER BY database_id
    END
    ELSE
    begin 
        INSERT into @Databases(name) VALUES (@DatabaseName)
    END;

    Declare @i int = 1
    Declare @numberOfDatabases int;

    SELECT @numberOfDatabases = COUNT(*) from @Databases

    while @i < @numberOfDatabases
    BEGIN
        SELECT @DatabaseName = name from @Databases WHERE database_id = @i

        DECLARE @sql_query NVARCHAR(max);

        set @sql_query = N'
            USE ' + QUOTENAME(@DatabaseName) + N';
            SELECT
                ' + QUOTENAME(@DatabaseName, '''') + N' AS DatabaseName,
            SchmList.name as SchemaName,
            ObjList.name as ObjectName,
            ObjList.type as ObjectType
        From
            ' + QUOTENAME(@DatabaseName) + '.sys.all_objects As ObjList
        Join
            ' + QUOTENAME(@DatabaseName) + '.sys.schemas As  SchmList
            on ObjList.SCHEMA_ID = SchmList.SCHEMA_ID
        where ObjList.type in (''FN'', ''P'');';

        INSERT into @temp
            EXEC sp_executesql @sql_query

        set @i = @i + 1

    end;
    SELECT * from @temp

END;
GO

EXEC usp_GetProcedureAndFunctions