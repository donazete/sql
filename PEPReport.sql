/****** Script for SelectTopNRows command from SSMS  ******/
Declare @StDate as Datetime
Declare @EnDate as Datetime
Declare @RptType as bit

Set @StDate = '01/01/2012'
Set @EnDate = '08/18/2017'
Set @RptType = 0

IF @RptType = 1
begin
	SELECT (Case
				When AccountID = '3000' or AccountID = '300' Then 'K-STOCKBROKER'
				Else 'K-FUND MANAGER'
			End) as TypeofInst
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
				, '' as DateofInc
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
				, '' as BusType
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
				, '' as RCNum
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
				, C.Address1 as CFirstLineAddy
				, C.Address2 as CSecLineAddy
				, C.City AS	CCity
				, C.State as CState
				, C.Email1
				, C.Phone1
				, G.EffectiveDate
				, C.CustAID as AcctNum
				, 'ACTIVE' as AcctStat
			,[EffectiveDate] As TransactionDt
		  ,[AccountID]
		  --,[Sub]
		  --,C.Name
		  ,A.Description as Product
		  ,[Amount]
		  , (Case
					When G.Amount > 0 and (AccountID = '3000' or AccountID = '300') Then 'Q-DEPOSIT FOR STOCKBROKING'
					When G.Amount < 0 and (AccountID = '3000' or AccountID = '300') Then 'Q-WITHDRAWAL FROM STOCKBROKING'
					When G.Amount > 0 and (AccountID != '3000' or AccountID != '300') Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
					When G.Amount < 0 and (AccountID != '3000' or AccountID != '300') Then 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
					End) as InstType
		  --,G.[Description] as TransactionNarrative
		  ,C.AccountOfficer
	  FROM [dbo].[Acct_GL] G 
		inner join IWVW_Cust_Customers C
			on G.Sub = C.CustAID
		left join [dbo].[Cust_CustomersEx] E
					on C.ID# = E.CustID
		inner join (SELECT [pParamInvID]
				  ,[AID]
				  ,P.Code
				  , P.Description
			  FROM [IWGI].[dbo].[OP_InvolvmentAccts] OP
				inner join pParams P
					on OP.pParamInvID = P.ID#) A
			on G.AccountID = A.AID
		inner join [dbo].[Attrib_Values] AV
			on C.ID# = AV.OwnerTableID
	Where EffectiveDate between @StDate and @EnDate and Av.AttribSetID = 16 and Av.Value = 'YES' and SysRef not like 'REVERS%' and (AccountID != '3000' and AccountID != '300')
	Order by EffectiveDate, AccountID, Sub
END
Else
BEGIN
	SELECT (Case
				When AccountID = '3000' or AccountID = '300' Then 'K-STOCKBROKER'
				Else 'K-FUND MANAGER'
			End) as TypeofInst
			, 'INVESTMENT ONE STOCKBROKERS LIMITED' as InstCode
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
				, '' as DateofInc
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
				, '' as BusType
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
				, '' as RCNum
				, (SELECT [Value]
					 FROM [dbo].[Attrib_Values] V
						inner join [dbo].[Attrib_Sets] S
							on S.ID# = V.AttribSetID
					Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
				, C.Address1 as CFirstLineAddy
				, C.Address2 as CSecLineAddy
				, C.City AS	CCity
				, C.State as CState
				, C.Email1
				, C.Phone1
				, G.EffectiveDate
				, C.CustAID as AcctNum
				, 'ACTIVE' as AcctStat
			,[EffectiveDate] As TransactionDt
		  ,[AccountID]
		  --,[Sub]
		  --,C.Name
		  ,A.Description as Product
		  ,[Amount]
		  , (Case
					When G.Amount > 0 and (AccountID = '3000' or AccountID = '300') Then 'Q-DEPOSIT FOR STOCKBROKING'
					When G.Amount < 0 and (AccountID = '3000' or AccountID = '300') Then 'Q-WITHDRAWAL FROM STOCKBROKING'
					When G.Amount > 0 and (AccountID != '3000' or AccountID != '300') Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
					When G.Amount < 0 and (AccountID != '3000' or AccountID != '300') Then 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
					End) as InstType
		  --,G.[Description] as TransactionNarrative
		  ,C.AccountOfficer
	  FROM [dbo].[Acct_GL] G 
		inner join IWVW_Cust_Customers C
			on G.Sub = C.CustAID
		left join [dbo].[Cust_CustomersEx] E
					on C.ID# = E.CustID
		inner join (SELECT [pParamInvID]
				  ,[AID]
				  ,P.Code
				  , P.Description
			  FROM [IWGI].[dbo].[OP_InvolvmentAccts] OP
				inner join pParams P
					on OP.pParamInvID = P.ID#) A
			on G.AccountID = A.AID
		inner join [dbo].[Attrib_Values] AV
			on C.ID# = AV.OwnerTableID
	Where EffectiveDate between @StDate and @EnDate and Av.AttribSetID = 16 and Av.Value = 'YES' and SysRef not like 'REVERS%' and (AccountID = '3000' or AccountID = '300')
	Order by EffectiveDate, AccountID, Sub
END
--Select * from Acct_GL where Sub in ('15328', '1117')