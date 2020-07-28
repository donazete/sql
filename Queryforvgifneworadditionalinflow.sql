Declare @SchemeCode as int
Declare @FromDate as datetime
Declare @TillDate as datetime
Declare @Reporttype as int


Set @SchemeCode = 13
Set @FromDate = '04/16/2019'
Set @TillDate = getdate()
Set @Reporttype = 1

--Select * from [dbo].[HDR_Client]

--Select Client_Code from 
--[dbo].[Mutual_Trans]
--Where [scheme_code] = @SchemeCode and Date = (Select top 1 date from [dbo].[Mutual_Trans] Where [scheme_code] = @SchemeCode)

IF @Reporttype = 1
/* Query for fresh inflow */
	SELECT MUT.[Date]				AS [TxnDate]
						, ACC.[UCC]					AS [CustomerNumber]
						, '' as RegistrarAcctNum
						, CLH.[client_TName]		AS [ClientLastName]
						, CLH.[client_FName]		AS [ClientFirstName]
						, CLH.[client_SName]		AS [ClientMiddleName]
						
						, CASE 
							WHEN MUT.[type] = 'B'
								THEN 'Subscription'
							ELSE
								'Redemption'
						  END						AS [TxnType]
						, CLH.[Address1]			AS [Address]
						, CLH.[state]				AS [State]
						, MUT.[qty]					AS [Holding]
						, CLH.[mobile_no]			AS [MobileNo]
						, CLH.[email]				AS [Email]
						, '' AS BVN
						, BANK.[AccountNo]			AS [BankAccountNo]
						, BANK.[BankName]			AS [BankName]					
					FROM [dbo].[Mutual_Trans] MUT WITH (NOLOCK) 
						INNER JOIN [dbo].[SchemeData] SCH WITH (NOLOCK) 
							ON SCH.[mf_schcode] = MUT.[scheme_code]
						INNER JOIN [dbo].[HDR_MutualFund] FUND
							ON FUND.[MfFundCode] = SCH.[MfFundCode] 
						INNER JOIN [dbo].[HDR_Client] ACC WITH (NOLOCK) 
							ON ACC.[client_code] = MUT.[Client_Code] 
						INNER JOIN dbo.[Hdr_ClientHead] CLH
							on CLH.[Client_Code] = ACC.[Head_ClientCode]
						LEFT JOIN dbo.[dtl_ClientHeadExistingBanks] BANK
							ON CLH.[Client_Code] = BANK.[ClientCode]
					WHERE ((@SchemeCode = 0) OR (SCH.[mf_schcode] = @SchemeCode)) and MUT.type = 'B'
					AND MUT.[date] between @FromDate and @TillDate and ACC.[Client_Code] not in (Select Client_Code from [dbo].[Mutual_Trans]
									Where [scheme_code] = @SchemeCode and Date <  @FromDate) 
					ORDER BY MUT.[Date]

Else
/* Query for additional inflow */
	SELECT MUT.[Date]				AS [TxnDate]
						, ACC.[UCC]					AS [CustomerNumber]
						, '' as RegistrarAcctNum
						, CLH.[client_TName]		AS [ClientLastName]
						, CLH.[client_FName]		AS [ClientFirstName]
						, CLH.[client_SName]		AS [ClientMiddleName]
						
						, CASE 
							WHEN MUT.[type] = 'B'
								THEN 'Subscription'
							ELSE
								'Redemption'
						  END						AS [TxnType]
						, CLH.[Address1]			AS [Address]
						, CLH.[state]				AS [State]
						, MUT.[qty]					AS [Holding]
						, CLH.[mobile_no]			AS [MobileNo]
						, CLH.[email]				AS [Email]
						, '' AS BVN
						, BANK.[AccountNo]			AS [BankAccountNo]
						, BANK.[BankName]			AS [BankName]
					FROM [dbo].[Mutual_Trans] MUT WITH (NOLOCK) 
						INNER JOIN [dbo].[SchemeData] SCH WITH (NOLOCK) 
							ON SCH.[mf_schcode] = MUT.[scheme_code]
						INNER JOIN [dbo].[HDR_MutualFund] FUND
							ON FUND.[MfFundCode] = SCH.[MfFundCode] 
						INNER JOIN [dbo].[HDR_Client] ACC WITH (NOLOCK) 
							ON ACC.[client_code] = MUT.[Client_Code] 
						INNER JOIN dbo.[Hdr_ClientHead] CLH
							on CLH.[Client_Code] = ACC.[Head_ClientCode]
						LEFT JOIN dbo.[dtl_ClientHeadExistingBanks] BANK
							ON CLH.[Client_Code] = BANK.[ClientCode]
					WHERE ((@SchemeCode = 0) OR (SCH.[mf_schcode] = @SchemeCode)) and MUT.type = 'B'
					AND MUT.[date] between @FromDate and @TillDate and ACC.[Client_Code] in (Select Client_Code from [dbo].[Mutual_Trans]
									Where [scheme_code] = @SchemeCode and Date <  @FromDate) 
					ORDER BY MUT.[Date]