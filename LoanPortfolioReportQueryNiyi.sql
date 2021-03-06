/****** Script for SelectTopNRows command from SSMS  ******/
Declare @Dt as Datetime
Declare @StDt as Datetime
Declare @Liquidated as bit
Declare @InsType as varchar(10)

Set @StDt = '01/01/2000'
Set @Dt = GETDATE()
Set @Liquidated = 0
Set @InsType = '7004'

SELECT Case L.LoanType
		When 0 Then 'Reducing Balance'
		When 1 Then 'Fixed'
		When 2 Then 'Interest only'
		When 3 Then 'Fixed Rate Flexible'
		When 4 Then 'Interest Only Flexible'
		When 5 Then 'Reducing Balance with no compunding'
		When 6 Then 'Straight line'
		Else ''
		End as LoanType
      ,L.TransNo
      ,L.CustAID
      ,L.LoanAmount as RequestedAmt
	  , D.Amount as DisbursedAmt
	  , D.Amount - (SELECT ISNULL(Sum([PComponent]),0)
		  FROM [IWGI].[dbo].[LoanRepayments] R
		  Where Date <= @Dt and L.ID# = R.AppLnID) as OutstandingPrin
      ,L.Interest
	  ,(L.PrincipalPlusInterest - L.LoanAmount) - (SELECT ISNULL(Sum([IComponent]), 0)
		  FROM [IWGI].[dbo].[LoanRepayments] R
		  Where Date <= @Dt and L.ID# = R.AppLnID) as OutstandingInt
      ,L.PerMonthInterest
      ,L.RepaymentPeriod
      ,L.CommencementDate
	  ,D.EffectiveDate as DisbursementDate
      ,L.MaturityDate
      ,L.PrincipalPlusInterest
	  ,L.PrincipalPlusInterest - (SELECT ISNULL(Sum([AmtRepayed]), 0)
		  FROM [IWGI].[dbo].[LoanRepayments] R
		  Where Date <= @Dt and L.ID# = R.AppLnID) as TotalOutstanding
      ,(SELECT ISNULL(Sum([AmtRepayed]),0)
		  FROM [IWGI].[dbo].[LoanRepayments] R
		  Where Date <= @Dt and L.ID# = R.AppLnID) as TotalRepayment
	  ,L.DeductionPerMonth
      ,L.CommitmentFee
      ,L.LegalCharges
      ,L.OtherCharges
      ,L.PenalRate
      ,L.LoanAID
      ,L.LoanSub
      ,L.LoanIntAID
      ,L.LoanIntSub
      ,L.LoanFeesAID
      ,L.LoanFeesSub
      ,L.Approved
      ,L.ApprovalDate
      ,L.ApprovedBy
      ,L.Liquidated
      ,L.LiquidationDate
      ,L.LiquidatedBy
      ,L.LiquidationType
      ,L.OutstandingLoanAmt
      ,L.SkippedMonths
      ,L.IRR
      ,L.InstrumentType
  FROM IWGI.dbo.Loans L
	inner join [dbo].[LoanDisbursements] D
		on D.LoanID = L.ID#
Where L.CommencementDate between @StDt and @Dt and Liquidated = @Liquidated and L.LoanAID = @InsType

Select distinct LoanAID
From dbo.Loans
Where LoanAID not in ('1000', '1003')