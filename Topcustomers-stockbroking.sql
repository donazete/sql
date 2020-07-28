Select A.CustAID, C.Name, C.Phone1, C.Email1, SUM(A.Amt) TradeValue, SUM(Commission) as Commission
From (Select CustAID, SUM(TotalAmt) as Amt , SUM(Commision) as Commission
from IWVW_Stkb_SoldEx
Where YEAR(DateAlloted) = 2017
Group by CustAID

union all

Select CustAID, SUM(TotalAmt) as Amt, SUM(Commision) as Commission
from IWVW_Stkb_PurchasesEx
Where YEAR(DateAlloted) = 2017
Group by CustAID) A
	inner join IWVW_Cust_Customers C
	on C.CustAID = A.CustAID
Group by A.CustAID, C.Name, C.Phone1, C.Email1
order by TradeValue desc