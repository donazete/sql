Declare @Dt as Datetime
Set @Dt = GETDATE()

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT DISTINCT [Trans#]
      ,[CustID]
	  ,C.Name
      ,[EffectiveDate]
      ,[Principal]
	  ,[InterestRate]
      ,(Case
			When CPGLAid = '3005' and Principal < 500000 Then [InterestRate] + 3
			When CPGLAid = '3005' and Principal between 500000 and 999999 Then [InterestRate] + 4
			When CPGLAid = '3005' and Principal >= 1000000 Then [InterestRate] + 5
			When CPGLAid = '3006' Then 15
			Else [InterestRate]
		End) as [InterestRate2]
      ,(Case
			--When CPGLAid = '3006' Then 365
			When CPGLAid = '3008' Then 365
			Else [Tenure]
		End) as [Tenure]
      ,[MaturityDate]
	  ,([Principal] * (Case
					When CPGLAid = '3005' and Principal < 500000 Then [InterestRate] + 3
					When CPGLAid = '3005' and Principal between 500000 and 999999 Then [InterestRate] + 4
					When CPGLAid = '3005' and Principal >= 1000000 Then [InterestRate] + 5
					When CPGLAid = '3006' Then 15
					Else [InterestRate]
				End)/100 * (Case
						--When CPGLAid = '3006' Then 365
						When CPGLAid = '3008' Then 365
						Else [Tenure]
					End)/(Select  [dbo].[IWfn_GetDaysInYear](@Dt)))InterestAmount
	  ,C.AccountOfficer
	  ,DATEDIFF(dd, @Dt, MaturityDate) as 'Days till Maturity'
	  ,(([Principal] * (Case
					When CPGLAid = '3005' and Principal < 500000 Then [InterestRate] + 3
					When CPGLAid = '3005' and Principal between 500000 and 999999 Then [InterestRate] + 4
					When CPGLAid = '3005' and Principal >= 1000000 Then [InterestRate] + 5
					When CPGLAid = '3006' Then 15
					Else [InterestRate]
				End)/100 * (Case
						--When CPGLAid = '3006' Then 365
						When CPGLAid = '3008' Then 365
						Else [Tenure]
					End)/(Select  [dbo].[IWfn_GetDaysInYear](@Dt))) / (Case
						--When CPGLAid = '3006' Then 365
						When CPGLAid = '3008' Then 365
						Else [Tenure]
					End)) as 'Daily cost of fund'
      --,[WeightedCost]
	  , CPGLAid
      ,[InstrumentType]
  FROM [IWGI].[dbo].[OP_IFund_Trans] I
	inner join IWVW_Cust_Customers C
		on C.Custaid = I.CustID
  WHERE Liquidated = 0 and FirstRec = 1 --and CPGLAid = '3008'
  order by Trans#

  --Select distinct CPGLAid
  --FROM [IWGI].[dbo].[OP_IFund_Trans]
  --order by CPGLAid
  