Select ID#
	, FundCode
	, Date
	, AID
	, Sub
	, AID+CustAID as Acct
	, 100 as UnitPrice
	, Case TxnType
		When 0 then 'Subscription'
		else 'Redemption'
	End as TxnType
	, Qty/100 as Qty
	, Amount
	, Comments
from OP_MFTxns2
Where Date >= '10/01/2018' and FundCode = 'ABACUS' and Comments not like '%Dividend%'
order by Date