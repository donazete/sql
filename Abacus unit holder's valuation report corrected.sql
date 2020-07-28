Declare @MFCode as varchar(10)
Declare @EnDate as datetime
Declare @CustAID as varchar(10)
Declare @NoofDays as int


set @EnDate = '02/24/2017'
set @MFCode = 'ABACUS'
set @CustAID = '16922' --'17519' --
set @NoofDays = 104

Select Date
		, (CASE
				WHEN TxnType = 0 Then 'Subscription'
				WHEN TxnType = 1 Then 'Redemption'
			END) as TxnType
		, (CASE
				WHEN TxnType = 0 Then Amount
				WHEN TxnType = 1 Then (Amount * -1)
			END) as Amount
		, Amount/Qty as UnitPrice
		, (CASE
				WHEN TxnType = 0 Then Qty
				WHEN TxnType = 1 Then (Qty * -1)
			END) as Qty
		, DATEDIFF(dd, Date, @EnDate) as NoofDays
		/* return on each line of investment computed by getting the net income, diving by total units subscribed multiplying by amount invested and prorating number of days in fund   */
		,(Case 
			When TxnType = 0 Then (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('I100','E100')
				Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('A100','L100')
										Group by MF.MFCode) * Qty * 
										(DATEDIFF(dd,
											Case
												When Convert(Int,@EnDate - Date) < @NoofDays AND YEAR(Date) = YEAR(@EnDate) Then [Date]
												When Convert(Int,@EnDate - Date) < @NoofDays AND YEAR(Date) < YEAR(@EnDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EnDate) - 1)
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 3 Then '12/31/'+Convert(Varchar(4), YEAR(@EnDate) - 1)
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 6 Then '03/31/'+Convert(Varchar(4), YEAR(@EnDate))
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 9 Then '06/30/'+Convert(Varchar(4), YEAR(@EnDate))
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) > 9 Then '09/30/'+Convert(Varchar(4), YEAR(@EnDate))
											End
										, @EnDate))/365
			Else (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('I100','E100')
				Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('A100','L100')
										Group by MF.MFCode) * Qty * 
										(DATEDIFF(dd,
											Case
												When Convert(Int,@EnDate - Date) < @NoofDays AND YEAR(Date) = YEAR(@EnDate) Then [Date]
												When Convert(Int,@EnDate - Date) < @NoofDays AND YEAR(Date) < YEAR(@EnDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EnDate) - 1)
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 3 Then '12/31/'+Convert(Varchar(4), YEAR(@EnDate) - 1)
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 6 Then '03/31/'+Convert(Varchar(4), YEAR(@EnDate))
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) <= 9 Then '06/30/'+Convert(Varchar(4), YEAR(@EnDate))
												When Convert(Int,@EnDate - Date) >= @NoofDays And Month(@EnDate) > 9 Then '09/30/'+Convert(Varchar(4), YEAR(@EnDate))
											End
										, @EnDate))/365 * -1
			End) RTD
		,(Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('I100','E100')
				Group by MF.MFCode) as totalincome
		, (Select Sum(Amount)* -1 as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('A100','L100')
										Group by MF.MFCode) as totalunits
		--, (CASE
		--		WHEN TxnType = 0 Then Amount
		--		WHEN TxnType = 1 Then (Amount * -1)
		--	END) * (Select Sum(Amount) as Amount
		--		From Acct_GL G
		--			inner join OP_MFAccts MF
		--				on G.AccountID = MF.AID and G.Sub = MF.Sub
		--		Where MF.MFCode = @MFCode and G.EffectiveDate <= @EnDate and MF.AcctType IN ('I100','E100')
		--		Group by MF.MFCode)
		--, ( Select top 1 BidPrice 
		--	  from IWVW_MFValuation2 where MFCode = @MFCode AND ValuationDate <= @EnDate
		--	  Order by ValuationDate desc) as CurrentPrice
		--, (( Select top 1 BidPrice 
		--	  from IWVW_MFValuation2 where MFCode = @MFCode AND ValuationDate <= @EnDate
		--	  Order by ValuationDate desc) * (CASE
		--					WHEN TxnType = 0 Then Qty
		--					WHEN TxnType = 1 Then (Qty * -1)
		--				END)
		--	) as MarketValue 
From dbo.OP_MFTxns2
Where FundCode = @MFCode and CustAID = @CustAID and Date <= @EnDate