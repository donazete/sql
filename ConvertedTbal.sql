/****** Script for SelectTopNRows command from SSMS  ******/
SELECT F.[Company]
, Case
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode1] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode1] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode2] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode2] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode3] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode3] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode4] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode4] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode5] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode5] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode6] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode6] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode7] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode7] and Company = 'ORANGE')
	When (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode8] and Company = 'ORANGE') IS NOT NULL Then (Select [LedgerID] from Fintrak.[dbo].[Fintrak_AcctMapping] where F.FinAcct = [OldLedgerCode8] and Company = 'ORANGE')
    Else ''
End as LedgerID
	  ,F.[AcctID]
      ,F.[FinAcct]
      ,F.[Sub]
      ,F.[Description]
      ,F.[Amount]
  FROM [dbo].[Fin_TBalConv] F
Where F.Company = 'ORANGE' --and G.Company = 'ORANGE'
order by ledgerid--, LedgerID2, LedgerID3, ledgerid4, LedgerID5, LedgerID6,ledgerid7, LedgerID8


--SELECT Sum(F.[Amount])
--  FROM [dbo].[Fin_TBalConv] F
--	left join Fintrak.[dbo].[Fintrak_AcctMapping] G
--		on F.FinAcct = G.[OldLedgerCode1] --or F.FinAcct = G.[OldLedgerCode2] or F.FinAcct = G.[OldLedgerCode3] or F.FinAcct = G.[OldLedgerCode4]
--			or F.FinAcct = G.[OldLedgerCode5]
--Where F.Company = 'ORANGE'
--order by g.ledgerid


--Select F.[FinAcct]
--      , Count( F.[FinAcct])
--  FROM [dbo].[Fin_TBalConv] F
--  Group by  F.[FinAcct]



--  Select [LedgerID], [OldLedgerCode1], Count([LedgerID])
--  from Fintrak.[dbo].[Fintrak_AcctMapping]
--  Group by [LedgerID], [OldLedgerCode1]
--  order by [OldLedgerCode1], [LedgerID]

--Select [LedgerID], [OldLedgerCode1]--, Count([LedgerID])
--  from Fintrak.[dbo].[Fintrak_AcctMapping]
--  Where [OldLedgerCode1] = '102001'
