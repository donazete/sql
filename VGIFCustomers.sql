SELECT [CusNum]
      ,[CusName]
         ,CSCS [Reg No]
      ,[TelNo] + ' ' + [Mobile] as [Phone Number]
      ,[Email]
	  , [DOB]
	  , [CusType]
	  , [Mobile]
	  ,[FirstName]
      ,[MiddleName]
      ,[Surname]
	  ,[LExpDate]
      ,[ApprDat]
      ,[AccOpDat]
      ,REPLACE(LTRIM(RTRIM([NKin])), CHAR(10), '') as NKin
      ,[Gender]
	  ,[Natnlty]
      ,[PassPNo]
      ,[Occuptn]
	  ,[Addr1]
      ,[Addr2]
      ,[TwnCity]
      ,[LGA]
      ,[AddrState]
	  , LTRIM(RTRIM([CusAddr])) as CusAddr
         ,REPLACE(REPLACE(LTRIM(RTRIM([Addr1] + ' ' + [Addr2] + ' ' + [TwnCity] + ' ' + [LGA] + ' ' + [AddrState])), CHAR(13), ' '), CHAR(10), ' ') as [Address]
      ,REPLACE(REPLACE(LTRIM(RTRIM([RAddr])), CHAR(13), ' '), CHAR(10), ' ') [RAddr]
         ,REPLACE(REPLACE(LTRIM(RTRIM(CusAddr)), CHAR(13), ' '), CHAR(10), ' ') CusAddr
  FROM [SubDB].[dbo].[Customer]
  --where Email not like '%@%.%'
  --and CusNum in (SELECT [AcctNumber]
  --                           FROM [SubDB].[dbo].[SubMast]
  --                           where SubCode = '111' 
  --                           and AcctBal <> 0)
  Where CusNum = '01795'
  order by cusnum
  


  SELECT *
FROM [SubDB].[dbo].[SubMast]
where SubCode = '111'


SELECT AcctNumber, SubCode,
              (select CusName from SubDB.dbo.Customer where AcctNumber = CusNum) [Name],
              Sum(TrnAmt) [Amount]
  FROM [SubDB].[dbo].[SubTrnHst]
  where SubCode in ('111', '222')
  and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null)
  --and AcctNumber = '04503'
  group by AcctNumber, SubCode
  order by AcctNumber, SubCode



  select Distinct AcctNumber,
	getdate() as dt,
	(Select sum(TrnAmt) from [SubDB].[dbo].[SubTrnHst] where SubCode = '111' and AcctNumber = T.AcctNumber and Batno is not null and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1)) as Principal,
	(Select sum(TrnAmt) from [SubDB].[dbo].[SubTrnHst] where SubCode = '222' and AcctNumber = T.AcctNumber and Batno is not null and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1)) as InterestAccrued
  FROM [SubDB].[dbo].[SubTrnHst] T
  where SubCode = '111' and Batno is not null
  order by AcctNumber





  SELECT AcctNumber, SubCode,
              (select CusName from SubDB.dbo.Customer where AcctNumber = CusNum) [Name],
              Sum(TrnAmt) [PrincipalAmount],
				ISNULL(( SELECT CrdIntMth
				  FROM [SubDB].[dbo].[SubMast]
				  where SubCode in ('111') and AcctNumber = T.AcctNumber),0) + ISNULL((Select sum(TrnAmt) from [SubDB].[dbo].[SubTrnHst] where SubCode in ('222') and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null) and AcctNumber = T.AcctNumber), 0) [IntAmount]
  FROM [SubDB].[dbo].[SubTrnHst] T
  where SubCode in ('111')
  and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null)
  --and AcctNumber = '04503'
  group by AcctNumber, SubCode
   having Sum(TrnAmt) > 0
  order by AcctNumber--, SubCode


  --SELECT SubCode, AcctNumber, CusNum, AcctBal, CrdIntMth, CrdIntYTD
  --FROM [SubDB].[dbo].[SubMast]
  --where SubCode in ('111', '222') and AcctNumber = '04503'
  --order by AcctNumber, SubCode


  



  Select * from [SubDB].[dbo].[SubTrnHst] where SubCode in ('222') and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null) and AcctNumber = '05210'
  order by TrnDat desc