Declare @StDate as DateTime
Declare @EndDate as DateTime
Declare @CoyCode as Integer

set @StDate = '04/01/2017'
set @EndDate = '04/30/2017'
set @CoyCode = 1 --(select coyID from [dbo].[ts_CompanyInfo])



--select month(@EndDate)
--select '01/01/'+Convert(Varchar, Year(@EndDate)) 

--select M.* 
--from dbo.vw_IOFSMPRMapping M
------le

--select top 100 * from vw_IOFSFinanceTrans
 
 /* MPR Per Company Analysis Query */
-- Select Caption
--	, CaptionID
--	, Case CaptionID
--		When 3 Then 'Operating Expense'
--		else 'Operating Income'
--		End as CaptionGrp
--	, SubCaption
--	, Sum(MTDValue) MTDValue
--	, Sum(YTDAmount) YTDAmount
--	--,AccountCategoryID
--	, sCoyCode
--	, CI.coyName
--	, CaptionOrder
--	, Itemorder
--from (Select T.AccountID
--	, M.Acct
--	, M.CaptionID
--	, M.Caption
--	, M.SubCaption
--	, M.AccountName
--	--, C.AccountCategoryID
--	, Sum(Amt) as MTDValue
--	, (Select Sum(Amt) from vw_IOFSFinanceTrans where AccountID = T.AccountID and sCoyCode = T.sCoyCode and ValueDate between '01/01/'+Convert(Varchar, Year(@EndDate)) and @EndDate) as YTDAmount
--	, T.sCoyCode
--	, M.CoyID
--	, M.CaptionOrder
--	, M.ItemOrder
--	, M.Report
-- from vw_IOFSFinanceTrans T
--	left join [dbo].[ts_Finance_ChartOfAccount] C
--		on T.AccountID = C.AccountID
--	left join dbo.vw_IOFSMPRMapping M
--		on T.AccountID = M.Acct and T.sCoycode = M.CoyID
--Where C.AccountCategoryID IN (4,5) and T.ValueDate between @StDate and @EndDate and T.scoycode IN (@CoyCode)
--Group by T.AccountID, T.sCoyCode, M.Acct
--	, M.CaptionID
--	, M.Caption
--	, M.AccountName, M.CoyID
--	, M.CaptionOrder
--	, M.ItemOrder
--	, M.Report, M.SubCaption
----order by T.AccountID, T.sCoyCode
--) B
--	inner join ts_CompanyInfo CI
--		on CI.CoyID = B.sCoyCode
--Group by Caption
--	, SubCaption,CaptionID,sCoyCode, CI.coyName,CaptionOrder
--	, Itemorder
--Order by CaptionOrder
--	, Itemorder


--select * from vw_IOFSBudgetMPRLink
--where year = 2017 and coycode = 1

/* MPR Per Company */
 Select Caption
	, CaptionID
	, Case CaptionID
		When 3 Then 'Operating Expense'
		else 'Operating Income'
		End as CaptionGrp
	, SubCaption
	, Sum(MTDValue) MTDValue
	, (Case
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
	, '' '%MTDBudget'
	, Sum(YTDAmount) YTDAmount
	, '' YTDBudget
	, '' '%YTDBudget'
	, (Select Sum(FullYear) from vw_IOFSBudgetMPRLink where MPRCaption = B.SubCaption and [Year] = Year(@EndDate) and coyCode = B.sCoyCode) FullYearBudget
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
Order by CaptionOrder
	, Itemorder


/* Budget Query */


  select Company
		, CompanyMIS
		, CoyCode
		, MPRCaption
		,Sum(FullYear) as FullYear
		,Sum([Mth1]) as January
		,Sum([Mth2]) as February
		,Sum([Mth3]) as March
		,Sum([Mth4]) as April
		,Sum([Mth5]) as May
		,Sum([Mth6]) as June
		,Sum([Mth7]) as July
		,Sum([Mth8]) as August
		,Sum([Mth9]) as September
		,Sum([Mth10]) as October
		,Sum([Mth11]) as November
		,Sum([Mth12]) as December
  FROM (    select distinct MIS_Code
			, T.Level1
			, T.Level1Name as AcctOfficer
			, T.Level8Name as Company
			, T.Level8 as CompanyMIS
			, Case T.Level8
				When 'CAM900' Then 5
				When 'FIN300' Then 7
				When 'FMG800' Then 3
				When 'FSG700' Then 1
				When 'PEN400' Then 4
				When 'SBG600' Then 2
				When 'VEN500' Then 6
				Else 0
			End as CoyCode
			,B.[Caption]
			, Case 
				When B.[Caption] = 'Advisory Fee' Then 'Fee income'
				When B.[Caption] = 'Corporate stock broking' Then 'Brokerage Fee and Other income'
				When B.[Caption] = 'Depreciation' Then 'Operating expenses'
				When B.[Caption] = 'Interest Expense' Then 'Interest expense'
				When B.[Caption] = 'Interest Income' Then 'Interest income'
				When B.[Caption] = 'Investment Income' Then 'Investment income'
				When B.[Caption] = 'Management fees income' Then 'Management fee Income'
				When B.[Caption] = 'MTM' Then 'MTM on Equities and Bonds'
				When B.[Caption] = 'Other Income' Then 'Other income'
				When B.[Caption] = 'Other Operating Expenses' Then 'Operating expenses'
				When B.[Caption] = 'Staff Related Expenses' Then 'Staff costs'
				When B.[Caption] = 'Treasury Mgt. Income(bond,Tbills Trading)' Then 'Treasury Mgt income'
				When B.[Caption] = 'Trustee Fee Income' Then 'Trustee Fee Income'
				else ''
			End as MPRCaption
			,B.FullYear
			,[Mth1]
			  ,[Mth2]
			  ,[Mth3]
			  ,[Mth4]
			  ,[Mth5]
			  ,[Mth6]
			  ,[Mth7]
			  ,[Mth8]
			  ,[Mth9]
			  ,[Mth10]
			  ,[Mth11]
			  ,[Mth12]
  FROM [BudgetDB].[dbo].[Income_PlannedIncome] B
	inner join [BudgetDB].[dbo].[Team] T
		on T.Level1 = B.MIS_Code
  where B.[year] = 2017 and B.Caption not like 'N/A%') C
  Group by MPRCaption, Company, CoyCode
		, CompanyMIS
  --order by MIS_Code


  select *  FROM Fintrak214.[BudgetDB].[dbo].[Income_PlannedIncome]





/* MPR Investigation query     */
Select T.AccountID
	, M.Acct
	, M.CaptionID
	, M.Caption
	, M.SubCaption
	, M.AccountName
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
Where C.AccountCategoryID IN (4,5) and T.ValueDate between @StDate and @EndDate and T.scoycode IN (@CoyCode)
Group by T.AccountID, T.sCoyCode, M.Acct
	, M.CaptionID
	, M.Caption
	, M.AccountName, M.CoyID
	, M.CaptionOrder
	, M.ItemOrder
	, M.Report, M.SubCaption
order by T.AccountID, T.sCoyCode