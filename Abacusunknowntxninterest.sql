Create Procedure DBO.IOFS_UnknownTxnInterestTransfer
	@SuspenseCustAID varchar(10),
	@CustAID varchar(10),
	@MFCode varchar(10),
	@Amt money,
	@EnDate datetime
WITH ENCRYPTION
AS

Begin tran
	-- Allot type 3 for interest reallocation for unknown transactions
	-- Deduction from interest accrued on suspense account
	INSERT INTO [IWGI].[dbo].[IOFS_MMFundReturnsAllot] ([FundCode]
      ,[AllotDate]
      ,[CustAID]
      ,[UnitHolding]
      ,[FundReturnPerUnit]
      ,[DailyReturn]
      ,[Txndate]
      ,[AllotType]) VALUES 
	  (@MFCode, @EnDate, @SuspenseCustAID, (select Sum(Case
							When TxnType = 0 Then Qty
							Else Qty * - 1
						End) as Qty
				  from OP_MFTxns2
				  Where FundCode = @MFCode and CustAID = @SuspenseCustAID and [Date] <= @EnDate), 0, @Amt  * -1, Getdate(), 3)

	-- Addition of interest accrued on suspense account to actual customer
	INSERT INTO [IWGI].[dbo].[IOFS_MMFundReturnsAllot] ([FundCode]
      ,[AllotDate]
      ,[CustAID]
      ,[UnitHolding]
      ,[FundReturnPerUnit]
      ,[DailyReturn]
      ,[Txndate]
      ,[AllotType]) VALUES 
	  (@MFCode, @EnDate, @CustAID, (select Sum(Case
							When TxnType = 0 Then Qty
							Else Qty * - 1
						End) as Qty
				  from OP_MFTxns2
				  Where FundCode = @MFCode and CustAID = @CustAID and [Date] <= @EnDate), 0, @Amt, Getdate(), 3)


commit