Select L.CustCode
	, C.AccountName
	, L.ProductAcctNo
	, L.Tenor
	, L.Rate
	, L.EffectDate
	, L.TerminalDate
	, L.Principal
	, L.OutstandingPrincipal
	, L.CurrentAcct
	, L.DateOfDisburse
	, L.CoyCode
	, L.Disbursed
from ts_Banking_LoanLease L
	inner Join ts_Banking_CASA C
		on L.CurrentAcct = C.ProductAcctNo
Where Booked = 1 and L.CoyCode in (7) and Disbursed = 1 and L.EffectDate <= '12/31/2019' and L.TerminalDate > '12/31/2019'
	and L.ProductAcctNo not in (Select ProductAccNo from ts_Banking_Termination
						Where ApprovedLoan = 1)



--Select * from ts_Banking_CASA
--Where ProductAcctNo in ('0000083128', '0000082597')