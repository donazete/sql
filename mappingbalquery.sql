Select A.LedgerID
	, A.OldLedgerCode1
	, (Select sum(Amount) from IWGI.dbo.Acct_GL where Accountid+Sub = A.OldLedgerCode1 and branchcode = '000' and txndate <= '03/27/2018') as Infoware
	--, (Select Sum(CreditAmt + (DebitAmt * -1)) from [COREBANKING].[FinTrakFundManager].[dbo].[ts_Finance_Transaction]
	--	Where AccountID = A.LedgerID and approved = 1 and scoycode = 5) as Fintrak
from Fintrak_AcctMapping A
Where companyID = 1


Select Accountid, sum(Amount) from IWGI.dbo.Acct_GL 
where Accountid in ('3000', '3001', '3005', '3007', '3008') and branchcode = '000' and txndate <= '03/27/2018' 
Group by Accountid


select custaid from IWGI.dbo.cust_customers
Where createdate between '03/01/2018' and '03/31/2018'