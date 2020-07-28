-- Sproc for getting the referral code of an agent and the customer who reffered that agent
Create Procedure DBO.IOFS_GetCustReferrer_Referral
	@CustAID varchar(10)
WITH ENCRYPTION
AS
	--Declare @CustAID as varchar(10)
	--Set @CustAID =  '8912'
	Declare @Owner as int
	Set @Owner = (Select ID# from Cust_Customers where CustAID = @Custaid)

	select Value as AgentRefferalCode
		, (select Value from [dbo].[Attrib_Values] Where AttribSetID = 58 and OwnerTableID = @Owner) as Refferer
	from [dbo].[Attrib_Values]
	Where AttribSetID = 57 and OwnerTableID = @Owner
GO



-- Sproc for setting the referrer a new customer
Create Procedure DBO.IOFS_SetCustReferrer
	@CustAID varchar(10),
	@Value varchar(255),
	@User varchar(15)
WITH ENCRYPTION
AS
	Declare @Owner as int
	Set @Owner = (Select ID# from Cust_Customers where CustAID = @Custaid)
	INSERT INTO [dbo].[Attrib_Values]
           ([AttribSetID]
           ,[OwnerTableID]
           ,[Value]
           ,[UserID]
           ,[TxnDate])
     VALUES
           (58
           ,@Owner
           ,@Value
           ,@User
           ,GETDATE())
GO


-- Sproc for setting the referral code of a new agent
Create Procedure DBO.IOFS_SetCustReferralCode
	@CustAID varchar(10),
	@Value varchar(255),
	@User varchar(15)
WITH ENCRYPTION
AS
	Declare @Owner as int
	Set @Owner = (Select ID# from Cust_Customers where CustAID = @Custaid)
	INSERT INTO [dbo].[Attrib_Values]
           ([AttribSetID]
           ,[OwnerTableID]
           ,[Value]
           ,[UserID]
           ,[TxnDate])
     VALUES
           (57
           ,@Owner
           ,@Value
           ,@User
           ,GETDATE())
GO


-- Sproc for updating the referral code of a new agent
Create Procedure DBO.IOFS_UpdateCustReferralCode
	@CustAID varchar(10),
	@Value varchar(255),
	@User varchar(15)
WITH ENCRYPTION
AS
	Declare @Owner as int
	Set @Owner = (Select ID# from Cust_Customers where CustAID = @Custaid)

	UPDATE [dbo].[Attrib_Values]
	   SET [Value] = @Value
		  ,[UserID] = @User
		  ,[TxnDate] = GetDate()
	 WHERE [AttribSetID] = 57 and [OwnerTableID] = @Owner
GO


-- Sproc for updating the referer of a new customer
Create Procedure DBO.IOFS_UpdateCustReferrer
	@CustAID varchar(10),
	@Value varchar(255),
	@User varchar(15)
WITH ENCRYPTION
AS
	Declare @Owner as int
	Set @Owner = (Select ID# from Cust_Customers where CustAID = @Custaid)

	UPDATE [dbo].[Attrib_Values]
	   SET [Value] = @Value
		  ,[UserID] = @User
		  ,[TxnDate] = GetDate()
	 WHERE [AttribSetID] = 58 and [OwnerTableID] = @Owner
GO