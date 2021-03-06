--Create Procedure DBO.IOFS_StkPerformanceTrack
--	@Perf float,
--	@EnDate datetime
--WITH ENCRYPTION
--AS

	--CREATE TABLE #Stk (Stockcode varchar(10) PRIMARY KEY NOT NULL)
BEGIN
	DROP TABLE #StkTrack 
	CREATE TABLE #StkTrack (Stockcode varchar(10) PRIMARY KEY NOT NULL, 
		CurrentPx float not null, 
		LastClosingPx float not null, 
		LastClosingPx2 float null, 
		LastClosingPx3 float null,
		DtCurrentPx datetime not null, 
		DtLastClosingPx datetime not null, 
		DtLastClosingPx2 datetime  null, 
		DtLastClosingPx3 datetime null,
		CurPerf float not null,
		PrevPerf float not null,
		PrevPerf1 float not null,
		AvgVol13wks float not null)

	DECLARE @stock as varchar(10)
	DECLARE @CurrentPx as float
	DECLARE @LastClosingPx as float
	DECLARE @LastClosingPx2 as float
	DECLARE @LastClosingPx3 as float
	DECLARE @DtCurrentPx as datetime
	DECLARE @DtLastClosingPx as datetime
	DECLARE @DtLastClosingPx2 as datetime
	DECLARE @DtLastClosingPx3 as datetime
	DECLARE @AvgVol as float

	DECLARE Stk_Cursor CURSOR FOR  
	(select Stockcode from Stkb_StockMaster where AssetClass IN ('Equities', 'NASD') and InActive = 0)

	OPEN Stk_Cursor;  
	FETCH NEXT FROM Stk_Cursor INTO @stock;  
	WHILE @@FETCH_STATUS = 0  
	   BEGIN  
		  
			--SET @stock = 
			SET @CurrentPx = (select top 1 price from stkb_quotes where StockCode = @stock order by [date] desc)
			SET @LastClosingPx = (select top 1 price from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc)
			SET @LastClosingPx2 = (select top 1 price from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [Date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc) order by [date] desc)) 
			SET @LastClosingPx3 = (select top 1 price from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [Date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc) order by [date] desc))order by [date] desc)
			SET @DtCurrentPx = (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc)
			SET @DtLastClosingPx = (select top 1 [Date] from stkb_quotes where StockCode = @stock and [Date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc) order by [date] desc)
			SET @DtLastClosingPx2 =  (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [Date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc) order by [date] desc))
			SET @DtLastClosingPx3 = (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [Date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock and [date] < (select top 1 [Date] from stkb_quotes where StockCode = @stock order by [date] desc) order by [date] desc) order by [date] desc))order by [date] desc)
			SET @AvgVol = (Select Avg(A.Volume) from (select top 65 * from stkb_quotes where StockCode = @stock order by [date] desc) A)

			INSERT INTO #StkTrack (Stockcode, 
					CurrentPx, 
					LastClosingPx, 
					LastClosingPx2, 
					LastClosingPx3,
					DtCurrentPx, 
					DtLastClosingPx, 
					DtLastClosingPx2, 
					DtLastClosingPx3,
					CurPerf,
					PrevPerf ,
					PrevPerf1,
					AvgVol13wks) VALUES
				(@stock, 
				@CurrentPx, 
				@LastClosingPx, 
				@LastClosingPx2, 
				@LastClosingPx3,
				@DtCurrentPx, 
				@DtLastClosingPx, 
				@DtLastClosingPx2, 
				@DtLastClosingPx3, 
				(@CurrentPx - @LastClosingPx)/@LastClosingPx * 100, 
				(@LastClosingPx - @LastClosingPx2)/@LastClosingPx2 * 100,
				(@LastClosingPx2 - @LastClosingPx3)/@LastClosingPx3 * 100, 
				@AvgVol)
		  
		  FETCH NEXT FROM Stk_Cursor;  
	   END;  
	CLOSE Stk_Cursor;  
	DEALLOCATE Stk_Cursor;    

SELECT * FROM #StkTrack

END