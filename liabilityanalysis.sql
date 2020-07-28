SELECT DISTINCT Trans#
	, CustID
	, InterestRate
	, (Select top 1 EffectiveDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as EffectiveDate
	, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as InitMaturityDate
	, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as ActualMaturityDate
	, (Select top 1 Principal From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommPrincipal
	, (Select top 1 Principal From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as CurrPrincipal
	, (Select top 1 Tenure From OP_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommTenure
	, datediff(dd, (Select top 1 EffectiveDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#)
	, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID# desc)) as CurrTenure
	, Liquidated
	, CPGLAid
From OP_IFund_Trans P
Where(CONVERT(VARCHAR, @EnDate, 112) >= CONVERT(VARCHAR, (Select top 1 EffectiveDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#), 112) )
	AND (CONVERT(VARCHAR, @StDate, 112) <= CONVERT(VARCHAR, (Select top 1 MaturityDate From OP_IFund_Trans Where Trans# = P.Trans# order by ID#), 112) )
ORDER BY Trans#