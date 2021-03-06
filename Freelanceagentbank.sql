/****** Script for SelectTopNRows command from SSMS  ******/
SELECT C.Name
	  , C.CustAID
	  , A.[CustomerNumber]
      ,[DisplayCustomerName]
      ,[PhoneNumber]
      ,[EmailAddress]
      --,[DateOfBirth]
      ,[SalesAgentCode] as ReferralCode
	  , B.BankCode
	  , B.AcctNumber
	  , P.Description
  FROM Cust_Customers C
	inner join [IOFS].[dbo].[MFilesFreelanceAgent] A
		on C.CustAID = A.CustomerNumber
	Left join Op_ContactsBankInfo B
		on B.ParentRowID = C.ID#
	inner join pParams P
		on 	P.Type = 'BANKNAMES' and P.Code = B.BankCode


  --Select * from pParams
  --Where Type like '%BANK%'