Select AccountID
	, Sub
	--, Description
	, Name
	, Email1
	, Phone1
	, [dbo].[IWfn_Acct_BalanceAsAtDt](AccountID, Sub, 'NGN', Getdate()) as Balance
from Acct_Subs S
	inner join IWVW_Cust_Customers C
		on C.CustAID = S.Sub
Where AccountID = '3004'
order by Name