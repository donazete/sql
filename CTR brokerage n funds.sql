
If @RptType = 1
Begin
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
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1012 and [OwnerTableID] = C.ID#) as DateofInc
			, '' as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1011 and [OwnerTableID] = C.ID#) as BusType
			, '' as IDNum
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as RCNum
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
End
Else
	Begin
		SELECT 'B-BROKING FIRM' as TypeofInst
			, 'INVESTMENT ONE STOCKBROKERS LIMITED' as InstCode
			, '' as SECReg
			,'' as NSENum
			, CS.CsCsAcct# as CSCSNum
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
			, G.Amount
			, (Case
				When G.Amount > 0 Then 'Q-DEPOSIT FOR STOCK BROKING'
				Else 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
				End) as InstType
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			left join Cust_CsCsInfo CS
				on C.CustAID = CS.CustAID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.BatchNo != 0 and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID != '3000') and C.ClientType = 'IND' and ABS(G.Amount) >= @IndAmt and G.SysRef Not Like 'REVERS%'

		UNION ALL

		SELECT 'B-BROKING FIRM' as TypeofInst
			, 'INVESTMENT ONE STOCKBROKERS LIMITED' as InstCode
			, '' as SECReg
			,'' as NSENum
			, CS.CsCsAcct# as CSCSNum
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
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1012 and [OwnerTableID] = C.ID#) as DateofInc
			, '' as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1011 and [OwnerTableID] = C.ID#) as BusType
			, '' as IDNum
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as RCNum
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
				When G.Amount > 0 Then 'Q-DEPOSIT FOR STOCK BROKING'
				Else 'Q-WITHDRAWAL FROM STOCK BROKING'
				End) as InstType
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			left join Cust_CsCsInfo CS
				on C.CustAID = CS.CustAID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.BatchNo != 0 and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID != '3000') and C.ClientType != 'IND' and ABS(G.Amount) >= @CorpAmt and G.SysRef Not Like 'REVERS%'
		Order by C.CustAID
	End