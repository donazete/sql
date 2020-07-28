USE IWGI
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

Create Procedure DBO.IOFS_FIFCheckValRec
	@MFCode varchar(10),
	@EnDate datetime
WITH ENCRYPTION
AS
	Select Count(*) as Cnt from [dbo].[IOFS_FIFundDailyReturns]
	Where ValDate = @EnDate and FundCode = @MFCode
GO
