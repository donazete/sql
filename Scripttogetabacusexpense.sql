Declare @MFCode as varchar(10)
Declare @StDate as datetime
Declare @EnDate as datetime



set @StDate = '12/19/2016'
set @EnDate = '03/26/2017'
set @MFCode = 'ABACUS'

--drop table #date

create table #date ([date] datetime)

create table #val ([date] datetime, expense money, units float)

WHILE @StDate <= @EnDate
BEGIN
	INSERT INTO #date
	SELECT @StDate

	set @StDate = DATEADD(dd, 1, @StDate)
END

Declare daycursor cursor for
SELECT * from #date

OPEN daycursor   
FETCH NEXT FROM daycursor INTO @StDate   

WHILE @@FETCH_STATUS = 0   
BEGIN   
       INSERT INTO #val
	   SELECT @StDate
		, (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate = @StDate and MF.AcctType IN ('E100')
				Group by MF.MFCode) as Expense
		, Sum(Case TxnType
				When 0 Then Qty
				Else Qty * -1
			End) as TotalUnits
		FROM OP_MFTxns2
		WHERE FundCode = @MFCode and Date <= @StDate

       FETCH NEXT FROM daycursor INTO @StDate     
END   

CLOSE daycursor  
DEALLOCATE daycursor
SELECt * from #val