---=================================================================================================================
--            BELOW PROCEDURE WILL CONSIDER NOT NULL AND LENGTH WHEN GENERATING COUNT 
---=================================================================================================================

CREATE OR ALTER PROC USP_ColumnCount
(
@TableName		Varchar(100),
@SchemaName		Varchar(100)
)
AS
--USP_ColumnCount 'emp','dbo'
DECLARE @userData 
	TABLE(
		ColumnName varchar(50),
        ColumnCount int,
		DistinctCount int
        )
 DECLARE @sqlStr varchar(max) 
 DECLARE CountCur CURSOR FAST_FORWARD READ_ONLY
 FOR
	SELECT 'SELECT ''' + c.name + ''', SUM(CASE WHEN (' + c.name + ' IS NOT NULL OR LTRIM(RTRIM(LEN(' + c.name + ')))>=1) THEN 1 ELSE 0 END), COUNT(DISTINCT ' + c.name + ')  FROM ' + Schema_name(t.schema_id) + '.' + t.name    
	FROM [sys].[tables] AS t INNER JOIN [sys].[columns] AS c ON [c].[object_id] = [t].[object_id]
	WHERE t.name=@TableName  AND Schema_name(t.schema_id)=@SchemaName

 OPEN CountCur
 FETCH NEXT FROM CountCur INTO @sqlStr 
  WHILE @@FETCH_STATUS = 0
    BEGIN
		
        INSERT  INTO @userData( ColumnName, ColumnCount, DistinctCount )
        EXEC(@sqlStr)
        Print(@sqlStr)

        FETCH NEXT FROM CountCur INTO @sqlStr 
    END
 CLOSE CountCur
 DEALLOCATE CountCur
 SELECT * FROM @userData

