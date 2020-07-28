declare @MFCode as varchar(10)
declare @Dt as datetime
Set @MFCode = 'ABACUS'
Set @Dt = getdate()

Select MF.MFCode
		, 'Gross Asset Value' as Description
		, (Sum(Amount) * -1) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('A100')
Group by MF.MFCode

Union All

Select MF.MFCode
		, 'Total Liabilities' as Description
		, (Sum(Amount) * -1) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('L100')
Group by MF.MFCode

Union All

Select MF.MFCode
		, 'Total Income' as Description
		, Sum(Amount) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('I100')
Group by MF.MFCode

Union All

Select MF.MFCode
		, 'Total Expenses' as Description
		, Sum(Amount) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('E100')
Group by MF.MFCode

Union All

Select MF.MFCode
		, 'Return on Investment' as Description
		, Sum(Amount) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('I100','E100')
Group by MF.MFCode

Union All

Select MF.MFCode
		, 'Net Asset Value' as Description
		, (Sum(Amount) * -1) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('A100','L100')
Group by MF.MFCode

Union All

SELECT FundCode
		, 'Units Subscribed' as Description
		, ISNULL(Sum(Case TxnType
			When 0 Then [Qty]
			Else Qty * -1
		 End), 0) as Amount
  FROM [dbo].[OP_MFTxns2]
  Where FundCode = @MFCode and Date <= @Dt 
  Group by FundCode

  Union All

 Select @MFCode
		, '% Yield' as Description
		, ((Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('I100','E100')
				Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('A100','L100')
										Group by MF.MFCode) *100) as Amount

Union All

Select @MFCode
		, 'Return per Unit' as Description
		, (Select Sum(Amount) 
			From Acct_GL G
				inner join OP_MFAccts MF
					on G.AccountID = MF.AID and G.Sub = MF.Sub
			Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('I100','E100')
			Group by MF.MFCode) / (SELECT Sum(Case TxnType
									When 0 Then [Qty]
									Else Qty * -1
								 End) as Amount
						  FROM [dbo].[OP_MFTxns2]
						  Where FundCode = @MFCode and Date <= @Dt 
						  Group by FundCode) as Amount

Union All

Select MF.MFCode
		, 'NAV Per Unit' as Description
		, (Sum(Amount) * -1) / (SELECT Sum(Case TxnType
									When 0 Then [Qty]
									Else Qty * -1
								 End) as Amount
						  FROM [dbo].[OP_MFTxns2]
						  Where FundCode = @MFCode and Date <= @Dt 
						  Group by FundCode) as Amount
From Acct_GL G
	inner join OP_MFAccts MF
		on G.AccountID = MF.AID and G.Sub = MF.Sub
Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('A100','L100')
Group by MF.MFCode


/*Where AccountID IN (Select AID from OP_MFAccts Where MFCode = @MFCode) and Sub IN (Select AID from OP_MFAccts Where MFCode = @MFCode)
	and EffectiveDate <= @Dt*/

