Select * from IWVW_Stkb_Purchases
Where CustAID = '10334' and StockCode = 'ETI' and Qty = 350 and DateAlloted = '11/04/2016'

Select * from IWVW_Stkb_Purchases
Where CustAID = '10334' and StockCode = 'ETI' and DateAlloted = '11/04/2016'

Select * from Stkb_JobbingBookTxn
Where CustNo = '10334' and StockCode = 'ETI' and EffectiveDate = '11/04/2016'

Select * from Stkb_JobbingBookTxn
Where CustNo = '10334' and StockCode = 'ETI' and Units = 350 --and EffectiveDate = '11/04/2016'



Select * from Stkb_JobbingBookTxn
Where CustNo = '11881' and StockCode = 'Guaranty' and EffectiveDate = '11/07/2016'

Select * from Stkb_JobbingBookTxn 
Where CustNo = '10334' and StockCode = 'ETI' 
order by ID#

Select * from IWVW_Stkb_Purchases
Where CustAID = '10334' and StockCode = 'ETI'
order by ID#