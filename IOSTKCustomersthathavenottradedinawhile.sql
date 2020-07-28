Select A.CustAID
	, C.Name
	, C.Phone1
	, C.Email1
	, C.Address1
	, C.AccountOfficer
From (select CustAID
			from IWVW_Stkb_PurchasesEx
			Where DateAlloted < GETDATE()-180
			union
			select CustAID
			from IWVW_Stkb_SoldEx
			Where DateAlloted < GETDATE()-180) A
inner join IWVW_Cust_Customers C
	on C.CustAID = A.CustAID
Where A.CustAID not in (select CustAID
									from IWVW_Stkb_PurchasesEx
									Where DateAlloted >= GETDATE()-180
									union
									select CustAID
									from IWVW_Stkb_SoldEx
									Where DateAlloted >= GETDATE()-180)


--select CustAID
--from IWVW_Stkb_PurchasesEx
--Where DateAlloted >= GETDATE()-180
--union
--select CustAID
--from IWVW_Stkb_SoldEx
--Where DateAlloted >= GETDATE()-180
--order by datealloted