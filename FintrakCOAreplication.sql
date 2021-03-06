/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID]
      ,[Description]
      ,[AccountCategoryID]
      ,[BalanceSheetOrder]
      ,[IncomeSheetOrder]
      ,[Active]
      ,[SubCaptionID]
  FROM [FinTrakFundManager].[dbo].[ts_Finance_AccountType]

  Select * from ts_Finance_ChartOfAccount
  WHere AccountTypeID = 510000 

  Select * from ts_Finance_ChartOfAccountCode
  WHere Accountid in (Select AccountID from ts_Finance_ChartOfAccountCode
  Where AccountID in (Select AccountID from ts_Finance_ChartOfAccount
  WHere AccountTypeID = 510000) and coyid = 1) and coyid != 1 and coyID != 4
  order by coyID, AccountID