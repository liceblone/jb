USE [WMS_TMall]
GO
/*
drop table [TClient]
drop table [TinvMapping]
drop table [TLabelTemplate]
drop table [TOrderDL]
drop table [TOrderM] 
 
 */
 

/****** Object:  Table [dbo].[TLabelTemplate]    Script Date: 12/21/2019 09:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
 
GO
CREATE TABLE [dbo].[TLabelTemplate](
	[FTemplateID] [nvarchar](20) NOT NULL,
	[FTemplateName] [nvarchar](20) NOT NULL,  -- 新增
	-- [FClientID] [nvarchar](20) NULL, --- 去掉
	[FMinPkgTemplate] [nvarchar](20) NOT NULL,
	[FMiddlePkgTemplate] [nvarchar](20) NULL,
	[FLargePkgTemplate] [nvarchar](20) NULL,
	 [FScanOnly] [nvarchar](20) NULL,      
	[FLabelLocation] [nvarchar](20) NULL,
	[FVersion] timestamp,
	[FUpdateDate] [datetime]  default getdate(),
	[F_ID] [nvarchar](50) default newid(),
 CONSTRAINT [PK_TLabelTemplate] PRIMARY KEY CLUSTERED 
(
	[F_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TInvMapping]    Script Date: 12/21/2019 09:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TInvMapping](
	[FInvCode] [nvarchar](20)NOT NULL,
	[FHsBarCode] [nvarchar](20)NOT NULL,
	[FPartNo] [nvarchar](20) NOT NULL,
	[FBrand] [nvarchar](20) NULL,
	[FPack] [nvarchar](20) NULL,
	[FRsSurfix] [nvarchar](20) NULL,
	FInvTypeName [nvarchar](20) NULL,
	[FUnit] [nvarchar](20) NULL,
	[FMinPkgQty] [int] NULL,
	[FMiddlePkgQty] [int] NULL,
	[FLargePkgQty] [int] NULL,
	[FVersion] timestamp,
	[FUpdateDate] [datetime]  default getdate(),
	[F_ID] [nvarchar](50) default newid(),
 CONSTRAINT [PK_TInvMapping] PRIMARY KEY CLUSTERED 
(
	[F_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TClient]    Script Date: 12/21/2019 09:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TClient](
	[FClientID] [nvarchar](20)NOT NULL,
	[FClientName] [nvarchar](20)NOT NULL,
	[FNickName] [nvarchar](20) NULL,
	[FTemplateID] [nvarchar](20)   NULL,  --- 新增
	[FVersion] timestamp,
	[FUpdateDate] [datetime]  default getdate(),
	[F_ID] [nvarchar](50) default newid(),
 CONSTRAINT [PK_TClient] PRIMARY KEY CLUSTERED 
(
	[F_ID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOrderM]    Script Date: 12/21/2019 09:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOrderM](
	[FClientName] [nvarchar](20) NULL,
	[FClientID] [nvarchar](20) NOT NULL,
	[FOrderID] [nvarchar](20) NOT NULL,
	[FNote] [nvarchar](20) NULL,
	[Fdate] [nvarchar](20) NULL,
	[FOrderType] [nvarchar](20) NULL,
	[FTotalPlatQty] [int] NULL,
	[FTotalMiddlePkgQty] [int] NULL,
	[FTotalLargePkgQty] [int] NULL,
	[FisFinished] [nvarchar](20) NULL default 0,
	[FVersion] timestamp,
	[FUpdateDate] [datetime]  default getdate(),
	[F_ID] [nvarchar](50) default newid(),
 CONSTRAINT [PK_TOrderM] PRIMARY KEY CLUSTERED 
(
	[FOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TOrderDL]    Script Date: 12/21/2019 09:59:05 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TOrderDL](
	[FOrderID] [nvarchar](20) NOT NULL,
	[FOrderDLID] [nvarchar](20) NOT NULL,
	[FClientOrderNo] [nvarchar](20) NULL,
	[Fqty] [int]  NOT NULL,
	[FCltBarCode1] [nvarchar](20) NULL,
	[FCltBarCode2] [nvarchar](20) NULL,
	[FCltBarCode3] [nvarchar](20) NULL,
	[FCltInvCode] [nvarchar](20) NULL,
	[FInvCode] [nvarchar](20) NOT NULL,
	[FBrand] [nvarchar](20) NULL,
	[FPack] [nvarchar](20) NULL,
	[FRsSurfix] [nvarchar](20) NULL,
	[FUnit] [nvarchar](20) NULL,
	[FInvTypeName] [nvarchar](20) NULL,
	[FMinPkgQty] [int]    NULL,
	[FMiddlePkgQty] [int] NULL,
	[FLargePkgQty] [int] NULL,
	[FVerifiedQty] [int] NOT NULL default 0,
	[FScannedQty] [int] NOT NULL  default 0,
	[FTemplateID] [nvarchar](20) NULL,
	[FLabelLocation] [nvarchar](20) NULL,
	[FStartSequenceNum] [nvarchar](20) NULL,
	[FScanOnly] [nvarchar](20) NULL, 
	[FVersion] timestamp,
	[FUpdateDate] [datetime]  default getdate(),
	[F_ID] [nvarchar](50) default newid(),
 CONSTRAINT [PK_TOrderDL] PRIMARY KEY CLUSTERED 
(
	[FOrderDLID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK_TOrderDL_TOrderDL]    Script Date: 12/21/2019 09:59:05 ******/
ALTER TABLE [dbo].[TOrderDL]  WITH CHECK ADD  CONSTRAINT [FK_TOrderDL_TOrderDL] FOREIGN KEY([FOrderID])
REFERENCES [dbo].[TOrderM] ([FOrderID])
GO
ALTER TABLE [dbo].[TOrderDL] CHECK CONSTRAINT [FK_TOrderDL_TOrderDL]
GO

 