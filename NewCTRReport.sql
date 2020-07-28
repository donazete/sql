declare @RptType as integer
declare @StDate as datetime
declare @EnDate as datetime
declare @IndAmt as money
declare @CorpAmt as money


set @RptType = 0
set @StDate = '09/01/2017'
set @EnDate = '09/13/2017'
set @IndAmt = 5000000
set @CorpAmt = 10000000




If @RptType = 1
Begin
		SELECT @EnDate as ReportDt
			, '' as RefNum
			, '' as BankCode
			, (Case
				When ClientType = 'IND' Then 'INDIVIDUAL'
				Else 'CORPORATE'
				End) as CustType
			, C.BranchCode
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
			, C.Nationality
			, (Case
				When ClientType != 'IND' Then ''
				Else C.BirthDay
				End) as BirthDay
			, '' as DateofInc
			, C.Title
			, '' as Alias
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
			, '' as RCNum
			, '' as IssueDt
			, '' as PlaceofIssue
			, '' as Issuingauthority
			, '' as Addytype
			, C.Address1 as CFirstLineAddy
			, C.Address2 as CSecLineAddy
			, C.City AS	CCity
			, '' as LGA
			, C.State as CState
			, C.Phone1
			, C.Email1
			, 'FIXED INCOME' as AcctType
			, C.CustAID as AcctNum
			, 'ACTIVE' as AcctStat
			, C.CreateDate 
			, '' as linkedaccts
			, G.EffectiveDate
			, G.Description as TxnDetails
			, G.Amount
			, (Case
				When G.Amount > 0 Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
				Else 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
				End) as InstType
			, '' as FundSource
			, 'SELF' as Beneficiary
			, C.Address1 as BenAddy
			, 'SELF' as Sender
			, C.Address1 as SenderAddy
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.SysRef like 'JE%' and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID != '300') and C.ClientType = 'IND' and ABS(G.Amount) >= @IndAmt and G.SysRef Not Like 'REVERS%'

		UNION ALL

		SELECT @EnDate as ReportDt
			, '' as RefNum
			, '' as BankCode
			, (Case
				When ClientType = 'IND' Then 'INDIVIDUAL'
				Else 'CORPORATE'
				End) as CustType
			, C.BranchCode
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
			, C.Nationality
			, (Case
				When ClientType != 'IND' Then ''
				Else C.BirthDay
				End) as BirthDay
			, '' as DateofInc
			, C.Title
			, '' as Alias
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
			, '' as RCNum
			, '' as IssueDt
			, '' as PlaceofIssue
			, '' as Issuingauthority
			, '' as Addytype
			, C.Address1 as CFirstLineAddy
			, C.Address2 as CSecLineAddy
			, C.City AS	CCity
			, '' as LGA
			, C.State as CState
			, C.Phone1
			, C.Email1
			, 'FIXED INCOME' as AcctType
			, C.CustAID as AcctNum
			, 'ACTIVE' as AcctStat
			, C.CreateDate 
			, '' as linkedaccts
			, G.EffectiveDate
			, G.Description as TxnDetails
			, G.Amount
			, (Case
				When G.Amount > 0 Then 'Q-DEPOSIT FOR FUND MANAGEMENT'
				Else 'Q-WITHDRAWAL FROM FUND MANAGEMENT'
				End) as InstType
			, '' as FundSource
			, 'SELF' as Beneficiary
			, C.Address1 as BenAddy
			, 'SELF' as Sender
			, C.Address1 as SenderAddy
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.SysRef like 'JE%' and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID != '300') and C.ClientType != 'IND' and ABS(G.Amount) >= @CorpAmt and G.SysRef Not Like 'REVERS%'
		Order by C.CustAID
End
Else
	Begin
		SELECT @EnDate as ReportDt
			, '' as RefNum
			, '' as BankCode
			, (Case
				When ClientType = 'IND' Then 'INDIVIDUAL'
				Else 'CORPORATE'
				End) as CustType
			, C.BranchCode
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
			, C.Nationality
			, (Case
				When ClientType != 'IND' Then ''
				Else C.BirthDay
				End) as BirthDay
			, '' as DateofInc
			, C.Title
			, '' as Alias
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
			, '' as RCNum
			, '' as IssueDt
			, '' as PlaceofIssue
			, '' as Issuingauthority
			, '' as Addytype
			, C.Address1 as CFirstLineAddy
			, C.Address2 as CSecLineAddy
			, C.City AS	CCity
			, '' as LGA
			, C.State as CState
			, C.Phone1
			, C.Email1
			, 'STOCK BROKING' as AcctType
			, C.CustAID as AcctNum
			, 'ACTIVE' as AcctStat
			, C.CreateDate 
			, '' as linkedaccts
			, G.EffectiveDate
			, G.Description as TxnDetails
			, G.Amount
			, (Case
				When G.Amount > 0 Then 'Q-DEPOSIT FOR STOCK BROKING'
				Else 'Q-WITHDRAWAL FROM STOCK BROKING'
				End) as InstType
			, '' as FundSource
			, 'SELF' as Beneficiary
			, C.Address1 as BenAddy
			, 'SELF' as Sender
			, C.Address1 as SenderAddy
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			left join Cust_CsCsInfo CS
				on C.CustAID = CS.CustAID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.SysRef like 'JE%' and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID = '300') and C.ClientType = 'IND' and ABS(G.Amount) >= @IndAmt and G.SysRef Not Like 'REVERS%'

		UNION ALL

		SELECT @EnDate as ReportDt
			, '' as RefNum
			, '' as BankCode
			, (Case
				When ClientType = 'IND' Then 'INDIVIDUAL'
				Else 'CORPORATE'
				End) as CustType
			, C.BranchCode
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
			, C.Nationality
			, (Case
				When ClientType != 'IND' Then ''
				Else C.BirthDay
				End) as BirthDay
			, '' as DateofInc
			, C.Title
			, '' as Alias
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1010 and [OwnerTableID] = C.ID#) as Occupation
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1029 and [OwnerTableID] = C.ID#) as IDType
			, (SELECT [Value]
				 FROM [dbo].[Attrib_Values] V
					inner join [dbo].[Attrib_Sets] S
						on S.ID# = V.AttribSetID
				Where S.AttribID = 1027 and [OwnerTableID] = C.ID#) as IDNum
			, '' as RCNum
			, '' as IssueDt
			, '' as PlaceofIssue
			, '' as Issuingauthority
			, '' as Addytype
			, C.Address1 as CFirstLineAddy
			, C.Address2 as CSecLineAddy
			, C.City AS	CCity
			, '' as LGA
			, C.State as CState
			, C.Phone1
			, C.Email1
			, 'STOCK BROKING' as AcctType
			, C.CustAID as AcctNum
			, 'ACTIVE' as AcctStat
			, C.CreateDate 
			, '' as linkedaccts
			, G.EffectiveDate
			, G.Description as TxnDetails
			, G.Amount
			, (Case
				When G.Amount > 0 Then 'Q-DEPOSIT FOR STOCK BROKING'
				Else 'Q-WITHDRAWAL FROM STOCK BROKING'
				End) as InstType
			, '' as FundSource
			, 'SELF' as Beneficiary
			, C.Address1 as BenAddy
			, 'SELF' as Sender
			, C.Address1 as SenderAddy
		From IWVW_Cust_Customers C
			left join [dbo].[Cust_CustomersEx] E
				on C.ID# = E.CustID
			left join Cust_CsCsInfo CS
				on C.CustAID = CS.CustAID
			inner join Acct_GL G
				On G.Sub = C.CustAID
		Where G.SysRef like 'JE%'  and G.EffectiveDate between @StDate and @EnDate and G.AccountID IN (SELECT DISTINCT [AID] FROM [dbo].[OP_InvolvmentAccts]
							Where AID = '300') and C.ClientType != 'IND' and ABS(G.Amount) >= @CorpAmt and G.SysRef Not Like 'REVERS%'
		Order by C.CustAID
	End