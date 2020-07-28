Select * from (Select * from IWVW_Stkb_SoldEx
		union all
		Select * from IWVW_Stkb_PurchasesEx) A
Where DateAlloted >= '01/01/2016' and  CustAid in (Select distinct CustAID
	/*, (Select top 1 DateAlloted from (Select * from IWVW_Stkb_SoldEx
		union all
		Select * from IWVW_Stkb_PurchasesEx) B Where Custaid = A.CustAID order by DateAlloted desc) as lasttradedate*/
from (Select * from IWVW_Stkb_SoldEx
		union all
		Select * from IWVW_Stkb_PurchasesEx) A
Where DateAlloted <= '12/31/2015' and (Select top 1 DateAlloted from (Select * from IWVW_Stkb_SoldEx
		union all
		Select * from IWVW_Stkb_PurchasesEx)B Where Custaid = A.CustAID order by DateAlloted desc) <= '08/31/2015')

