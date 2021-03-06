/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [Trans#]
      ,[CustID]
	  , C.Name
      ,[Principal]
      ,[InterestRate]
      ,[EffectiveDate]
      ,[Tenure]
      ,[MaturityDate]
      ,[InterestAmount]
      ,[CPGLAid]
      ,[CPGLSub]
      ,[SuspenseAID]
      ,[SuspenseSub]
      ,[OrigPrincipal]
      ,[Liquidated]
      ,[FirstRec]
      ,[PnLAID]
      ,[PnLSub]
      ,[InterestRecAID]
      ,[InterestRecSub]
      ,[InstrumentType]
  FROM [IWGI].[dbo].[AMPL_IFund_Trans] A
	inner join Cust_Customers C
		on A.CustID = C.CustAID
  Where EffectiveDate <= '12/31/2017' and CustID = '14137' and MaturityDate >= '12/31/2017'



Select * FROM [IWGI].[dbo].[AMPL_IFund_Trans]
Where Principal like '193400273'  --.972603

FundCode	FundName	MFGLAid	MFGLSub
KEDARI	KEDARI	KIS807	14082
ABACUS	ABACUS	3000	14137
VBF	VANTAGE BALANCED FUND	3000	8798
KSIF	KWARA STATE INFRASTRUCTURE FUND	3000	17014

  select * from OP_MutualFund
  Where FundCode in ('VBF','KEDARI','ABACUS','KSIF')