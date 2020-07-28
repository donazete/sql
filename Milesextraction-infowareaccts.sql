select * from Acct_GL
where SysRef = 'JE-188940'
order by Description

select distinct AID from OP_InvolvmentAccts

select AccountID
	, Sub
	, AccountID+Sub as AcctNum
	, (Select Name from Cust_Customers where CustAID = A.sub) as Name
	, (select P.Code from OP_InvolvmentAccts O
			inner join pParams P
			on P.ID# = O.pParamInvID 
		Where O.AID = A.Accountid) as InvType
from Acct_Subs A
Where AccountID in (select AID from OP_InvolvmentAccts)
and AccountID not in ('300', '3000', '1004', '21')




	select * from pparams


	select * from IWVW_Cust_Customers where id# >= 57830  --CustAID = '26231'