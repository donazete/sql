
Select A.[Customer Acct]
	, C.Name
	, SUM(MktValue) as PortfolioValue
from (Select [Customer Acct]
	, P.StockCode
	, SUM(Units) as Units
	, (Select top 1 Price from Stkb_Quotes where StockCode = P.StockCode order by Date desc) as CurrentPrice
	, (SUM(Units) * (Select top 1 Price from Stkb_Quotes where StockCode = P.StockCode order by Date desc)) as MktValue
from Stkb_Portfolio P
	inner join Stkb_StockMaster M
		on M.StockCode = P.StockCode
Where M.InActive = 0 and M.AssetClass = 'Equities'
Group by [Customer Acct]
	, P.StockCode) A
		inner join IWVW_Cust_Customers C
			on C.CustAID = A.[Customer Acct]
Group by A.[Customer Acct]
	, C.Name
Having SUM(MktValue) <= 1000000 and SUM(MktValue) > 0



Select [Customer Acct]
	, C.Name
	, P.StockCode
	, C.Address1
	, C.Phone1
	, C.Email1
	, SUM(Units) as Units
	, (Select top 1 Price from Stkb_Quotes where StockCode = P.StockCode order by Date desc) as CurrentPrice
	, (SUM(Units) * (Select top 1 Price from Stkb_Quotes where StockCode = P.StockCode order by Date desc)) as MktValue
from Stkb_Portfolio P
	inner join Stkb_StockMaster M
		on M.StockCode = P.StockCode
	inner join IWVW_Cust_Customers C
		on P.[Customer Acct] = C.CustAID
Where M.InActive = 0 and M.AssetClass = 'Equities'
Group by [Customer Acct]
	, C.Name
	, P.StockCode
	, C.Address1
	, C.Phone1
	, C.Email1
Having (SUM(Units) * (Select top 1 Price from Stkb_Quotes where StockCode = P.StockCode order by Date desc)) > 0 
order by [Customer Acct]

Select * from Acct_GL
where AccountID = '2004' and Sub = '004'



select top 10 * from Stkb_Quotes
