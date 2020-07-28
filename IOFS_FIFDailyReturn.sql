USE IWGI
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO


Create Procedure DBO.IOFS_FIFDailyReturn
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS

		Select Sum(Case TxnType
					When 0 Then Qty
					Else Qty * -1
				End) as TotalUnits
				, (SELECT TOP 1 [IntRate] FROM [dbo].[IOFS_FIFundRates] Where EffectiveDate <= @EnDate and FundCode = @MFCode Order by EffectiveDate desc, ID# desc) as IntRate
				, Sum(Case TxnType
					When 0 Then Qty
					Else Qty * -1
				End) * (SELECT TOP 1 [IntRate]/100 FROM [dbo].[IOFS_FIFundRates] Where EffectiveDate <= @EnDate and FundCode = @MFCode Order by EffectiveDate desc, ID# desc) / (select [dbo].[IWfn_GetDaysInYear](@EnDate)) as DailyReturn
		From [dbo].[OP_MFTxns2] MF
		Where Date <= @EnDate and FundCode = @MFCode


GO