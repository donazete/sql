
Select A.LedgerID
	, A.OldLedgerCode1
	, (Select sum(Amount) from IWGI.dbo.Acct_GL where Accountid+Sub = A.OldLedgerCode1 and branchcode = '007' and txndate <= '03/27/2018') as Infoware
	--, (Select Sum(CreditAmt + (DebitAmt * -1)) from [COREBANKING].[FinTrakFundManager].[dbo].[ts_Finance_Transaction]
	--	Where AccountID = A.LedgerID and approved = 1 and scoycode = 5) as Fintrak
from Fintrak_AcctMapping A
Where companyID = 5



Select Accountid, sum(Amount) from IWGI.dbo.Acct_GL 
where Accountid in ('3101', '3105', '3106', '3108', '3009') and branchcode = '007' and txndate <= '03/27/2018'
Group by Accountid


Select * from IWGI.dbo.Acct_GL 
where Accountid in ('300') and branchcode = '006' and txndate <= '03/27/2018'

Select EffectiveDate, SUM(Amount) from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('1006002') and EffectiveDate > '12/31/2016' and branchcode = '007' and txndate <= '03/27/2018'
Group by EffectiveDate
Order by EffectiveDate

Select EffectiveDate, COUNT(*) from IWGI.dbo.Acct_GL 
Where AccountID in ('3101') and EffectiveDate > '12/31/2016' and branchcode = '007' and txndate <= '03/27/2018'
Group by EffectiveDate
Order by EffectiveDate

Select EffectiveDate, COUNT(*) from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('3101') and EffectiveDate > '12/31/2016' and branchcode = '007' and txndate <= '03/27/2018'
Group by EffectiveDate
Order by EffectiveDate


Select * from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('3101') and EffectiveDate > '12/31/2016'  and branchcode = '007' and txndate <= '03/27/2018' and SysRef = 'REVERSal'
order by Description

Select * from IWGI.dbo.Acct_GL 
Where AccountID in ('3009') and EffectiveDate > '12/31/2016'  and branchcode = '007' and txndate <= '03/27/2018' --and SysRef = 'REVERSed'
order by Description--, ID#


Select SysRef, COUNT(*) from IWGI.dbo.Acct_GL 
Where AccountID in ('3101') and EffectiveDate = '03/26/2018'  and branchcode = '007' and txndate <= '03/27/2018'
Group by SysRef
Order by SysRef

Select SysRef, COUNT(*) from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('2700005') and EffectiveDate > '12/31/2016'  and branchcode = '007' and txndate <= '03/27/2018'
Group by SysRef
Order by SysRef

Select SysRef, COUNT(*) from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('3200005') and EffectiveDate = '03/20/2018' and branchcode = '007' and txndate <= '03/27/2018'
Group by SysRef
Order by SysRef

Select * from Acct_GL
Where sysref in (Select * from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('2103006') and EffectiveDate > '03/20/2018' and BranchCode != '007' and SysRef not like 'Revers%')

Select * from Acct_GL
Where description in (Select description from IWGI.dbo.Acct_GL 
Where AccountID+Sub in ('2103001') and EffectiveDate > '03/20/2018' and BranchCode != '007' and SysRef like 'Revers%')

select * from Acct_GL
Where AccountID+Sub in ('1700001') and EffectiveDate = '03/22/2018' and branchcode = '007' and txndate <= '03/27/2018'
order by EffectiveDate, Description

select ID# from Acct_GL
Where AccountID+Sub in ('101007') and EffectiveDate > '12/31/2016'
order by ID#


Select AccountID, Sub, Accountid+SUB, SUM(Amount)
from Acct_GL
Where BranchCode = '007' and txndate <= '03/27/2018' and AccountID not in ('3101','3105','3106','3108', '3009')
group by AccountID, Sub
order by AccountID, Sub


Select AccountID, AccountID, Accountid, SUM(Amount)
from Acct_GL
Where BranchCode = '007' and txndate <= '03/27/2018' and AccountID in ('3101','3105','3106','3108', '3009')
group by AccountID
--order by AccountID

Select Description, ID# from IWGI.dbo.Acct_GL 
where Accountid in ('300') and branchcode = '006' and EffectiveDate = '03/24/2017'
Order by Description

Stock Sale: 59,753 UBA @NGN5.39 for A/C 9481 {3462593}

select * from Acct_GL
--where SysRef = 'JE-198030' {4728706}
Where description like 'IFund Prin - Deposit#: 3783596; Cust#: 6398'

select * from Acct_GL
Where ID# in (4739641,4739643,4739647,4739651,4739655,4739659,4739663,4739981,4739999,4740121,4740174,4740176,4740841,4740845,4740847,4741244,4741288)


select * from Fintrak_AcctMapping
Where CompanyID = 5


begin tran


update Acct_GL
set BranchCode = '007'
--where SysRef = 'JE-198091'
Where description like 'IFund Prin - Deposit#: 3783608; Cust#: 14621'
--Where sysref in (Select SysRef from IWGI.dbo.Acct_GL 
--Where AccountID+Sub in ('2103006') and BranchCode != '007')
--Where description in (Select description from IWGI.dbo.Acct_GL 
--Where AccountID+Sub in ('2103001') and EffectiveDate > '03/20/2018' and BranchCode != '007' and SysRef like 'Revers%')

rollback
commit