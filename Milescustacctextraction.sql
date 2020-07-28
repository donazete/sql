Select Accountid, SUB, Accountid+SUB as Acctnum, S.Description, P.Code
	,Case C.ClientType
		WHen 'IND' Then 'Individual'
		Else 'Corporate' 
		End as CType, C.CreateDate
From Acct_Subs S
	inner join OP_InvolvmentAccts I
		on S.AccountID = I.AID
	inner join pParams P
		on I.pParamInvID = P.ID#
	INNER JOIN Cust_Customers C
		On S.Sub = C.CustAID
Where AccountID in (Select AID from OP_InvolvmentAccts) and S.ID# > 114680 and AccountID not in ('300', '3000', '3001', '3101', '3005', '3105','3008', '3108', '3009', '3006', '3106', '1004', '3007', '3107')
order by CustAID