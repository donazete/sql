
Begin tran

DECLARE WACCursor CURSOR FOR
	Select MasterAcct, Sub
	From IOCMSplit Where Sub != ''

Declare @MasterAcct as varchar(10)
Declare @Sub as varchar(10)

OPEN WACCursor
FETCH NEXT FROM WACCursor INTO 
                  @MasterAcct,
                  @Sub


WHILE @@FETCH_STATUS = 0
      BEGIN
		Update Acct_Gl
		Set BranchCode = '007'
		Where AccountID = @MasterAcct and Sub = @Sub

		FETCH NEXT FROM WACCursor INTO
		@MasterAcct,
        @Sub

	  END

	  
		--Update Acct_Subs
		--Set BranchCode = '007'
		--Where AccountID in (Select MasterAcct From IOCMSplit Where Sub = '')

CLOSE WACCursor
DEALLOCATE WACCursor
RETURN


Update Acct_GL
		Set BranchCode = '007'
		Where AccountID in (Select MasterAcct From IOCMSplit Where Sub = '')


commit
rollback


	--select * from Acct_Subs
	--Where BranchCode = '007'

	--Select * from Cust_Involvements
	--Where Type in ('FICAPMGT', 'MYPASSCAP', 'HYINCAPMGT', 'REALESTCAP', 'MDTERM')


	--Update Cust_Involvements
	--Set BranchCode = '007'
	--Where Type in ('FICAPMGT', 'MYPASSCAP', 'HYINCAPMGT', 'REALESTCAP', 'MDTERM')



	SELECT [ID#]
      ,[MasterAcct]
      ,[Sub]
      ,[MasterSub]
      ,[AcctDesc]
	  , A.Amt
  FROM [IWGI].[dbo].[IOCMSplit] C
  inner join (Select AccountID, Sub as Subacc, AccountID+Sub as comb, SUM(Amount) Amt
		  from Acct_GL
		  Where BranchCode = '007' --and EffectiveDate <= '12/31/2017'
		  Group by AccountID, Sub) A
	on C.MasterSub = A.comb
  Where Sub != ''

  
  Union all



  SELECT [ID#]
      ,[MasterAcct]
      ,[Sub]
      ,[MasterSub]
      ,[AcctDesc]
	  , A.Amt
  FROM [IWGI].[dbo].[IOCMSplit] C
	inner join (Select AccountID, SUM(Amount) Amt
		  from Acct_GL
		  Where BranchCode = '007' --and EffectiveDate <= '12/31/2017'
		  Group by AccountID) A
	on C.MasterSub = A.AccountID
  Where Sub = ''
  order by MasterAcct, Sub

  Select * from Acct_GL
  Where BranchCode = '007' and TxnDate between '03/19/2018' and '03/20/2018'
  order by TxnDate desc

  
  Select SUM(Amount) from Acct_GL
  Where BranchCode = '007'

  
  Select SysRef, SUM(Amount) from Acct_GL
  Where BranchCode = '007'
  Group by SysRef
  Having SUM(Amount) != 0
  order by ABS(SUM(Amount)), Sysref

  Select Distinct AccountID, Sub
  from Acct_GL
  Where BranchCode = '007'


  3101		3101
3108		3108
5017	001	5017001
7000	003	700000