/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP 1000 [ID#]
      ,[SourcePrdCode]
      ,[FintrakPrdCode]
      ,[SrcCustAID]
      ,[FintrakCustID]
      ,[SrcAcctNum]
      ,[FintrakAcctNum]
      ,[ProdType]
      ,[Company]
      ,[CreatedBy]
      ,[CreatedDateTime]
  FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping]
  where SrcCustAID = '2451'
  order by SourcePrdCode


  Select SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company, Cnt = Count(SourcePrdCode)
FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company
Having Count(SourcePrdCode) > 1
order by SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company


Begin tran


Select SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company, Cnt = Count(SourcePrdCode)
INTO Holdkey
FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping]
Group by SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company
Having Count(SourcePrdCode) > 1
order by SourcePrdCode, FintrakPrdCode, SrcCustAID, FintrakCustID, SrcAcctNum, FintrakAcctNum, ProdType, Company

select * from Holdkey


--SELECT DISTINCT C.SourcePrdCode, C.FintrakPrdCode, C.SrcCustAID, C.FintrakCustID, C.SrcAcctNum, C.FintrakAcctNum, C.ProdType, C.Company
--INTO Holddups
--FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping] C
--	inner join Holdkey H
--ON C.SourcePrdCode = H.SourcePrdCode AND C.FintrakPrdCode = H.FintrakPrdCode AND C.SrcCustAID = H.SrcCustAID AND C.FintrakCustID = H.FintrakCustID AND C.SrcAcctNum = H.SrcAcctNum
--	AND C.FintrakAcctNum = H.FintrakAcctNum AND C.ProdType = H.ProdType AND C.Company = H.Company

--select * from Holddups
--where SrcCustAID = '10715'


--Select SourcePrdCode, SrcCustAID, Cnt = Count(SourcePrdCode)
--FROM Holddups
--Group by SourcePrdCode, SrcCustAID
--Having Count(SourcePrdCode) > 1
--order by SourcePrdCode, SrcCustAID

DELETE C
FROM [Fintrak].[dbo].[Fintrak_CustAcctMapping] C, Holdkey H
WHERE C.SourcePrdCode = H.SourcePrdCode AND C.FintrakPrdCode = H.FintrakPrdCode AND C.SrcCustAID = H.SrcCustAID AND C.FintrakCustID = H.FintrakCustID AND C.SrcAcctNum = H.SrcAcctNum
	AND C.FintrakAcctNum = H.FintrakAcctNum AND C.ProdType = H.ProdType AND C.Company = H.Company

INSERT [Fintrak].[dbo].[Fintrak_CustAcctMapping] ([SourcePrdCode]
      ,[FintrakPrdCode]
      ,[SrcCustAID]
      ,[FintrakCustID]
      ,[SrcAcctNum]
      ,[FintrakAcctNum]
      ,[ProdType]
      ,[Company]
	  ,[CreatedBy]
      ,[CreatedDateTime])
SELECT [SourcePrdCode]
      ,[FintrakPrdCode]
      ,[SrcCustAID]
      ,[FintrakCustID]
      ,[SrcAcctNum]
      ,[FintrakAcctNum]
      ,[ProdType]
      ,[Company]
	  ,'IWGI'
	  , GETDATE()
FROM Holdkey

rollback

commit