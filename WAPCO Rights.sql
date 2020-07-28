select * from IWVW_Stkb_SoldEx
Where JbkTxnNum = 337187
order by JbkTxnNum

select * from Stkb_JobbingBookTxn
where ID# = 337187
order by ID#

select * from IWVW_Stkb_SoldEx
Where JbkTxnNum between 337329 and 337331
order by JbkTxnNum


select * from Stkb_JobbingBookTxn
where ID# between 337329 and 337331
order by ID#

select * from IWVW_Stkb_SoldEx
Where CustAID = '13087' and DateAlloted = '11/08/2017' and StockCode = 'ZENITHBANK'
order by JbkTxnNum


Select [Customer Acct]
	, C.Name
	, C.Email1
	, C.Phone1
	, StockCode
	, SUM(Units) as Units
from Stkb_Portfolio P
	inner join IWVW_Cust_Customers C
		on P.[Customer Acct] = C.CustAID
Where StockCode = 'WAPCO' and [Purchase Date] <= '11/01/2017'
Group by [Customer Acct], C.Name
	, C.Email1
	, C.Phone1
	, StockCode
Having SUM(Units) > 0