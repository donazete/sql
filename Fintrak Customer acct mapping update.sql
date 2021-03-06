/****** Script for SelectTopNRows command from SSMS  ******/
Begin tran

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
  Where Type != 'AGENT' AND CI.[CustAID] NOT IN (Select Distinct SrcCustAID from Fintrak.[dbo].[Fintrak_CustAcctMapping]) AND CI.[CustAID] not like '%AGNT%' and (Select [FintrakCustAID] from Fintrak.[dbo].[Fintrak_CustMapping] where [SourceCustAID] = CI.[CustAID]) IS NOT NULL
  ---order by FintrakCustID


  commit
  rollback


  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT [ID#]
      ,[SourcePrdCode]
      ,[FintrakPrdCode]
      ,[SrcCustAID]
      ,[FintrakCustID]
      ,[SrcAcctNum]
      ,[FintrakAcctNum]
      ,[ProdType]
      ,[Company]
  FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping]