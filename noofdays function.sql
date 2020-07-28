USE IWGI
GO
SET ANSI_NULLS, QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION DBO.IWfn_MMF_INVESTMENTDAYS
(
      --@CustAID_INP VARCHAR(10),
      @MFCode_INP StockCode_UDT,
      @Date_INP DATETIME
)
RETURNS @WACTable TABLE 
      (
      [ID] INT,
      Dt DATETIME,
	  Qty Money,
      NoofDaysCustExist INT,
	  NoofDaysofInvest INT,
	  NoofDaysCustInvest INT
      )
AS
BEGIN
	DECLARE @CustNo VARCHAR(10),
			@Fund VARCHAR(10),
			@Units MONEY,
			@CustDays INT,
			@InvestDays INT,
			@CustInvestDays INT

	DECLARE DayCursor CURSOR FOR
		Select DISTINCT @CustNo = MX.CustAID
			, @Fund = MX.FundCode
			, @Units = Sum(Case TxnType 
								When 0 Then Qty 
								else Qty * -1 
						end)
			, @CustDays = Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode))
			, @InvestDays = DATEDIFF(dd,(Case When Month(@Date_INP) <= 6 then '12/31/'+Convert(Varchar(4), YEAR(@Date_INP) - 1) else '06/30/'+Convert(Varchar(4), YEAR(@Date_INP)) end), @Date_INP)
			, @CustInvestDays = DATEDIFF(dd,
									Case
										--When Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
										When Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@Date_INP) Then (Select top 1 [Date] from OP_MFTxns2 Where CustAID = MX.CustAID)
										When Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) < 183 AND (select top 1 YEAR(Date) from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode) = YEAR(@Date_INP) Then '12/31/'+Convert(Varchar(4), YEAR(GETDATE()) - 1)
										When Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@Date_INP) <= 6 Then '12/31/'+Convert(Varchar(4), YEAR(GETDATE()) - 1)
										When Convert(Int,@Date_INP-(select top 1 Date from OP_MFTxns2 MX1 where MX1.CustAID=MX.CustAID and MX1.FundCode=MX.FundCode)) >= 183 And Month(@Date_INP) > 6 Then '06/30/'+Convert(Varchar(4), YEAR(GETDATE()))
									End
								, @Date_INP)
		From OP_MFTxns2 MX
END