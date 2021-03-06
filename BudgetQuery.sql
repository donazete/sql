/****** Script for SelectTopNRows command from SSMS  ******/
--SELECT [ID]
--      ,[Caption]
--      ,[MIS_Code]
--      ,[Year]
--      ,[Mth1]
--      ,[Mth2]
--      ,[Mth3]
--      ,[Mth4]
--      ,[Mth5]
--      ,[Mth6]
--      ,[Mth7]
--      ,[Mth8]
--      ,[Mth9]
--      ,[Mth10]
--      ,[Mth11]
--      ,[Mth12]
--      ,[FullYear]
--      ,[lastupdated]
--  FROM [BudgetDB].[dbo].[Income_PlannedIncome]
--  where [year] = 2017 and Caption not like 'N/A%'


  --select distinct level8, Level8Name
  --FROM [BudgetDB].[dbo].[Team]

  /* Investigation query */
  select distinct MIS_Code
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
  where B.[year] = 2017 and B.Caption not like 'N/A%'
  order by MIS_Code




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
		,[Year]
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
			  ,B.[Year] as [Year]
  FROM [BudgetDB].[dbo].[Income_PlannedIncome] B
	inner join [BudgetDB].[dbo].[Team] T
		on T.Level1 = B.MIS_Code
  where B.Caption not like 'N/A%') C
  Group by [Year], MPRCaption, Company, CoyCode
		, CompanyMIS
  --order by MIS_Code



  select Distinct Caption
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




  CREATE VIEW vw