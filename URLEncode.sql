IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Numbers')
BEGIN

     CREATE TABLE dbo.Numbers
    (
        Num INT NOT NULL 
        CONSTRAINT [PKC__Numbers__Num] PRIMARY KEY CLUSTERED (Num) on [PRIMARY]
    )
    ;WITH Nbrs_3( n ) AS ( SELECT 1 UNION SELECT 0 ),
          Nbrs_2( n ) AS ( SELECT 1 FROM Nbrs_3 n1 CROSS JOIN Nbrs_3 n2 ),
          Nbrs_1( n ) AS ( SELECT 1 FROM Nbrs_2 n1 CROSS JOIN Nbrs_2 n2 ),
          Nbrs_0( n ) AS ( SELECT 1 FROM Nbrs_1 n1 CROSS JOIN Nbrs_1 n2 ),
          Nbrs  ( n ) AS ( SELECT 1 FROM Nbrs_0 n1 CROSS JOIN Nbrs_0 n2 )
     
    INSERT INTO dbo.Numbers(Num)
    SELECT n
    FROM ( SELECT ROW_NUMBER() OVER (ORDER BY n)
          FROM Nbrs ) D ( n )
         WHERE n <= 50000 ;
END




GO
SET ANSI_NULLS ON
GO

IF EXISTS (
    SELECT 1
    FROM dbo.sysobjects 
    WHERE id = OBJECT_ID(N'[dbo].[URLEncode]') 
        AND xtype IN (N'FN', N'IF', N'TF'))
BEGIN
    DROP FUNCTION [dbo].[URLEncode]
END
GO

CREATE FUNCTION [dbo].[URLEncode] 
	(@decodedString VARCHAR(4000))
RETURNS VARCHAR(4000)
AS
BEGIN
/*******************************************************************************************************
*   dbo.URLEncode 
*   Creator:       Robert Cary
*   Date:          03/18/2008
*
*   Notes:         
*                  
*
*   Usage:
        select dbo.URLEncode('K8%/fwO3L mEQ*.}')
*   Modifications:   
*   Developer Name      Date        Brief description
*   ------------------- ----------- ------------------------------------------------------------
*   
********************************************************************************************************/

DECLARE @encodedString VARCHAR(4000)

IF @decodedString LIKE '%[^a-zA-Z0-9*-.!_]%' ESCAPE '!'
BEGIN
    SELECT @encodedString = REPLACE(
                                    COALESCE(@encodedString, @decodedString),
                                    SUBSTRING(@decodedString,num,1),
                                    '%' + SUBSTRING(master.dbo.fn_varbintohexstr(CONVERT(VARBINARY(1),ASCII(SUBSTRING(@decodedString,num,1)))),3,3))
    FROM dbo.numbers 
    WHERE num BETWEEN 1 AND LEN(@decodedString) AND SUBSTRING(@decodedString,num,1) like '[^a-zA-Z0-9*-.!_]' ESCAPE '!'
END
ELSE
BEGIN
	SELECT @encodedString = @decodedString 
END

RETURN @encodedString

END
GO