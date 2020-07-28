select Sum(Case TxnType
		When 0 Then Qty
		Else Qty * -1
	End) as Units
From OP_MFTxns2
Where FundCode = 'VBF' and Date <= '11/23/2017'


Select distinct Trans#
	, CustID
	, InterestRate
	, (Select top 1 EffectiveDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as EffectiveDate
	, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as InitMaturityDate
	, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as ActualMaturityDate
	, (Select top 1 Principal From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommPrincipal
	, (Select top 1 Principal From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as CurrPrincipal
	, (Select top 1 Tenure From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommTenure
	, datediff(dd, (Select top 1 EffectiveDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#), (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc)) as CurrTenure
	, Liquidated
	, CPGLAid
From OP_IFund_Trans P
Where (Select top 1 Year(MaturityDate) From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc) >= 2017-- YEAR(MaturityDate) >= 2017 
order by Trans#



Select top 100 *
From OP_IFund_Trans