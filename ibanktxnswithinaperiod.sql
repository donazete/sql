select SP.DateAlloted, SP.CustAID, C.Name, SP.StockCode, SP.Qty, SP.UnitPrice, SP.Consideration, SP.TotalAmt, 'Sale' as Txn
from IWVW_Stkb_PurchasesEx  SP
	inner join Stkb_JobbingBookTxn ST
		on ST.ID# = SP.JbkTxnNum
	inner join Cust_Customers C
		on SP.CustAID = C.CustAID
Where DateAlloted between '07/01/2019' and '07/31/2019' and ST.OriginOfRecord = 5

Union all 

select SP.DateAlloted, SP.CustAID, C.Name, SP.StockCode, SP.Qty, SP.UnitPrice, SP.Consideration, SP.TotalAmt, 'Purchase' as Txn
from IWVW_Stkb_SoldEx  SP
	inner join Stkb_JobbingBookTxn ST
		on ST.ID# = SP.JbkTxnNum
	inner join Cust_Customers C
		on SP.CustAID = C.CustAID
Where DateAlloted between '07/01/2019' and '07/31/2019' and ST.OriginOfRecord = 5
order by SP.CustAID, Datealloted