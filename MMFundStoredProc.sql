USE IWGI
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

Create Procedure DBO.IOFS_MMFCheckValRec
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS
	Select Count(*) as Cnt from [dbo].[IOFS_MMFundDailyReturns]
	Where ValDate = @EnDate and FundCode = @MFCode
GO

Create Procedure DBO.IOFS_MMFUpdateValRec
	@MFCode varchar(10),
	@EnDate datetime,
	@Income money,
	@Expense money,
	@DailyRet money,
	@TotalUnits float,
	@RetperUnit float
WITH ENCRYPTION
AS
	INSERT INTO [dbo].[IOFS_MMFundDailyReturns] ([FundCode]
      ,[ValDate]
      ,[Income]
      ,[Expense]
      ,[DailyReturn]
      ,[TotalUnits]
      ,[Returnperunit]) VALUES
	  (@MFCode,
		@EnDate,
		@Income,
		@Expense,
		@DailyRet,
		@TotalUnits,
		@RetperUnit)
GO


Create Procedure DBO.IOFS_MMFDailyReturn
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS

		Select Sum(Amount) as [Return]
			, (Select Sum(Amount)
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate = @EnDate and MF.AcctType IN ('I100')
				Group by MF.MFCode) as Income
			, (Select Sum(Amount) as Amount
				From Acct_GL G
					inner join OP_MFAccts MF
						on G.AccountID = MF.AID and G.Sub = MF.Sub
				Where MF.MFCode = @MFCode and G.EffectiveDate = @EnDate and MF.AcctType IN ('E100')
				Group by MF.MFCode) as Expense
			, (Select --(@EnDate - 1) as Dt,
					Sum(Case txnType
							When 0 Then Qty
							Else Qty * -1
						End) as TotalUnits
				From [dbo].[OP_MFTxns2]
				Where Date <= @EnDate - 1 and FundCode = @MFCode) as TotalUnits
		From Acct_GL G
			inner join OP_MFAccts MF
				on G.AccountID = MF.AID and G.Sub = MF.Sub
		Where MF.MFCode = @MFCode and G.EffectiveDate = @EnDate and MF.AcctType IN ('I100','E100')
		Group by MF.MFCode

GO


Create Procedure DBO.IOFS_MMFUnitsSubscribed
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS
	Select --(@EnDate - 1) as Dt,
		Sum(Case txnType
				When 0 Then Qty
				Else Qty * -1
			End) as TotalUnits
	From [dbo].[OP_MFTxns2]
	Where Date <= @EnDate - 1 and FundCode = @MFCode
GO


Create Procedure DBO.IOFS_MMFCustUnitHolding
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS

		Select (@EnDate - 1) as Dt,
			CustAID,
			Fundcode,
			Sum(Case txnType
					When 0 Then Qty
					Else Qty * -1
				End) as TotalUnits
		From [dbo].[OP_MFTxns2]
		Where Date <= @EnDate - 1 and FundCode = @MFCode
		Group by CustAID, Fundcode
GO


Create Procedure DBO.IOFS_MMFAllotReturn
	@MFCode varchar(10),
	@EnDate datetime,
	@CustAID varchar(10),
	@Units float,
	@RetPerUnit float,
	@DailyReturn float
WITH ENCRYPTION
AS
		INSERT INTO [dbo].[IOFS_MMFundReturnsAllot] ([FundCode]
		  ,[AllotDate]
		  ,[CustAID]
		  ,[UnitHolding]
		  ,[FundReturnPerUnit]
		  ,[DailyReturn]) VALUES
		  (@MFCode,
			@EnDate,
			@CustAID,
			@Units,
			@RetPerUnit,
			@DailyReturn)
GO