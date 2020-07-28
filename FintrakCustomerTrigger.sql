--DROP TRIGGER FintrakCustomerCreate

CREATE TRIGGER FintrakCustomerCreate  
ON [dbo].[Cust_Customers]  --- TODO:: Change to involvement table
AFTER INSERT   
AS  
  BEGIN
			DECLARE @CustomerCode as varchar(10)
			DECLARE @CustomerType as varchar(10)
			DECLARE @Surname as varchar(500)
			DECLARE @Othername as varchar(100)
			DECLARE @Firstname as varchar(100)
			DECLARE @Title as varchar(20)
			DECLARE @dob as varchar(10)
			DECLARE @Placeofbirth as varchar(50)
			DECLARE @Gender as varchar(10)
			DECLARE @MobilePhone as varchar(15)
			DECLARE @modeofId as varchar(20)
			DECLARE @email as varchar(150)
			DECLARE @nationality as varchar(50)
			DECLARE @residence as varchar(250)
			DECLARE @occupation as varchar(20)
			DECLARE @branch as varchar(10)
			DECLARE @company as varchar(10)
			DECLARE @mothername as varchar(50)
			DECLARE @maritalStatus as varchar(20)
			DECLARE @Header VARCHAR(100)
			DECLARE @tableHTML  NVARCHAR(MAX)
			DECLARE @param1  NVARCHAR(MAX)
			DECLARE @param  NVARCHAR(MAX) 

			Select @CustomerCode = CustAid from Inserted
			print @CustomerCode

			SELECT @CustomerCode = C.[CustAID]
				, @CustomerType = (CASE C.ClientType
						When 'IND' then 2
						When 'CORP' then 3
						else 2
					End)
			  ,@Surname = (CASE C.ClientType
						When 'CORP' then C.[Name]
						else CE.[LastName]
					End)
			  ,@Othername = (CASE C.ClientType
						When 'CORP' then ''
						else CE.[MiddleName]
					End)
			  ,@Firstname = (CASE C.ClientType
						When 'CORP' then C.[Name]
						else CE.[FirstName]
					End)
			  ,@Title = C.[Title]
			  ,@dob = (CASE C.ClientType 
						WHEN 'CORP' Then (SELECT [Value] FROM [dbo].[Attrib_Values] WHERE AttribSetID = 15 and OwnerTableID = C.ID#)
						ELSE  CONVERT(VARCHAR(10), C.[BirthDate], 103)
						END)  
			  , @Placeofbirth = ''
			  ,@Gender = ''
			  , @MobilePhone = O.[Phone1]
			  , @modeofId = (SELECT [Value] FROM [dbo].[Attrib_Values] WHERE AttribSetID = 40 and OwnerTableID = C.ID#) 
			  , @email = O.[Email1]
			  , @nationality = C.[Nationality]
			  ,@residence = ISNULL(O.[Address1],'')+' '+ISNULL(O.[Address2],'')+' '+ISNULL(O.[State],'')
			  , @occupation = (SELECT [Value] FROM [dbo].[Attrib_Values] WHERE AttribSetID = 13 and OwnerTableID = C.ID#)
			  , @branch = C.[BranchCode]
			  , @company = C.[BranchCode]
			  , @mothername = ''
			  , @maritalStatus = ''
		  FROM [Cust_Customers] C
			left join [Cust_CustomersEx] CE
				on C.ID# = CE.CustID
			left join OP_ContactInfo O
				on C.ID# = O.ParentRowID and O.ContactInfoOwnerID = 2
		  Where CustAID = @CustomerCode

		  /*
		  SELECT @CustomerCode 
				, @CustomerType 
			  ,@Surname 
			  ,@Othername 
			  ,@Firstname 
			  ,@Title
			  ,@dob   --- TODO:: Need to write a case statement to fetch date of incorporation for corporate clients
			  , @Placeofbirth
			  ,@Gender
			  , @MobilePhone 
			  , @modeofId --- TODO:: Need to write a statement to fetch mode of identification from custom attributes
			  , @email 
			  , @nationality
			  ,@residence
			  , @occupation  --- TODO:: Need to write a statement to fetch occupation from custom attributes
			  , @branch
			  , @company 
			  , @mothername 
			  , @maritalStatus */
		  


		  --- TODO:: Write procedure that calls Fintrak webservice and passes the required parameters
			Declare @Object as Int
			Declare @Status as Int
			Declare @hr as Int
			Declare @rc as Int
			Declare @ResponseText as Varchar(8000)
			Declare @MessageErreur as Varchar(8000)
			Declare @url as Varchar(500)
			Declare @Text as Varchar(500),
			@FileID Int, @Filename Varchar(8000)
			SET @url = 'http://10.75.1.212/api/v1/customer/add'
			Set @param1 = 'customerCode='+ISNULL(@CustomerCode, '')+'&customerType='+ISNULL(@CustomerType, 2)+'&surname='+ISNULL(@Surname, '')+'&othername='+ISNULL(@Othername, '')+'&firstname='+ISNULL(@Firstname, '')+
							'&title='+ISNULL(@Title,'')+'&dateOfBirth='+ISNULL(@dob, '')+'&placeOfBirth='+ISNULL(@Placeofbirth,'')+'&gender='+ISNULL(@Gender,'')+'&mobilePhone='+ISNULL(@MobilePhone,'')+'&modeOfID='+ISNULL(@modeofId,'')+
							'&email='+ISNULL(@email, '')+'&nationality='+ISNULL(@nationality,'')+'&residence='+ISNULL(@residence,'')+'&occupation='+ISNULL(@occupation,'')+'&branch='+ISNULL(@branch,'')+'&company='+ISNULL(@company,'')+
							'&motherName='+ISNULL(@mothername,'')+'&maritalStatus='+ISNULL(@maritalStatus,'')
			--Set @param = (SELECT dbo.UrlEncode(@param1))
			print @param1
			--set @param = 'customerCode=YAH00&customerType=COMP&surname=Aj&firstname=la&dateOfBirth=35&email=mailcom&company=kas&branch=000&mobilePhone=qq'
			--print @param
		
			EXEC @hr = sp_OACreate 'Msxml2.ServerXMLHTTP.3.0', @Object OUT
			IF @hr <> 0 
				Begin
					EXEC sp_OAGetErrorInfo @Object
					set @MessageErreur = 'sp_OACreate failed'
					Goto ex
				End

			EXEC @hr = sp_OAMethod @Object, 'Open', NULL, 'POST', @url, 'false'
			IF @hr <> 0 
				Begin
					EXEC sp_OAGetErrorInfo @Object
					set @MessageErreur = 'sp_OAMethod Open X-Fintrak-Api-Token failed'
					Goto ex
				End

			EXEC @hr = sp_OAMethod @Object, 'setRequestHeader', NULL, 'X-Fintrak-Api-Token', 'ECBi391j99-449B-4711-9B8C-2A482-644==555D'
			IF @hr <> 0 
				Begin
					EXEC sp_OAGetErrorInfo @Object
					set @MessageErreur = 'sp_OAMethod setRequestHeader X-Fintrak-Api-Token failed'
					Goto ex
				End

			EXEC @hr = sp_OAMethod @Object, 'setRequestHeader', NULL, 'Content-Type', 'application/x-www-form-urlencoded'
			IF @hr <> 0 
				Begin
					EXEC sp_OAGetErrorInfo @Object
					set @MessageErreur = 'sp_OAMethod setRequestHeader Content-Type failed'
					Goto ex
				End

			EXEC @hr = sp_OAMethod @Object, 'Send', NULL, @param1
			IF @hr <> 0 
				Begin
					EXEC sp_OAGetErrorInfo @Object
					set @MessageErreur = 'sp_OAMethod send failed' 
					Goto ex
				End

			exec @hr = sp_OAGetProperty @Object, 'status', @Text OUT
			if @hr <> 0 
				begin 
					set @MessageErreur = 'sp_OAGetProperty read status failed' 
					goto ex 
				end

			EXEC @hr = sp_OAMethod @Object, 'ResponseText', @ResponseText OUTPUT
			if @hr <> 0 
				begin 
					set @MessageErreur = 'sp_OAMethod read response failed' 
					goto ex 
				end

			EXEC @hr = sp_OADestroy @Object 
			IF @hr <> 0 
				Begin
					set @MessageErreur = 'sp_OADestroy failed' 
					Goto ex
				End
		

		  -- send success or failure mail
		  /* BEGIN
				DECLARE @Name AS VARCHAR(500)
			  SET @Name = @Surname+' '+@Firstname+' '+@Othername
			  SET @tableHTML = '<html>
									<header>
		
									</header>
									<body>
										<p>Customer created on Infoware successfully created on Fintrak</p>
										<ul>
											<li>Customer number: '+@CustomerCode+'</li>
											<li>Customer name: '+@Name+'</li>
										</ul>
									</body>
								</html>'
			  print @tableHTML
					EXEC msdb.dbo.sp_send_dbmail 
						@recipients= 'israel.adewale@investment-one.com; donazete@yahoo.com; donazete@gmail.com; donald.oyeleye@investment-one.com; donald.oyeleye@ddmtechie.com'
						,@blind_copy_recipients = 'israel.adewale@investment-one.com;adedayo.ajayi@investment-one.com' 
						,@profile_name = 'Technology'--'Customer Care'
						,@subject = 'Customer creation Successful' 
						,@body = @tableHTML
						,@body_format = 'HTML';
		END
		*/
		Declare @cmd as Varchar(8000)
		SET @param = 'CustomerID: '+ISNULL(@CustomerCode, '')+' Customer type: '+ISNULL(@CustomerType, 2)+' Surname: '+ISNULL(@Surname, '')+' Othernames: '+ISNULL(@Othername, '')+' First name: '+ISNULL(@Firstname, '')+
							' Title: '+ISNULL(@Title,'')+' Date of birth: '+ISNULL(@dob, '')+' Place of birth: '+ISNULL(@Placeofbirth,'')+' Phone: '+ISNULL(@MobilePhone,'')+' Mode of ID: '+ISNULL(@modeofId,'')+
							' Email: '+ISNULL(@email, '')+' Nationality: '+ISNULL(@nationality,'')+' Residence: '+ISNULL(@residence,'')+' Occupation: '+ISNULL(@occupation,'')+' Branch: '+ISNULL(@branch,'')+' Company: '+ISNULL(@company,'')+
							' Mother name: '+ISNULL(@mothername,'')+' Marital Status: '+ISNULL(@maritalStatus,'')+Convert(Varchar(20),Getdate())
		SET @Filename =  'C:\Donald\FintrakCustLog.txt'
		Set @cmd = 'echo '+@param +' > '+@Filename
		
		EXECUTE @hr = sp_OACreate 'Scripting.FileSystemObject', @Object OUT
		IF @hr <> 0 PRINT 'Scripting.FileSystemObject'

		--Open a file
		execute @hr = sp_OAMethod @Object, 'OpenTextFile', @FileID OUT, @FileName, 8, 1
		IF @hr <> 0 PRINT 'OpenTextFile'

		--Write Text1
		execute @hr = sp_OAMethod @FileID, 'WriteLine', Null, @param
		IF @hr <> 0 PRINT 'WriteLine'

		EXECUTE @hr = sp_OADestroy @FileID
		EXECUTE @hr = sp_OADestroy @Object

		ex:
		print @MessageErreur
		--return 
  END
GO


sp_configure 'show advanced options', 1;  
GO  
RECONFIGURE;  
GO  
sp_configure 'Ole Automation Procedures', 1;  
GO  
RECONFIGURE;  
GO 





/****** Script for SelectTopNRows command from SSMS  ******/
INSERT INTO [dbo].[Cust_Customers] ([CustAID]
      ,[Contact]
      ,[Name]
      ,[Title]
      ,[Address1]
      ,[Address2]
      ,[State]
      ,[Country]
      ,[Phone]
      ,[Fax]
      ,[Nationality]
      ,[ClientType]
      ,[BirthDate]
      ,[CreditLimit]
      ,[ContactDate]
      ,[EMail]
      ,[AccountOfficer_ID]
      ,[AccountOfficer]
      ,[Comments]
      ,[UserID]
      ,[TxnDate]
      --,[ID#]
      ,[BranchCode]
      ,[Gender]
      ,[CreatedBy]
      ,[CreateDate])
VALUES
('24054'
      ,''
     ,'Adedayo Ajayi'
      ,'Mr.'
      ,'Borough Rd, London'
      ,''
      ,''
      ,''
      ,'08099930535'
      ,''
      ,''
      ,'CORP'
      ,'10/13/1960'
      ,''
      ,''
      ,'pefdow@yahoo.com'
      ,null
      ,null
      ,''
      ,'Admin'
      ,Getdate()
      ,'000'
      ,''
      ,'Admin'
      ,Getdate())
	  