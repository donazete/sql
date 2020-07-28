Declare @TxnType as Int
Declare @StDate as Datetime
Declare @EnDate as Datetime

Set @StDate = '01/01/2019'
Set @EnDate = '12/31/2019'
Set @TxnType = 0

IF @TxnType = 0
SELECT DISTINCT P.Trans#
, CustID
, InterestRate
, EffectiveDate
, MaturityDate as InitMaturityDate
, dbo.IOFS_getActualMaturityDt(P.Trans#, 0) as ActualMaturityDate
, OrigPrincipal
, dbo.IOFS_getCurrentPrincipal(P.Trans#, @StDate, 0) as CommPrincipal
,  dbo.IOFS_getCurrentPrincipal(P.Trans#, @EnDate, 0) as CurrPrincipal
, Tenure as CommTenure
, Case 
	When EffectiveDate < @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, @StDate, @EnDate) + 1
	When EffectiveDate = @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, @StDate, @EnDate)
	When EffectiveDate > @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, EffectiveDate, @EnDate)
	When EffectiveDate < @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, @StDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0)) + 1
	When EffectiveDate = @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, @StDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0))
	When EffectiveDate > @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, EffectiveDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0))
	End as InterestTenure
, datediff(dd, EffectiveDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0)) as CurrTenure
, [dbo].[IOFSfn_ComputeInterest](dbo.IOFS_getCurrentPrincipal(P.Trans#, @EnDate, 0), P.InterestRate, P.EffectiveDate, (Case 
	When EffectiveDate < @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, @StDate, @EnDate) + 1
	When EffectiveDate = @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, @StDate, @EnDate)
	When EffectiveDate > @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @EnDate Then datediff(dd, EffectiveDate, @EnDate)
	When EffectiveDate < @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, @StDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0)) + 1
	When EffectiveDate = @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, @StDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0))
	When EffectiveDate > @StDate And dbo.IOFS_getActualMaturityDt(P.Trans#, 0) < @EnDate Then datediff(dd, EffectiveDate, dbo.IOFS_getActualMaturityDt(P.Trans#, 0))
	End)) as PeriodInterest
, Liquidated
, CPGLAid
, SuspenseAID
, SuspenseSub
, PnlAID
, PnlSub
, InterestRecAID
, InterestRecSub
--, ISNULL(D.IntAccrued, 0) AccruedInterest
--, dbo.IOFSFn_getGLInterestAccrued(P.Trans#, @StDate, @EnDate, PnlAID, PnlSub) as GLIntAccrued
From OP_IFund_Trans P
	--OUTER APPLY (SELECT Distinct Trans#, SUM(Amount) As IntAccrued FROM (Select Description, SUBSTRING(Description, PATINDEX('%' + P.Trans# + '%', Description), LEN(P.Trans#)) as Trans#, Amount 
	--			from Acct_GL G
	--			Where Accountid = PnlAID and Sub = PnlSub and effectivedate between @StDate and @EnDate and BatchNo = 0) I
	--			Group by Trans#) D
Where @EnDate >= EffectiveDate AND @StDate <= MaturityDate and FirstRec = 1 and dbo.IOFS_getActualMaturityDt(P.Trans#, 0) >= @StDate 
ORDER BY P.Trans#
ELSE
SELECT DISTINCT Trans#
, CustID
, InterestRate
, (Select top 1 EffectiveDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#) as EffectiveDate
, (Select top 1 MaturityDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#) as InitMaturityDate
, (Select top 1 MaturityDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as ActualMaturityDate
, (Select top 1 Principal From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommPrincipal
, (Select top 1 Principal From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID# desc) as CurrPrincipal
, (Select top 1 Tenure From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#) as CommTenure
, datediff(dd, (Select top 1 EffectiveDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#)
, (Select top 1 MaturityDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID# desc)) as CurrTenure
, Liquidated
, CPGLAid
, SuspenseAID
, SuspenseSub
, PnlAID
, PnlSub
, InterestRecAID
, InterestRecSub
From AMPL_IFund_Trans P
Where(CONVERT(VARCHAR, @EnDate, 112) >= CONVERT(VARCHAR, (Select top 1 EffectiveDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#), 112) )
AND (CONVERT(VARCHAR, @StDate, 112) <= CONVERT(VARCHAR, (Select top 1 MaturityDate From AMPL_IFund_Trans Where Trans# = P.Trans# order by ID#), 112) ) and FirstRec = 1
ORDER BY Trans#
