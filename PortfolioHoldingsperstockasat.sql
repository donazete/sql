Select [Customer Acct]
	, C.Name
	, C.Email1
	, C.Phone1
	, StockCode
	, SUM(Units) as Holding
From Stkb_Portfolio P
	inner join IWVW_Cust_Customers C
		on C.CustAID = P.[Customer Acct]
Where [Purchase Date] <= '12/04/2018' and StockCode = 'WAPCO'
Group by  [Customer Acct]
	, StockCode, C.Name
	, C.Email1
	, C.Phone1
Having SUM(Units) > 0
Order by C.Name