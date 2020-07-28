select * from AMPL_IFund_Trans
Where custid = '14137' and EffectiveDate <= '05/14/2018' and MaturityDate >= '05/14/2018' and Liquidated = 0
order by Trans#, EffectiveDate

select * from AMPL_IFund_Trans
Where custid = '14137' and EffectiveDate <= '05/14/2018' and MaturityDate >= '05/14/2018' and Liquidated = 0
order by EffectiveDate


select Distinct Trans# from AMPL_IFund_Trans
Where custid = '14137' and EffectiveDate <= '05/14/2018' and MaturityDate >= '05/14/2018' and Liquidated = 0
order by Trans#, EffectiveDate


select * from AMPL_IFund_Trans
Where custid = '14137' and Liquidated = 0  and MaturityDate <= '05/14/2018' --
order by Trans#


select * from AMPL_IFundMthlyRun
--order by ID#
Where MonthIndex = '201801' and Trans# in (select Distinct Trans# from AMPL_IFund_Trans
					Where custid = '14137' and Liquidated = 0 and EffectiveDate <= '01/07/2018' and MaturityDate >= '01/07/2018')
Group by Trans#
order by Trans#

select Trans#, SUM(TotalAccrued) from AMPL_IFundMthlyRun
Where  MonthIndex = '201801' and Trans# in (select Distinct Trans# from AMPL_IFund_Trans
					Where custid = '14137' and Liquidated = 0 and EffectiveDate <= '01/06/2018' and MaturityDate >= '01/06/2018')
Group by Trans#
order by Trans#

select * from AMPL_IFund_Trans
Where custid = '14137' and Liquidated = 1 and MaturityDate >= '12/29/2017'

select * from [dbo].[AMPL_IFundLiq]
Where IFundTxnID in (select ID# from AMPL_IFund_Trans
		Where custid = '14137' and Liquidated = 1 and MaturityDate >= '12/29/2017')

select IFundTxnID from [dbo].[AMPL_IFundLiq]
Where IFundTxnID in (select ID# from AMPL_IFund_Trans
		Where custid = '14137' and Liquidated = 1 and MaturityDate >= '12/29/2017') and ID# >= 5708

Select * from AMPL_IFund_Trans
Where trans# in (select Trans# from AMPL_IFund_Trans
Where ID# in (select IFundTxnID from [dbo].[AMPL_IFundLiq]
Where IFundTxnID in (select ID# from AMPL_IFund_Trans
		Where custid = '14137' and Liquidated = 1 and MaturityDate >= '12/29/2017') and ID# >= 5708))
order by Trans#, ID#



select trans# from AMPL_IFund_Trans
Where custid = '14137' and Liquidated = 0

select trans# from AMPL_IFund_Trans
Where custid = '14137' and Liquidated = 0 --and PnLAID = '1304'

select * from Acct_GL
Where amount < 0 and AccountID like '40%' and TxnDate <= '2018-05-18' and BranchCode = '004' and BatchNo != 0 --and EffectiveDate between '12/28/2017' and '12/29/2017' --and BranchCode = '004' and sysref not like 'Revers%'
order by effectivedate -- by sysref

select * from Acct_GL
Where AccountID like '40%' and EffectiveDate > '01/01/2018' and LEN(accountid) = 4 order by BranchCode    and BranchCode = '004' and BatchNo != 0 --and EffectiveDate between '12/28/2017' and '12/29/2017' --and BranchCode = '004' and sysref not like 'Revers%'
order by sysref


select * from Acct_GL
Where amount < 0 and AccountID like '40%' and EffectiveDate = '01/06/2018' and BranchCode = '004' and BatchNo != 0 --and EffectiveDate between '12/28/2017' and '12/29/2017' --and BranchCode = '004' and sysref not like 'Revers%'
order by sysref



select * from Acct_GL
Where AccountID like '400%' and LEN(AccountID) = 4 and EffectiveDate <= '05/14/2018' and BranchCode != '004' --and sysref not like 'Revers%'



select Sum(Amount) from Acct_GL
Where AccountID like '400%' and EffectiveDate <= '04/30/2018' and BranchCode = '004' and sysref not like 'Revers%'
--order by sysref

select * from Acct_GL
Where AccountID like '400%' and EffectiveDate > '12/31/2017' and BranchCode = '004' and BatchNo != 0


select * from AMPL_IFund_Trans
Where Trans# = 9447

--begin tran

--update  acct_gl
--set AccountID = '1304', Sub = '004'
--Where id# in (3999740,4049655)

--commit


select * from acct_gl
where sysref in ('PLMMR-76819','PLMMR-79136') -- id# in (3999740,4049655)


select * from acct_gl
where id# in (3999740,4049655)


select * from AMPL_IFundLiq
where IFundTxnID in (8420, 8421)


select * from Acct_GL
Where AccountID = '1504' and Sub = '003' and SysRef like 'PLMLQ%'


9402



select * from AMPL_IFund_Trans
Where Principal = 99948000.27 	--custid = '14137' and

select * from AMPL_IFund_Trans
Where Principal = 43945568.49 
