

  select S.AccountID, S.AccountName, FSCaptionCode, F.Caption, F.FinType, F.FinSubType, C.coyID
from ts_Finance_ChartOfAccount S
	left join [FinancialReport].[ifrs_registry] F
		on S.FSCaptionCode = F.Code
	left join ts_Finance_ChartOfAccountCode C
		on S.AccountID = C.AccountID
order by Accountid