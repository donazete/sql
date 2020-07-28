Declare @EndDate as datetime
Declare @StDate as datetime
Declare @CoyCode as varchar(10)


set @StDate = '04/01/2017'
set @EndDate = '04/30/2017'
--set @CoyCode = '2'


Select CaptionID
	, B.Subcaption
	, Case CaptionID
		When 3 Then 'Operating Expense'
		else 'Operating Income'
		End as CaptionGrp
	, Sum(MTDValue) MTDValue
	, (Case
		When Month(@EndDate) = 1 Then (Select Sum(January) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 2 Then (Select Sum(February) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 3 Then (Select Sum(March) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 4 Then (Select Sum(April) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 5 Then (Select Sum(May) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 6 Then (Select Sum(June) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 7 Then (Select Sum(July) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 8 Then (Select Sum(August) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 9 Then (Select September from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 10 Then (Select October from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 11 Then (Select November from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		When Month(@EndDate) = 12 Then (Select December from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate))
		Else ''
	End) MTDBudget
	, '' '%MTDBudget'
	, Sum(YTDAmount) YTDAmount
	, (Case
		When Month(@EndDate) = 1 Then (Select Sum(January) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 2 Then (Select Sum(January + February) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 3 Then (Select Sum(January + February + March) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 4 Then (Select Sum(January + February + March + April) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 5 Then (Select Sum(January + February + March + April + May) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 6 Then (Select Sum(January + February + March + April + May + June) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 7 Then (Select Sum(January + February + March + April + May + June + July) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 8 Then (Select Sum(January + February + March + April + May + June + July + August) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 9 Then (Select Sum(January + February + March + April + May + June + July + August + September) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 10 Then (Select Sum(January + February + March + April + May + June + July + August + September + October) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 11 Then (Select Sum(January + February + March + April + May + June + July + August + September + October + November) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		When Month(@EndDate) = 12 Then (Select Sum(January + February + March + April + May + June + July + August + September + October + November + December) from vw_IOFSBudgetMPRLink where Upper(MPRCaption) = Upper(B.SubCaption) and [Year] = Year(@EndDate) and coyCode = B.sCoyCode)
		Else ''
	End) YTDBudget
	, '' '%YTDBudget'
	, (Select Sum(FullYear) from vw_IOFSBudgetMPRLink where MPRCaption = B.SubCaption and [Year] = Year(@EndDate) and coyCode = B.sCoyCode) FullYearBudget
	, Case CaptionID
		When 3 Then (SELECT Amt/12 * -1
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Expense')
		else (SELECT Amt/12
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income')
		End as MTDBudgetTemp
	, (SELECT Sum(Amt/12 * -1)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		(SELECT Amt/12
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') MTDBudgetNet
	, Case CaptionID
		When 3 Then (SELECT (Amt/12) * -1 * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Expense')
		else (SELECT (Amt/12) * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income')
		End as YTDBudgetTemp
	, (SELECT Sum(Amt/12) * -1 * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		(SELECT (Amt/12) * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') as YTDBudgetNet
	, Case CaptionID
		When 3 Then (SELECT Amt * -1
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Expense')
		else (SELECT Amt
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income')
		End as FullYearBudgetTemp
	, (SELECT Sum(Amt) * -1
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		 (SELECT Amt
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') as FullYearBudgetNet
	--,AccountCategoryID
	, sCoyCode
	, CI.coyName
	, CaptionOrder
	, Itemorder
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
Where C.AccountCategoryID IN (4,5) and T.ValueDate between @StDate and @EndDate and T.scoycode = (@CoyCode)
Group by T.AccountID, T.sCoyCode, M.Acct
	, M.CaptionID
	, M.Caption
	, M.AccountName, M.CoyID
	, M.CaptionOrder
	, M.ItemOrder
	, M.Report, M.SubCaption
--order by T.AccountID, T.sCoyCode
) B
	inner join ts_CompanyInfo CI
		on CI.CoyID = B.sCoyCode
Group by Caption
	, SubCaption,CaptionID,sCoyCode, CI.coyName,CaptionOrder
	, Itemorder
--Order by CaptionOrder
--	, Itemorder

Union

Select 'Indirect Expense' as Caption
	, 4 as CaptionID
	, 'Indirect Expense' as  CaptionGrp
	, 'Indirect Expense' as SubCaption
	, (Amt * -1)/12 as MTDValue
	, (Amt * -1)/12 as MTDBudget
	, '' as '%MTDBudget'
	, (Amt * -1)/12 *  Month(@EndDate) as YTDAmount
	, (Amt * -1)/12 *  Month(@EndDate) as YTDBudget
	, '' as '%YTDBudget'
	, (Amt * -1) as FullYearBudget
	, (Amt * -1)/12 as MTDBudgetTemp
	,(SELECT Sum(Amt/12) * -1
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		(SELECT Amt/12
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') MTDBudgetNet
	, (Amt/12) * -1 * Month(@EndDate) as YTDBudgetTemp
	, (SELECT Sum(Amt/12) * -1 * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		(SELECT (Amt/12) * Month(@EndDate)
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') as YTDBudgetNet
	, (Amt * -1) as FullYearBudgetTemp
	, (SELECT Sum(Amt) * -1
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem like '%Expense') +
		 (SELECT Amt
						  FROM [dbo].[IOFS_TempBudget]
						  Where CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Income') as FullYearBudgetNet
	, CoyCode
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
	, 4 as CaptionOrder
	, 1 as ItemOrder
From [dbo].[IOFS_TempBudget] T
Where T.CoyCode = @CoyCode and BudgetYear = Year(@EndDate) and BudgetItem = 'Indirect Expense'

Order by CaptionOrder
	, Itemorder
