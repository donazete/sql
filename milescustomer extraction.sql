/****** Script for SelectTopNRows command from SSMS  ******/
SELECT C.CustAID
      ,C.Contact
      ,C.LastName
      ,C.FirstName
      ,C.MiddleName
      ,C.Name
      ,C.Title
      ,C.Nationality
      ,C.ClientType
      ,C.BranchCode
      ,C.ContactDate
      ,C.AccountOfficer_ID
      ,C.AccountOfficer
      ,C.Address1
      ,C.Address2
      ,C.City
      ,C.State
      ,C.Country
      ,C.Phone1
      ,C.Phone2
      ,C.Phone3
      ,C.Fax
      ,C.Email1
      ,C.Email2
      ,C.NextOfKin
      ,C.Relationship
      ,C.Website
      ,C.BirthDay
      ,C.Anniversary
      ,C.Notes
      ,C.YahooMsgID
      ,C.MSNMsgID2
      ,C.SkypeID
      ,C.Custom1
      ,C.Custom2
      ,C.CreatedBy
      ,C.CreateDate
      ,C.ID#
	  ,E.[BankCode]
	  , P.Description
      ,E.[AcctNumber]
      ,E.[Description]
	  ,Case 
			When [NLastName] IS NULL or [NLastName] = '' THEN C.LastName
			ELSE [NLastName]
		END as [NLastName]
      ,Case 
			When [NFirstName] IS NULL or [NFirstName] = '' THEN C.[FirstName]
			ELSE [NFirstName]
		END as [NFirstName]
      ,Case 
			When [NMiddleName] IS NULL or [NMiddleName] = '' THEN C.[MiddleName]
			ELSE [NMiddleName]
		END as [NMiddleName]
      ,Case 
			When [NName] IS NULL or [NName] = '' THEN C.[Name]
			ELSE [NName]
		END as [NName]
      ,Case 
			When [NTitle] IS NULL or [NTitle] = '' THEN C.[Title]
			ELSE [NTitle]
		END as [NTitle]
      ,Case 
			When [NNationality] IS NULL or [NNationality] = '' THEN C.[Nationality]
			ELSE [NNationality]
		END as [NNationality]
      ,Case 
			When [NClientType] IS NULL or [NClientType] = '' THEN C.[ClientType]
			ELSE [NClientType]
		END as [NClientType]
      ,Case 
			When [NAddress1] IS NULL or [NAddress1] = '' THEN C.[Address1]
			ELSE [NAddress1]
		END as [NAddress1]
      ,Case 
			When [NAddress2] IS NULL or [NAddress2] = '' THEN C.[Address2]
			ELSE [NAddress2]
		END as [NAddress2]
      ,Case 
			When [NCity] IS NULL or [NCity] = '' THEN C.[City]
			ELSE [NCity]
		END as [NCity]
      ,Case 
			When [NState] IS NULL or [NState] = '' THEN C.[State]
			ELSE [NState]
		END as [NState]
      ,Case 
			When [NCountry] IS NULL or [NCountry] = '' THEN C.[Country]
			ELSE [NCountry]
		END as [NCountry]
      ,Case 
			When [NPhone1] IS NULL or [NPhone1] = '' THEN C.[Phone1]
			ELSE [NPhone1]
		END as [NPhone1]
      ,Case 
			When [NPhone2] IS NULL or [NPhone2] = '' THEN C.[Phone2]
			ELSE [NPhone2]
		END as [NPhone2]
      ,Case 
			When [NPhone3] IS NULL or [NPhone3] = '' THEN C.[Phone3]
			ELSE [NPhone3]
		END as [NPhone3]
      ,Case 
			When [NEmail1] IS NULL or [NEmail1] = '' THEN C.[Email1]
			ELSE [NEmail1]
		END as [NEmail1]
      ,Case 
			When [NEmail2] IS NULL or [NEmail2] = '' THEN C.[Email2]
			ELSE [NEmail2]
		END as [NEmail2]
      ,Case 
			When [NNextOfKin] IS NULL or [NNextOfKin] = '' THEN C.[NextOfKin]
			ELSE [NNextOfKin]
		END as [NNextOfKin]
      ,Case 
			When [NRelationship] IS NULL or [NRelationship] = '' THEN C.[Relationship]
			ELSE [NRelationship]
		END as [NRelationship]
      ,Case 
			When [NBirthDay] IS NULL or [NBirthDay] = '' THEN C.[BirthDay]
			ELSE [NBirthDay]
		END as [NBirthDay]
  FROM [IWGI].[dbo].[IWVW_Cust_Customers] C
  	left join [IWGI].[dbo].[Op_ContactsBankInfo] E
	on C.ID# = E.[ParentRowID] and E.ContactInfoOwnerID = 2
		left join [pParams] P
			on E.BankCode = P.Code and P.Type = 'BANKNAMES'
		left join Fintrak.dbo.InfoWARECustomerCleanup I
			on I.NID# = C.ID#