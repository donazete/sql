-- Balances as at 

SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, Sum(Case txntype
		When 0 Then Qty
		Else Qty * -1
	End) as Qty
	,  Sum(Case txntype
		When 0 Then Amount
		Else Amount * -1
	End) Amount
	, (SELECT Sum([DailyReturn])
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = O.FundCode and CustAID = O.CustAID and AllotDate <= '12/31/2017') as AccruedInt
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 53 and OwnerTableID = (Select ID# from Cust_Customers where CustAID = O.CustAID)) as DividendOpt
FROM OP_MFTxns2 O
wHERE FundCode = 'ABACUS' and Date <= '05/31/2018'
Group by Custaid
	, Fundcode, AID, Sub
Having Sum(Case txntype
		When 0 Then Qty
		Else Qty * -1
	End) >= 1
ORDER BY Custaid

--select * FROM OP_MFTxns2



SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (select top 1 BidPrice from IWVW_MFValuation2 where MFCode = O.FundCode and ValuationDate <= '12/31/2017'  order by ValuationDate desc) as NAV
	, (SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 12 and OwnerTableID = (Select ID# from Cust_Customers where CustAID = O.CustAID)) as DividendOpt
FROM OP_MFTxns2 O
wHERE FundCode = 'VBF' and Date <= '12/31/2017'
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Custaid
select top 1 * from IWVW_MFValuation2


SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (select top 1 UnitPrice from IWVW_MFValuation2 where MFCode = O.FundCode and ValuationDate = '12/31/2017' order by ValuationDate desc) as NAV
FROM OP_MFTxns2 O
wHERE FundCode = 'KEDARI' and Date <= '12/31/2017'
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Custaid



--select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10]('10808', 'vbf')
--order by ID desc
--select * from [dbo].[IWfn_PM_WAC_FrmInceptionV10]('10808', 'vbf')


SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (SELECT Sum([DailyReturn])
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = O.FundCode and CustAID = O.CustAID) as AccruedInt
	, (select top 1 UnitPrice from OP_MFValuation where MFCode = O.FundCode order by ValuationDate desc) as NAV
FROM OP_MFTxns2 O
wHERE FundCode in ('TGF', 'MEDWEALTH', 'IPS2', 'IPSPLUS', 'CHDTRST')
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Fundcode, Custaid


-- Differential transaction 

SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, Sum(Case txntype
		When 0 Then Qty
		Else Qty * -1
	End) as Qty
	,  Sum(Case txntype
		When 0 Then Amount
		Else Amount * -1
	End) Amount
	, (SELECT Sum([DailyReturn])
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = O.FundCode and CustAID = O.CustAID) as AccruedInt
FROM OP_MFTxns2 O
wHERE FundCode = 'ABACUS'
ORDER BY Custaid

--select * FROM OP_MFTxns2



SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (SELECT Sum([DailyReturn])
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = O.FundCode and CustAID = O.CustAID) as AccruedInt
FROM OP_MFTxns2 O
wHERE FundCode = 'VBF'
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Custaid


SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (select top 1 UnitPrice from IWVW_MFValuation2 where MFCode = O.FundCode order by ValuationDate desc) as NAV
FROM OP_MFTxns2 O
wHERE FundCode = 'KEDARI'
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Custaid



--select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10]('10808', 'vbf')
--order by ID desc
--select * from [dbo].[IWfn_PM_WAC_FrmInceptionV10]('10808', 'vbf')


SELECT Custaid
	, Fundcode
	, AID+Sub AS ucc
	, (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) as Qty
	,  (select top 1 CumCost from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) Amount
	, (SELECT Sum([DailyReturn])
	  FROM [IWGI].[dbo].[IOFS_MMFundReturnsAllot]
	  Where FundCode = O.FundCode and CustAID = O.CustAID) as AccruedInt
	, (select top 1 UnitPrice from OP_MFValuation where MFCode = O.FundCode order by ValuationDate desc) as NAV
FROM OP_MFTxns2 O
wHERE FundCode in ('TGF', 'MEDWEALTH', 'IPS2', 'IPSPLUS', 'CHDTRST')
Group by Custaid
	, Fundcode, AID, Sub
Having (select top 1 CumUnits from [dbo].[IWfn_PM_WAC_FrmInceptionV10](O.Custaid, O.FundCode)
		order by ID desc) >= 1
ORDER BY Fundcode, Custaid

--Select Distinct Trans#
--	, CustID
--	, InstrumentType
--	, (select top 1 principal from OP_IFund_Trans where Trans# = I.Trans# order by ID# desc) as Principal
--	, (select top 1 MaturityDate from OP_IFund_Trans where Trans# = I.Trans# order by ID# desc) as MaturityDate
--	, (select top 1 InterestRate from OP_IFund_Trans where Trans# = I.Trans# order by ID# desc) as Interestrate
--	, (select SUM(AccruedInterest) from [dbo].[IWfn_IFundPositionGeneric](I.CustID, '11/22/2017', 0)
--		Where TransNo = I.Trans#) as AccruedInt
--	, CPGLAid
--	, (select top 1 Tenure from OP_IFund_Trans where Trans# = I.Trans# order by ID#) as Tenure
--From OP_IFund_Trans I
--Where Liquidated = 0
--order by CPGLAid

--Select *
--From OP_IFund_Trans where Trans# = 3775114

--select * from OP_IFund_Trans where Trans# = 3780695 order by ID# desc

--select top 1 principal from OP_IFund_Trans where Trans# = 3780681 order by ID# desc

--select SUM(AccruedInterest) from [dbo].[IWfn_IFundPositionGeneric]('15635', '11/22/2017', 0)
--Where TransNo = I.Trans#


--select * from IWVW_Cust_Customers
--Where CustAID not in (Select Distinct Custaid from Cust_Involvements)


