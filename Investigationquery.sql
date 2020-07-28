select * from AMPL_IFund_Trans
where liquidated = 0 and Custid = '14137'
order by trans#


select distinct trans# from AMPL_IFund_Trans
where liquidated = 0 and Custid = '14137'
order by trans#

select * from AMPL_IFundLiq
where TxnDate > '07/04/2017'

select * from AMPL_IFund_Trans
where ID# in (select IFundTxnID from AMPL_IFundLiq
where TxnDate > '07/04/2017') and CustID = '14137'

select * from AMPL_IFundMthlyRun
Where Trans# in (select distinct trans# from AMPL_IFund_Trans
where liquidated = 0 and Custid = '14137') and Date = '06/30/2017'
order by [Date], Trans#


select Trans#, Sum(TotalAccrued) Inttilldt from AMPL_IFundMthlyRun
Where Trans# in (select distinct trans# from AMPL_IFund_Trans
where liquidated = 0 and Custid = '14137')
Group by Trans#
order by Trans#


