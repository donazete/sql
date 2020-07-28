Declare @MfCode as varchar(10)
Declare @EndDate as datetime

Set @MfCode = 'ABACUS'
Set @EndDate = GETDATE()

Select ROW_NUMBER() OVER (ORDER BY CC.Name) AS SN, MX.CustAID, CC.Name, CC.Phone1, CC.Email1
, Sum(A.Units) as Units
, Sum(A.Units) as Principal
, ((Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('I100','E100')
				Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('A100','L100')
										Group by MF.MFCode) *100) as FundYield
, Sum(A.Units) + ((Sum(A.Units)) * ((Select Sum(Amount) as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('I100','E100')
										Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
																From Acct_GL G
																	inner join OP_MFAccts MF
																		on G.AccountID = MF.AID and G.Sub = MF.Sub
																Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('A100','L100')
																Group by MF.MFCode) *100) / 100 * (DATEDIFF(dd,
																									Case
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@EndDate) Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) < YEAR(@EndDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) <= 6 Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) > 6 Then '06/30/'+Convert(Varchar(4), YEAR(@EndDate))
																									End
																								, @EndDate)/183)) as ValueOfInvestment
, ((Sum(A.Units)) * ((Select Sum(Amount) as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('I100','E100')
										Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
																From Acct_GL G
																	inner join OP_MFAccts MF
																		on G.AccountID = MF.AID and G.Sub = MF.Sub
																Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('A100','L100')
																Group by MF.MFCode) *100) / 100 * (DATEDIFF(dd,
																									Case
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@EndDate) Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) < YEAR(@EndDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) <= 6 Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) > 6 Then '06/30/'+Convert(Varchar(4), YEAR(@EndDate))
																									End
																								, @EndDate)/183)) as YTDReturns
, ((Sum(A.Units)) * ((Select Sum(Amount) as Amount
										From Acct_GL G
											inner join OP_MFAccts MF
												on G.AccountID = MF.AID and G.Sub = MF.Sub
										Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('I100','E100')
										Group by MF.MFCode) / (Select Sum(Amount)* -1 as Amount
																From Acct_GL G
																	inner join OP_MFAccts MF
																		on G.AccountID = MF.AID and G.Sub = MF.Sub
																Where MF.MFCode = @MFCode and G.EffectiveDate <= @EndDate and MF.AcctType IN ('A100','L100')
																Group by MF.MFCode) *100) / 100 * (DATEDIFF(dd,
																									Case
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@EndDate) Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) < YEAR(@EndDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) <= 6 Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
																										When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) > 6 Then '06/30/'+Convert(Varchar(4), YEAR(@EndDate))
																									End
																								, @EndDate)/183)) / (Sum(A.Units)) * 100 as YTDReturnPercent
, DATEDIFF(dd,
		Case
			When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@EndDate) Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
			When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) < YEAR(@EndDate) Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
			When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) <= 6 Then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1)
			When Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@EndDate) > 6 Then '06/30/'+Convert(Varchar(4), YEAR(@EndDate))
		End
	, @EndDate) as Noofdaysininvestment
, DATEDIFF(dd,(Case When Month(@EndDate) <= 6 then '12/31/'+Convert(Varchar(4), YEAR(@EndDate) - 1) else '06/30/'+Convert(Varchar(4), YEAR(@EndDate)) end), @EndDate) as NoOfDayofInvestRun
,Convert(Int,@EndDate-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) as NoOfDaysCustExisted
From OP_MFTxns2 MX
Inner join IWVW_Cust_Customers CC on CC.CustAID=MX.CustAID
inner join OP_MutualFund MF on MF.FundCode=MX.FundCode
inner Join 
(
 select ID#,Date,CustAID,Case when TxnType='0' Then Qty Else Qty*-1 End as Units ,
 Case when TxnType='0' Then Amount Else Amount*-1 End as Amount,UnitPrice,FundCode
 From OP_MFTxns2
)A on A.ID#=MX.ID#
where MF.FundCode = @MFCode and MX.Date < @EndDate+1
Group by  MX.CustAID, CC.Name, CC.Phone1, CC.Email1, MF.CustAID,MX.FundCode
Having  Sum(A.Units) > '1'
order by CC.Name
--order by ROW_NUMBER() OVER (ORDER BY CC.Name)