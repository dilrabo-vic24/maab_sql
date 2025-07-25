DECLARE @email_subject NVARCHAR(255);
DECLARE @html_body     NVARCHAR(MAX);
DECLARE @table_rows    NVARCHAR(MAX);
DECLARE @css_style     NVARCHAR(MAX);

SET @css_style = N'
<style type="text/css">
    body { font-family: Arial, sans-serif; }
    h1 { color: #333366; }
    table {
        border-collapse: collapse;
        width: 100%;
        border: 1px solid #ddd;
    }
    th, td {
        text-align: left;
        padding: 8px;
        border: 1px solid #ddd;
    }
    thead th {
        background-color: #4CAF50;
        color: white;
        font-weight: bold;
    }
    tr:nth-child(even) { background-color: #f2f2f2; }
    tr:hover { background-color: #ddd; }
</style>';


SET @table_rows = CAST(
    (
        SELECT
            s.name                                                              AS 'td','', 
            t.name                                                              AS 'td','',
            i.name                                                              AS 'td','', 
            i.type_desc                                                         AS 'td','', 

            STRING_AGG(c.name, ', ') WITHIN GROUP (ORDER BY ic.key_ordinal)     AS 'td',''  
        FROM
            sys.indexes AS i
        INNER JOIN
            sys.tables AS t ON i.object_id = t.object_id
        INNER JOIN
            sys.schemas AS s ON t.schema_id = s.schema_id
        INNER JOIN
            sys.index_columns AS ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
        INNER JOIN
            sys.columns AS c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
        WHERE
            t.is_ms_shipped = 0
            AND i.index_id > 0
        GROUP BY
            s.name,
            t.name,
            i.name,
            i.type_desc
        ORDER BY
            s.name,
            t.name,
            i.name
        FOR XML PATH('tr'), TYPE
    ) AS NVARCHAR(MAX)
);


SET @email_subject = N'Index Metadata Report for Database: ' + QUOTENAME(DB_NAME());

SET @html_body = N'<html><head>' + @css_style + N'</head><body>' +
                 N'<h1>' + @email_subject + N'</h1>' +
                 N'<table>' +
                 N'<thead><tr>' +
                 N'<th>Schema Name</th>' +
                 N'<th>Table Name</th>' +
                 N'<th>Index Name</th>' +
                 N'<th>Index Type</th>' +
                 N'<th>Indexed Columns</th>' +
                 N'</tr></thead>' +
                 N'<tbody>' + ISNULL(@table_rows, N'') + N'</tbody>' +
                 N'</table></body></html>';


EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'Profile',
    @recipients = 'recipient@example.com;recipient@example.com',
    @subject = @email_subject,
    @body = @html_body,
    @body_format = 'HTML';