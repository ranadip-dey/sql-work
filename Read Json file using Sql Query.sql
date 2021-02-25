--CONTENT OF JSON FILE json.txt
--=============================
--{
--	"roomId":147392
--	,"roomName":"House 3"
--	,"address":{"address1":"123 Main St","city":"Fort Mill","stateId":"US-SC","postalCode":"29715","countryId":"US"}
--	,"owners":[{"userId":144367,"firstName":"Jamie","lastName":"Conetta","transactionSideId":"buy","officeId":10972}]
--	,"officeId":10972
--	,"latitude":0.00000000
--	,"longitude":0.00000000
--	,"createdDate":"2019-04-26T20:36:24.407"
--	,"closedStatusId":""
--	,"isUnderContract":false
--	,"status":"Active"
--	,"contractAmount":275000.0000,
--	"roomImageUrl":"https://dtrstage.blob.core.windows.net/dtrdoc-pub/2019042620-rp-efcb1eb3-28bd-446b-9eaf-6ca02d7621bd"
--}

--++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

DECLARE @JSON VARCHAR(MAX)

SELECT @JSON = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\Ranadip\Desktop\for GitHub\json.txt', SINGLE_CLOB) AS j

SELECT * FROM OPENJSON (@JSON) WITH 
( roomId int
, roomName varchar(50)
, address1 varchar(100) '$.address.address1'
, city varchar(100) '$.address.city'
, stateId varchar(100) '$.address.stateId'
, postalCode varchar(100) '$.address.postalCode'
, countryId varchar(100) '$.address.countryId'
, latitude varchar(50)
, longitude varchar(50)
, createdDate varchar(50)
, closedStatusId varchar(50)
, isUnderContract varchar(50)
, status varchar(50)
, contractAmount varchar(50)
, roomImageUrl varchar(500)
, owners nvarchar(max) as json
) as rooms
CROSS APPLY OPENJSON(rooms.owners)
WITH (
  userId int 
, firstName varchar(100) 
, lastName varchar(100) 
, transactionSideId varchar(100) 
, officeId varchar(100) 
) as owners
