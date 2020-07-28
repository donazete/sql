Select [Customer Acct]
	, C.Name
	, StockCode
	, SUM(Units)  as Qty
	, SUM(Units)/4 CurrHolding
from Stkb_Portfolio P
	inner join Cust_Customers C
		on C.CustAID = P.[Customer Acct]
Where StockCode = 'CILeasing' and [Purchase Date] <= GETDATE()-1
Group by [Customer Acct], C.Name, StockCode
Having SUM(Units) > 0