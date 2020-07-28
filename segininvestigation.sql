select SUM(Amount) from Acct_GL
Where AccountID = '2200' and Sub = '003'


select * from Acct_GL
Where AccountID = '2200' and Sub = '003' and YEAR(EffectiveDate)>= 2017 and TxnDate < '04/16/2018' --and Abs(Amount) = 3212.64
order by EffectiveDate, Description

select * from Acct_GL
Where AccountID = '2200' and Sub = '003' and Description like 'Invest. Fund Interest accrual - Deposit#: 3777993, Cust ID: 11196, Month: 7'

select * from Acct_GL
Where Description like 'Invest. Fund Interest accrual - Deposit#: 3777993, Cust ID: 11196, Month: 7'
