/****** Script for SelectTopNRows command from SSMS  ******/
Declare @Dt as datetime

Set @Dt = '01/01/2018'
WHILE @Dt < '04/01/2018'
BEGIN
	INSERT INTO Fintrak.[dbo].[EndofDayBalance] ([InfowareCustNo]
      ,[FintrakCustNo]
      ,[AcctName]
      ,[Eod_Balance]
      ,[Eod_AverageBalance]
      ,[Eod_Date]
      ,[CurrencyCode]
      ,[InfowareAccountNo]
      ,[FintrakAccountNo]
      ,[ProductCode]
      ,[ContractRate]
      ,[Class]
	  ,CreatedBy
	 , CreatedDateTime)
	(SELECT CustID
		, FintrakCustID
		, Name
		, Sum(Principal) as EODBalance
		, null as EODAvgBalance
		, EODDate
		, Currency
		, InfowareAcctNum
		, FintrakAcctNum
		, InfowareProductCode
		, null as  Contra
		, Class
		, 'Donald.Oyeleye'
		, GetDate()
	FROM (SELECT Distinct [Trans#]
		  ,[CustID]
		  ,F.FintrakCustID
		  ,C.Name
		  ,(select top 1 principal from [IWGI].[dbo].[OP_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) as [Principal]
		  ,[InterestRate]
		  --,(select Sum(AccruedInterest) from IWGI.dbo.[IWfn_IFundPositionGeneric](CustID, @Dt, I.Liquidated)) as InterestAmt
		  , @Dt as EODDate
		  , 'NGN' as Currency
		  , CPGLAid+Custid as InfowareAcctNum
		  , F.FintrakAcctNum
		  ,(select top 1 EffectiveDate from [IWGI].[dbo].[OP_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id#) as [EffectiveDate]
		  ,(select top 1 MaturityDate from [IWGI].[dbo].[OP_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) as [MaturityDate]
		  , CPGLAid as InfowareProductCode
			, 'Liability' as Class
	  FROM [IWGI].[dbo].[OP_IFund_Trans] I
		inner join [IWGI].[dbo].Cust_Customers C
			on C.CustAID = I.CustID
		left join [Fintrak].[dbo].[vwFintrakCusttoAcctOfficerMISCodePerCompanyPerProduct] F
			on I.CustID = F.CustAID and I.CPGLAid = F.SourcePrdCode
	  Where EffectiveDate <= @Dt and (select top 1 MaturityDate from [IWGI].[dbo].[OP_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) >= @Dt) A --where CustID = 10026
	  GROUP BY CustID
		, FintrakCustID
		, Name
		, EODDate
		, Currency
		, InfowareAcctNum
		, FintrakAcctNum
		, InfowareProductCode
		, Class)

--		Set @Dt = DATEADD(dd, 1, @Dt)

--END


--union all
--WHILE @Dt < '05/09/2017'
--BEGIN 
--	INSERT INTO Fintrak.[dbo].[EndofDayBalance] ([InfowareCustNo]
--      ,[FintrakCustNo]
--      ,[AcctName]
--      ,[Eod_Balance]
--      ,[Eod_AverageBalance]
--      ,[Eod_Date]
--      ,[CurrencyCode]
--      ,[InfowareAccountNo]
--      ,[FintrakAccountNo]
--      ,[ProductCode]
--      ,[ContractRate]
--      ,[Class]
--		,CreatedBy
--		, CreatedDateTime)
--	SELECT CustID
--		, FintrakCustID
--		, Name
--		, Sum(Principal) as EODBalance
--		, null as EODAvgBalance
--		, EODDate
--		, Currency
--		, InfowareAcctNum
--		, FintrakAcctNum
--		, InfowareProductCode
--		, null as  Contra
--		, Class
--		, 'Donald.Oyeleye'
--		, GetDate()
--	FROM (SELECT Distinct [Trans#]
--		  ,[CustID]
--		  ,'' as FintrakCustID
--		  ,C.Name
--		  ,(select top 1 principal from [IWGI].[dbo].[AMPL_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) as [Principal]
--		  --,[InterestRate]
--		  --,(select Sum(AccruedInterest) from IWGI.dbo.[IWfn_IFundPositionGeneric](CustID, @Dt, I.Liquidated)) as InterestAmt
--		  , @Dt as EODDate
--		  , 'NGN' as Currency
--		  , CPGLAid+CPGLSub as InfowareAcctNum
--		  , (Select top 1 LedgerID from Fintrak.[dbo].[Fintrak_AcctMapping] where OldLedgerCode1 = CPGLAid+CPGLSub or OldLedgerCode2 = CPGLAid+CPGLSub or OldLedgerCode3 = CPGLAid+CPGLSub 
--						or OldLedgerCode4 = CPGLAid+CPGLSub or OldLedgerCode5 = CPGLAid+CPGLSub or OldLedgerCode6 = CPGLAid+CPGLSub or OldLedgerCode7 = CPGLAid+CPGLSub) as FintrakAcctNum
--		  ,(select top 1 EffectiveDate from [IWGI].[dbo].[AMPL_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id#) as [EffectiveDate]
--		  ,(select top 1 MaturityDate from [IWGI].[dbo].[AMPL_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) as [MaturityDate]
--		  , CPGLAid+CPGLSub as InfowareProductCode
--		  , 'Asset' as Class
--	  FROM [IWGI].[dbo].[AMPL_IFund_Trans] I
--		inner join [IWGI].[dbo].Cust_Customers C
--			on C.CustAID = I.CustID
--	  Where EffectiveDate <= @Dt and (select top 1 MaturityDate from [IWGI].[dbo].[AMPL_IFund_Trans] where Trans# = I.Trans# and EffectiveDate <= @Dt order by id# desc) >= @Dt and CustID = '000') A
--	  GROUP BY CustID
--		, FintrakCustID
--		, Name
--		, EODDate
--		, Currency
--		, InfowareAcctNum
--		, FintrakAcctNum
--		, InfowareProductCode
--		, Class
	  --order by Trans# --, I.id#

	  Set @Dt = DATEADD(dd, 1, @Dt)
END
