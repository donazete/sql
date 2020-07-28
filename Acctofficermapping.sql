Select F.fmCustomerNumber
	, C.ID#
	, F.fcCompanyCode
	, F.fcCompanyName
	, F.faaAccountOfficerCode
	, F.InfowareAccountOfficerTableID
	, (Select IDNumber from IWGI.dbo.OP_Officers where ID# = F.InfowareAccountOfficerTableID) as AcctIDNum
	, F.faaAcountOfficerLastName
from [vwFintrakCustomerWithAccountOfficer] F
	inner join IWGI.dbo.Cust_Customers C
		on C.CustAID = F.fmCustomerNumber
order by fcCompanyName, fmCustomerNumber



Select *
from [vwFintrakCustomerWithAccountOfficer]