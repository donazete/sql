SELECT Q.StockCode
	, Price
	, Q.StockCode as symbol
	, 'NSE'
	, [Date]
	, Trades
	, Volume
	, Value
	, [Open]
	, Low
	, High
	, WeekLow52
	, WeekHigh52
FROM Stkb_Quotes Q
	inner join Stkb_StockMaster S
		on S.StockCode = Q.StockCode
WHERE Date BETWEEN '01/02/2013' AND '09/24/2017' AND Q.StockCode NOT IN (SELECT FundCode FROM OP_MutualFund) and (S.AssetClass != 'Bonds' or S.Sector != 'Bonds') and Price > 0
order by [Date], Q.StockCode

--select * from Stkb_StockMaster