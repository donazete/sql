Declare @stDate as Datetime
Declare @enDate as Datetime
Declare @coyCode as int
Declare @acctCat as int

set @stDate = '01/01/2017'
set @enDate = '04/30/2017'
set @coyCode = 1
set @acctCat = 5

  select DateName(Month, T.Valuedate) as [Month], Month(T.Valuedate) as MonthVal 
	, T.AccountID
	, C.AccountName
	, C.AccountCategoryID
	, Sum(T.DebitAmt) Debit
	, Sum(T.CreditAmt) Credit
	, (Sum(T.CreditAmt) - Sum(T.DebitAmt)) NetBalance
	, sCoyCode as Company
  from ts_Finance_Transaction T
	inner join ts_Finance_ChartOfAccount C
	on T.AccountID = C.AccountID
Where ValueDate between @stDate and @enDate  and C.AccountCategoryID in (@acctCat) and T.sCoyCode in (@coyCode)
Group by T.sCoyCode, DateName(Month, T.Valuedate), Month(T.Valuedate),  C.AccountCategoryID,T.AccountID, C.AccountName
order by T.sCoyCode, Month(T.Valuedate), C.AccountCategoryID, T.AccountID


select Month(T.Valuedate) as [Month]
	--, T.AccountID
	--, C.AccountName
	, case C.AccountCategoryID
		When 4 Then 'Income'
		else 'Expense'
	end as Category
	, Sum(T.DebitAmt) Debit
	, Sum(T.CreditAmt) Credit
	, (Sum(T.CreditAmt) - Sum(T.DebitAmt)) NetBalance
	, sCoyCode as Company
  from ts_Finance_Transaction T
	inner join ts_Finance_ChartOfAccount C
	on T.AccountID = C.AccountID
Where Year(ValueDate) =2017 and C.AccountCategoryID in (4,5)
Group by T.sCoyCode, Month(T.Valuedate), C.AccountCategoryID --,T.AccountID, C.AccountName
order by T.sCoyCode, Month(T.Valuedate), C.AccountCategoryID--, T.AccountID



select (Sum(T.CreditAmt) - Sum(T.DebitAmt)) from ts_Finance_Transaction T
where AccountID = '400001' and sCoyCode = 1 and YEAR(ValueDate) = 2017 and MONTH(ValueDate) = 1