Declare @StDt as datetime
Declare @EnDt as datetime
Declare @Email1 as varchar(500)
Declare @User as varchar(500)
Declare @CustAID as varchar(10)

Set @StDt = '01/01/2000'
Set @EnDt = GETDATE()
Set @User = 'GTBASSET\Donald.Oyeleye'
Set @Email1 = SUBSTRING(@User, 10, 200)
Set @CustAID  = NULL

--Select @Email1, LEN(@Email1)

If (@User= 'GTBASSET\Donald.Oyeleye' OR @User= 'GTBASSET\Israel.Adewale' OR @User= 'GTBASSET\Oluwaseun.Ajayi')
	Select CustAID
		, Name
		, ClientType
		, Nationality
		, AccountOfficer
		, C.Address1
		, C.Address2
		, C.City
		, C.[State]
		, C.Country
		, C.Email1
		, NextOfKin
		, Relationship
		, Birthday
		, CreateDate
		, (SELECT [Value]
			  FROM [IWGI].[dbo].[Attrib_Values] V
			Where AttribSetID = 37 and V.OwnerTableID = C.ID#) as BVN
		, (SELECT top 1 PA.Description
			  FROM [IWGI].[dbo].[Op_ContactsBankInfo] BI
				inner join (Select * from pParams
					Where Type like 'BANKNAMES') PA
				On BI.BankCode = PA.Code
			Where [ParentRowID] = C.ID#) as Bank1
		, (SELECT Top 1 [AcctNumber]
			FROM [IWGI].[dbo].[Op_ContactsBankInfo]
			Where [ParentRowID] = C.ID# and [ContactInfoOwnerID] = 2) as BankAcct1
		, I.Email1 as AcctOfficerEmail
	from IWVW_Cust_Customers C
		outer apply (Select * from OP_Officers O
			Where C.Accountofficer_ID = O.IDNumber) O
		outer apply (Select * from OP_ContactInfo I
			Where I.ParentRowID = O.ID# and ContactInfoOwnerID = 1) I
	Where (CreateDate IS NULL OR CreateDate between @StDt and @EnDt) and (C.CustAID LIKE CASE WHEN @CustAID IS NULL THEN '%' ELSE @CustAID END)
	Order by Name
Else 
	Select CustAID
		, Name
		, ClientType
		, Nationality
		, AccountOfficer
		, C.Address1
		, C.Address2
		, C.City
		, C.[State]
		, C.Country
		, C.Email1
		, NextOfKin
		, Relationship
		, Birthday
		, CreateDate
		, (SELECT [Value]
			  FROM [IWGI].[dbo].[Attrib_Values] V
			Where AttribSetID = 37 and V.OwnerTableID = C.ID#) as BVN
		, (SELECT top 1 PA.Description
			  FROM [IWGI].[dbo].[Op_ContactsBankInfo] BI
				inner join (Select * from pParams
					Where Type like 'BANKNAMES') PA
				On BI.BankCode = PA.Code
			Where [ParentRowID] = C.ID#) as Bank1
		, (SELECT Top 1 [AcctNumber]
			FROM [IWGI].[dbo].[Op_ContactsBankInfo]
			Where [ParentRowID] = C.ID# and [ContactInfoOwnerID] = 2) as BankAcct1
		, I.Email1 as AcctOfficerEmail
	from IWVW_Cust_Customers C
		outer apply (Select * from OP_Officers O
			Where C.Accountofficer_ID = O.IDNumber) O
		outer apply (Select * from OP_ContactInfo I
			Where I.ParentRowID = O.ID# and ContactInfoOwnerID = 1) I
	Where (CreateDate IS NULL OR CreateDate between @StDt and @EnDt) and I.Email1 = @Email1+'@investment-one.com' and (C.CustAID LIKE CASE WHEN @CustAID IS NULL THEN '%' ELSE @CustAID END)
	Order by Name


--select * from OP_Officers

--select * from OP_ContactInfo
--Where ContactInfoOwnerID = 1

--Select * from pParams
--Where Type like 'BANKNAMES'
--select distinct ContactInfoOwnerID from OP_ContactInfo


--Select * from IWVW_Cust_Customers
----Where AccountOfficer IS NULL
--order by CustAID