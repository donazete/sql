select T.TransactionDate
	, T.ValueDate
	, T.AccountID
	, T.LEGTYPE
	, B.AccountName
	, T.Description
	, T.DebitAmt
	, T.CreditAmt
from ts_Finance_Transaction T
	left join ts_Banking_LoanLease L
		on L.ProductAcctNo = T.LEGTYPE
	left join ts_Banking_CASA B
		on B.ProductAcctNo = L.CurrentAcct
where AccountID = '400001' and sCoyCode = 7

select * from ts_Banking_LoanLease
select * from ts_Banking_CASA