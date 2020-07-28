SELECT D.SchemeCode
	  , AccountCode
	  --, D.AccountNo
	  , ACC.[UCC] AS [InfowareNumber]
	  , ACC.[ClientName]
	  ,Sum([DividendAmt]) Dividend
  FROM [MWIntegra].[dbo].[Hdr_MFDivDailyAccrual] M
	inner join [MWIntegra].[dbo].[Dtl_MFDivDailyAccrual] D
		on M.HeaderID = D.HeaderID
	inner join [dbo].[HDR_Client] ACC WITH (NOLOCK) 
			ON ACC.client_code = D.AccountCode
	Where D.SchemeCode = 13 and M.[Date] between '01/01/2019' and '06/30/2019'
	--Where D.SchemeCode = 13 and AccountCode in ('16358')
	Group by D.SchemeCode
	  , AccountCode
	  --, D.AccountNo
	  , ACC.[UCC]
	  , ACC.[ClientName]
	order by  ACC.[UCC]--, [Date]