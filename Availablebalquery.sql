--Declare @CustID as varchar(10)
Declare @AID as varchar(10)
Declare @Dt as datetime

--set @CustID = '11881'
set @AID = '300'
set @Dt = getdate()

select AccountID
, Sub
, C.Name
,[dbo].[IWfn_Acct_BalanceAsAtDt] (@AID, S.Sub, 'NGN', @Dt) as CurrentBal
, Case @AID 
	When '300' Then (select ISNULL(Sum(EstimatedValue), 0) from Stkb_JobbingBookTxn Where CustNo = S.Sub and TxnType = 0 and Cancelled = 0 and Alloted = 0 and EffectiveDate < = @Dt)
	else 0
End as PendingTrades
, [dbo].[IWfn_Acct_BalanceAsAtDt] (@AID, S.Sub, 'NGN', @Dt) - (Case @AID 
						When '300' Then (select ISNULL(Sum(EstimatedValue), 0) from Stkb_JobbingBookTxn Where CustNo = S.Sub and TxnType = 0 and Cancelled = 0 and Alloted = 0 and EffectiveDate < = @Dt)
						else 0
					End) AvailableBal
from Acct_Subs S
	inner join Cust_Customers C
		on S.Sub = C.CustAID
Where AccountID = @AID