/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [AccountID]
      ,[AccountName]
      ,[AccountTypeID]
      ,[AccountCategoryID]
      ,[AccountGroupID]
      ,[coyID]
      ,[brID]
      ,[CurrCode]
      ,[Costcode]
      ,[stCode]
      ,[UserName]
      ,[IncomeSheetOrder]
      ,[BalanceSheetOrder]
      ,[SystemUse]
      ,[AccountStatus]
      ,[BrSpecific]
      ,[DateCreated]
      ,[OldAccountID]
      ,[OldAccountID1]
      ,[OldAccountID2]
      ,[OldAccountID3]
      ,[FSCaptionCode]
  FROM [FinTrakFundManager].[dbo].[ts_Finance_ChartOfAccount]


 SELECT Distinct T.AccountID, C.AccountName, T.sCoyCode as CoyCode, C.AccountCategoryID
 FROM ts_Finance_Transaction T
	inner join [FinTrakFundManager].[dbo].[ts_Finance_ChartOfAccount] C
	on T.AccountID = C.AccountID
WHERE C.AccountCategoryID IN (4, 5)

union 

select T.AccountID, C.AccountName, T.coyID as CoyCode, C.AccountCategoryID
FROM ts_Finance_ChartOfAccountCode T
	inner join [FinTrakFundManager].[dbo].[ts_Finance_ChartOfAccount] C
	on T.AccountID = C.AccountID
WHERE C.AccountCategoryID IN (4, 5)

order by CoyCode, T.AccountID, C.AccountCategoryID
