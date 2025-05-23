USE [master]
GO
/****** Object:  Database [gamedbNew]    Script Date: 1/23/2024 2:18:02 PM ******/
CREATE DATABASE [gamedbNew]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'gamedbNew', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\gamedbNew.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'gamedbNew_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\gamedbNew_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [gamedbNew] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [gamedbNew].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [gamedbNew] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [gamedbNew] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [gamedbNew] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [gamedbNew] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [gamedbNew] SET ARITHABORT OFF 
GO
ALTER DATABASE [gamedbNew] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [gamedbNew] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [gamedbNew] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [gamedbNew] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [gamedbNew] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [gamedbNew] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [gamedbNew] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [gamedbNew] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [gamedbNew] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [gamedbNew] SET  ENABLE_BROKER 
GO
ALTER DATABASE [gamedbNew] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [gamedbNew] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [gamedbNew] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [gamedbNew] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [gamedbNew] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [gamedbNew] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [gamedbNew] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [gamedbNew] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [gamedbNew] SET  MULTI_USER 
GO
ALTER DATABASE [gamedbNew] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [gamedbNew] SET DB_CHAINING OFF 
GO
ALTER DATABASE [gamedbNew] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [gamedbNew] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [gamedbNew] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [gamedbNew] SET QUERY_STORE = OFF
GO
USE [gamedbNew]
GO
/****** Object:  User [mothannakh]    Script Date: 1/23/2024 2:18:02 PM ******/
CREATE USER [mothannakh] FOR LOGIN [mothannakh] WITH DEFAULT_SCHEMA=[dbo]
GO
ALTER ROLE [db_owner] ADD MEMBER [mothannakh]
GO
/****** Object:  Table [dbo].[account]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[account](
	[act_id] [int] NOT NULL,
	[act_name] [varchar](50) NOT NULL,
	[gm] [tinyint] NOT NULL,
	[cha_ids] [varchar](80) NOT NULL,
	[last_ip] [varchar](16) NOT NULL,
	[disc_reason] [varchar](128) NOT NULL,
	[last_leave] [datetime] NOT NULL,
	[password] [varchar](50) NULL,
	[merge_state] [int] NOT NULL,
 CONSTRAINT [PK_account] PRIMARY KEY CLUSTERED 
(
	[act_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[birth_tab]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[birth_tab](
	[birth_name] [varchar](50) NOT NULL,
 CONSTRAINT [PK_birth_tab] PRIMARY KEY CLUSTERED 
(
	[birth_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[boat]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[boat](
	[boat_id] [int] IDENTITY(1,1) NOT NULL,
	[boat_berth] [smallint] NOT NULL,
	[boat_name] [char](17) NOT NULL,
	[boat_boatid] [int] NOT NULL,
	[boat_header] [int] NOT NULL,
	[boat_body] [int] NOT NULL,
	[boat_engine] [int] NOT NULL,
	[boat_cannon] [int] NOT NULL,
	[boat_equipment] [int] NOT NULL,
	[boat_bagsize] [smallint] NOT NULL,
	[boat_bag] [char](7000) NOT NULL,
	[boat_diecount] [smallint] NOT NULL,
	[boat_isdead] [char](1) NOT NULL,
	[cur_endure] [int] NOT NULL,
	[mx_endure] [int] NOT NULL,
	[cur_supply] [int] NOT NULL,
	[mx_supply] [int] NOT NULL,
	[skill_state] [char](400) NOT NULL,
	[boat_ownerid] [int] NOT NULL,
	[boat_createtime] [char](50) NOT NULL,
	[boat_isdeleted] [char](1) NOT NULL,
	[map] [char](50) NOT NULL,
	[map_x] [int] NOT NULL,
	[map_y] [int] NOT NULL,
	[angle] [int] NOT NULL,
	[degree] [smallint] NOT NULL,
	[exp] [int] NOT NULL,
	[version] [smallint] NOT NULL,
 CONSTRAINT [PK_boat] PRIMARY KEY CLUSTERED 
(
	[boat_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ChaGD]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ChaGD](
	[Date] [datetime] NULL,
	[AllGd] [bigint] NULL,
	[Name] [varchar](32) NULL,
	[ChaGd] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[character](
	[cha_id] [int] IDENTITY(1,1) NOT NULL,
	[cha_name] [varchar](50) NOT NULL,
	[motto] [varchar](50) NOT NULL,
	[icon] [smallint] NOT NULL,
	[version] [smallint] NOT NULL,
	[pk_ctrl] [tinyint] NOT NULL,
	[mem_addr] [bigint] NOT NULL,
	[act_id] [int] NOT NULL,
	[guild_id] [int] NOT NULL,
	[guild_stat] [tinyint] NOT NULL,
	[guild_permission] [smallint] NOT NULL,
	[job] [varchar](50) NOT NULL,
	[degree] [smallint] NOT NULL,
	[exp] [bigint] NOT NULL,
	[hp] [int] NOT NULL,
	[sp] [int] NOT NULL,
	[ap] [int] NOT NULL,
	[tp] [int] NOT NULL,
	[gd] [int] NOT NULL,
	[str] [int] NOT NULL,
	[dex] [int] NOT NULL,
	[agi] [int] NOT NULL,
	[con] [int] NOT NULL,
	[sta] [int] NOT NULL,
	[luk] [int] NOT NULL,
	[sail_lv] [int] NOT NULL,
	[sail_exp] [int] NOT NULL,
	[sail_left_exp] [int] NOT NULL,
	[live_lv] [int] NOT NULL,
	[live_exp] [int] NOT NULL,
	[map] [varchar](50) NOT NULL,
	[map_x] [int] NOT NULL,
	[map_y] [int] NOT NULL,
	[radius] [int] NOT NULL,
	[angle] [int] NOT NULL,
	[look] [varchar](2000) NOT NULL,
	[kb_capacity] [int] NOT NULL,
	[kitbag] [varchar](7000) NOT NULL,
	[skillbag] [varchar](1200) NOT NULL,
	[shortcut] [varchar](1200) NOT NULL,
	[mission] [varchar](2048) NOT NULL,
	[misrecord] [varchar](2048) NOT NULL,
	[mistrigger] [varchar](2048) NOT NULL,
	[miscount] [varchar](512) NOT NULL,
	[birth] [varchar](50) NOT NULL,
	[login_cha] [varchar](50) NOT NULL,
	[live_tp] [int] NOT NULL,
	[map_mask] [varchar](8000) NOT NULL,
	[delflag] [tinyint] NOT NULL,
	[operdate] [datetime] NOT NULL,
	[deldate] [datetime] NULL,
	[main_map] [varchar](50) NOT NULL,
	[skill_state] [varchar](1024) NOT NULL,
	[bank] [varchar](50) NOT NULL,
	[estop] [datetime] NOT NULL,
	[estoptime] [int] NOT NULL,
	[kb_locked] [int] NOT NULL,
	[kitbag_tmp] [int] NOT NULL,
	[credit] [int] NOT NULL,
	[store_item] [int] NOT NULL,
	[extend] [varchar](2048) NULL,
 CONSTRAINT [PK_character] PRIMARY KEY CLUSTERED 
(
	[cha_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_character] UNIQUE NONCLUSTERED 
(
	[cha_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[character_log]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[character_log](
	[cha_id] [int] NOT NULL,
	[cha_name] [varchar](50) NOT NULL,
	[act_id] [int] NOT NULL,
	[guild_id] [int] NOT NULL,
	[job] [varchar](50) NOT NULL,
	[degree] [smallint] NOT NULL,
	[exp] [int] NOT NULL,
	[hp] [int] NOT NULL,
	[sp] [int] NOT NULL,
	[ap] [int] NOT NULL,
	[tp] [int] NOT NULL,
	[gd] [int] NOT NULL,
	[str] [int] NOT NULL,
	[dex] [int] NOT NULL,
	[agi] [int] NOT NULL,
	[con] [int] NOT NULL,
	[sta] [int] NOT NULL,
	[luk] [int] NOT NULL,
	[map] [varchar](50) NOT NULL,
	[map_x] [int] NOT NULL,
	[map_y] [int] NOT NULL,
	[radius] [int] NOT NULL,
	[look] [varchar](80) NOT NULL,
	[del_date] [datetime] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[dtproperties]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[dtproperties](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[objectid] [int] NULL,
	[property] [varchar](64) NOT NULL,
	[value] [varchar](255) NULL,
	[uvalue] [nvarchar](255) NULL,
	[lvalue] [image] NULL,
	[version] [int] NOT NULL,
 CONSTRAINT [pk_dtproperties] PRIMARY KEY CLUSTERED 
(
	[id] ASC,
	[property] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[friends]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[friends](
	[cha_id1] [int] NOT NULL,
	[cha_id2] [int] NOT NULL,
	[relation] [varchar](50) NOT NULL,
	[createtime] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[guild]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[guild](
	[guild_id] [int] NOT NULL,
	[guild_name] [varchar](16) NOT NULL,
	[motto] [varchar](50) NOT NULL,
	[passwd] [varchar](20) NOT NULL,
	[leader_id] [int] NOT NULL,
	[type] [tinyint] NOT NULL,
	[stat] [tinyint] NOT NULL,
	[money] [bigint] NOT NULL,
	[exp] [bigint] NOT NULL,
	[member_total] [smallint] NOT NULL,
	[try_total] [smallint] NOT NULL,
	[disband_date] [datetime] NOT NULL,
	[challlevel] [smallint] NOT NULL,
	[challid] [int] NOT NULL,
	[challmoney] [bigint] NOT NULL,
	[challstart] [smallint] NOT NULL,
 CONSTRAINT [PK_guild] PRIMARY KEY CLUSTERED 
(
	[guild_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_guild_name] UNIQUE NONCLUSTERED 
(
	[guild_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[IPAddress]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[IPAddress](
	[ip1] [float] NOT NULL,
	[ip2] [float] NOT NULL,
	[country] [nvarchar](70) NULL,
	[city] [nvarchar](70) NULL,
 CONSTRAINT [PK_IPAddress] PRIMARY KEY CLUSTERED 
(
	[ip1] ASC,
	[ip2] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[item]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[item](
	[db_id] [int] IDENTITY(1,1) NOT NULL,
	[cha_id] [int] NOT NULL,
	[type] [smallint] NOT NULL,
	[item_type_id] [smallint] NOT NULL,
	[attr] [varchar](255) NOT NULL,
 CONSTRAINT [PK_item] PRIMARY KEY CLUSTERED 
(
	[db_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Kop_MonthReport]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Kop_MonthReport](
	[act_name] [varchar](50) NULL,
	[degree] [int] NULL,
	[ip] [varchar](20) NULL,
	[createdate] [datetime] NULL,
	[logouttime] [datetime] NULL,
	[playtime] [int] NULL,
	[Guild_Name] [varchar](16) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[map_mask]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[map_mask](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cha_id] [int] NOT NULL,
	[content1] [char](600) NOT NULL,
	[content2] [char](600) NOT NULL,
	[content3] [char](600) NOT NULL,
	[content4] [char](600) NOT NULL,
	[content5] [char](600) NOT NULL,
 CONSTRAINT [PK_map_mask] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [IX_map_mask] UNIQUE NONCLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[master]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[master](
	[cha_id1] [int] NOT NULL,
	[cha_id2] [int] NOT NULL,
	[finish] [int] NOT NULL,
	[relation] [varchar](50) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[param]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[param](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[param1] [int] NULL,
	[param2] [int] NULL,
	[param3] [int] NULL,
	[param4] [int] NULL,
	[param5] [int] NULL,
	[param6] [int] NULL,
	[param7] [int] NULL,
	[param8] [int] NULL,
	[param9] [int] NULL,
	[param10] [int] NULL,
 CONSTRAINT [PK_param] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personavatar]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personavatar](
	[cha_id] [int] NOT NULL,
	[avatar] [image] NULL,
 CONSTRAINT [PK_psersonavatar] PRIMARY KEY CLUSTERED 
(
	[cha_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[personinfo]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[personinfo](
	[cha_id] [int] NOT NULL,
	[motto] [nvarchar](40) NULL,
	[showmotto] [bit] NULL,
	[sex] [nvarchar](50) NULL,
	[age] [int] NULL,
	[name] [nvarchar](50) NULL,
	[animal_zodiac] [nvarchar](50) NULL,
	[blood_type] [nvarchar](50) NULL,
	[birthday] [int] NULL,
	[state] [nvarchar](50) NULL,
	[city] [nvarchar](50) NULL,
	[constellation] [nvarchar](50) NULL,
	[career] [nvarchar](50) NULL,
	[avatarsize] [int] NULL,
	[prevent] [bit] NULL,
	[support] [int] NULL,
	[oppose] [int] NULL,
 CONSTRAINT [PK_personinfo] PRIMARY KEY CLUSTERED 
(
	[cha_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[property]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[property](
	[id] [bigint] NOT NULL,
	[cha_id] [bigint] NOT NULL,
	[context] [nvarchar](255) NOT NULL,
	[sum] [bigint] NOT NULL,
	[time] [datetime] NOT NULL,
 CONSTRAINT [PK_property] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resource]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resource](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[cha_id] [int] NOT NULL,
	[type_id] [smallint] NOT NULL,
	[content] [char](8000) NOT NULL,
 CONSTRAINT [PK_Resource] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stat_log]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stat_log](
	[track_date] [datetime] NOT NULL,
	[login_num] [int] NOT NULL,
	[play_num] [int] NOT NULL,
	[wgplay_num] [int] NULL,
 CONSTRAINT [PK_stat_log] PRIMARY KEY CLUSTERED 
(
	[track_date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stat_log_hh]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stat_log_hh](
	[track_date] [datetime] NOT NULL,
	[login_num] [int] NOT NULL,
	[play_num] [int] NOT NULL,
	[wgplay_num] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatDegree]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatDegree](
	[statDate] [datetime] NOT NULL,
	[degree] [smallint] NOT NULL,
	[characterCount] [bigint] NULL,
 CONSTRAINT [PK_StatDegree] PRIMARY KEY CLUSTERED 
(
	[statDate] ASC,
	[degree] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatGender]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatGender](
	[statDate] [datetime] NOT NULL,
	[gender] [varchar](8) NOT NULL,
	[genderCount] [bigint] NULL,
 CONSTRAINT [PK_StatGender] PRIMARY KEY CLUSTERED 
(
	[statDate] ASC,
	[gender] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatJob]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatJob](
	[statDate] [datetime] NOT NULL,
	[job] [varchar](50) NOT NULL,
	[characterCount] [bigint] NULL,
 CONSTRAINT [PK_StatJob] PRIMARY KEY CLUSTERED 
(
	[statDate] ASC,
	[job] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatLogin]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatLogin](
	[statDate] [datetime] NOT NULL,
	[loginCount] [bigint] NULL,
 CONSTRAINT [PK_StatLogin] PRIMARY KEY CLUSTERED 
(
	[statDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StatMap]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StatMap](
	[statDate] [datetime] NOT NULL,
	[map] [varchar](50) NOT NULL,
	[playCount] [bigint] NULL,
 CONSTRAINT [PK_StatMap] PRIMARY KEY CLUSTERED 
(
	[statDate] ASC,
	[map] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Trade_Log]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Trade_Log](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ExecuteTime] [datetime] NOT NULL,
	[GameServer] [nvarchar](50) NOT NULL,
	[Action] [nvarchar](50) NOT NULL,
	[From] [nvarchar](50) NOT NULL,
	[To] [nvarchar](50) NULL,
	[Memo] [nvarchar](1000) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[weekreport]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[weekreport](
	[act_name] [varchar](50) NULL,
	[cha_name] [varchar](50) NULL,
	[degree] [int] NULL,
	[ip] [varchar](20) NULL,
	[createdate] [datetime] NULL,
	[logouttime] [datetime] NULL,
	[playtime] [int] NULL,
	[Guild_Name] [varchar](16) NULL
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_act_name]  DEFAULT ('') FOR [act_name]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_gm]  DEFAULT ((0)) FOR [gm]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_cha_ids]  DEFAULT ('') FOR [cha_ids]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_last_ip]  DEFAULT ('') FOR [last_ip]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_disc_reson]  DEFAULT ('') FOR [disc_reason]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_last_leave]  DEFAULT ('2001-01-01') FOR [last_leave]
GO
ALTER TABLE [dbo].[account] ADD  CONSTRAINT [DF_account_merge_state]  DEFAULT ((0)) FOR [merge_state]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_berth]  DEFAULT ((0)) FOR [boat_berth]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_name]  DEFAULT ('') FOR [boat_name]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_boat]  DEFAULT ((0)) FOR [boat_boatid]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_header]  DEFAULT ((0)) FOR [boat_header]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_body]  DEFAULT ((0)) FOR [boat_body]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_engine]  DEFAULT ((0)) FOR [boat_engine]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_cannon]  DEFAULT ((0)) FOR [boat_cannon]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_part]  DEFAULT ((0)) FOR [boat_equipment]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_bagsize]  DEFAULT ((0)) FOR [boat_bagsize]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_bag]  DEFAULT ('') FOR [boat_bag]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_diecount]  DEFAULT ((0)) FOR [boat_diecount]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_isdie]  DEFAULT ((0)) FOR [boat_isdead]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_cur_endure]  DEFAULT ((0)) FOR [cur_endure]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_mx_endure]  DEFAULT ((0)) FOR [mx_endure]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_cur_supply]  DEFAULT ((0)) FOR [cur_supply]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_mx_supply]  DEFAULT ((0)) FOR [mx_supply]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_skill_state]  DEFAULT ('') FOR [skill_state]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_ownerid]  DEFAULT ((0)) FOR [boat_ownerid]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_createtime]  DEFAULT ('') FOR [boat_createtime]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_boat_isdeleted]  DEFAULT ((0)) FOR [boat_isdeleted]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_map]  DEFAULT ('') FOR [map]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_map_x]  DEFAULT ((-1)) FOR [map_x]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_map_y]  DEFAULT ((-1)) FOR [map_y]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_angle]  DEFAULT ((0)) FOR [angle]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_degree]  DEFAULT ((1)) FOR [degree]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_exp]  DEFAULT ((0)) FOR [exp]
GO
ALTER TABLE [dbo].[boat] ADD  CONSTRAINT [DF_boat_version]  DEFAULT ((1)) FOR [version]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_motto]  DEFAULT ('') FOR [motto]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_icon]  DEFAULT ((1)) FOR [icon]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_version]  DEFAULT ((1)) FOR [version]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_pk_ctrl_1]  DEFAULT ((0)) FOR [pk_ctrl]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_mem_addr]  DEFAULT ((0)) FOR [mem_addr]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_guild_id]  DEFAULT ((0)) FOR [guild_id]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_guild_stat]  DEFAULT ((0)) FOR [guild_stat]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_guild_permission]  DEFAULT ((0)) FOR [guild_permission]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_job]  DEFAULT ('??') FOR [job]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_degree]  DEFAULT ((0)) FOR [degree]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_exp]  DEFAULT ((0)) FOR [exp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_hp]  DEFAULT ((-1)) FOR [hp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_sp]  DEFAULT ((-1)) FOR [sp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_ap]  DEFAULT ((0)) FOR [ap]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_tp]  DEFAULT ((0)) FOR [tp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_gd]  DEFAULT ((10000)) FOR [gd]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_str]  DEFAULT ((0)) FOR [str]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_dex]  DEFAULT ((0)) FOR [dex]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_agi]  DEFAULT ((0)) FOR [agi]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_con]  DEFAULT ((0)) FOR [con]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_sta]  DEFAULT ((0)) FOR [sta]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_luk]  DEFAULT ((0)) FOR [luk]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_sail_lv]  DEFAULT ((1)) FOR [sail_lv]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_sail_exp]  DEFAULT ((0)) FOR [sail_exp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_sail_left_exp]  DEFAULT ((0)) FOR [sail_left_exp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_live_lv]  DEFAULT ((1)) FOR [live_lv]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_live_exp]  DEFAULT ((0)) FOR [live_exp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_map]  DEFAULT ('') FOR [map]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_map_x]  DEFAULT ((-1)) FOR [map_x]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_map_y]  DEFAULT ((-1)) FOR [map_y]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_radius]  DEFAULT ((0)) FOR [radius]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_angle]  DEFAULT ((0)) FOR [angle]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_look]  DEFAULT ('') FOR [look]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_kb_capacity]  DEFAULT ((24)) FOR [kb_capacity]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_kitbag]  DEFAULT ('') FOR [kitbag]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_skillbag]  DEFAULT ('') FOR [skillbag]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_shortcut_1]  DEFAULT ('') FOR [shortcut]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_mission]  DEFAULT ('') FOR [mission]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_misrecord]  DEFAULT ('') FOR [misrecord]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_trigger]  DEFAULT ('') FOR [mistrigger]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_miscount]  DEFAULT ('') FOR [miscount]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_birth]  DEFAULT ('???') FOR [birth]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_login_cha]  DEFAULT ((0)) FOR [login_cha]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_live_tp]  DEFAULT ((0)) FOR [live_tp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_map_mask]  DEFAULT ((0)) FOR [map_mask]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_delflag]  DEFAULT ((0)) FOR [delflag]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_operdate]  DEFAULT (getdate()) FOR [operdate]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_main_map]  DEFAULT ('') FOR [main_map]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_skill_state]  DEFAULT ('') FOR [skill_state]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_bank]  DEFAULT ('') FOR [bank]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_estop]  DEFAULT (getdate()) FOR [estop]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_estoptime]  DEFAULT ((0)) FOR [estoptime]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_kb_locked]  DEFAULT ((0)) FOR [kb_locked]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_kitbag_tmp]  DEFAULT ((0)) FOR [kitbag_tmp]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_credit]  DEFAULT ((0)) FOR [credit]
GO
ALTER TABLE [dbo].[character] ADD  CONSTRAINT [DF_character_store_item]  DEFAULT ((0)) FOR [store_item]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_guild_id]  DEFAULT ((0)) FOR [guild_id]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_job]  DEFAULT ((0)) FOR [job]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_degree]  DEFAULT ((1)) FOR [degree]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_exp]  DEFAULT ((0)) FOR [exp]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_hp]  DEFAULT ((-1)) FOR [hp]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_sp]  DEFAULT ((-1)) FOR [sp]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_ap]  DEFAULT ((0)) FOR [ap]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_tp]  DEFAULT ((0)) FOR [tp]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_gd]  DEFAULT ((0)) FOR [gd]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_str]  DEFAULT ((0)) FOR [str]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_dex]  DEFAULT ((0)) FOR [dex]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_agi]  DEFAULT ((0)) FOR [agi]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_con]  DEFAULT ((0)) FOR [con]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_sta]  DEFAULT ((0)) FOR [sta]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_luk]  DEFAULT ((0)) FOR [luk]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_map]  DEFAULT ('') FOR [map]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_map_x]  DEFAULT ((-1)) FOR [map_x]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_map_y]  DEFAULT ((-1)) FOR [map_y]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_radius]  DEFAULT ((0)) FOR [radius]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_look]  DEFAULT ('') FOR [look]
GO
ALTER TABLE [dbo].[character_log] ADD  CONSTRAINT [DF_character_log_del_date]  DEFAULT (getdate()) FOR [del_date]
GO
ALTER TABLE [dbo].[dtproperties] ADD  DEFAULT ((0)) FOR [version]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_guild_name]  DEFAULT ('') FOR [guild_name]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_motto]  DEFAULT ('') FOR [motto]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_passwd]  DEFAULT ('') FOR [passwd]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_leader_id]  DEFAULT ((0)) FOR [leader_id]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_type]  DEFAULT ((0)) FOR [type]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_stat]  DEFAULT ((0)) FOR [stat]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_money]  DEFAULT ((0)) FOR [money]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_exp]  DEFAULT ((0)) FOR [exp]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_total]  DEFAULT ((0)) FOR [member_total]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_pending_total]  DEFAULT ((0)) FOR [try_total]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_disband_date]  DEFAULT (getdate()) FOR [disband_date]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_challlevel]  DEFAULT ((0)) FOR [challlevel]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_challid]  DEFAULT ((0)) FOR [challid]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_challmoney]  DEFAULT ((0)) FOR [challmoney]
GO
ALTER TABLE [dbo].[guild] ADD  CONSTRAINT [DF_guild_challstart]  DEFAULT ((0)) FOR [challstart]
GO
ALTER TABLE [dbo].[map_mask] ADD  CONSTRAINT [DF_map_mask_content]  DEFAULT ((0)) FOR [content1]
GO
ALTER TABLE [dbo].[map_mask] ADD  CONSTRAINT [DF_map_mask_content4]  DEFAULT ((0)) FOR [content2]
GO
ALTER TABLE [dbo].[map_mask] ADD  CONSTRAINT [DF_map_mask_content3]  DEFAULT ((0)) FOR [content3]
GO
ALTER TABLE [dbo].[map_mask] ADD  CONSTRAINT [DF_map_mask_content2]  DEFAULT ((0)) FOR [content4]
GO
ALTER TABLE [dbo].[map_mask] ADD  CONSTRAINT [DF_map_mask_content1]  DEFAULT ((0)) FOR [content5]
GO
ALTER TABLE [dbo].[master] ADD  CONSTRAINT [DF_master_cha_id1]  DEFAULT ((0)) FOR [cha_id1]
GO
ALTER TABLE [dbo].[master] ADD  CONSTRAINT [DF_master_cha_id2]  DEFAULT ((0)) FOR [cha_id2]
GO
ALTER TABLE [dbo].[master] ADD  CONSTRAINT [DF_master_finish]  DEFAULT ((0)) FOR [finish]
GO
ALTER TABLE [dbo].[master] ADD  CONSTRAINT [DF_master_relation]  DEFAULT ('teacher') FOR [relation]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param1]  DEFAULT ((0)) FOR [param1]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param2]  DEFAULT ((0)) FOR [param2]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param3]  DEFAULT ((0)) FOR [param3]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param4]  DEFAULT ((0)) FOR [param4]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param5]  DEFAULT ((0)) FOR [param5]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param6]  DEFAULT ((0)) FOR [param6]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param7]  DEFAULT ((0)) FOR [param7]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param8]  DEFAULT ((0)) FOR [param8]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param9]  DEFAULT ((0)) FOR [param9]
GO
ALTER TABLE [dbo].[param] ADD  CONSTRAINT [DF_param_param10]  DEFAULT ((0)) FOR [param10]
GO
ALTER TABLE [dbo].[Resource] ADD  CONSTRAINT [DF_Recource_type_id]  DEFAULT ((1)) FOR [type_id]
GO
ALTER TABLE [dbo].[Resource] ADD  CONSTRAINT [DF_Recource_content]  DEFAULT ('') FOR [content]
GO
ALTER TABLE [dbo].[stat_log] ADD  CONSTRAINT [DF_stat_log_track_date]  DEFAULT (getdate()) FOR [track_date]
GO
ALTER TABLE [dbo].[stat_log] ADD  CONSTRAINT [DF_stat_log_login_num]  DEFAULT ((0)) FOR [login_num]
GO
ALTER TABLE [dbo].[stat_log] ADD  CONSTRAINT [DF_stat_log_play_num]  DEFAULT ((0)) FOR [play_num]
GO
ALTER TABLE [dbo].[character]  WITH NOCHECK ADD  CONSTRAINT [FK_character_account] FOREIGN KEY([act_id])
REFERENCES [dbo].[account] ([act_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[character] CHECK CONSTRAINT [FK_character_account]
GO
ALTER TABLE [dbo].[item]  WITH NOCHECK ADD  CONSTRAINT [FK_item_character] FOREIGN KEY([cha_id])
REFERENCES [dbo].[character] ([cha_id])
ON UPDATE CASCADE
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[item] CHECK CONSTRAINT [FK_item_character]
GO
/****** Object:  StoredProcedure [dbo].[AccReadAllData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AccReadAllData]
@_ACT_ID INT
AS 
SET NOCOUNT ON
select gm, act_name from account
where act_id = @_ACT_ID

GO
/****** Object:  StoredProcedure [dbo].[AddCreditByDBID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddCreditByDBID]
@_CREDIT INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
credit=@_CREDIT
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[AddFriend]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddFriend]
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
insert friends (cha_id1, cha_id2, relation) values
(@_CHA_ID1, @_CHA_ID2, @_RELATION)

GO
/****** Object:  StoredProcedure [dbo].[AddGroup]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddGroup]
@_CHA_ID1 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
insert into friends (cha_id1, cha_id2, relation, createtime) values
(@_CHA_ID1, -1, @_RELATION, GETDATE())

GO
/****** Object:  StoredProcedure [dbo].[AddMaster]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
insert [master] (cha_id1, cha_id2, finish) values (@_CHA_ID, @_CHA_ID2, 0)

GO
/****** Object:  StoredProcedure [dbo].[AddMoney]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddMoney]
@_GOLD INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
gd = gd + @_GOLD
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[AddStatLog]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[AddStatLog]
@_LOGIN_NUM INT, @_PLAY_NUM INT, @_WGPLAY_NUM INT
AS
SET NOCOUNT ON
INSERT INTO stat_log (login_num, play_num, wgplay_num) 
VALUES (@_LOGIN_NUM, @_PLAY_NUM, @_WGPLAY_NUM)

GO
/****** Object:  StoredProcedure [dbo].[Approve2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Approve2]
@_GUILD_ID INT, @_MAX_MEMBERS INT
AS 
SET NOCOUNT ON
UPDATE guild set try_total = try_total -1, member_total = member_total +1
where guild_id = @_GUILD_ID and member_total < @_MAX_MEMBERS and try_total > 0

GO
/****** Object:  StoredProcedure [dbo].[Approve3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Approve3]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat = 1 and delflag = 0

GO
/****** Object:  StoredProcedure [dbo].[BackupRow]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BackupRow]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT guild_id, guild_stat
FROM character
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[BackupRow1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[BackupRow1]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET delflag = 1, deldate = GETDATE()
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[CancelTryFor]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CancelTryFor]
@_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id =0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[Challenge2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Challenge2]
@_CHALL_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where challid = @_CHALL_ID

GO
/****** Object:  StoredProcedure [dbo].[Challenge4]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[Challenge4]
@_CHALL_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where challid = @_CHALL_ID

GO
/****** Object:  StoredProcedure [dbo].[Challenge5]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Challenge5]
@_CHALL_ID INT, @_CHALL_MONEY INT,
@_GUILD_ID INT, @_MONEY INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = @_CHALL_ID, challmoney = @_CHALL_MONEY
where challid = @_CHALL_ID and challmoney < @_MONEY and challstart = 0

GO
/****** Object:  StoredProcedure [dbo].[ChallWin1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[ChallWin1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where guild_id=@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[ChallWin2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChallWin2]
@_GUILD_ID INT, @_GUILD_LV INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = 0, challstart=0, challmoney = 0, challlevel=@_GUILD_LV
where guild_id=@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[ChallWin3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ChallWin3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set challid = 0, challstart=0, challmoney = 0, challlevel=0
where guild_id=@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Create1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create1]
@_GUILD_TYPE INT
AS 
SET NOCOUNT ON
SELECT isnull(min(guild_id),0) from guild
where  guild_id > 0 and leader_id = 0 and type = @_GUILD_TYPE

GO
/****** Object:  StoredProcedure [dbo].[Create2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create2]
@_CHA_ID INT, @_PASSWD VARCHAR(20),
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set leader_id = @_CHA_ID, passwd = @_PASSWD, stat = 0, [money] = 0, [exp] = 0,
member_total = 1, try_total = 0
where  leader_id = 0 and guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Create3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
select guild_name from guild
where  guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Create4]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create4]
@_CHA_ID INT,
@_PASSWD VARCHAR(20), @_GUILD_NAME VARCHAR(16),
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set leader_id = @_CHA_ID, passwd=@_PASSWD, guild_name = @_GUILD_NAME, stat = 0, [money] = 0, [exp] = 0,
member_total =1, try_total = 0
where leader_id = 0 and guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Create5]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Create5]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
update character set guild_id = @_GUILD_ID, guild_stat = 0, guild_permission = -1
where cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[CreateBoat]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[CreateBoat]
@_BOAT_NAME CHAR(17), @_BOAT_BERTH SMALLINT,
@_BOAT_BOATID INT, @_BOAT_HEADER INT, @_BOAT_BODY INT,
@_BOAT_ENGINE INT, @_BOAT_CANNON INT, @_BOAT_EQUIP INT,
@_BOAT_BAG INT, @_BOAT_DIECOUNT INT, @_BOAT_ISDEAD INT,
@_BOAT_OWNERID INT, @_BOAT_CREATETIME CHAR(50), @_BOAT_ISDEL INT
AS 
SET NOCOUNT ON
insert boat
(boat_name, boat_berth, boat_boatid, boat_header, boat_body,
boat_engine, boat_cannon, boat_equipment, boat_bag, boat_diecount,
boat_isdead, boat_ownerid, boat_createtime, boat_isdeleted)
values(@_BOAT_NAME, @_BOAT_BERTH,
@_BOAT_BOATID, @_BOAT_HEADER, @_BOAT_BODY,
@_BOAT_ENGINE, @_BOAT_CANNON, @_BOAT_EQUIP,
@_BOAT_BAG, @_BOAT_DIECOUNT, @_BOAT_ISDEAD,
@_BOAT_OWNERID, @_BOAT_CREATETIME, @_BOAT_ISDEL)

GO
/****** Object:  StoredProcedure [dbo].[DelEstop]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DelEstop]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
UPDATE character
SET estoptime = 0 
WHERE cha_name = @_CHA_NAME

GO
/****** Object:  StoredProcedure [dbo].[DeleteGroup]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DeleteGroup]
@_CHA_ID1 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
delete friends 
where cha_id1 = @_CHA_ID1 and cha_id2=-1 and relation = @_RELATION

GO
/****** Object:  StoredProcedure [dbo].[DelFriend]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DelFriend]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
delete friends 
where(cha_id1=@_CHA_ID1 AND cha_id2=@_CHA_ID2) OR (cha_id1=@_CHA_ID2 and cha_id2=@_CHA_ID1)

GO
/****** Object:  StoredProcedure [dbo].[DelMaster]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[DelMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
delete [master] where (cha_id1 = @_CHA_ID and cha_id2 = @_CHA_ID2)

GO
/****** Object:  StoredProcedure [dbo].[Disband1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Disband1]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
update guild set motto='', passwd='', leader_id = 0, stat = 0, money =0, [exp] = 0, member_total=0, try_total=0
where guild_id =@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Disband2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Disband2]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
update character set guild_id = 0, guild_stat = 0, guild_permission = 0
where guild_id =@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[Disband3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Disband3]
@_GUILD_ID INT, @_PASSWD VARCHAR(20),
@_LEADER_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set motto = '', passwd='', leader_id=0, stat=0,[money]=0,[exp]=0,member_total=0,try_total=0
where guild_id = @_GUILD_ID and leader_id = @_LEADER_ID and passwd=@_PASSWD

GO
/****** Object:  StoredProcedure [dbo].[Disband4]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Disband4]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id =0, guild_stat =0, guild_permission = 0
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[EndChall]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EndChall]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challstart, guild_name, challid, challmoney, challlevel FROM guild
where guild_id=@_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[EndEstopTime]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EndEstopTime]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET estoptime = estoptime - DATEDIFF(minute, estop, GETDATE()) 
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[EStop]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[EStop]
@_CHA_NAME VARCHAR(50), @_TIME INT
AS
SET NOCOUNT ON
UPDATE character
SET estop = GETDATE(), estoptime = @_TIME
WHERE cha_name = @_CHA_NAME

GO
/****** Object:  StoredProcedure [dbo].[FetchAccidByChaName]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FetchAccidByChaName]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT cha_id
FROM character
WHERE cha_name = @_CHA_NAME

GO
/****** Object:  StoredProcedure [dbo].[FetchActNameRowByChaID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[FetchActNameRowByChaID]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT a.act_name
FROM character c, account a
WHERE c.cha_id = @_CHA_ID AND c.act_id = a.act_id

GO
/****** Object:  StoredProcedure [dbo].[FetchRowByActID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FetchRowByActID]
@_ACT_ID INT
AS
SET NOCOUNT ON
SELECT act_name,gm,cha_ids,password,last_ip,disc_reason,CONVERT(varchar(20),last_leave,120)
FROM account
WHERE act_id = @_ACT_ID

GO
/****** Object:  StoredProcedure [dbo].[FetchRowByActName]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FetchRowByActName]
@_ACT_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT act_id,gm,cha_ids,password,last_ip,disc_reason,CONVERT(varchar(20),last_leave,120)
FROM account
WHERE act_name = @_ACT_NAME

GO
/****** Object:  StoredProcedure [dbo].[FetchRowByChaID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[FetchRowByChaID]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT c.cha_name, c.motto, c.icon,
CASE 
	WHEN c.guild_stat = 0 THEN c.guild_id ELSE 0 END,
CASE
	WHEN c.guild_stat <>0 OR c.guild_id = 0 THEN '(none]' ELSE g.guild_name END,
c.job, c.degree, c.map, c.map_x,c.map_y,c.look,c.str,c.dex,c.agi,c.con,c.sta,c.luk

FROM character c, guild g
WHERE c.guild_id = g.guild_id AND c.cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[FetchRowByChaName]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FetchRowByChaName]
@_CHA_NAME VARCHAR(50)
AS
SET NOCOUNT ON
SELECT cha_id, motto, icon
FROM character
WHERE cha_name = @_CHA_NAME

GO
/****** Object:  StoredProcedure [dbo].[FinishMaster]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[FinishMaster]
@_CHA_ID INT
AS
SET NOCOUNT ON 
update [master] set finish = 1 where cha_id1 = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[GetBoat]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetBoat]
@_BOAT_ID INT
AS 
SET NOCOUNT ON
select boat_name, boat_boatid, boat_berth, boat_header, boat_body,
boat_engine, boat_cannon, boat_equipment, boat_diecount, boat_isdead,
boat_ownerid, boat_isdeleted, cur_endure, mx_endure, cur_supply, mx_supply,
skill_state, map, map_x, map_y, angle, degree, [exp] from boat
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[GetChallInfo]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[GetChallInfo]
@_CHALLLEVEL INT
AS 
SET NOCOUNT ON
SELECT guild_id, challid, challmoney FROM guild
where challlevel=@_CHALLLEVEL

GO
/****** Object:  StoredProcedure [dbo].[GetFriendAddr]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetFriendAddr]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select character.mem_addr addr
from character (nolock) INNER JOIN friends on character.cha_id = friends.cha_id2
where (friends.cha_id1=@_CHA_ID1 AND friends.cha_id2 = @_CHA_ID2)

GO
/****** Object:  StoredProcedure [dbo].[GetFriendsCount1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetFriendsCount1]
@_CHA_ID1 INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2 = @_CHA_ID2) OR (cha_id1=@_CHA_ID2 and cha_id2=@_CHA_ID1)

GO
/****** Object:  StoredProcedure [dbo].[GetFriendsCount2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetFriendsCount2]
@_CHA_ID1 INT, @_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2 <> -1) AND (relation=@_RELATION)

GO
/****** Object:  StoredProcedure [dbo].[GetGroupCount]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGroupCount]
@_CHA_ID1 INT
AS
SET NOCOUNT ON 
select count(*) num 
from (select distinct friends.relation relation from friends where friends.cha_id1=@_CHA_ID1 and friends.cha_id2=-1) cc
where 1=1

GO
/****** Object:  StoredProcedure [dbo].[GetGuildMemberNum]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGuildMemberNum]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
select member_total from guild 
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[GetGuildName]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetGuildName]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_name FROM guild
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[GetMasterCount]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMasterCount]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id1=@_CHA_ID)

GO
/****** Object:  StoredProcedure [dbo].[GetMasterData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetMasterData]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from ( 
		select distinct master.relation relation from character INNER JOIN 
		master ON character.cha_id = master.cha_id2 where master.cha_id1 = @_CHA_ID 
		) cc union select master.relation relation,count(character.mem_addr) addr,0 
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON 
		character.cha_id = master.cha_id2 where master.cha_id1 = @_CHA_ID group by relation 
		union select master.relation relation,character.mem_addr addr,character.cha_id 
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto
		from character INNER JOIN master ON character.cha_id = master.cha_id2
		where master.cha_id1 = @_CHA_ID order by relation,cha_id,icon

GO
/****** Object:  StoredProcedure [dbo].[GetPrenticeCount]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPrenticeCount]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id2=@_CHA_ID and finish = 0)

GO
/****** Object:  StoredProcedure [dbo].[GetPrenticeData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetPrenticeData]
@_CHA_ID INT
AS
SET NOCOUNT ON 
select '' relation,count(*) addr,0 cha_id,'' cha_name,0 icon,'' motto from (
		select distinct master.relation relation from character INNER JOIN
		master ON character.cha_id = master.cha_id1 where master.cha_id2 = @_CHA_ID
		) cc union select master.relation relation,count(character.mem_addr) addr,0
		cha_id,'' cha_name,1 icon,'' motto from character INNER JOIN master ON
		character.cha_id = master.cha_id1 where master.cha_id2 = @_CHA_ID group by relation
		union select master.relation relation,character.mem_addr addr,character.cha_id
		cha_id,character.cha_name cha_name,character.icon icon,character.motto motto
		from character INNER JOIN master ON character.cha_id = master.cha_id1
		where master.cha_id2 = @_CHA_ID order by relation,cha_id,icon

GO
/****** Object:  StoredProcedure [dbo].[GetTypeByID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GetTypeByID]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT type, guild_name, motto from guild
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[GroupIsExsit]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GroupIsExsit]
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION VARCHAR(50)
AS
SET NOCOUNT ON 
select count(*) num from friends 
where (cha_id1=@_CHA_ID1 and cha_id2=@_CHA_ID2) and relation=@_RELATION

GO
/****** Object:  StoredProcedure [dbo].[GuildFetchRowByName]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[GuildFetchRowByName]
@_GUILD_NAME VARCHAR(16)
AS
SET NOCOUNT ON 
select guild_id from guild
where guild_id =@_GUILD_NAME

GO
/****** Object:  StoredProcedure [dbo].[HasCall]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[HasCall]
@_CHALL_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, challstart FROM guild
where challlevel=@_CHALL_LV

GO
/****** Object:  StoredProcedure [dbo].[HasGuildLevel]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[HasGuildLevel]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT challlevel FROM guild
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[HasMaster]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[HasMaster]
@_CHA_ID INT, @_CHA_ID2 INT
AS
SET NOCOUNT ON 
select COUNT(*) num from [master] 
where (cha_id1=@_CHA_ID and cha_id2=@_CHA_ID2)

GO
/****** Object:  StoredProcedure [dbo].[InitGuildMember]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InitGuildMember]
@_GUILD_ID INT
AS
SET NOCOUNT ON 
select c.mem_addr, c.cha_id, c.cha_name, c.motto, c.job, c.degree, c.icon, c.guild_permission
from character as c where (c.guild_stat = 0) and (c.guild_id = @_GUILD_ID) and (c.delflag = 0)

GO
/****** Object:  StoredProcedure [dbo].[InsertRow1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertRow1]
AS
SET NOCOUNT ON
SELECT TOP 1 act_id 
FROM account WITH(nolock)
ORDER BY act_id DESC

GO
/****** Object:  StoredProcedure [dbo].[InsertRow2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertRow2]
@_ACT_ID INT, @_ACT_NAME VARCHAR(50), @_CHA_IDS VARCHAR(80)
AS
SET NOCOUNT ON
INSERT INTO account (act_id, act_name, cha_ids)
VALUES (@_ACT_ID, @_ACT_NAME, @_CHA_IDS)

GO
/****** Object:  StoredProcedure [dbo].[InsertRow3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[InsertRow3]
@_CHA_NAME VARCHAR(50), @_ACT_ID INT,
@_BIRTH VARCHAR(50), @_MAP VARCHAR(50),
@_LOOK VARCHAR(2000)
AS
SET NOCOUNT ON 
insert character (cha_name, act_id, birth, map, look) values
(@_CHA_NAME, @_ACT_ID, @_BIRTH, @_MAP, @_LOOK)

GO
/****** Object:  StoredProcedure [dbo].[IsChaOnline]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IsChaOnline]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT mem_addr FROM character
Where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[IsEstop]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[IsEstop]
@_CHA_ID INT
AS
SET NOCOUNT ON
SELECT estop
FROM character
WHERE cha_id = @_CHA_ID and DATEADD(minute, estoptime, estop) > GETDATE()

GO
/****** Object:  StoredProcedure [dbo].[Kick1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Kick1]
@_CHA_ID INT, @_GUILD_ID INT, @_GUILD_PERM1 INT,
@_GUILD_PERM2 INT
AS 
SET NOCOUNT ON
SELECT cha_id from character
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_permission & @_GUILD_PERM1 = @_GUILD_PERM2

GO
/****** Object:  StoredProcedure [dbo].[Kick2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Kick2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat =0 and cha_id not in(select leader_id from guild where guild_id = @_GUILD_ID)

GO
/****** Object:  StoredProcedure [dbo].[Leave1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Leave1]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission = 0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID AND guild_stat =0 and cha_id not in (select leader_id from guild where guild_id = @_GUILD_ID)

GO
/****** Object:  StoredProcedure [dbo].[Leave2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Leave2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set member_total = member_total -1
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[ListChallenge1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListChallenge1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[ListChallenge2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListChallenge2]
@_CHALL_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney, leader_id, challstart FROM guild
where challlevel = @_CHALL_LV

GO
/****** Object:  StoredProcedure [dbo].[ListTryPlayer1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListTryPlayer1]
@_DISBAND_DAYS INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT g.guild_id, g.guild_name, g.motto, g.[type], g.stat, c.cha_name, g.member_total, g.[exp], g.[money], 
case when g.stat>0 then @_DISBAND_DAYS*24*60 - DATEDIFF(mi, g.disband_date, GETDATE()) else 0 end disband_time1
from character c, guild g
where g.leader_id = c.cha_id and g.guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[ListTryPlayer2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ListTryPlayer2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT c.cha_id, c.cha_name, c.job, c.degree from character c
where c.guild_stat = 1 and c.guild_id = @_GUILD_ID and c.delflag = 0

GO
/****** Object:  StoredProcedure [dbo].[Motto]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Motto]
@_MOTTO VARCHAR(50), @_GUILD_ID INT,
@_LEADER_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set motto = @_MOTTO
where guild_id = @_GUILD_ID and leader_id = @_LEADER_ID

GO
/****** Object:  StoredProcedure [dbo].[MoveGroup]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[MoveGroup]
@_RELATION_NEW VARCHAR(50),
@_CHA_ID1 INT, @_CHA_ID2 INT,
@_RELATION_OLD VARCHAR(50)
AS
SET NOCOUNT ON 
update friends set relation=@_RELATION_NEW where cha_id1= @_CHA_ID1 and cha_id2=@_CHA_ID2 and relation=@_RELATION_OLD

GO
/****** Object:  StoredProcedure [dbo].[OnlySavePosWhenBeSaved]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[OnlySavePosWhenBeSaved]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50),
@_MAP_X INT, @_MAP_Y INT, @_ANGLE INT,
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
map = @_MAP, main_map = @_MAIN_MAP, map_x = @_MAP_X, map_y = @_MAP_Y,
angle = @_ANGLE
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[ReadAllData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadAllData]
@charID INT
AS
SET NOCOUNT ON
SELECT act_id, guild_stat, guild_id, hp, sp, exp, radius, angle, cha_name, motto, icon, version,
pk_ctrl, degree, job, gd, ap, tp, str, dex, agi, con, sta, luk, sail_lv, sail_exp, sail_left_exp, live_lv, live_exp,
live_tp, main_map, map_x, map_y, birth, look, skillbag, shortcut, mission, misrecord, mistrigger, miscount, login_cha, kitbag, 
kitbag_tmp, map_mask, skill_state, bank, kb_locked, credit, store_item, extend 
FROM character
WHERE cha_id = @charID

GO
/****** Object:  StoredProcedure [dbo].[ReadBankDataEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadBankDataEx]
@_BANK_ID INT 
AS 
SET NOCOUNT ON
select cha_id, type_id, content from Resource
where id = @_BANK_ID

GO
/****** Object:  StoredProcedure [dbo].[ReadCabin]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadCabin]
@_BOAT_ID INT
AS 
SET NOCOUNT ON
select boat_bag from boat
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[ReadKitbagTmpData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadKitbagTmpData]
@_ID INT
AS 
SET NOCOUNT ON
select content from Resource
where id = @_ID

GO
/****** Object:  StoredProcedure [dbo].[ReadKitbagTmpDataEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ReadKitbagTmpDataEx]
@_ID INT
AS 
SET NOCOUNT ON
select cha_id, type_id, content from Resource
where id = @_ID

GO
/****** Object:  StoredProcedure [dbo].[Reject2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reject2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE character set guild_id = 0, guild_stat = 0, guild_permission =0
where cha_id = @_CHA_ID and guild_id = @_GUILD_ID and guild_stat = 1

GO
/****** Object:  StoredProcedure [dbo].[Reject3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[Reject3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set try_total = try_total -1
where guild_id = @_GUILD_ID and try_total > 0

GO
/****** Object:  StoredProcedure [dbo].[ResourceCreate]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ResourceCreate]
@_ID INT, @_TYPE_ID INT
AS 
SET NOCOUNT ON
insert Resource (cha_id, type_id)
values(@_ID, @_TYPE_ID)

GO
/****** Object:  StoredProcedure [dbo].[SaveAllData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[SaveAllData]
@_HP INT,@_SP   INT,@_EXP VARCHAR(32),@_MAP  VARCHAR(50),@_MAIN_MAP  VARCHAR(50),
@_MAP_X  INT,@_MAP_Y  INT,@_RADIUS INT,@_ANGLE SMALLINT,@_PK_CTRL TINYINT,@_DEGREE SMALLINT,@_JOB SMALLINT,@_GD INT,
@_AP INT,@_TP INT,@_STR INT,@_DEX INT,@_AGI INT,@_CON INT,@_STA INT,@_LUK INT,@_LOOK VARCHAR(2000),@_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200),@_MISSION VARCHAR(2048),@_MISRECORD VARCHAR(2048),@_MISTRIGGER VARCHAR(2048),@_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50),@_LOGIN_CHA VARCHAR(50),@_SAIL_LV INT,@_SAIL_EXP INT,@_SAIL_LEFT_EXP INT,@_LIVE_LV INT,@_LIVE_EXP INT,
@_LIVE_TP INT,@_KB_LOCKED INT,@_CREDIT INT,@_STORE_ITEM INT,@_SKILL_STATE VARCHAR(1024),@_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp = @_HP, sp=@_SP, [exp]=CAST(@_EXP AS BIGINT), map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, radius=@_RADIUS, angle=@_ANGLE, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveAllDataExWithoutPos]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveAllDataExWithoutPos]

@_HP INT, @_SP INT, @_EXP BIGINT, @_RADIUS INT, @_PK_CTRL TINYINT, @_DEGREE SMALLINT, @_JOB SMALLINT, @_GD INT,
@_AP INT, @_TP INT, @_STR INT, @_DEX INT, @_AGI INT, @_CON INT, @_STA INT, @_LUK INT, @_LOOK VARCHAR(2000), @_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200), @_MISSION VARCHAR(2048), @_MISRECORD VARCHAR(2048), @_MISTRIGGER VARCHAR(2048), @_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50), @_LOGIN_CHA VARCHAR(50), @_SAIL_LV INT, @_SAIL_EXP INT, @_SAIL_LEFT_EXP INT, @_LIVE_LV INT, @_LIVE_EXP INT,
@_LIVE_TP INT, @_KB_LOCKED INT, @_CREDIT INT, @_STORE_ITEM INT, @_SKILL_STATE VARCHAR(1024), @_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp=@_HP, sp=@_SP, [exp]=@_EXP, radius=@_RADIUS, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveAllDataExWithPos]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveAllDataExWithPos]
@_HP INT, @_SP INT, @_EXP BIGINT, @_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50),
@_MAP_X INT, @_MAP_Y INT, @_RADIUS INT, @_ANGLE SMALLINT, @_PK_CTRL TINYINT, @_DEGREE SMALLINT, @_JOB SMALLINT, @_GD INT,
@_AP INT, @_TP INT, @_STR INT, @_DEX INT, @_AGI INT, @_CON INT, @_STA INT, @_LUK INT, @_LOOK VARCHAR(2000), @_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200), @_MISSION VARCHAR(2048), @_MISRECORD VARCHAR(2048), @_MISTRIGGER VARCHAR(2048), @_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50), @_LOGIN_CHA VARCHAR(50), @_SAIL_LV INT, @_SAIL_EXP INT, @_SAIL_LEFT_EXP INT, @_LIVE_LV INT, @_LIVE_EXP INT,
@_LIVE_TP INT, @_KB_LOCKED INT, @_CREDIT INT, @_STORE_ITEM INT, @_SKILL_STATE VARCHAR(1024), @_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp=@_HP, sp=@_SP, [exp]=@_EXP, map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, radius=@_RADIUS, angle=@_ANGLE, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveAllDataWithoutPos]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveAllDataWithoutPos]
@_HP INT,@_SP   INT,@_EXP VARCHAR(32),
@_RADIUS INT,@_PK_CTRL TINYINT,@_DEGREE SMALLINT,@_JOB SMALLINT,@_GD INT,
@_AP INT,@_TP INT,@_STR INT,@_DEX INT,@_AGI INT,@_CON INT,@_STA INT,@_LUK INT,@_LOOK VARCHAR(2000),@_SKILLBAG VARCHAR(1200),
@_SHORTCUT VARCHAR(1200),@_MISSION VARCHAR(2048),@_MISRECORD VARCHAR(2048),@_MISTRIGGER VARCHAR(2048),@_MISCOUNT VARCHAR(512),
@_BIRTH VARCHAR(50),@_LOGIN_CHA VARCHAR(50),@_SAIL_LV INT,@_SAIL_EXP INT,@_SAIL_LEFT_EXP INT,@_LIVE_LV INT,@_LIVE_EXP INT,
@_LIVE_TP INT,@_KB_LOCKED INT,@_CREDIT INT,@_STORE_ITEM INT,@_SKILL_STATE VARCHAR(1024),@_EXTEND VARCHAR(2048),@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
hp = @_HP, sp=@_SP, [exp]=CAST(@_EXP AS BIGINT),radius=@_RADIUS, pk_ctrl=@_PK_CTRL, degree=@_DEGREE,
job=CAST(@_JOB AS VARCHAR(50)), gd=@_GD, ap=@_AP, tp=@_TP, [str]=@_STR, dex=@_DEX, agi=@_AGI, con=@_CON, sta=@_STA, luk=@_LUK, look=@_LOOK, skillbag=@_SKILLBAG,
shortcut=@_SHORTCUT, mission=@_MISSION, misrecord=@_MISRECORD, mistrigger=@_MISTRIGGER, miscount=@_MISCOUNT, birth=@_BIRTH, login_cha=@_LOGIN_CHA,
sail_lv=@_SAIL_LV, sail_exp=@_SAIL_EXP, sail_left_exp=@_SAIL_LEFT_EXP, live_lv=@_LIVE_LV, live_exp=@_LIVE_EXP, live_tp=@_LIVE_TP, kb_locked=@_KB_LOCKED, 
credit=@_CREDIT, store_item=@_STORE_ITEM, skill_state=@_SKILL_STATE, extend =@_EXTEND 
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBankDataEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBankDataEx]
@_CONTENT CHAR(8000), @_BANK_ID INT 
AS 
SET NOCOUNT ON
update Resource set content = @_CONTENT
where id = @_BANK_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBankDBID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBankDBID]
@_BANK varchar(50), @_CHA_ID INT 
AS
SET NOCOUNT ON
UPDATE character set
bank=@_BANK
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBoatDelTag]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBoatDelTag]
@_BOAT_ISDEL INT, @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_isdeleted = @_BOAT_ISDEL
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBoatEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBoatEx]
@_BOAT_BERTH SMALLINT, @_BOAT_OWNERID INT, @_CUR_ENDURE INT,
@_MX_ENDURE INT, @_CUR_SUPPLY INT, @_MX_SUPPLY INT,
@_SKILL_STATE CHAR(400), @_DEGREE SMALLINT, @_EXP INT,
@_BOAT_BAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_berth=@_BOAT_BERTH, boat_ownerid=@_BOAT_OWNERID,cur_endure = @_CUR_ENDURE,
mx_endure=@_MX_ENDURE, cur_supply=@_CUR_SUPPLY, mx_supply=@_MX_SUPPLY, skill_state =@_SKILL_STATE,
degree = @_DEGREE, [exp]=@_EXP, boat_bag=@_BOAT_BAG
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBoatExWithPos]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBoatExWithPos]
@_BOAT_BERTH SMALLINT, @_BOAT_OWNERID INT, @_CUR_ENDURE INT,
@_MX_ENDURE INT, @_CUR_SUPPLY INT, @_MX_SUPPLY INT,
@_SKILL_STATE CHAR(400), @_MAP CHAR(50), @_MAP_X INT,
@_MAP_Y INT, @_ANGLE INT,@_DEGREE SMALLINT, @_EXP INT,
@_BOAT_BAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
UPDATE boat set boat_berth=@_BOAT_BERTH, boat_ownerid=@_BOAT_OWNERID,cur_endure = @_CUR_ENDURE,
mx_endure=@_MX_ENDURE, cur_supply=@_CUR_SUPPLY, mx_supply=@_MX_SUPPLY, skill_state =@_SKILL_STATE,
map= @_MAP, map_x = @_MAP_X, map_y = @_MAP_Y, angle=@_ANGLE, degree =@_DEGREE, [exp]=@_EXP, boat_bag=@_BOAT_BAG
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBoatTempData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBoatTempData]
@_BOAT_DIECOUNT SMALLINT, @_BOAT_ISDEAD CHAR(1), 
@_BOAT_OWNERID INT, @_BOAT_ISDELETED CHAR(1),
@_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_diecount= @_BOAT_DIECOUNT, boat_isdead = @_BOAT_ISDEAD, 
boat_ownerid = @_BOAT_OWNERID, boat_isdeleted = @_BOAT_ISDELETED
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveBoatTempData3params]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveBoatTempData3params]
@_BOAT_OWNERID INT, @_BOAT_ISDEL CHAR(1),
@_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_ownerid = @_BOAT_OWNERID, boat_isdeleted=@_BOAT_ISDEL
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveCabin]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveCabin]
@_KITBAG CHAR(7000), @_BOAT_ID INT
AS 
SET NOCOUNT ON
update boat set boat_bag = @_KITBAG 
where boat_id = @_BOAT_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveKBagDBIDEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveKBagDBIDEx]
@_ID INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
kitbag=@_ID
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveKBagTmpDBID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveKBagTmpDBID]
@_ID INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
kitbag_tmp=@_ID
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveKBState]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveKBState]
@_Lock INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
kb_locked=@_Lock
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveKitbagTmpDataEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveKitbagTmpDataEx]
@_CONTENT CHAR(8000), @_ID INT
AS 
SET NOCOUNT ON
update Resource set content=@_CONTENT
where id = @_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveMissionData]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveMissionData]
@_MIS_INFO varchar(2048), @_MIS_RECORD varchar(2048), @_MIS_TRIGGER varchar(2048), @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
mission=@_MIS_INFO, misrecord=@_MIS_RECORD, mistrigger=@_MIS_TRIGGER
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveMoney]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveMoney]
@_GD INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
gd=@_GD
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveParam]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveParam]
@_PARAM1 INT, @_PARAM2 INT, @_PARAM3 INT,
@_PARAM4 INT, @_PARAM5 INT, @_PARAM6 INT,
@_PARAM7 INT, @_PARAM8 INT, @_PARAM9 INT,
@_PARAM10 INT
AS
SET NOCOUNT ON 
update param set param1 = @_PARAM1, param2 = @_PARAM2, param3 = @_PARAM3,
param4=@_PARAM4, param5=@_PARAM5, param6=@_PARAM6,param7=@_PARAM7,param8=@_PARAM8,
param9=@_PARAM9, param10=@_PARAM10 where id = 1

GO
/****** Object:  StoredProcedure [dbo].[SavePos]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SavePos]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50), @_MAP_X INT, @_MAP_Y INT, @_ANGLE INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, angle=@_ANGLE
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SavePosEx]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SavePosEx]
@_MAP VARCHAR(50), @_MAIN_MAP VARCHAR(50), @_MAP_X INT, @_MAP_Y INT, @_ANGLE INT, @_CHA_ID INT
AS 
SET NOCOUNT ON
UPDATE character set
map=@_MAP, main_map=@_MAIN_MAP, map_x=@_MAP_X, map_y=@_MAP_Y, angle=@_ANGLE
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SaveStoreItemID]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SaveStoreItemID]
@_ID INT, @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character set
store_item=@_ID
where cha_id=@_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SetAddr]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetAddr]
@_MEM_ADDR BIGINT, @_CHA_ID INT
AS
SET NOCOUNT ON 
UPDATE character set mem_addr = @_MEM_ADDR 
where cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[SetDiscInfo]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[SetDiscInfo]
@_CLIENT_IP VARCHAR(16), 
@_REASON VARCHAR(128),
@_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET last_ip = @_CLIENT_IP, disc_reason = @_REASON 
WHERE act_id = @_ACT_ID

GO
/****** Object:  StoredProcedure [dbo].[StartChall1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[StartChall1]
@_GUILD_LV INT
AS 
SET NOCOUNT ON
SELECT guild_id, guild_name, challid, challmoney FROM guild
where challlevel=@_GUILD_LV

GO
/****** Object:  StoredProcedure [dbo].[StartChall2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [dbo].[StartChall2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
UPDATE guild set challstart = 1
where guild_id = @_GUILD_ID and challstart = 0

GO
/****** Object:  StoredProcedure [dbo].[StartEstopTime]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[StartEstopTime]
@_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET estop = GETDATE()
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[TryFor1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TryFor1]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT guild_id from guild
where leader_id > 0 and guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[TryFor2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TryFor2]
@_CHA_ID INT, @_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT c.guild_id, c.guild_stat, g.guild_name from guild g, character c
where  c.guild_id = g.guild_id and c.cha_id = @_CHA_ID and g.guild_id <> @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[TryFor3]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TryFor3]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
SELECT type, guild_name from guild
where  guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[TryForConfirm1]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TryForConfirm1]
@_GUILD_ID INT, @_CHA_ID INT,
@_MAX_TRY INT, @_MAX_MEMBER INT
AS 
SET NOCOUNT ON
update character set guild_id = @_GUILD_ID, guild_stat = 1, guild_permission =0
where cha_id = @_CHA_ID and @_GUILD_ID in (select guild_id from guild where leader_id >0 and guild_id = @_GUILD_ID and try_total < @_MAX_TRY and member_total < @_MAX_MEMBER)

GO
/****** Object:  StoredProcedure [dbo].[TryForConfirm2]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[TryForConfirm2]
@_GUILD_ID INT
AS 
SET NOCOUNT ON
update guild set try_total = try_total +1
where guild_id = @_GUILD_ID

GO
/****** Object:  StoredProcedure [dbo].[UpdateGroup]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateGroup]
@_RELATION_NEW VARCHAR(50),
@_CHA_ID1 INT,
@_RELATION_OLD VARCHAR(50)
AS
SET NOCOUNT ON 
update friends set relation = @_RELATION_NEW where cha_id1=@_CHA_ID1 and relation=@_RELATION_OLD

GO
/****** Object:  StoredProcedure [dbo].[UpdateInfo]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateInfo]
@_ICON SMALLINT, @_MOTTO VARCHAR(50), @_CHA_ID INT
AS
SET NOCOUNT ON
UPDATE character
SET icon = @_ICON, motto = @_MOTTO
WHERE cha_id = @_CHA_ID

GO
/****** Object:  StoredProcedure [dbo].[UpdatePassword]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdatePassword]
@_PASSWORD VARCHAR(50), @_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET password = @_PASSWORD
WHERE act_id = @_ACT_ID

GO
/****** Object:  StoredProcedure [dbo].[UpdateRow]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[UpdateRow]
@_CHA_IDS VARCHAR(80), @_ACT_ID INT
AS
SET NOCOUNT ON
UPDATE account
SET cha_ids = @_CHA_IDS
WHERE act_id = @_ACT_ID

GO
/****** Object:  StoredProcedure [dbo].[ZeroAddr]    Script Date: 1/23/2024 2:18:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[ZeroAddr]
AS 
SET NOCOUNT ON
UPDATE character
SET mem_addr = 0
WHERE mem_addr != 0

GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'性别' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'sex'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'年龄' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'age'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'名字' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'name'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'属相' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'animal_zodiac'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'血型' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'blood_type'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'生日' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'birthday'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'地区' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'state'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'城市' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'city'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'星座' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'constellation'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'职业' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'career'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'免骚扰' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'personinfo', @level2type=N'COLUMN',@level2name=N'prevent'
GO
USE [master]
GO
ALTER DATABASE [gamedbNew] SET  READ_WRITE 
GO
