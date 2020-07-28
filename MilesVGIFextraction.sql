--[dbo].[spselVGIFCustomerBalance] 
--                @CustomerNumber VARCHAR(10)


--SELECT * FROM [dbo].[SubTrnHst] 
--ORDER BY RecordID DESC 
--111  -- Principal Account 
--222  -- Interest Account


--[dbo].[iofsKGIFCustomerBalance] 
--        @SubCode VARCHAR(3) 
--    ,@Account VARCHAR(15) 
--    ,@BalanceOutput VARCHAR(20) OUTPUT 
--    ,@DerivedSubCode VARCHAR(20) OUTPUT 
--        ,@DerivedCustomerName VARCHAR(200) OUTPUT 
--        ,@DerivedPostDate VARCHAR(20) OUTPUT 
--        ,@DerivedTransactionDate VARCHAR(20) OUTPUT

Select Distinct AcctNumber
	, (Select top 1 TrnAmt from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '11/01/2017' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID) as OpeningBal
	, ISNULL((Select Sum(TrnAmt) from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate >= '11/01/2017' and Batno IS NOT NULL and Partlars != '' 
		and  AcctNumber = S.AcctNumber and RecordID not in (Select top 1 RecordID from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '11/01/2017' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID)),0) as contribution
	, (Select top 1 TrnAmt from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '11/01/2017' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID) + 
		ISNULL((Select Sum(TrnAmt) from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate >= '11/01/2017' and Batno IS NOT NULL and Partlars != '' 
		and  AcctNumber = S.AcctNumber and RecordID not in (Select top 1 RecordID from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '11/01/2017' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID)),0) as CurrBal
	, (Select top 1 TrnAmt from [dbo].[SubTrnHst] Where SubCode = '222' and PostDate = '11/01/2017' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID) as Interestaccrued
From [dbo].[SubTrnHst] S
Where SubCode = '111'







SELECT AcctNumber,
              Sum(TrnAmt) [Principal],
			  (SELECT Sum(TrnAmt) [Amount]
				  FROM [SubDB].[dbo].[SubHst2017]
				  where SubCode = '222'
				  and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null) and  AcctNumber = S.AcctNumber) as Interest
  FROM [SubDB].[dbo].[SubHst2017] S
  where SubCode = '111'
  and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null)
  --and AcctNumber = '04503'
  group by AcctNumber
  Having Sum(TrnAmt) > 0
  order by AcctNumber



  



Select CustAID
	, C.Name
	, A.Value as VGIFCust
	,(SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 51 and OwnerTableID = C.ID#) as VGIGFNumber
	,(SELECT [Value]
		  FROM [IWGI].[dbo].[Attrib_Values]
		  Where AttribSetID = 54 and OwnerTableID = C.ID#) as DivOpt
From Cust_Customers C
	inner join Attrib_Values A
		on A.AttribSetID in (50) and C.ID# = A.OwnerTableID
Where A.Value = 'YES'



Select Distinct AcctNumber
       , (Select top 1 TrnAmt from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '01/01/2018' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID) as OpeningBal
       , ISNULL((Select Sum(TrnAmt) from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate between '01/01/2018' and '06/30/2018' and Batno IS NOT NULL and Partlars != '' 
              and  AcctNumber = S.AcctNumber and RecordID not in (Select top 1 RecordID from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '01/01/2018' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID)),0) as contribution
       , ISNULL((Select top 1 TrnAmt from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '01/01/2018' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID), 0) + 
              ISNULL((Select Sum(TrnAmt) from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate between '01/01/2018' and '06/30/2018' and Batno IS NOT NULL and Partlars != '' 
              and  AcctNumber = S.AcctNumber and RecordID not in (Select top 1 RecordID from [dbo].[SubTrnHst] Where SubCode = '111' and PostDate = '01/01/2018' and Batno IS NULL and AcctNumber = S.AcctNumber order by RecordID)),0) as CurrBal
		--, (SELECT SUM(TrnAmt) FROM SubTrnHst WHERE SubCode = '222'
		--		AND BATNO IS  NULL
		--		AND PARTLARS  = ''
		--		AND PostDate = '2018-06-01' and AcctNumber = S.AcctNumber) as AccruedInt
From [dbo].[SubTrnHst] S
Where SubCode = '111'
order by AcctNumber

---Transactions

SELECT SubCode,
              AcctNumber,
              (select CusName from SubDB.dbo.Customer where AcctNumber = CusNum) [Name],
              CASE 
                     WHEN Partlars = '' AND MONTH(PostDate) = 1 AND DAY(PostDate) = 1
                           THEN 'Opening Balance'
                     ELSE Partlars
              END as Partlars,
              Instno,
              TrnAmt [Amount],
              PostDate [Post Date],
              TrnDat [Value Date]
  FROM [SubDB].[dbo].[SubTrnHst]
  where SubCode = '111'
  and not (MONTH(PostDate) > 1 and DAY(PostDate) = 1 and Batno is null)
  and MONTH(PostDate) > 6 -- change date filter year depending on period required
  and Partlars <> 'Auto Entries GRP June 2018 GRP' -- excluding interest paid in june
  --and TrnAmt > 0 -- alter gt/lt for subscription/redemption
  order by AcctNumber, PostDate