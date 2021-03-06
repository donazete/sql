Declare @Dt as Datetime
Declare @MFCode as varchar(10)

set @Dt = '04/01/2017' 
set @MFCode = 'ABACUS'

create table #tb (Valdt Datetime, Qty money, Expense money, TotIncome money)

while @Dt <= '04/30/2017'
BEGIN
INSERT INTO #tb
	Select @Dt
		, Sum(Case TxnType
			When 0 Then Qty
			Else Qty * -1
			End) as Qty
		, (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate = @Dt and MF.AcctType IN ('E100')
				Group by MF.MFCode) as Expense
		, (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @Dt and MF.AcctType IN ('I100')
				Group by MF.MFCode) as TotalIncome
	From OP_MFTxns2
	Where FundCode = @MFCode and Date <= @Dt

	set @Dt = DATEADD(dd,1,@Dt)

END

select * from #tb