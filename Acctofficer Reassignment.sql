Begin Tran

Update C
Set C. AccountOfficer_ID = M.NewOfficerID
From IWGI.dbo.Cust_Customers C inner join IWGI20150820.[dbo].[AcctOfficerMigration] M
		on C.CustAID = M.CustAID

commit


Select C.CustAID, C.Name, C.AccountOfficer_ID, M.Name, M.OldOfficerID, M.OldOfficerName, M.NewOfficerID, M.NewOfficerName
From IWGI.dbo.IWVW_Cust_Customers C
	inner join IWGI20150820.[dbo].[AcctOfficerMigration] M
		on C.CustAID = M.CustAID
order by M.NewOfficerName