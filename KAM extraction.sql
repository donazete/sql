/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [GLTrnDat], 
		[GLNumber]
      ,[GLTrnAmt]
	  ,[GLPartlars]
	  , '005' as Branch
  FROM [GLDB].[dbo].[GLTrnHst]
  where BchCode is not null and GLTrnAmt != 0 and GLTrnDat between '06/01/2017' and '06/30/2017'
  order by GLTrnDat

