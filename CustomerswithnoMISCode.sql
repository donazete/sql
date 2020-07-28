Select Distinct CU.ID#
	, C.Custaid
	, C.Name
	, C.MISCODE
	, I.Type
	, O.ID# as OfficerID
	, O.Officer 
	, CU.AccountOfficer
	, CU.AccountOfficer_ID
	, CU.City
	, CU.State
	, CU.Country
from IOVW_CustomersAcctOfficerMIS C
	inner join Cust_Involvements I
		on C.Custaid = I.CustAID
	left join IWVW_Cust_Customers CU
		on CU.CustAID = C.Custaid
	left join OP_Officers O
		on O.IDNumber = CU.AccountOfficer_ID
Where (MISCODE IS NULL or MISCODE = '') --and I.Type in ('STK','MGIN', 'AGENT') and (CU.AccountOfficer IS NULL or CU.AccountOfficer = '')
order by CU.AccountOfficer_ID --Custaid --, Type, CU.AccountOfficer_ID

--Select * from  OP_Officers


--Select Distinct AccountOfficer_ID from IWVW_Cust_Customers
--order by AccountOfficer_ID

select * from IOVW_CustomersAcctOfficerMIS