Declare @EndDate as datetime
Declare @StDate as datetime
Declare @CoyCode as varchar(10)


set @StDate = '04/01/2017'
set @EndDate = '04/30/2017'
set @CoyCode = '2'

Select HCaption
	, Sum(MTDValue) as MTDValue
	, Sum(YTDAmount) as YTDAmount
	, Sum(MTDBudget) as MTDBudget
	, Sum(YTDBudget) as YTDBudget
	, Sum(FullYearBudget) as FullYearBudget
	, Case HCaption
		When 'Revenue' Then (Select sum(Amt)/12 FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Income' and [CoyCode] = sCoyCode)
		Else (Select (sum(Amt) * -1)/12 FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Expense' and [CoyCode] = sCoyCode)
	End as MTDBudgetTemp
	, Case HCaption
		When 'Revenue' Then (Select sum(Amt)/12 * Month(@EndDate) FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Income' and [CoyCode] = sCoyCode)
		Else (Select (sum(Amt) * -1)/12  * Month(@EndDate) FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Expense' and [CoyCode] = sCoyCode)
	End as YTDBudgetTemp
	, Case HCaption
		When 'Revenue' Then (Select sum(Amt) FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Income' and [CoyCode] = sCoyCode)
		Else (Select sum(Amt) * -1 FROM [FinTrakFundManager].[dbo].[IOFS_TempBudget] Where [BudgetYear] = Year(@EndDate) and [BudgetItem] = 'Expense' and [CoyCode] = sCoyCode)
	End as FullYearBudgetTemp
	, sCoyCode
	, CI.coyName
From (Select Case CaptionID
			When 3 then 'Expense'
			Else 'Revenue'
		End as HCaption
	, Subcaption
	, Sum(MTDValue) as MTDValue
	, Sum(YTDAmount) as YTDAmount
	,(Case
		When Month(@EndDate) = 1 Then (Select January from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 2 Then (Select February from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 3 Then (Select March from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 4 Then (Select April from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 5 Then (Select May from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 6 Then (Select June from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 7 Then (Select July from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 8 Then (Select August from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 9 Then (Select September from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 10 Then (Select October from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 11 Then (Select November from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 12 Then (Select December from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		Else ''
	End) MTDBudget
	, (Case
		When Month(@EndDate) = 1 Then (Select January from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 2 Then (Select (January + February) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 3 Then (Select (January + February + March) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 4 Then (Select (January + February + March + April) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 5 Then (Select (January + February + March + April + May) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 6 Then (Select (January + February + March + April + May + June) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 7 Then (Select (January + February + March + April + May + June + July) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 8 Then (Select (January + February + March + April + May + June + July + August) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 9 Then (Select (January + February + March + April + May + June + July + August + September) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 10 Then (Select (January + February + March + April + May + June + July + August + September + October) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 11 Then (Select (January + February + March + April + May + June + July + August + September + October + November) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 12 Then (Select (January + February + March + April + May + June + July + August + September + October + November + December) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		Else ''
	End) YTDBudget
	, (Select Sum(FullYear) from vw_IOFSBudgetMPRLink where MPRCaption = B.SubCaption and [Year] = Year(@EndDate) and coyCode = B.sCoyCode) FullYearBudget
	, sCoyCode
from (Select T.AccountID
	, M.Acct
	, M.CaptionID
	, M.Caption
	, M.SubCaption
	, M.AccountName
	--, C.AccountCategoryID
	, Sum(Amt) as MTDValue
	, (Select Sum(Amt) from vw_IOFSFinanceTrans where AccountID = T.AccountID and sCoyCode = T.sCoyCode and ValueDate between '01/01/'+Convert(Varchar, Year(@EndDate)) and @EndDate) as YTDAmount
	, T.sCoyCode
	, M.CoyID
	, M.CaptionOrder
	, M.ItemOrder
	, M.Report
 from vw_IOFSFinanceTrans T
	left join [dbo].[ts_Finance_ChartOfAccount] C
		on T.AccountID = C.AccountID
	left join dbo.vw_IOFSMPRMapping M
		on T.AccountID = M.Acct and T.sCoycode = M.CoyID
Where C.AccountCategoryID IN (4,5) and T.ValueDate between @StDate and @EndDate --and T.scoycode IN (@CoyCode)
Group by T.AccountID, T.sCoyCode, M.Acct
	, M.CaptionID
	, M.Caption
	, M.AccountName, M.CoyID
	, M.CaptionOrder
	, M.ItemOrder
	, M.Report, M.SubCaption
--order by T.sCoyCode
) B
Group By CaptionID, Subcaption, sCoyCode
) C
	inner join ts_CompanyInfo CI
		on CI.CoyID = C.sCoyCode
Group by HCaption, sCoyCode, CI.coyName

Union

Select BudgetItem as HCaption
	, (Amt * -1) / 12 as MTDValue
	, (Amt * -1) * Month(@EndDate) / 12 as YTDAmount
	, (Amt * -1) / 12 as MTDBudget
	, (Amt * -1) * Month(@EndDate) / 12 as YTDBudget
	, (Amt * -1) as FullYearBudget
	, (Amt * -1) / 12 as MTDBudgetTemp
	, (Amt * -1) * Month(@EndDate) / 12 as YTDBudgetTemp
	, (Amt * -1) as FullYearBudgetTemp
	, CoyCode as sCoyCode
	, Case Coycode
		When 1 then 'FINANCIAL SERVICES'
		When 2 then 'STOCKBROKING'
		When 3 then 'FUNDS MGT'
		When 4 then 'PENSION'
		When 5 then 'CAPITAL MGT'
		When 6 then 'VENTURE CAPITAL'
		When 7 then 'ORANGE ONE FINANCE LTD.'
		Else 'IVO'
	End as CoyName
From [dbo].[IOFS_TempBudget]
Where BudgetItem = 'Indirect Expense' and [BudgetYear] = Year(@EndDate)
order by sCoyCode
