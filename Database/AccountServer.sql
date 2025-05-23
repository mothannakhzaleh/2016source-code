USE [master]
GO
/****** Object:  Database [AccountServeNew]    Script Date: 1/23/2024 2:16:47 PM ******/
CREATE DATABASE [AccountServeNew]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'AccountServeNew', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AccountServeNew.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'AccountServeNew_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\AccountServeNew_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [AccountServeNew] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [AccountServeNew].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [AccountServeNew] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [AccountServeNew] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [AccountServeNew] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [AccountServeNew] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [AccountServeNew] SET ARITHABORT OFF 
GO
ALTER DATABASE [AccountServeNew] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [AccountServeNew] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [AccountServeNew] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [AccountServeNew] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [AccountServeNew] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [AccountServeNew] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [AccountServeNew] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [AccountServeNew] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [AccountServeNew] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [AccountServeNew] SET  ENABLE_BROKER 
GO
ALTER DATABASE [AccountServeNew] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [AccountServeNew] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [AccountServeNew] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [AccountServeNew] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [AccountServeNew] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [AccountServeNew] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [AccountServeNew] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [AccountServeNew] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [AccountServeNew] SET  MULTI_USER 
GO
ALTER DATABASE [AccountServeNew] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [AccountServeNew] SET DB_CHAINING OFF 
GO
ALTER DATABASE [AccountServeNew] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [AccountServeNew] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [AccountServeNew] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [AccountServeNew] SET QUERY_STORE = OFF
GO
USE [AccountServeNew]
GO
/****** Object:  User [mothannakh]    Script Date: 1/23/2024 2:16:47 PM ******/
CREATE USER [mothannakh] FOR LOGIN [mothannakh] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [mothannakh]
GO
/****** Object:  Table [dbo].[account_charge]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_charge](
	[id] [int] NOT NULL,
	[charge_flag] [int] NULL,
	[charge_begin_tick] [int] NULL,
	[charge_end_tick] [int] NULL,
	[saves] [int] NULL,
 CONSTRAINT [PK_account_charge] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[account_login]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_login](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NULL,
	[password] [varchar](250) NULL,
	[originalPassword] [varchar](50) NULL,
	[sid] [int] NOT NULL,
	[login_status] [int] NULL,
	[enable_login_tick] [bigint] NULL,
	[login_group] [varchar](50) NULL,
	[last_login_time] [datetime] NULL,
	[last_logout_time] [datetime] NULL,
	[last_login_ip] [varchar](50) NULL,
	[enable_login_time] [datetime] NULL,
	[total_live_time] [bigint] NOT NULL,
	[last_login_mac] [varchar](50) NULL,
	[ban] [int] NULL,
	[q1] [varchar](50) NULL,
	[a1] [varchar](50) NULL,
	[QQ] [varchar](50) NULL,
	[tname] [varchar](50) NULL,
	[card] [varchar](18) NULL,
	[tel] [varchar](50) NULL,
	[anquan] [varchar](50) NULL,
	[email] [varchar](50) NULL,
 CONSTRAINT [PK_account_login] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_account_login] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_account_login_name] UNIQUE NONCLUSTERED 
(
	[name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[account_pending]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account_pending](
	[acc_id] [int] IDENTITY(1,1) NOT NULL,
	[name] [varchar](50) NOT NULL,
	[password] [varchar](250) NOT NULL,
	[squestion] [varchar](100) NOT NULL,
	[answer] [varchar](100) NOT NULL,
	[email] [varchar](100) NOT NULL,
	[gender] [int] NOT NULL,
	[credit] [int] NULL,
	[truename] [varchar](100) NOT NULL,
	[birthday] [datetime] NOT NULL,
	[contact] [varchar](50) NOT NULL,
	[country] [varchar](50) NOT NULL,
	[ipaddr] [varchar](50) NOT NULL,
	[ip2country] [varchar](50) NOT NULL,
	[actcode] [varchar](50) NULL,
	[invtcode] [varchar](50) NULL,
	[create_time] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[act_album]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[act_album](
	[act_id] [int] IDENTITY(1,1) NOT NULL,
	[act_name] [varchar](50) NULL,
	[SessionKey] [varchar](50) NULL,
	[create_time] [datetime] NULL,
	[update_time] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GameDBServerList]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GameDBServerList](
	[server_section] [int] NOT NULL,
	[server_ip] [nvarchar](128) NOT NULL,
	[server_uid] [nvarchar](128) NOT NULL,
	[server_pwd] [nvarchar](128) NOT NULL,
	[server_db] [nvarchar](128) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[LogRandomAccount]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[LogRandomAccount](
	[accountName] [varchar](50) NOT NULL,
	[addDate] [datetime] NULL,
	[expireDate] [datetime] NULL,
	[ip] [varchar](15) NULL,
	[plainPassword] [varchar](32) NULL,
 CONSTRAINT [PK_LogRandomAccount] PRIMARY KEY CLUSTERED 
(
	[accountName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[safety]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[safety](
	[aid] [bigint] IDENTITY(1,1) NOT NULL,
	[allowIP] [varchar](32) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TradeRecord]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TradeRecord](
	[record_id] [nvarchar](50) NOT NULL,
	[record_message] [int] NOT NULL,
	[record_section] [int] NOT NULL,
	[record_info] [nvarchar](4000) NOT NULL,
	[record_time] [datetime] NOT NULL,
	[ret_info] [nvarchar](4000) NOT NULL,
	[ret_time] [datetime] NOT NULL,
	[state] [int] NOT NULL,
	[flow_id] [nvarchar](50) NULL,
	[production_id] [nvarchar](50) NULL,
 CONSTRAINT [IX_TradeRecord] UNIQUE NONCLUSTERED 
(
	[record_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[user_log]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_log](
	[log_id] [int] IDENTITY(1,1) NOT NULL,
	[user_id] [int] NOT NULL,
	[user_name] [varchar](50) NOT NULL,
	[login_time] [datetime] NULL,
	[logout_time] [datetime] NULL,
	[login_ip] [varchar](20) NULL,
 CONSTRAINT [PK_user_log] PRIMARY KEY CLUSTERED 
(
	[log_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserAccountLogin]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserAccountLogin](
	[Date] [datetime] NULL,
	[AllAccount] [int] NULL,
	[ActionAccount] [int] NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_sid]  DEFAULT ((0)) FOR [sid]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_login_status]  DEFAULT ((0)) FOR [login_status]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_enable_login_tick]  DEFAULT ((0)) FOR [enable_login_tick]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_last_login_time]  DEFAULT (getdate()) FOR [last_login_time]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_last_logout_time]  DEFAULT (getdate()) FOR [last_logout_time]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_enable_login_time]  DEFAULT ('2001-1-1 1:1:1') FOR [enable_login_time]
GO
ALTER TABLE [dbo].[account_login] ADD  CONSTRAINT [DF_account_login_total_live_time]  DEFAULT ((0)) FOR [total_live_time]
GO
ALTER TABLE [dbo].[act_album] ADD  DEFAULT (getdate()) FOR [create_time]
GO
ALTER TABLE [dbo].[act_album] ADD  DEFAULT (getdate()) FOR [update_time]
GO
/****** Object:  StoredProcedure [dbo].[AccountLogin]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AccountLogin]
@_LOGIN_STATUS INT, @_LOGIN_GROUP VARCHAR(50), @_LAST_LOGIN_MAC VARCHAR(50), @_LAST_LOGIN_IP VARCHAR(50), @_ID INT
AS
SET NOCOUNT ON
UPDATE account_login 
SET login_status = @_LOGIN_STATUS, login_group = @_LOGIN_GROUP, enable_login_time=GETDATE(), last_login_mac = @_LAST_LOGIN_MAC
WHERE id = @_ID

GO
/****** Object:  StoredProcedure [dbo].[AccountLogout]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
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
/****** Object:  StoredProcedure [dbo].[OperAccountBan]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OperAccountBan]
@_BAN INT, @_USERNAME VARCHAR(50)
AS
SET NOCOUNT ON
update account_login set ban=@_BAN
where name=@_USERNAME

GO
/****** Object:  StoredProcedure [dbo].[QueryAccount]    Script Date: 1/23/2024 2:16:47 PM ******/
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
/****** Object:  StoredProcedure [dbo].[UserLogin]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UserLogin]
@_USER_ID INT, @_USERNAME VARCHAR(50),
@_USER_IP VARCHAR(20)
AS
SET NOCOUNT ON
INSERT into user_log (user_id, user_name, login_time, login_ip) values (@_USER_ID, @_USERNAME, GETDATE(), @_USER_IP)

GO
/****** Object:  StoredProcedure [dbo].[UserLogout]    Script Date: 1/23/2024 2:16:47 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UserLogout]
@_USER_ID INT
AS
SET NOCOUNT ON
update user_log set logout_time = GETDATE() where log_id = (select max(log_id) from user_log 
where user_id = @_USER_ID)

GO
USE [master]
GO
ALTER DATABASE [AccountServeNew] SET  READ_WRITE 
GO
