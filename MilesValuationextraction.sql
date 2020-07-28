select MFCode	
	, ValuationDate
	, MktValue
	, UnitsOutstanding
	, UnitPrice
	, BidPrice
	, OfferPrice
from IWVW_MFValuation2






/****** Script for SelectTopNRows command from SSMS  ******/
SELECT [MFCode]
      ,[ValuationDate]
      ,[UnitsOutstanding]
      ,(CostOfEquities + OtherInvestments + BankBalance) [MktValue]
      ,[UnitPrice]
      ,[BidPrice]
  FROM [IWGI].[dbo].[OP_MFValuation]
  Where MFCode in ('IPSPLUS','TGF','IPS2', 'CHDTRST', 'MEDWEALTH')


  -- fund expense

  /****** Script for SelectTopNRows command from SSMS  ******/
SELECT CustAID
	 , (Select FundCode from OP_MutualFund where custaid = A.CustAID) as Fund
      ,[FeeType]
      ,[IsFeeOnMktValue]
      ,[FeeOnMktValue]
      ,[IsFeeOnProfit]
      ,[FeeOnProfit]
      ,[IsFeeOnLoss]
      ,[FeeOnLoss]
      ,[IsFeeOnMktValueProfit]
      ,[FeeOnMktValueProfit]
      ,[UserID]
      ,[TxnDate]
      ,[FeeOnMktValueFixed]
      ,[FeeOnProfitFixed]
      ,[FeeOnLossFixed]
      ,[FeeOnMktValueProfitFixed]
  FROM [IWGI].[dbo].[AM_CustFees] A
  where CustAID in (Select distinct CustAID from OP_MutualFund)
  order by CustAID
