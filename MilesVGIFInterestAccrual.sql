/****** Script for SelectTopNRows command from SSMS  ******/
SELECT M.[HeaderID]
      ,[Date]
      ,[CreatedOn]
	  ,SchemeCode
	  , AccountCode
	  , AccountNo
	  ,[TWMPODID]
	  ,[DividendAmt]
  FROM [MWIntegra].[dbo].[Hdr_MFDivDailyAccrual] M
	inner join [MWIntegra].[dbo].[Dtl_MFDivDailyAccrual] D
		on M.HeaderID = D.HeaderID
	Where SchemeCode = @Scheme and AccountCode in (@Acctcode) and Date between @stDt and @Endt
	--Where SchemeCode = 13 and AccountCode in (16358) --and Date between @stDt and @Endt
	25667	25667		24698


SELECT AccountCode
	  , Sum([DividendAmt]) as Dividend
  FROM [MWIntegra].[dbo].[Hdr_MFDivDailyAccrual] M
	inner join [MWIntegra].[dbo].[Dtl_MFDivDailyAccrual] D
		on M.HeaderID = D.HeaderID
	Where SchemeCode = @SchemeCode and AccountCode = (@AccountCode) and Date between @stDt and @FromDate
