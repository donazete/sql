-- Terminated loans

select L.CustCode
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  ,C.AccountName
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
	  ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
	  ,L.CurrentAcct
      ,L.DateOfDisburse
	  , T.DateTerminated
	  , (Select SUM(CreditAmt + (DebitAmt * -1)) from ts_Finance_Transaction where AccountID like '4%' and LEGTYPE = L.ProductAcctNo and Approved = 1
		and Description like 'Daily Interest Accrual for%' ) as Interest
from ts_Banking_LoanLease L
	inner join ts_Banking_Termination T
		on L.ProductAcctNo = T.ProductAccNo
	inner join ts_Banking_CASA C
		on L.CurrentAcct = C.ProductAcctNo
Where L.CoyCode = 7 and L.Disbursed = 1 and T.ApprovedLoan = 1 and YEAR(DateTerminated) = 2017


-- Running loans


select L.CustCode
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  ,C.AccountName
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
	  ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
	  ,L.CurrentAcct
      ,L.DateOfDisburse
	  , (Select SUM(CreditAmt + (DebitAmt * -1)) from ts_Finance_Transaction where AccountID like '4%' and LEGTYPE = L.ProductAcctNo and ValueDate <= '12/31/2017'
		and Description like 'Daily Interest Accrual for%' and Approved = 1) as Interest
from ts_Banking_LoanLease L
	inner join ts_Banking_CASA C
		on L.CurrentAcct = C.ProductAcctNo
Where L.CoyCode = 7 and L.Disbursed = 1 and ((select ApprovedLoan from ts_Banking_Termination Where ProductAccNo = L.ProductAcctNo) IS NULL OR 
	(select ApprovedLoan from ts_Banking_Termination Where ProductAccNo = L.ProductAcctNo) = 0) and L.EffectDate <= '12/31/2017' --and L.DateOfDisburse IS NOT NULL


select * from ts_Banking_CASA
Where ProductAcctNo = '0000024806' AccountName like 'erf%'

select * from ts_banking_loanlease
Where CurrentAcct = '0000024349'


--select ApprovedLoan from ts_Banking_Termination
--Where ProductAccNo = L.ProductAcctNo


--select * from ts_Finance_Transaction
--WHere ApplicationID = 'fintrakbanking' and sCoyCode = 7 and PostedBy = 'sys'



--select * from ts_Finance_Transaction
--WHere AccountID = '400003' and sCoyCode = 7


Select L.CustCode
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  ,C.AccountName
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
	  ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
	  ,L.CurrentAcct
      ,L.DateOfDisburse,LEGTYPE, SUM(CreditAmt + (DebitAmt * -1)) as Amt from 
ts_Finance_transaction T
	left join ts_Banking_LoanLease L
		on T.LEGTYPE = L.ProductAcctNo
	inner join ts_Banking_CASA C
		on L.CurrentAcct = C.ProductAcctNo
Where T.accountid in ('400003', '400020','400021') and T.scoycode = 7 and T.valuedate <= '12/31/2017' and T.Approved = 1
group by L.CustCode
      ,L.ProductCode
      ,L.ProductName
      ,L.ProductAcctNo
	  ,C.AccountName
      ,L.BranchId
      ,L.Tenor
      ,L.Rate
	  ,L.EffectDate
      ,L.TerminalDate
      ,L.CoyCode
      ,L.MISCode
      ,L.DateCreated
      ,L.Principal
	  ,L.CurrentAcct
      ,L.DateOfDisburse,LEGTYPE
order by LEGTYPE

Select AccountID, SUM(CreditAmt + (DebitAmt * -1)) as Amt from ts_Finance_transaction T
Where T.accountid in ('400003', '400020','400021') and T.scoycode = 7 and T.valuedate <= '12/31/2017' and T.Approved = 1 and LEGTYPE = AccountID
group by AccountID


Select * from ts_Finance_transaction T
Where T.accountid in ('400003', '400020','400021') and T.scoycode = 7 and T.valuedate <= '12/31/2017' and T.Approved = 1 and LEGTYPE = AccountID


Select SUM(CreditAmt + (DebitAmt * -1)) as Amt from ts_Finance_transaction
Where accountid = '400003' and scoycode = 7 and valuedate <= '12/31/2017' and Approved = 1


Select SUM(CreditAmt + (DebitAmt * -1)) as Amt from ts_Finance_transaction
Where accountid = '400003' and scoycode = 7 and TransactionDate <= '12/31/2017' and Approved = 1



Select * from ts_Finance_transaction
Where accountid = '400003' and scoycode = 7 and valuedate <= '12/31/2017' and Approved = 1