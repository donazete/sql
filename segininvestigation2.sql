


select * from ts_Finance_Transaction
where AccountID = '210004' and Description like '%3917069%'
order by ValueDate, Description

select * from ts_Finance_Transaction
where AccountID = '414008'

select * from ts_Finance_Transaction
where Description like 'Invest. Fund Interest accrual - Deposit#: 3777993, Cust ID: 11196, Month: 7%'


Begin tran

update ts_Finance_Transaction
set sCoyCode = 6
where Description like 'Placement Interest accrual - Deposit#: 9614, Cust ID: 000, Month: 12%'

commit