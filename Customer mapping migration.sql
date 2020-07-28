INSERT INTO [dbo].[Fintrak_CustMapping] ([SourceCustAID], [FintrakCustAID], [SourceApp]) --VALUES
(Select CustAID
	, Case 
		When Len(CustAID) = 4 Then Convert(varchar, 100)+LTRIM(RTRIM(CustAID))
		Else Convert(varchar, 10)+LTRIM(RTRIM(CustAID))
		End
	, 'Infoware'
from IWGI.dbo.Cust_Customers
Where CustAID not like '%AGNT%')