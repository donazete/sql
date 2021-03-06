
CREATE VIEW IOVW_CustomersAcctOfficerMIS
AS 
	Select C.Custaid
		, C.Name
		, A.AttribSetID
		, A.Value as AcctOffIDNum
		, O.Officer
		, A.Company
		--, () as MISCODE
		--, B.IDNumber
		--, B.Officer
		, B.AttribSetID as AttribSetIDB
		, B.Value as MISCODE
		, B.Company as CompanyB
	from IWVW_Cust_Customers C
		left join (Select [AttribSetID]
						  , Case AttribSetID
								When 31 Then 'IOSL'
								When 32 Then 'IOFS'
								When 33 Then 'IOFM'
								When 34 Then 'VENCAP'
								When 35 Then 'OrangeONE'
								When 36 Then 'CAPMGMT'
								else ''
							end as Company
						  ,[OwnerTableID]
						  ,[Value]
					from [dbo].[Attrib_Values]
					Where AttribSetID IN (31,32,33,34,35,36)) A 
						on C.ID# = A.OwnerTableID
			left join OP_Officers O	
				on O.IDNumber = A.Value
			left join (Select A.Value, A.AttribSetID, OwnerTableID
							, (Case A.AttribSetID
								When 17 then 'IOSL'
								When 18 then 'IOFS'
								When 19 then 'IOFM'
								When 20 then 'OrangeONE'
								When 21 then 'VENCAP'
								When 22 then 'CAPMGMT'
								else ''
							End) as Company
						from [dbo].[Attrib_Values] A
								Where AttribSetID IN (17,18,19,20,21,22) and Value != '') B
						on O.ID# = B.OwnerTableID and B.Company = A.Company
		
		
		
			
	GO


	Select * from IOVW_CustomersAcctOfficerMIS
	order by MISCODE desc


