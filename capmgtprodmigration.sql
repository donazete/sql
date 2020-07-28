Begin tran

Insert into Cust_Involvements(CustAID, Type, Status, UserID, TxnDate, BranchCode)
select CustAID
	, (Case [Type]
		When 'IFUND' Then 'FICAPMGT'
		When 'MYPASSNEW' Then 'MYPASSCAP'
		When 'HIGHYIELD' Then 'HYINCAPMGT'
		When 'REALESTATE' Then 'REALESTCAP'
	End) Type
	, Status
	, UserID
	, TxnDate
	, BranchCode 
from Cust_Involvements
Where [Type] in ('IFUND', 'MYPASSNEW', 'HIGHYIELD', 'REALESTATE')


select * from Cust_Involvements
Where [Type] in ('FICAPMGT', 'MYPASSCAP', 'HYINCAPMGT', 'REALESTCAP')

delete from Cust_Involvements
Where [Type] in ('FICAPMGT', 'MYPASSCAPMT', 'HYINCAPMGT', 'REALESTCAP')

commit
rollback

--select (Case AccountID
--			When '3001' Then '3201'
--			When '3005' Then '3205'
--			When '3006' Then '3206'
--			When '3008' Then '3208'
--		End) as MasterAccount
--	, Sub as Sub
--	, (Case AccountID
--			When '3001' Then 'FIXED INCOME - CAP MGT'
--			When '3005' Then 'MYPASS - CAP MGT'
--			When '3006' Then 'HIGH YIELD - CAP MGT'
--			When '3008' Then 'REAL ESTATE - CAP MGT'
--		End) as MasterAcctName
--	, Description as SubName
--	, 'Current Liability' as AccountType
--	, '000' BranchCode
--from Acct_subs
--Where AccountID IN ('3001','3005','3006','3008')
--order by MasterAccount


--begin tran

--select * from acct_subs
--Where Txndate > '06/23/2017' and UserID = 'oyeleye156'

--delete from acct_subs
--Where Txndate > '06/23/2017' and UserID = 'oyeleye156'

--commit
