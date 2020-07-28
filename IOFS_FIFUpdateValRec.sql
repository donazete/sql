USE IWGI
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO

Create Procedure DBO.IOFS_FIFUpdateValRec
	@MFCode varchar(10),
	@EnDate datetime,
	@DailyRet money,
	@TotalUnits float,
	@AccRate float
WITH ENCRYPTION
AS
	INSERT INTO [dbo].[IOFS_FIFundDailyReturns] ([FundCode]
      ,[ValDate]
      ,[DailyReturn]
      ,[TotalUnits]
      ,[AccrualRate]) VALUES
	  (@MFCode,
		@EnDate,
		@DailyRet,
		@TotalUnits,
		@AccRate)
GO