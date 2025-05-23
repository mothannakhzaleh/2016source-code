USE AccountServeNew
GO

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[QueryAccount]
@_CHA_NAME VARCHAR(50) 
AS 
SET NOCOUNT ON
SELECT id, password, sid, login_status, login_group, ban, datediff(s, enable_login_time, GETDATE()) AS protect_time FROM account_login
where name = @_CHA_NAME
GO

CREATE PROCEDURE [dbo].[AccountLogin]
@_LOGIN_STATUS INT, @_LOGIN_GROUP VARCHAR(50), @_LAST_LOGIN_MAC VARCHAR(50), @_LAST_LOGIN_IP VARCHAR(50), @_ID INT
AS
SET NOCOUNT ON
UPDATE account_login 
SET login_status = @_LOGIN_STATUS, login_group = @_LOGIN_GROUP, enable_login_time=GETDATE(), last_login_mac = @_LAST_LOGIN_MAC
WHERE id = @_ID
GO

CREATE PROCEDURE [dbo].[AccountLogout]
@_LOGIN_STATUS INT, @_ID INT
AS
SET NOCOUNT ON
UPDATE account_login
SET login_status = @_LOGIN_STATUS, login_group = '', enable_login_time=GETDATE(), last_logout_time=GETDATE(), 
	total_live_time=total_live_time+DATEDIFF(SECOND, last_login_time, GETDATE()) 
WHERE id = @_ID
GO

CREATE PROCEDURE [dbo].[UserLogin]
@_USER_ID INT, @_USERNAME VARCHAR(50),
@_USER_IP VARCHAR(20)
AS
SET NOCOUNT ON
INSERT into user_log (user_id, user_name, login_time, login_ip) values (@_USER_ID, @_USERNAME, GETDATE(), @_USER_IP)
GO

CREATE PROCEDURE [dbo].[UserLogout]
@_USER_ID INT
AS
SET NOCOUNT ON
update user_log set logout_time = GETDATE() where log_id = (select max(log_id) from user_log 
where user_id = @_USER_ID)
GO

CREATE PROCEDURE [dbo].[OperAccountBan]
@_BAN INT, @_USERNAME VARCHAR(50)
AS
SET NOCOUNT ON
update account_login set ban=@_BAN
where name=@_USERNAME
GO