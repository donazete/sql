Declare @StDate as Datetime
Declare @EnDate as Datetime
Declare @Coycode as int
Declare @Acct as varchar(10)
Declare @Line as varchar(150)
Declare @Dept as varchar(150)

Set @StDate = '01/01/2018'
Set @EnDate = '11/30/2018'
Set @Coycode = 2 -- (Select coyid FROM [FinTrakFundManager].[dbo].[ts_CompanyInfo] where coyid != 'IVO')
Set @Acct = '500015'
Set @Line = 'Salaries'

/* Query for single account Enquiry */
--SELECT E.[Department]
--      ,E.[ExpenseLine]
--      ,E.[Account]
--	  , C.AccountName
--	  , T.AccountID
--	  , T.TransactionDate
--	  , DateName(Month, T.TransactionDate) as [Month]
--	  , Month(T.TransactionDate) as MonthVal
--	  , T.Description
--	  , T.sCoyCode as CoyCode
--	  , Case
--			When DebitAmt > 0 Then DebitAmt * -1
--			When CreditAmt > 0 Then CreditAmt
--			Else 0
--		End As Amount
--  FROM [IOFS].[dbo].[ExpenseMapping] E
--	inner join FinTrakFundManager.dbo.ts_Finance_Transaction T
--		on T.AccountID = E.Account
--	inner join FinTrakFundManager.dbo.ts_Finance_ChartOfAccount C
--		on C.AccountID = E.Account
--WHERE T.TransactionDate between @StDate and @EnDate and T.Approved = 1 and T.sCoyCode in (@Coycode) and E.Account = @Acct
--order by T.TransactionDate

/* Query for single line breakdown */
SELECT E.[Department]
      ,E.[ExpenseLine]
      ,E.[Account]
	  , C.AccountName
	  , T.AccountID
	  , T.TransactionDate
	  , DateName(Month, T.TransactionDate) as [Month]
	  , T.Description
	  , Case
			When DebitAmt > 0 Then DebitAmt * -1
			When CreditAmt > 0 Then CreditAmt
			Else 0
		End As Amount
  FROM [IOFS].[dbo].[ExpenseMapping] E
	inner join FinTrakFundManager.dbo.ts_Finance_Transaction T
		on T.AccountID = E.Account
	inner join FinTrakFundManager.dbo.ts_Finance_ChartOfAccount C
		on C.AccountID = E.Account
WHERE T.TransactionDate between @StDate and @EnDate and T.Approved = 1 and T.sCoyCode in (@Coycode) and E.ExpenseLine = @Line


/* Query for Expense analysis */
--SELECT E.[Department]
--      ,E.[ExpenseLine]
--      ,E.[Account]
--	  , C.AccountName
--	  , T.AccountID
--	  , T.TransactionDate
--	  , DateName(Month, T.TransactionDate) as [Month]
--	  , T.Description
--	  , Case
--			When DebitAmt > 0 Then DebitAmt * -1
--			When CreditAmt > 0 Then CreditAmt
--			Else 0
--		End As Amount
--  FROM [IOFS].[dbo].[ExpenseMapping] E
--	inner join FinTrakFundManager.dbo.ts_Finance_Transaction T
--		on T.AccountID = E.Account
--	inner join FinTrakFundManager.dbo.ts_Finance_ChartOfAccount C
--		on C.AccountID = E.Account
--WHERE T.TransactionDate between @StDate and @EnDate and T.Approved = 1 and T.sCoyCode in (@Coycode) and E.[Department] IN (@Dept)


--Select *
--FROM [IOFS].[dbo].[ExpenseMapping]
--order by Department