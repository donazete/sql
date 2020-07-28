select ref, SUM(CreditAmt + (DebitAmt * -1))
from ts_Finance_Transaction 
Where sCoyCode = 1 and applicationID = 'fintrakbanking' and Approved = 1
group by Ref


select ref, SUM(CreditAmt + (DebitAmt * -1))
from ts_Finance_Transaction 
Where applicationID = 'fintrakbanking' and Approved = 1 -- sCoyCode = 1 and 
group by Ref



select ref, SUM(CreditAmt + (DebitAmt * -1))
from ts_Finance_Transaction 
Where applicationID = 'treasuryreversal' and Approved = 1 --and sCoyCode = 1 
group by Ref


select ref, SUM(CreditAmt + (DebitAmt * -1))
from ts_Finance_Transaction 
Where sCoyCode = 1 and applicationID = 'treasuryreversal' and Approved = 1
group by Ref



select TransactionDate, COUNT(*) from ts_Finance_Transaction 
Where AccountID = '214000' and sCoyCode = 5 and Approved = 1 -- Ref = 'TRN/16/1202080'
Group by Transactiondate
order by Transactiondate


select TransactionDate, SUM(CreditAmt + (DebitAmt * -1)) from ts_Finance_Transaction 
Where AccountID = '113092' and sCoyCode = 5 and Approved = 1 -- Ref = 'TRN/16/1202080'
Group by Transactiondate
order by Transactiondate

select Ref, COUNT(*) from ts_Finance_Transaction 
Where AccountID = '214000' and sCoyCode = 5 and Approved = 1 and ValueDate = '03/26/2018' -- Ref = 'TRN/16/1202080'
Group by Ref
order by Ref


select *
	, Case 
		When DebitAmt = 0 Then CreditAmt
		else DebitAmt * -1
	End as amt
from ts_Finance_Transaction 
--Where TransactionDate = '03/22/2018' and AccountID = '115071' and sCoyCode = 5 and Approved = 1
Where AccountID = '414025' and Approved =1 and sCoyCode = 5 --and Ref = 'IFD-94812' and TransactionDate = '03/01/2018'
--where ID in (1208807, 1208806, 1208808)
order by Description, ID


select * from ts_Finance_Transaction 
Where AccountID = '210010' and sCoyCode = 2 and Approved = 1 and TransactionDate = '12/13/2017'
Order by Description

Select Description
--, SUBSTRING([Description], LEN([Description]) - CHARINDEX('{', Reverse([Description]) ) + 2, CHARINDEX('{', Reverse([Description]) ) - 2) AS [InforwareID] 
From ts_Finance_Transaction
Where AccountID = '213000' and sCoyCode = 2 and approved = 1 and applicationid = 'treasuryreversal' and valuedate = '03/24/2017' --and ref = 'PEAS2-38853'
Order by Description -- [InforwareID]


Select Description
From ts_Finance_Transaction
Where AccountID = '213000' and sCoyCode = 2 and approved = 1 and applicationid = 'treasuryreversal' and valuedate <= '03/24/2017' and Description not like '{Batch%'
Order by Description -- [InforwareID]

Select * from ts_Finance_Transaction
Where AccountID = '113092' and Approved = 1 and sCoyCode = 5
order by TransactionDate, Description

Select ID, SUBSTRING([Description], LEN([Description]) - CHARINDEX('{', Reverse([Description]) ) + 2, CHARINDEX('{', Reverse([Description]) ) - 2) AS [InforwareID]   
from ts_Finance_Transaction
Where AccountID = '110003' and Approved = 1 and sCoyCode = 2
order by [InforwareID]

Placement Interest accrual - Deposit#: 9162, Cust ID: 000, Month: 6 {3725818}

select * from ts_Finance_Transaction
where Ref = 'JE-198221'
Where Description like 'IFund Prin - Deposit#: 3783624; Cust#: 20339%'
--Where ID in (294718,294732,296406,296502,296898,298119,299526,299606,653776)
order by Description




Begin tran

update ts_Finance_Transaction
set LEGTYPE = '210022', AccountID = '210022'
--set sCoyCode = 2
--Set Approved = 0, deleted = 1
Where ID in (1174239)
--Where AccountID = '213000' and sCoyCode = 2 and approved = 1 and applicationid = 'treasuryreversal' and valuedate <= '03/24/2017' and Description not like '{Batch%'

commit


select * from ts_banking_casa
where ProductAcctNo = '0000201'