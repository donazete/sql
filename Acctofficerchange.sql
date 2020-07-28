select * from IWVW_Cust_Customers
Where AccountOfficer_ID = '195'

select * from IWVW_Cust_Customers
Where AccountOfficer_ID = '304'


select * from OP_Officers
Where Officer like '%oyewo%'

Begin tran

Update Cust_Customers
Set AccountOfficer_ID = '304'
Where AccountOfficer_ID = '195'

commit
