/****** Script for SelectTopNRows command from SSMS  ******/
SELECT I.ID#
      ,I.Trans#
      ,I.CustID
	  , C.Name
      ,I.Principal
      ,I.InterestRate
      ,I.EffectiveDate
	  /*, Case 
			When I.EffectiveDate < '08/01/2016' Then '07/31/2016'
			Else I.EffectiveDate
		End as EffCompDate */
      ,I.Tenure
      ,I.MaturityDate
      ,I.CPGLAid
      ,I.CPGLSub
      ,I.SuspenseAID
      ,I.SuspenseSub
      ,I.Liquidated
      ,I.PnLAID
      ,I.PnLSub
      ,I.InterestRecAID
      ,I.InterestRecSub
      ,I.InstrumentType
  FROM [IWGI].[dbo].[OP_IFund_Trans] I
	inner join Cust_Customers C
		on C.Custaid = I.CustID
Where (I.EffectiveDate < '08/31/2016' and I.MaturityDate > '08/31/2016')
	--and I.CPGLAid = '3001'
order by I.CPGLAid, Trans#, ID#





/****** Script for SelectTopNRows command from SSMS  ******/
SELECT I.ID#
      ,I.Trans#
      ,I.CustID
	  , C.Name
      ,I.Principal
      ,I.InterestRate
      ,I.EffectiveDate
	  /*, Case 
			When I.EffectiveDate < '08/01/2016' Then '07/31/2016'
			Else I.EffectiveDate
		End as EffCompDate */
      ,I.Tenure
      ,I.MaturityDate
      ,I.CPGLAid
      ,I.CPGLSub
      ,I.SuspenseAID
      ,I.SuspenseSub
      ,I.Liquidated
      ,I.PnLAID
      ,I.PnLSub
      ,I.InterestRecAID
      ,I.InterestRecSub
      ,I.InstrumentType
  FROM [IWGI].[dbo].[OP_IFund_Trans] I
	inner join Cust_Customers C
		on C.Custaid = I.CustID
Where (I.EffectiveDate < '08/01/2016' and I.MaturityDate >= '08/01/2016' and I.MaturityDate <= '08/31/2016')
	--and I.CPGLAid = '3001'
order by I.CPGLAid, Trans#, ID#