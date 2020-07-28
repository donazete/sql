select * from ts_Finance_Transaction
where Valuedate != TransactionDate and ApplicationID not like 'fintrakbanking%'


begin tran

update ts_Finance_Transaction
set Valuedate = TransactionDate
where Valuedate != TransactionDate and ApplicationID not like 'fintrakbanking%'

commit


select top 1 valuedate from ts_Finance_Transaction
order by ValueDate desc

select * from ts_Finance_Transaction
Where Ref in (select Ref from ts_Finance_Transaction
Where AccountID = '213004' and Month(ValueDate) = 9) and Month(ValueDate) = 9
order by Ref

select * from ts_Finance_Transaction
Where AccountID = '213004' and Month(TransactionDate) = 6

select * from ts_Finance_Transaction
Where Ref in('TRN/116/4595660', 'TRN/148/2035106')


