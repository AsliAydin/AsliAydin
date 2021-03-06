USE [master]
GO
/****** Object:  Database [TRENDYOL_DB]    Script Date: 1/26/2020 7:14:41 PM ******/
CREATE DATABASE [TRENDYOL_DB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TRENDYOL', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TRENDYOL.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'TRENDYOL_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER\MSSQL\DATA\TRENDYOL_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [TRENDYOL_DB] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TRENDYOL_DB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TRENDYOL_DB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET ARITHABORT OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TRENDYOL_DB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TRENDYOL_DB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TRENDYOL_DB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TRENDYOL_DB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET RECOVERY FULL 
GO
ALTER DATABASE [TRENDYOL_DB] SET  MULTI_USER 
GO
ALTER DATABASE [TRENDYOL_DB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TRENDYOL_DB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TRENDYOL_DB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TRENDYOL_DB] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [TRENDYOL_DB] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'TRENDYOL_DB', N'ON'
GO
ALTER DATABASE [TRENDYOL_DB] SET QUERY_STORE = OFF
GO
USE [TRENDYOL_DB]
GO
/****** Object:  Table [dbo].[AreaLeft2]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaLeft2](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [int] NOT NULL,
	[AutoID] [bigint] NOT NULL,
	[Title] [nvarchar](150) NULL,
	[ImagePaith] [nvarchar](250) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[OrderNo] [int] NOT NULL,
 CONSTRAINT [PK_AreaLeft2] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AreaRight]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AreaRight](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [int] NOT NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
	[ImagePath] [nvarchar](250) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[OrderNo] [int] NOT NULL,
 CONSTRAINT [PK_AreaRight] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Menu]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Menu](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [int] NOT NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](25) NOT NULL,
	[URL] [nvarchar](200) NOT NULL,
	[ParentMenuID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_Menu] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID] [uniqueidentifier] NOT NULL,
	[CreatedBy] [uniqueidentifier] NULL,
	[CreatedDate] [datetime] NULL,
	[ModifiedBy] [uniqueidentifier] NULL,
	[ModifiedDate] [datetime] NULL,
	[Status] [int] NOT NULL,
	[AutoID] [bigint] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](255) NOT NULL,
	[Password] [nvarchar](max) NOT NULL,
	[Gender] [char](1) NOT NULL,
	[IsCampaign] [bit] NOT NULL,
	[IsContract] [bit] NOT NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[AreaLeft2] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Title], [ImagePaith], [URL], [OrderNo]) VALUES (N'095fc873-503a-4fd8-9ee6-8a78abfc3deb', NULL, CAST(N'2020-01-26T17:49:38.590' AS DateTime), NULL, NULL, 1, 1, NULL, N'https://img-trendyol.mncdn.com/assets/t/y/Creative/ds/Automation/BrandBoutique/2020/1/23/HoticYazVeKisFirsati_section1_202001231205_webBig.jpg', N'/hotic+yaya-by-hotic', 10)
INSERT [dbo].[AreaLeft2] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Title], [ImagePaith], [URL], [OrderNo]) VALUES (N'a8d5bba1-6cd3-4539-94a8-a0eaf57353c0', NULL, CAST(N'2020-01-26T17:54:52.650' AS DateTime), NULL, NULL, 4, 3, N'Deneme', N'/images/deneme', N'/deneme', 30)
INSERT [dbo].[AreaLeft2] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Title], [ImagePaith], [URL], [OrderNo]) VALUES (N'123887b1-cb23-4016-9c42-b773111a69af', NULL, CAST(N'2020-01-26T17:52:48.130' AS DateTime), NULL, NULL, 1, 2, N'Aqua', N'https://img-trendyol.mncdn.com/assets/campaign/media/banners/original/401195/4db1b4f0e5_1_new.jpg', N'/aqua-di-polo-saat--gunes-gozlugu/butikdetay/401195', 20)
SET IDENTITY_INSERT [dbo].[AreaRight] ON 

INSERT [dbo].[AreaRight] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [ImagePath], [URL], [OrderNo]) VALUES (N'16085152-7598-4a32-bfd5-566084c35b4f', NULL, CAST(N'2020-01-26T18:14:50.263' AS DateTime), NULL, NULL, 1, 2, N'https://img-trendyol.mncdn.com/assets/t/y/creative/bnr/rightBnr/2020/ocak/elektronik/21/images/exc.png', N'/oyuncu-dizustu-bilgisayari?q=excalibur', 20)
INSERT [dbo].[AreaRight] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [ImagePath], [URL], [OrderNo]) VALUES (N'e9534d0e-b659-466b-869c-86ecbcb5c874', NULL, CAST(N'2020-01-26T18:14:08.250' AS DateTime), NULL, NULL, 1, 1, N'https://img-trendyol.mncdn.com/assets/t/y/creative/bnr/rightBnr/2019/aralik/erkek/17/images/so.gif', N'/sanaozel/1', 10)
SET IDENTITY_INSERT [dbo].[AreaRight] OFF
SET IDENTITY_INSERT [dbo].[Menu] ON 

INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'12c42468-6206-414c-bec9-17d53ce3f1c9', NULL, CAST(N'2020-01-26T16:29:22.403' AS DateTime), NULL, NULL, 1, 2, N'ERKEK', N'/butik/liste/erkek', NULL)
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'd14452e1-125c-48cb-a2fc-4a682041b42d', NULL, CAST(N'2020-01-26T16:39:03.657' AS DateTime), NULL, NULL, 1, 8, N'Bebek Bezi', N'/cocuk+bebek-bezi', N'a2680608-43e4-4c77-8231-6d60a6bcda65')
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'ea61620b-ec90-48b4-95f8-5393bf66c04f', NULL, CAST(N'2020-01-26T16:26:47.260' AS DateTime), NULL, NULL, 1, 1, N'KADIN', N'/butik/liste/kadin', NULL)
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'a2680608-43e4-4c77-8231-6d60a6bcda65', NULL, CAST(N'2020-01-26T16:30:36.317' AS DateTime), NULL, NULL, 1, 3, N'ÇOCUK', N'/butik/liste/cocuk', NULL)
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'8d239c53-2340-4658-96dc-7e8626901661', NULL, CAST(N'2020-01-26T16:38:09.473' AS DateTime), NULL, NULL, 1, 7, N'Bebek', N'/bebek-giyim', N'a2680608-43e4-4c77-8231-6d60a6bcda65')
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'f9a810fb-9aa7-4410-9f21-80d94e2c635b', NULL, CAST(N'2020-01-26T16:36:41.650' AS DateTime), NULL, NULL, 1, 6, N'Ayakkabı', N'/kadin+ayakkabi', N'ea61620b-ec90-48b4-95f8-5393bf66c04f')
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'c689e6a7-ec75-41dd-9ad2-9abeace1e99e', NULL, CAST(N'2020-01-26T16:43:31.653' AS DateTime), NULL, NULL, 1, 9, N'Elbise', N'/kadin+elbise', N'beb49522-4caf-47bb-a955-e9c0dbfacfea')
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'151b81a9-dac6-4411-897b-a37d32ee51cd', NULL, CAST(N'2020-01-26T16:32:03.680' AS DateTime), NULL, NULL, 1, 4, N'AYAKKABI&ÇANTA', N'/ayakkabi--canta', NULL)
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'beb49522-4caf-47bb-a955-e9c0dbfacfea', NULL, CAST(N'2020-01-26T16:33:32.220' AS DateTime), NULL, NULL, 1, 5, N'Giyim', N'/kadin+giyim', N'ea61620b-ec90-48b4-95f8-5393bf66c04f')
INSERT [dbo].[Menu] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [Name], [URL], [ParentMenuID]) VALUES (N'df67ddb0-7bd2-4d48-8cba-feccb1132e2a', NULL, CAST(N'2020-01-26T16:44:27.330' AS DateTime), NULL, NULL, 1, 10, N'T-Shirt', N'/kadin+t-shirt', N'beb49522-4caf-47bb-a955-e9c0dbfacfea')
SET IDENTITY_INSERT [dbo].[Menu] OFF
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([ID], [CreatedBy], [CreatedDate], [ModifiedBy], [ModifiedDate], [Status], [AutoID], [EmailAddress], [Password], [Gender], [IsCampaign], [IsContract]) VALUES (N'8f2dd815-7613-4d9c-b199-2cf39c5c477a', NULL, CAST(N'2020-01-26T19:03:07.823' AS DateTime), NULL, NULL, 1, 1, N'a', N'4', N'K', 1, 0)
SET IDENTITY_INSERT [dbo].[User] OFF
ALTER TABLE [dbo].[AreaLeft2] ADD  CONSTRAINT [DF_AreaLeft2_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[AreaLeft2] ADD  CONSTRAINT [DF_AreaLeft2_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[AreaRight] ADD  CONSTRAINT [DF_AreaRight_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[AreaRight] ADD  CONSTRAINT [DF_AreaRight_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[Menu] ADD  CONSTRAINT [DF_Menu_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_ID]  DEFAULT (newid()) FOR [ID]
GO
ALTER TABLE [dbo].[User] ADD  CONSTRAINT [DF_User_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
/****** Object:  StoredProcedure [dbo].[IDILESORGULA]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[IDILESORGULA]
(
@id UNIQUEIDENTIFIER
)
AS
BEGIN
SELECT * FROM MENU WHERE ParentMenuID=@id and Status=1
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAllMenus]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAllMenus]
@menuId UNIQUEIDENTIFIER=null
AS
BEGIN
	IF EXISTS (SELECT * FROM Menu WHERE ParentMenuID=@menuId) 
	   BEGIN
	            SELECT *FROM Menu WHERE ParentMenuID=@menuId AND Status=1
	    END
	ELSE
	    BEGIN
	            SELECT * FROM Menu WHERE ParentMenuID IS NULL AND Status=1
	           ORDER BY AutoID
	     END
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAreaLefts]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAreaLefts]
AS
BEGIN
		SELECT * FROM AreaLeft2 WHERE Status=1
		Order By OrderNo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_GetAreaRight]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_GetAreaRight]
AS

BEGIN
		SELECT * FROM AREARIGHT WHERE Status=1 
		ORDER BY OrderNo
END
GO
/****** Object:  StoredProcedure [dbo].[sp_NewRecord]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_NewRecord]
@status int,
@email nvarchar,
@sifre nvarchar,
@cinsiyet char,
@kampanya bit,
@kontrat bit
AS

BEGIN
		IF EXISTS (SELECT * FROM [User] WHERE @email=EmailAddress)
			BEGIN 
				
				PRINT 'Bu email adresi ile abonelik yapılmıştır.'
			END
		ELSE
			BEGIN
				INSERT INTO [User] (Status,EmailAddress,Password,Gender,Iscampaign,IsContract) VALUES (@status,@email,@sifre,@cinsiyet,@kampanya,@kontrat)
				PRINT 'Abonelik kaydınız yapılmıştır.'
			END
END
GO
/****** Object:  StoredProcedure [dbo].[TOPMENU]    Script Date: 1/26/2020 7:14:41 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TOPMENU]
AS
BEGIN
   SELECT * FROM MENU WHERE ParentMenuID IS NULL and Status=1
   ORDER BY AutoID
END
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=None,1=Active,2=Pasive,4=Deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaLeft2', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=None,1=Active,2=Pasive,4=Deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaRight', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=None,1=Active,2=Pasive,4=Deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'AreaRight'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=None,1=Active,2=Pasive,4=Deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'Menu', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'0=None,1=Active,2=Pasive,4=Deleted' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Status'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'Gender'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Seçildi=True,Seçilmedi=False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'IsCampaign'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'Sertifika Onaylandı=True,Onaylanmadı=False' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'User', @level2type=N'COLUMN',@level2name=N'IsContract'
GO
USE [master]
GO
ALTER DATABASE [TRENDYOL_DB] SET  READ_WRITE 
GO
