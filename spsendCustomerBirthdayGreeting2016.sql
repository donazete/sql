USE [JobCheck]
GO
/****** Object:  StoredProcedure [dbo].[spsendCustomerBirthdayGreeting2016]    Script Date: 09/11/2016 11:38:39 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[spsendCustomerBirthdayGreeting2016] 
	@BirthDayOffset INT = 0
AS

/*
Created May 23, 2014 by Israel Adewale (I.A)
Purpose: The procedure sends birthday greetings to all customers whose birthday is on the day it is executed

Revision History
May 26, 2014	Version 2.0 I.A. Included customer care in the blind copy and removed Mariam from the blind copy.
May 30, 2014	Version 2.1 I.A. Excluded sending blind copying account officer email when the email is allofus@gtbasset.com
Mar 31, 2015	Version 3.0 I.A. Adjusted to accommodate new design of the birthday card.
May 27, 2015	Version 3.1 I.A. Included bgcolor="orange"
Jul 1, 2015		Version 3.1.1 I.A. Include Mariam in the blind copy recipients.
Jul 2, 2015		Version 3.1.2 I.A. Corrected an error. Replaced '@CustomerEmailAddress' with @CustomerEmailAddress
Aug 26, 2015	Version 3.1.3 I.A. Adjusted to exclude email addresses in ExceptionEmailAddress table
Nov 18, 2015	Version 3.1.4 I.A. Adjusted to include account officers in blind copy
Nov 09, 2016	Version 3.1.5 D.O. HTML template modification, view to display Dear {Customername}
*/


SET NOCOUNT ON

DECLARE @BirthDayToCheck VARCHAR(4) -- This is in the format MMDD
		,@BirthAnniversaryDate DATETIME 

SET @BirthAnniversaryDate = GETDATE() + ISNULL(@BirthDayOffset, 0)
SET @BirthDayToCheck = RIGHT(CONVERT(VARCHAR, @BirthAnniversaryDate, 112), 4)

DECLARE @tableHTML  NVARCHAR(MAX) ;
DECLARE @MinimumRecordId INTEGER
DECLARE @MaximumRecordId INTEGER
DECLARE @Header VARCHAR(500)
DECLARE @BlindCopyRecipientsEmail VARCHAR(500)
SET @Header = 'HAPPY BIRTHDAY'


DECLARE Birthday_Cursor CURSOR
READ_ONLY
FOR 
	SELECT TOP 3 cn.Firstname
		  ,cc.[Email1]
		  ,oo.Email1
		  ,cc.BirthDay
		  ,@Header + '  ' +  cn.Firstname AS MessageSubject
	  FROM [IWGI].[dbo].[IWVW_Cust_Customers] cc
	  JOIN [dbo].[CustomerName] cn ON cn.[CustAID] = cc.CustAID
	  LEFT JOIN [IWGI].[dbo].[IWVW_OP_Officers] oo ON oo.IDNumber = cc.AccountOfficer_ID
  	  WHERE cc.[BirthDay] is not null
			AND cc.[Email1] IS NOT NULL
			AND cc.[Email1] LIKE '%@%'
			AND cc.[Email1] LIKE '%.%'
			AND RIGHT(CONVERT(VARCHAR, cc.[BirthDay], 112), 4) = @BirthDayToCheck
			AND ClientType = 'IND'
			AND cn.[EnableForAutoMessage] = 1
			AND cc.Email1 NOT IN (SELECT [EmailAddress] FROM [IOFS].[dbo].[ExceptionEmailAddress]) 
	  ORDER BY cn.Firstname
 
	DECLARE @DerivedFirstName VARCHAR(500)
		   ,@CustomerEmailAddress VARCHAR(200)
		   ,@AccountOfficerEmailAddress VARCHAR(200)
		   ,@CustomerBirthDay DATETIME
		   ,@MessageSubject VARCHAR(600)
	OPEN Birthday_Cursor

	FETCH NEXT FROM Birthday_Cursor INTO @DerivedFirstName 
								   ,@CustomerEmailAddress	
								   ,@AccountOfficerEmailAddress			
								   ,@CustomerBirthDay	
								   ,@MessageSubject		   
	WHILE (@@fetch_status <> -1)
	BEGIN
		IF (@@fetch_status <> -2)
		BEGIN

			SET @BlindCopyRecipientsEmail = 'Mariam.Imoukhuede@investment-one.com;' + @AccountOfficerEmailAddress + ';israel.adewale@investment-one.com;'

			-- Do not copy account officer if the email address is null or is allofus
			IF @AccountOfficerEmailAddress IS NULL OR @AccountOfficerEmailAddress = 'allofus@gtbasset.com'
			BEGIN
				SET @BlindCopyRecipientsEmail = 'customercare@investment-one.com;israel.adewale@investment-one.com;'
			END
			--https://ibank.investment-one.com/IW/images/ibankbanner/banner/bdimageonly.png
			--http://www.investment-one.com/images/BDImageOnly.png
			-- http://i.imgur.com/h9Q0ocF.png
			SET @DerivedFirstName = dbo.fnInitCap(@DerivedFirstName)
			SET @tableHTML =
							N'<html xmlns:v="urn:schemas-microsoft-com:vml"
xmlns:o="urn:schemas-microsoft-com:office:office"
xmlns:w="urn:schemas-microsoft-com:office:word"
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml"
xmlns="http://www.w3.org/TR/REC-html40">
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv=Content-Type content="text/html; charset=windows-1252">
		<meta name=ProgId content=Word.Document>
		<meta name=Generator content="Microsoft Word 14">
		<meta name=Originator content="Microsoft Word 14">
		<style type="text/css">
			.maincont {
				WIDTH: 600px; height: 700px;  background: url(''https://ibank.investment-one.com/IW/images/bdaybg.jpg'') no-repeat center; background-size: 600px 700px; margin: 5px auto 10px auto;
			}

			.name {
				width: 550px; margin: 0px auto 0px auto; padding: 150px 0px 0px 0px; text-align: right; height: 50px; font-family: Century Gothic, Verdana, Arial, Helvetica, sans-serif; font-size: 18px; line-height: 20px; font-weight: bold;
			}

			.bday{
				width: 400px; margin: 0px auto 0px auto; padding: 10px 0px 0px 10px; height: 50px; font-family: Century Gothic, Verdana, Arial, Helvetica, sans-serif; font-size: 30px; line-height: 20px; font-weight: bold;
			}

			.greet{
				width: 400px; margin: 0px auto 0px auto; padding: 10px 0px 0px 10px; height: 100px; font-family: Century Gothic, Verdana, Arial, Helvetica, sans-serif; font-size: 17px; line-height: 20px; font-weight: bold;
			}

			.sign{
				width: 400px; margin: 0px auto 0px auto; padding: 10px 0px 0px 10px; height: 50px; font-family: Century Gothic, Verdana, Arial, Helvetica, sans-serif; font-size: 20px; line-height: 20px; font-weight: bold;
			}
		</style>
	</head>
	<body>
		<div align=center class="maincont" >

			<div class="name">
	          				Dear '+@DerivedFirstName+', 
	        </div>
	        <div class="greet">
	          				Here is wishing you a <strong>wonderful birthday</strong> and a great year filled with happiness and joy
	        </div>
	        <div class="bday">
	          				Happy Birthday
	        </div>
	         <div class="sign">
	          				from allofus @ Investment One
	        </div>
			
		</div>
	</body>
</html>
 ' 
				--SET @Header = @Header + ' ' + dbo.fnInitCap(@DerivedFirstName)
 				--SET @tableHTML = REPLACE(@tableHTML, '{CustomerName}', dbo.fnInitCap(@DerivedFirstName))

--Mariam.Imoukhuede@investment-one.com
print @tableHTML
				EXEC msdb.dbo.sp_send_dbmail 
--					 @recipients= 'sidetuforreal@yahoo.com;Aderayo.Bankole@investment-one.com;Norbert.Olisakwe@investment-one.com;israel.adewale@investment-one.com;IKAYADEWALE@GMAIL.COM;IKAYADEWALE@YAHOO.COM;IKAYADEWALE@HOTMAIL.COM;Mariam.Imoukhuede@investment-one.com' -- Mariam.Imoukhuede@investment-one.com;israel.adewale@investment-one.com' -- @CustomerEmailAddress --;ISRAEL.ADEWALE@INVESTMENT-one.com;ikayadewale@gmail.com;ikayadewale@yahoo.com;ikayadewale@hotmail.com;sidetuforreal@yahoo.com'--sidetuforreal@yahoo.com;ikayadewale@hotmail.com:Ivy.Ojigbede@investment-one.com;Mariam.Imoukhuede@investment-one.com;aderayo@gmail.com;Aderayo.Bankole@investment-one.com;Norbert.Olisakwe@investment-one.com'
					 @recipients= 'israel.adewale@investment-one.com; donazete@yahoo.com; donazete@gmail.com; donald.oyeleye@investment-one.com; donald.oyeleye@ddmtechie.com'
					--,@blind_copy_recipients = @BlindCopyRecipientsEmail -- 'israel.adewale@investment-one.com;Mariam.Imoukhuede@investment-one.com' -- ikayadewale@gmail.com;@AccountOfficerEmailAddress;ikayadewale@gmail.com;ikayadewale@hotmail.com;ikayadewale@yahoo.com;israel.adewale@investment-one.com' --israel.adewale@investment-one.com', 
					,@profile_name = 'Customer Care'--'Customer Care'
					,@subject =  @MessageSubject 
					,@body = @tableHTML
					,@body_format = 'HTML';
		END
		FETCH NEXT FROM Birthday_Cursor INTO @DerivedFirstName 
								   ,@CustomerEmailAddress
								   ,@AccountOfficerEmailAddress
								   ,@CustomerBirthDay
								   ,@MessageSubject
	END

	CLOSE Birthday_Cursor
	DEALLOCATE Birthday_Cursor




