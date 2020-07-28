Declare @StDate as Datetime
Declare @EnDate as Datetime
Declare @IndAmt as Money
Declare @CorpAmt as Money

Set @StDate = '08/30/2016'
Set @EnDate = '09/03/2016'
Set @IndAmt = 5000000
Set @CorpAmt = 10000000

SELECT 'K-FUND MANAGER' as TypeofInst
	, 'INVESTMENT ONE FINANCIAL SERVICES' as InstCode
	, '' as SECReg
	,'' as NSENum
	, '' as CSCSNum
	, '' as DMONum
	, 'LAGOS' as TxnBranch
	, (Select Address1 from IWVW_Cust_Customers Where CustAID = '000') as FirstLineAddy
	, '' as SecLineAddy
	, 'VICTORIA ISLAND' as City
	, 'LAGOS' as [State]
	, (Case
		When ClientType != 'IND' Then C.Name
		When ClientType = 'IND' and ((E.LastName IS NULL) OR (E.LastName = '')) Then C.Name
		Else E.LastName
		End) as InvSurname
	, (Case
		When ClientType != 'IND' Then ''
		Else E.FirstName
		End) as Firstname
	, (Case
		When ClientType != 'IND' Then ''
		Else E.MiddleName
		End) as MiddleName
	, C.Title
	, '' as Alias
	, (Case
		When ClientType != 'IND' Then ''
		Else C.BirthDay
		End) as BirthDay
	, (Case
		When ClientType != 'IND' Then C.BirthDay
		Else ''
		End) as DateofInc
	, '' as Occupation
	, '' as BusType
	, '' as IDNum
	, '' as RCNum
	, '' as IDType
	, C.Address1 as CFirstLineAddy
	, C.Address2 as CSecLineAddy
	, C.City AS	CCity
	, C.State as CState
	, C.Email1
	, C.Phone1
	, G.EffectiveDate
	, C.CustAID as AcctNum
	, 'ACTIVE' as AcctStat
	, G.Amount
	, (Case
		When G.Amount > 0 Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
		Else 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
		End) as InstType
From IWVW_Cust_Customers C
	left join [dbo].[Cust_CustomersEx] E
		on C.ID# = E.CustID
	inner join Acct_GL G
		On G.Sub = C.CustAID
Where G.BatchNo != 0 and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
					Where AID != '3000') and C.ClientType = 'IND' and ABS(G.Amount) >= @IndAmt and G.SysRef Not Like 'REVERS%'

UNION ALL

SELECT 'K-FUND MANAGER' as TypeofInst
	, 'INVESTMENT ONE FINANCIAL SERVICES' as InstCode
	, '' as SECReg
	,'' as NSENum
	, '' as CSCSNum
	, '' as DMONum
	, 'LAGOS' as TxnBranch
	, (Select Address1 from IWVW_Cust_Customers Where CustAID = '000') as FirstLineAddy
	, '' as SecLineAddy
	, 'VICTORIA ISLAND' as City
	, 'LAGOS' as [State]
	, (Case
		When ClientType != 'IND' Then C.Name
		Else E.LastName
		End) as InvSurname
	, (Case
		When ClientType != 'IND' Then ''
		Else E.FirstName
		End) as Firstname
	, (Case
		When ClientType != 'IND' Then ''
		Else E.MiddleName
		End) as MiddleName
	, C.Title
	, '' as Alias
	, (Case
		When ClientType != 'IND' Then NULL
		Else C.BirthDay
		End) as BirthDay
	, (Case
		When ClientType != 'IND' Then C.BirthDay
		Else ''
		End) as DateofInc
	, '' as Occupation
	, '' as BusType
	, '' as IDNum
	, '' as RCNum
	, '' as IDType
	, C.Address1 as CFirstLineAddy
	, C.Address2 as CSecLineAddy
	, C.City AS	CCity
	, C.State as CState
	, C.Email1
	, C.Phone1
	, G.EffectiveDate
	, C.CustAID as AcctNum
	, 'ACTIVE' as AcctStat
	, G.Amount
	, (Case
		When G.Amount > 0 Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
		Else 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
		End) as InstType
From IWVW_Cust_Customers C
	left join [dbo].[Cust_CustomersEx] E
		on C.ID# = E.CustID
	inner join Acct_GL G
		On G.Sub = C.CustAID
Where G.BatchNo != 0 and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
					Where AID != '3000') and C.ClientType != 'IND' and ABS(G.Amount) >= @CorpAmt and G.SysRef Not Like 'REVERS%'
Order by C.CustAID