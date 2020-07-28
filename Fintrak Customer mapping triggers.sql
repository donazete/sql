CREATE TRIGGER FintrakCustomerAcctConvert  
ON [dbo].[Cust_Involvements]  --- TODO:: Change to involvement table
AFTER INSERT   
AS  
  BEGIN
	DECLARE @CustomerCode as varchar(10)

	Select @CustomerCode = CustAid from Inserted
	print @CustomerCode

	INSERT INTO Fintrak.[dbo].[Fintrak_CustAcctMapping] ([SourcePrdCode]
			  ,[FintrakPrdCode]
			  ,[SrcCustAID]
			  ,[FintrakCustID]
			  ,[SrcAcctNum]
			  ,[FintrakAcctNum]
			  ,[ProdType]
			  ,[Company])
		SELECT I.AID as SourceProdCode
			  , F.ProductCode
			  , CI.[CustAID]
			  , (Select [FintrakCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID]) as FintrakCustID
			  , I.AID+CI.[CustAID]
			  ,(Select [FintrakCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID])+F.ProductCode+
				(Case
					When (Select [SourceCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID] and [FintrakCustAID] like '%'+CI.[CustAID]+'%') = CI.[CustAID] Then '1'
					When (Select [SourceCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID] and [FintrakCustAID] like '%'+CI.[CustAID]+'%') = CI.[CustAID] and I.AID != '3000' Then '1'
					When (Select [SourceCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID] and [FintrakCustAID] not like '%'+CI.[CustAID]+'%') = CI.[CustAID] and I.AID = '3000' Then '2'
					Else '1'
				End)
			  , CI.[Type]
			  , F.fcCompanyID
		  FROM [IWGI].[dbo].[Cust_Involvements] CI
			inner join (SELECT [pParamInvID]
						  , P.Code
						  , P.Description
						  ,[AID]
					  FROM [IWGI].[dbo].[OP_InvolvmentAccts] I
						inner join [IWGI].[dbo].pParams P
							on P.ID# = I.pParamInvID) I
				on CI.Type = I.Code
			inner join Fintrak.[dbo].[FintrakAccountType] F
				on I.AID = F.InfoWAREAccountID
		  Where CI.[CustAID] = @CustomerCode
  END
GO




CREATE TRIGGER FintrakCustomerNoConvert  
ON [dbo].[Cust_Customers]  --- TODO:: Change to involvement table
AFTER INSERT   
AS  
  BEGIN
	DECLARE @CustomerCode as varchar(10)

	Select @CustomerCode = CustAid from Inserted
	print @CustomerCode

	INSERT INTO [Fintrak].[dbo].[Fintrak_CustMapping] ([SourceCustAID],[FintrakCustAID],[SourceApp])
	Select @CustomerCode
		, Case Len(@CustomerCode)
			When 4 Then '100'+@CustomerCode
			When 5 Then '10'+@CustomerCode
			When 6 Then '1'+@CustomerCode
			When 7 Then @CustomerCode
		End
		, 'Infoware'


  END
GO







Begin tran

  INSERT INTO [Fintrak].[dbo].[Fintrak_CustMapping] (SourceCustAID,FintrakCustAID,SourceApp)
  Select CustAID
		, Case len(CustAID)
			When 4 Then '100'+CustAID
			Else '10'+CustAID
		End
		, 'Infoware'
from IWGI.dbo.Cust_Customers
Where CustAID not like '%AGNT%' and Custaid not in (SELECT [SourceCustAID]
	FROM [Fintrak].[dbo].[Fintrak_CustMapping])


commit
	rollback