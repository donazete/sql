/****** Script for SelectTopNRows command from SSMS  ******/
SELECT ID#, [FundCode]
      ,[Date]
      ,[CustAID]
      ,[AID]
      ,[Sub]
	  , [AID] + [Sub]
      ,[UnitPrice]
      ,[BidPrice]
      ,[OfferPrice]
      ,[TxnType]
      ,[Qty]
      ,[Amount]
  FROM [IWGI].[dbo].[OP_MFTxns2]
  wHERE FundCode in ('MEDWEALTH') and Date >= '08/31/2018'
  order by FundCode, Date

  select * from OP_MFTxns2
  Where FundCode = 'kedari' and CustAID = '3089'



  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT [FundCode]
      ,[Date]
      ,[CustAID]
      ,[AID]
      ,[Sub]
	  , [AID] + [Sub]
      ,[UnitPrice]
      ,[BidPrice]
      ,[OfferPrice]
      ,[TxnType]
      ,[Qty]
      ,[Amount]
  FROM [IWGI].[dbo].[OP_MFTxns2]
  wHERE FundCode in ('VBF') and Date <= '05/31/2018'
  order by FundCode, Date


  Select 'GIS' as Fundcode
	, EffectiveDate
	, Sub
	, AccountID
	, AccountID + Sub
	, 1 as UnitPrice
	, Case 
		 When Amount < 0 Then 'R'
		 Else 'P'
	End as TxnType
	, ABS(Amount)as Qty
	, ABS(Amount) as Amount
  from Acct_GL
  Where EffectiveDate <= '05/31/2018' and AccountID = '3003' and Sub in (Select SUB
						  from Acct_GL
						  Where EffectiveDate <= '05/31/2018' and AccountID = '3003'
						  Group by SUB
						  Having SUM(Amount) > 0) and SysRef not like 'REVERS%'

select * from OP_MFTxns2
Where FundCode = 'ABACUS'

-- ABACUS

Select Distinct CustAID
	, 'ABACUS' as Fundcode
	, (Select top 1 ID# from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as IDNum
	, (Select top 1 Date from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as TxnDate
	, (Select top 1 TxnType from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as TxnType
	, (Select top 1 BidPrice from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as BidPrice
	, (Select top 1 Qty from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as Qty
	, (Select top 1 Amount from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as Amount
	, (SELECT ISNULL(Sum([DailyReturn]),0)
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = 'ABACUS' and CustAID = O.CustAID and AllotDate <= '05/31/2018') as AccruedInt
	, 'A' as Ident
from OP_MFTxns2 O
Where FundCode = 'ABACUS' and Date <= '05/31/2018'


union 

Select Custaid
	, FundCode
	, ID# as IDNum
	, Date
	, TxnType
	, BidPrice
	, Qty
	, Amount
	, 0 as AccruedInt
	, 'B' as Ident
from OP_MFTxns2 O
Where FundCode = 'ABACUS' and Date <= '05/31/2018' 
	and ID# not in (Select IDNum  
		from (Select Distinct CustAID
				, 'ABACUS' as Fundcode
				, (Select top 1 ID# from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as IDNum
				, (Select top 1 Date from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as TxnDate
				, (Select top 1 TxnType from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as TxnType
				, (Select top 1 BidPrice from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as BidPrice
				, (Select top 1 Qty from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as Qty
				, (Select top 1 Amount from OP_MFTxns2 where FundCode = 'ABACUS' and CustAID = O.CustAID and TxnType = 0 order by Date desc) as Amount
				, (SELECT ISNULL(Sum([DailyReturn]),0)
				  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
				  Where FundCode = 'ABACUS' and CustAID = O.CustAID and AllotDate <= '05/31/2018') as AccruedInt
			from OP_MFTxns2 O
			Where FundCode = 'ABACUS' and Date <= '05/31/2018') A)
AND O.TxnType = 0

			Select * from OP_MFTxns2
			Where FundCode = 'ABACUS' and Date <= '05/31/2018'


			--Select Distinct CustAID from OP_MFTxns2
			--Where FundCode = 'ABACUS' and Date <= '05/31/2018'
			--and TxnType = 0




IF Object_id('tempdb.dbo.#tblTransaction') IS NOT NULL DROP TABLE #tblTransaction
select ROW_NUMBER () OVER (PARTITION BY Custaid ORDER BY Custaid, ID#) As ROWNO
       , Custaid
       , FundCode
       , ID# 
       , Date
       , TxnType
       , BidPrice
       , Qty
       , Amount
       , ACC.AccruedInterest  as AccruedInt
       , 'B' as Ident
INTO #tblTransaction
from OP_MFTxns2 O
       OUTER APPLY
              (
                     SELECT ISNULL(Sum([DailyReturn]),0) AS AccruedInterest
                             FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
                             Where FundCode = 'ABACUS' and CustAID = O.CustAID and AllotDate <= '05/31/2018'
              ) ACC
Where FundCode = 'ABACUS' and Date <= '05/31/2018' 
order by custaid

UPDATE A
	SET A.[AccruedInt] = 0
FROM #tblTransaction A
	CROSS APPLY
		(
			SELECT MAX(B.Custaid) AS Custaid, MAX(B.ID#) AS ID# FROM #tblTransaction B
			WHERE B.[Custaid] = A.[Custaid]
			GROUP BY B.[Custaid]
		) MID
WHERE A.[ID#] <> MID.[ID#] 

SELECT '2204'+CustAID,* 
FROM #tblTransaction
order by date