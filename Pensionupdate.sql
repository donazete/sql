select * from ts_Finance_Transaction
Where sCoyCode = 4 and YEAR(valuedate) = 2018 and TransactionDate = '2018-05-17 00:00:00.000'


select * from ts_Finance_Transaction
Where sCoyCode = 4 and YEAR(valuedate) = 2018 and ValueDate = '2018-05-17'

Begin tran

update ts_Finance_Transaction
set ValueDate = TransactionDate
Where sCoyCode = 4 and YEAR(valuedate) = 2018 and ValueDate = '2018-05-17'


update ts_Finance_Transaction
set ValueDate = '02/28/2018',  TransactionDate = '02/28/2018'
Where sCoyCode = 4 and YEAR(valuedate) = 2018 and TransactionDate = '2018-05-17 00:00:00.000'

commit