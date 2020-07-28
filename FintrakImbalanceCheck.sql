select * from ts_Finance_Transaction
where AccountID = '510043' and YEAR(ValueDate) = 2017 and MONTH(ValueDate) = 3 and sCoyCode = 1

select Sum(debitamt - creditamt) from ts_Finance_Transaction
where valuedate = '05/03/2017' and ApplicationID != 'Fintrakbanking'



select Ref, Sum(debitamt - creditamt) from ts_Finance_Transaction
where valuedate = '05/03/2017' and ApplicationID != 'Fintrakbanking'
group by Ref



select * from ts_Finance_Transaction
where Ref in ('CSCS-20170428', 'JBKB-305914')

select * from ts_Finance_Transaction
where id in (263884, 273185, 273148)


begin tran

update ts_Finance_Transaction
set DebitAmt = 0
where id in (263884, 273185, 273148)

commit
rollback

--delete from ts_Finance_Transaction
--where id in (263884, 273185)