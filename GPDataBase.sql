USE [master]
GO
/****** Object:  Database [Grampanchayat]    Script Date: 22-06-2021 10:51:08 ******/
CREATE DATABASE [Grampanchayat]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Grampanchayat', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.Server\MSSQL\DATA\Grampanchayat.mdf' , SIZE = 73728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Grampanchayat_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.Server\MSSQL\DATA\Grampanchayat_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Grampanchayat] SET COMPATIBILITY_LEVEL = 140
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Grampanchayat].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Grampanchayat] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Grampanchayat] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Grampanchayat] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Grampanchayat] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Grampanchayat] SET ARITHABORT OFF 
GO
ALTER DATABASE [Grampanchayat] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Grampanchayat] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Grampanchayat] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Grampanchayat] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Grampanchayat] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Grampanchayat] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Grampanchayat] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Grampanchayat] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Grampanchayat] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Grampanchayat] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Grampanchayat] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Grampanchayat] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Grampanchayat] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Grampanchayat] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Grampanchayat] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Grampanchayat] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Grampanchayat] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Grampanchayat] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Grampanchayat] SET  MULTI_USER 
GO
ALTER DATABASE [Grampanchayat] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Grampanchayat] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Grampanchayat] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Grampanchayat] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Grampanchayat] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Grampanchayat', N'ON'
GO
ALTER DATABASE [Grampanchayat] SET QUERY_STORE = OFF
GO
USE [Grampanchayat]
GO
/****** Object:  UserDefinedTableType [dbo].[UT_House]    Script Date: 22-06-2021 10:51:11 ******/
CREATE TYPE [dbo].[UT_House] AS TABLE(
	[GrampanchayatName] [nvarchar](100) NULL,
	[HouseHeadName] [nvarchar](100) NULL,
	[PropertyNo] [nvarchar](50) NULL,
	[RegisterNo] [varchar](50) NULL,
	[RegisterYear] [int] NULL,
	[Area] [numeric](18, 2) NULL,
	[HomeTax] [numeric](18, 2) NULL,
	[LightTax] [numeric](18, 2) NULL,
	[HealthTax] [numeric](18, 2) NULL,
	[WaterTax] [numeric](18, 2) NULL,
	[BusinessTax] [numeric](18, 2) NULL,
	[ShopTax] [numeric](18, 2) NULL,
	[NoticeFee] [numeric](18, 2) NULL,
	[WarrantFee] [numeric](18, 2) NULL,
	[OtherTax] [numeric](18, 2) NULL,
	[HDescription] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[villagename] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedTableType [dbo].[UT_Resident]    Script Date: 22-06-2021 10:51:12 ******/
CREATE TYPE [dbo].[UT_Resident] AS TABLE(
	[GrampanchayatName] [nvarchar](50) NULL,
	[Title] [nvarchar](10) NULL,
	[FirstName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FatherName] [nvarchar](50) NULL,
	[MotherName] [nvarchar](50) NULL,
	[Gender] [nvarchar](10) NULL,
	[BithDate] [date] NULL,
	[BirthPlace] [nvarchar](10) NULL,
	[HouseNumber] [nvarchar](50) NULL,
	[AdharCardNumber] [nvarchar](50) NULL,
	[Address] [nvarchar](200) NULL,
	[IsActive] [bit] NULL,
	[MaritalStatus] [nvarchar](50) NULL,
	[PhyDisebleStatus] [nvarchar](50) NULL,
	[SpouseName] [nvarchar](10) NULL,
	[MobileNo] [nvarchar](50) NULL,
	[EmailId] [nvarchar](50) NULL,
	[VillageName] [nvarchar](50) NULL,
	[LoginPass] [nvarchar](50) NULL
)
GO
/****** Object:  UserDefinedFunction [dbo].[fun_CSVtoTable]    Script Date: 22-06-2021 10:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


create function [dbo].[fun_CSVtoTable](
 @csv nvarchar (4000),
 @Delimiter nvarchar (10)
 )
returns @returnValue table ([Item] nvarchar(4000))
begin
 declare @NextValue nvarchar(4000)
 declare @Position int
 declare @NextPosition int
 declare @comma nvarchar(1) 
 set @NextValue = ''
 set @comma = right(@csv,1)  
 set @csv = @csv + @Delimiter 
 set @Position = charindex(@Delimiter,@csv)
 set @NextPosition = 1 
 while (@Position <>  0)  
 begin
  set @NextValue = substring(@csv,1,@Position - 1) 
  insert into @returnValue ( [Item]) Values (@NextValue) 
  set @csv = substring(@csv,@Position +1,len(@csv))  
  set @NextPosition = @Position
  set @Position  = charindex(@Delimiter,@csv)
 end 
 return
end
GO
/****** Object:  UserDefinedFunction [dbo].[fun_QueryCSVColumn]    Script Date: 22-06-2021 10:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--create function dbo.fun_CSVtoTable(
-- @csv nvarchar (4000),
-- @Delimiter nvarchar (10)
-- )
--returns @returnValue table ([Item] nvarchar(4000))
--begin
-- declare @NextValue nvarchar(4000)
-- declare @Position int
-- declare @NextPosition int
-- declare @comma nvarchar(1) 
-- set @NextValue = ''
-- set @comma = right(@csv,1)  
-- set @csv = @csv + @Delimiter 
-- set @Position = charindex(@Delimiter,@csv)
-- set @NextPosition = 1 
-- while (@Position <>  0)  
-- begin
--  set @NextValue = substring(@csv,1,@Position - 1) 
--  insert into @returnValue ( [Item]) Values (@NextValue) 
--  set @csv = substring(@csv,@Position +1,len(@csv))  
--  set @NextPosition = @Position
--  set @Position  = charindex(@Delimiter,@csv)
-- end 
-- return
--end

create function [dbo].[fun_QueryCSVColumn](
 @csvColumn nvarchar (4000),
 @Delimiter nvarchar (2),
 @value nvarchar(4000),
 @search nvarchar(50) -- 'contains' | 'exact contains' | 'exact match'
 )
returns   nvarchar(1)
begin
declare @return varchar(1) = '0'
declare @table_ColumnValue table (value nvarchar(100))
declare @table_InputValue table (value nvarchar(100))
declare @joinCount int
declare @valuecount int
declare @Columnvaluecount int
insert into @table_ColumnValue  select distinct item from dbo.fun_CSVtoTable(@csvColumn,@Delimiter)
insert into @table_InputValue  select distinct item  from dbo.fun_CSVtoTable(@value,@Delimiter)
 select @joinCount =  count(*) from @table_ColumnValue a inner join  @table_InputValue b on a.value = b.value
 select @valuecount = count(*) from @table_InputValue
 select @Columnvaluecount = count(*) from @table_ColumnValue
 if(@search = 'contains') begin
 if @joinCount >0
 set @return = '1'  
 end
 else if (@search = 'exact contains')
 begin   
 if(@joinCount = @valuecount)
 set @return = '1' 
 end
else if (@search = 'exact match')
begin
 if( @joinCount = @valuecount and @joinCount= @Columnvaluecount )
 set @return ='1'
end 
 return @return
 
end
GO
/****** Object:  UserDefinedFunction [dbo].[StringSplit]    Script Date: 22-06-2021 10:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[StringSplit] (@sInputList varchar(8000),@Delimiter CHAR(1) = ',')      
       --(List of delimited items  ,delimiter that separates items)      
Returns @Return TABLE(Content Varchar(8000))      
AS      
BEGIN      
	--------------------------------------------------------------------------------------    
	DECLARE @Item Varchar(8000)      
	DECLARE @a AS Varchar(8000)      
	DECLARE @b AS Varchar(8000)      
	-----------------------------------------------------------------------------------------      
	WHILE CHARINDEX(@Delimiter,@sInputList,0) <> 0  ------chech the index of the Delimiter.    
	 BEGIN      
	 SELECT      
	       
	 @Item=RTRIM(LTRIM(SUBSTRING(@sInputList,1,CHARINDEX(@Delimiter,@sInputList,0)-1))),      
	 @sInputList=RTRIM(LTRIM(SUBSTRING(@sInputList,CHARINDEX(@Delimiter,@sInputList,0)+1,LEN(@sInputList))))      
	       
	 IF LEN(@Item) > 0      
	 INSERT INTO @Return(Content) VALUES(@Item)      
	 END      
	       
	 IF LEN(@sInputList) > 0      
	 INSERT INTO @Return VALUES(@sInputList)      

	 RETURN      
END
GO
/****** Object:  Table [dbo].[NoticeBoard]    Script Date: 22-06-2021 10:51:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NoticeBoard](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[Title] [nvarchar](500) NULL,
	[Description] [nvarchar](max) NULL,
	[InsertDate] [date] NULL,
	[ToDate] [date] NULL,
	[IsActive] [bit] NULL,
	[NoticeFor] [int] NULL,
	[Members] [varchar](max) NULL,
 CONSTRAINT [PK_NoticeBoard] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[VuNoticeBoard]    Script Date: 22-06-2021 10:51:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  CREATE VIEW [dbo].[VuNoticeBoard]
  as
  SELECT [ID]
      ,[GramPanchayatID]
      ,[Title]
      ,[Description]
      ,[InsertDate]
      ,[ToDate]
      ,[IsActive]
      ,[NoticeFor]
      ,[Members]
	  ,[Value]
  FROM [Grampanchayat].[dbo].[NoticeBoard] CROSS APPLY STRING_SPLIT([Members], ',');
GO
/****** Object:  Table [dbo].[AccountMapping]    Script Date: 22-06-2021 10:51:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AccountMapping](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatID] [int] NULL,
	[BillName] [varchar](50) NULL,
	[StaffID] [int] NULL,
	[MapKey] [varchar](100) NULL,
	[MapValue] [varchar](100) NULL,
	[IsActive] [bit] NULL,
	[UpdateDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BalanceAmount]    Script Date: 22-06-2021 10:51:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BalanceAmount](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatID] [int] NULL,
	[Amount] [numeric](10, 2) NULL,
	[UpdatedDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BirthMaster]    Script Date: 22-06-2021 10:51:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BirthMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ResidentID] [int] NULL,
	[GramPanchayatID] [int] NULL,
	[BirthDate] [date] NULL,
	[BirthPlace] [nvarchar](500) NULL,
	[PersonName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[MotherName] [nvarchar](50) NULL,
	[MotherAdhar] [nvarchar](20) NULL,
	[MotherEducation] [nvarchar](50) NULL,
	[MotherJob] [nvarchar](50) NULL,
	[MotherMarriageAge] [int] NULL,
	[FatherName] [nvarchar](50) NULL,
	[FatherAdhar] [nvarchar](20) NULL,
	[FatherEducation] [nvarchar](50) NULL,
	[FatherJob] [nvarchar](50) NULL,
	[CurrAddress] [nvarchar](50) NULL,
	[CurrVillage] [nvarchar](50) NULL,
	[CurrIsStayVillage] [bit] NULL,
	[CurrDisrict] [nvarchar](50) NULL,
	[CurrState] [nvarchar](50) NULL,
	[PerAddress] [nvarchar](50) NULL,
	[PerIsStayVillage] [bit] NULL,
	[PerVillage] [nvarchar](50) NULL,
	[PerDisrict] [nvarchar](50) NULL,
	[PerState] [nvarchar](50) NULL,
	[Religion] [nvarchar](50) NULL,
	[ChildCount] [int] NULL,
	[DeliveryPlace] [nvarchar](50) NULL,
	[DeliveryType] [nvarchar](50) NULL,
	[BabyWeight] [decimal](10, 2) NULL,
	[DeliveryDuration] [decimal](10, 2) NULL,
	[InformerName] [nvarchar](50) NULL,
	[InformerAdd] [nvarchar](50) NULL,
	[InformerSign] [nvarchar](50) NULL,
	[RegiNumber] [nvarchar](50) NULL,
	[RegiDate] [date] NULL,
	[RegiOrg] [nvarchar](50) NULL,
	[RegiCityVillage] [nvarchar](50) NULL,
	[RegiDistrict] [nvarchar](50) NULL,
	[RegiRemarks] [nvarchar](50) NULL,
	[RegiName] [nvarchar](50) NULL,
	[RegiCode] [nvarchar](50) NULL,
	[VillageName] [nvarchar](50) NULL,
	[VillageCode] [nvarchar](50) NULL,
	[TalukaName] [nvarchar](50) NULL,
	[TalukaCode] [nvarchar](50) NULL,
	[DistrictName] [nvarchar](50) NULL,
	[DistrictCode] [nvarchar](50) NULL,
	[HandoverDate] [date] NULL,
	[HandoverBy] [nvarchar](50) NULL,
	[HandoverByAdd] [nvarchar](50) NULL,
	[HandoverBySign] [nvarchar](50) NULL,
	[DocWrittenApp] [nvarchar](50) NULL,
	[DocGuaranteeApp] [nvarchar](50) NULL,
	[IsApprove] [int] NULL,
	[MotherId] [int] NULL,
	[FatherId] [int] NULL,
	[InsertDateTime] [datetime] NULL,
	[UpdateDateTime] [datetime] NULL,
 CONSTRAINT [PK__BirthMas__3214EC27F4AF7DD4] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ConsumableStockRegister_15]    Script Date: 22-06-2021 10:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ConsumableStockRegister_15](
	[ConsumableStockRegId] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatId] [int] NOT NULL,
	[Date] [date] NULL,
	[InitialRemain] [numeric](10, 2) NULL,
	[TotalCountOrConclusion] [nvarchar](200) NULL,
	[Total] [numeric](10, 2) NULL,
	[GivenToOrDate] [date] NULL,
	[GivenCountOrConclusion] [nvarchar](200) NULL,
	[Remain] [numeric](10, 2) NULL,
	[GivenBy] [nvarchar](250) NULL,
	[ReceivedBy] [nvarchar](250) NULL,
	[Remark] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Deleted] [bit] NULL,
	[InsertDateTime] [datetime] NULL,
	[InsertedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ConsumableStockRegId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DeathMaster]    Script Date: 22-06-2021 10:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DeathMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ResidentID] [int] NULL,
	[GramPanchayatID] [int] NULL,
	[DeathDate] [date] NULL,
	[PersonName] [nvarchar](50) NULL,
	[MotherName] [nvarchar](50) NULL,
	[MotherAdhar] [nvarchar](20) NULL,
	[FatherName] [nvarchar](50) NULL,
	[FatherAdhar] [nvarchar](20) NULL,
	[SpouseName] [nvarchar](50) NULL,
	[SpouseAdhar] [nvarchar](20) NULL,
	[CurrAddress] [nvarchar](50) NULL,
	[CurrVillage] [nvarchar](50) NULL,
	[CurrIsStayVillage] [bit] NULL,
	[CurrDisrict] [nvarchar](50) NULL,
	[CurrState] [nvarchar](50) NULL,
	[PerAddress] [nvarchar](50) NULL,
	[PerIsStayVillage] [bit] NULL,
	[PerVillage] [nvarchar](50) NULL,
	[PerDisrict] [nvarchar](50) NULL,
	[PerState] [nvarchar](50) NULL,
	[Age] [int] NULL,
	[AgeType] [nvarchar](20) NULL,
	[DeathPlaceType] [nvarchar](50) NULL,
	[DeathPlaceDetails] [nvarchar](50) NULL,
	[Religion] [nvarchar](50) NULL,
	[JobBusiness] [nvarchar](50) NULL,
	[MedicalTreatmentType] [nvarchar](50) NULL,
	[MedicalInstitutes] [nvarchar](50) NULL,
	[IsMedicallyCertified] [bit] NULL,
	[DeathReason] [nvarchar](50) NULL,
	[IsDeathDuringPregnancy] [bit] NULL,
	[PregnancyDetails] [nvarchar](50) NULL,
	[AddictionDetails] [nvarchar](50) NULL,
	[AddictionDuration] [nvarchar](50) NULL,
	[InformerName] [nvarchar](50) NULL,
	[InformerAdd] [nvarchar](50) NULL,
	[InformerSign] [nvarchar](50) NULL,
	[RegiNumber] [nvarchar](50) NULL,
	[RegiDate] [date] NULL,
	[RegiOrg] [nvarchar](50) NULL,
	[RegiCityVillage] [nvarchar](50) NULL,
	[RegiDistrict] [nvarchar](50) NULL,
	[RegiRemarks] [nvarchar](50) NULL,
	[RegisetrName] [nvarchar](50) NULL,
	[RegisetrCode] [nvarchar](50) NULL,
	[VillageName] [nvarchar](50) NULL,
	[VillageCode] [nvarchar](50) NULL,
	[TalukaName] [nvarchar](50) NULL,
	[TalukaCode] [nvarchar](50) NULL,
	[DistrictName] [nvarchar](50) NULL,
	[DistrictCode] [nvarchar](50) NULL,
	[HandoverDate] [date] NULL,
	[HandoverBy] [nvarchar](50) NULL,
	[HandoverByAdd] [nvarchar](50) NULL,
	[HandoverBySign] [nvarchar](50) NULL,
	[DocWrittenApp] [nvarchar](50) NULL,
	[DocGuaranteeApp] [nvarchar](50) NULL,
	[DocFuneralApp] [nvarchar](50) NULL,
	[IsApprove] [int] NULL,
	[IsActive] [bit] NULL,
	[InsertDateTime] [datetime2](7) NULL,
	[UpdateDateTime] [datetime] NULL,
 CONSTRAINT [PK_DeathMaster_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DemandBillDetails]    Script Date: 22-06-2021 10:51:14 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DemandBillDetails](
	[ID] [int] NOT NULL,
	[DemandBillMasterId] [int] NULL,
	[ResidentId] [int] NULL,
	[RaiseBy] [int] NULL,
	[Status] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[RaiseDate] [date] NULL,
	[PaidDate] [datetime] NULL,
	[Remark] [nvarchar](max) NULL,
	[GramPanchayatID] [int] NULL,
	[IsActive] [bit] NULL,
	[HouseID] [int] NULL,
 CONSTRAINT [PK__DemandBi__3214EC2742FDB856] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DemandBillMaster]    Script Date: 22-06-2021 10:51:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DemandBillMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[BillName] [nvarchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Designation]    Script Date: 22-06-2021 10:51:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Designation](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_Designation_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DisputeMaster]    Script Date: 22-06-2021 10:51:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DisputeMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatID] [int] NULL,
	[IsAgainstResident] [bit] NULL,
	[Subject] [nvarchar](100) NULL,
	[Details] [nvarchar](max) NULL,
	[ResidentID] [int] NULL,
	[StaffID] [int] NULL,
	[Documents] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[Status] [int] NULL,
	[RaiseDate] [date] NULL,
	[CloseDate] [date] NULL,
	[AdminRemark] [nvarchar](max) NULL,
	[ResidentRemark] [nvarchar](max) NULL,
	[UpdateDateTime] [datetime] NULL,
 CONSTRAINT [PK__DisputeM__3214EC27DC42BD75] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[EventManaging]    Script Date: 22-06-2021 10:51:15 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[EventManaging](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[EventTitle] [nvarchar](500) NULL,
	[EventDescription] [nvarchar](max) NULL,
	[EventFrom] [datetime] NULL,
	[EventTo] [datetime] NULL,
	[IsActive] [bit] NULL,
	[EventFor] [int] NULL,
 CONSTRAINT [PK__EventMan__3214EC2795FBA059] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ExceptionLog]    Script Date: 22-06-2021 10:51:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ExceptionLog](
	[ExceptionLogId] [int] IDENTITY(1,1) NOT NULL,
	[PROC_NAME] [varchar](max) NULL,
	[EERROR_NUMBER] [varchar](max) NULL,
	[EERROR_SEVERITY] [varchar](max) NULL,
	[EERROR_STATE] [varchar](max) NULL,
	[EERROR_PROCEDURE] [varchar](max) NULL,
	[EERROR_LINE] [varchar](max) NULL,
	[EERROR_MESSAGE] [varchar](max) NULL,
	[InsertDateTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[ExceptionLogId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GramPanchayat]    Script Date: 22-06-2021 10:51:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GramPanchayat](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramCode] [nvarchar](50) NULL,
	[VillageName] [nvarchar](50) NULL,
	[Block] [nvarchar](50) NULL,
	[District] [nvarchar](50) NULL,
	[State] [nvarchar](50) NULL,
	[Pincode] [nvarchar](50) NULL,
	[ContactNo] [nvarchar](50) NULL,
	[EmailID] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_GramPanchayat_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HeavyProductEntry_16]    Script Date: 22-06-2021 10:51:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HeavyProductEntry_16](
	[HeavyProductEntryId] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatId] [int] NULL,
	[Name] [nvarchar](50) NULL,
	[Description] [nvarchar](150) NULL,
	[PurchaseDate] [date] NULL,
	[PurchaseDetail] [nvarchar](150) NULL,
	[CountOrConclusion] [nvarchar](150) NULL,
	[Price] [numeric](10, 2) NULL,
	[StartApprovedBy] [int] NULL,
	[DisposeCountOrConclusion] [nvarchar](150) NULL,
	[DisposeCertificate] [nvarchar](150) NULL,
	[ReceivedAmount] [numeric](10, 2) NULL,
	[ReceivedDate] [date] NULL,
	[RemainAmount] [numeric](10, 2) NULL,
	[SarpanchId] [int] NULL,
	[EndApprovedBy] [int] NULL,
	[Remark] [nvarchar](150) NULL,
	[IsDelete] [bit] NULL,
	[IsActive] [bit] NULL,
	[InsertDateTime] [date] NULL,
	[InsertBy] [int] NULL,
 CONSTRAINT [PK_HeavyProductEntry_16] PRIMARY KEY CLUSTERED 
(
	[HeavyProductEntryId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[House]    Script Date: 22-06-2021 10:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[House](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[HouseHeadID] [int] NULL,
	[PropertyNo] [nvarchar](50) NULL,
	[RegisterNo] [nvarchar](50) NULL,
	[RegisterYear] [nvarchar](50) NULL,
	[Area] [decimal](10, 2) NULL,
	[HomeTax] [decimal](10, 2) NULL,
	[LightTax] [decimal](10, 2) NULL,
	[HealthTax] [decimal](10, 2) NULL,
	[WaterTax] [decimal](10, 2) NULL,
	[BusinessTax] [decimal](10, 2) NULL,
	[ShopTax] [decimal](10, 2) NULL,
	[NoticeFee] [decimal](10, 2) NULL,
	[WarrantFee] [decimal](10, 2) NULL,
	[OtherTax] [decimal](10, 2) NULL,
	[HDescription] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[VillageId] [int] NULL,
 CONSTRAINT [PK_House_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HouseTransfer]    Script Date: 22-06-2021 10:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HouseTransfer](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[HouseID] [int] NULL,
	[HouseHeadID] [int] NULL,
	[PropertyNo] [nvarchar](50) NULL,
	[RegisterNo] [nvarchar](50) NULL,
	[UpdaeDate] [datetime] NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_HouseTransfer_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MaritalStatus]    Script Date: 22-06-2021 10:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaritalStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_MaritalStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Marriage]    Script Date: 22-06-2021 10:51:17 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Marriage](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[MaleID] [int] NULL,
	[FemaleID] [int] NULL,
	[MarriageDate] [date] NULL,
	[MarriagePlace] [nvarchar](50) NULL,
	[VolumeNo] [nvarchar](50) NULL,
	[SerialNo] [nvarchar](50) NULL,
	[WeddPhoto] [nvarchar](150) NULL,
	[BoardPaper] [nvarchar](150) NULL,
	[MaleAdharPhoto] [nvarchar](150) NULL,
	[FemaleAdharPhoto] [nvarchar](150) NULL,
	[MalePanPhoto] [nvarchar](150) NULL,
	[FemalePanPhoto] [nvarchar](150) NULL,
	[WitnessSign] [nvarchar](150) NULL,
	[MaleBirthOrSchoolCert] [nvarchar](150) NULL,
	[FemaleBirthOrSchoolCert] [nvarchar](150) NULL,
	[ApprovDate] [date] NULL,
	[IsApprove] [int] NULL,
	[UpdateDateTime] [datetime] NULL,
 CONSTRAINT [PK_Marriage_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[NotificationMaster]    Script Date: 22-06-2021 10:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[NotificationMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatID] [int] NULL,
	[ResidentId] [int] NULL,
	[NotifDatetime] [datetime] NULL,
	[NotifType] [int] NULL,
	[NotifHeader] [nvarchar](100) NULL,
	[NotifDescription] [nvarchar](max) NULL,
	[IsView] [bit] NULL,
	[IsActive] [bit] NULL,
	[ControllerName] [varchar](50) NULL,
	[ActionName] [varchar](50) NULL,
 CONSTRAINT [PK_NotificationMaster_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Notifications]    Script Date: 22-06-2021 10:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Notifications](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatId] [int] NULL,
	[NotificationName] [nvarchar](150) NULL,
	[ControllerName] [nvarchar](50) NULL,
	[ActionName] [nvarchar](50) NULL,
	[Parameter] [int] NULL,
	[IsActive] [bit] NULL,
	[CreatedDate] [date] NULL,
 CONSTRAINT [PK__NOTIFICA__3214EC27D0A2E09D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OccasionDetails]    Script Date: 22-06-2021 10:51:18 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OccasionDetails](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[OccasionMasterId] [int] NULL,
	[PhotoName] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
	[ImagePath] [varchar](50) NULL,
 CONSTRAINT [PK_OccasionDetails_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[OccasionMaster]    Script Date: 22-06-2021 10:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[OccasionMaster](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatID] [int] NULL,
	[VillageId] [int] NULL,
	[SatffId] [int] NULL,
	[OccasionDate] [date] NULL,
	[OccasionName] [nvarchar](100) NULL,
	[OccasionDescription] [nvarchar](max) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_OccasionMaster_Id] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 22-06-2021 10:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[PaymentId] [int] IDENTITY(1,1) NOT NULL,
	[PaymentDate] [date] NULL,
	[HouseId] [int] NULL,
	[Amount] [decimal](10, 2) NULL,
	[IsActive] [bit] NULL,
	[UpdatedateTime] [datetime] NULL,
	[TranPayId] [varchar](100) NULL,
	[TranOrderId] [varchar](100) NULL,
	[Remark] [nvarchar](200) NULL,
	[GramPanchayatID] [int] NULL,
	[DemandBillMasterId] [int] NULL,
	[PayModeID] [int] NULL,
	[ResidentID] [int] NULL,
	[CreditNo] [int] NULL,
	[ChequeNumber] [int] NULL,
	[PersonName] [nvarchar](50) NULL,
	[ProductName] [nvarchar](50) NULL,
	[Count] [int] NULL,
	[Weight] [int] NULL,
	[Unit] [nvarchar](50) NULL,
	[IsCount] [bit] NULL,
	[CreditedApproveDate] [date] NULL,
	[IsCredit] [bit] NULL,
 CONSTRAINT [PK__Payment__9B556A38ABB5EB59] PRIMARY KEY CLUSTERED 
(
	[PaymentId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentMethod]    Script Date: 22-06-2021 10:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentMethod](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[PaymentName] [varchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PaymentModeMaster]    Script Date: 22-06-2021 10:51:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PaymentModeMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](100) NULL,
	[IsActive] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[PhysDisableStatus]    Script Date: 22-06-2021 10:51:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[PhysDisableStatus](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Categories] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
 CONSTRAINT [PK_PhysDisableStatus_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestCertificate]    Script Date: 22-06-2021 10:51:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestCertificate](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[ResidentID] [int] NULL,
	[GrampanchayatID] [int] NULL,
	[RequestFor] [int] NULL,
	[InsertDate] [date] NULL,
	[IsApprove] [int] NULL,
	[IsActive] [bit] NULL,
	[Remark] [varchar](200) NULL,
	[HouseID] [int] NULL,
	[SupportingDocument] [nvarchar](max) NULL,
	[RequestID] [int] NULL,
	[StaffApproveID] [int] NULL,
	[StaffApproveDate] [datetime] NULL,
	[AdminApproveID] [int] NULL,
	[AdminApproveDate] [datetime] NULL,
	[UpdateDateTime] [date] NULL,
 CONSTRAINT [PK__RequestC__3214EC272EDAC620] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestMaster]    Script Date: 22-06-2021 10:51:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CertificateName] [varchar](150) NULL,
	[IsActive] [bit] NULL,
	[IsDiffer] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Resident]    Script Date: 22-06-2021 10:51:20 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resident](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[Title] [nvarchar](50) NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[FatherID] [int] NULL,
	[MotherID] [int] NULL,
	[Gender] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[BirthPlace] [nvarchar](50) NULL,
	[HouseID] [int] NULL,
	[AdharCardNo] [nvarchar](50) NULL,
	[Address] [nvarchar](50) NULL,
	[LoginPass] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[MaritalStatusID] [int] NULL,
	[PhysDisableStatusID] [int] NULL,
	[SpouseID] [int] NULL,
	[SpouseName] [nvarchar](50) NULL,
	[FatherName] [nvarchar](50) NULL,
	[MotherName] [nvarchar](50) NULL,
	[MiddleName] [nvarchar](50) NULL,
	[MobileNo] [varchar](20) NULL,
	[EmailID] [varchar](50) NULL,
	[VillageId] [int] NULL,
 CONSTRAINT [PK_Resident_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RetailDemandRegisterr_11]    Script Date: 22-06-2021 10:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RetailDemandRegisterr_11](
	[RetailsDemandRegId] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatId] [int] NOT NULL,
	[SerialNumber] [int] NULL,
	[PersonName] [nvarchar](250) NULL,
	[PersonAddress] [nvarchar](250) NULL,
	[NatureofDemand] [nvarchar](250) NULL,
	[AuthorityforDemand] [nvarchar](250) NULL,
	[WeekofDemand] [numeric](10, 2) NULL,
	[AmountofDemand] [numeric](10, 2) NULL,
	[TotalAmountofDemand] [numeric](10, 2) NULL,
	[PaymentNumandDOB] [nvarchar](250) NULL,
	[AmountRecoveredReceiptNumandDate] [nvarchar](250) NULL,
	[RecoveredAmount] [numeric](10, 2) NULL,
	[DiscountOrderNumandDate] [nvarchar](250) NULL,
	[DiscountAmount] [numeric](10, 2) NULL,
	[Balance] [numeric](10, 2) NULL,
	[Shera] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Deleted] [bit] NULL,
	[InsertDateTime] [datetime] NULL,
	[InsertedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RetailsDemandRegId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Staff]    Script Date: 22-06-2021 10:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Staff](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[DesignationID] [int] NULL,
	[StartDate] [date] NULL,
	[EndDate] [date] NULL,
	[FirstName] [nvarchar](50) NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [nvarchar](50) NULL,
	[BirthDate] [date] NULL,
	[AdharCardNo] [nvarchar](50) NULL,
	[Address] [nvarchar](500) NULL,
	[IsActive] [bit] NULL,
	[LoginPass] [nvarchar](50) NULL,
	[EmailId] [nvarchar](50) NULL,
	[MobileNumber] [varchar](10) NULL,
	[GramPanchayatID] [int] NULL,
 CONSTRAINT [PK_Staff_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[StaffListRegister_13]    Script Date: 22-06-2021 10:51:21 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[StaffListRegister_13](
	[StaffListId] [int] IDENTITY(1,1) NOT NULL,
	[GrampanchayatId] [int] NOT NULL,
	[SerialNumber] [int] NULL,
	[Designation] [nvarchar](250) NULL,
	[NumberOfPost] [int] NULL,
	[ApprovedPostOrderNum&Date] [date] NULL,
	[PartTimeOrAnterior] [nvarchar](250) NULL,
	[Approvedpayscale] [nvarchar](250) NULL,
	[AssignedEmpName] [nvarchar](250) NULL,
	[AppointmentDate] [date] NULL,
	[SarpanchSignature] [nvarchar](250) NULL,
	[Signature] [nvarchar](250) NULL,
	[IsActive] [bit] NULL,
	[Deleted] [bit] NULL,
	[InsertDateTime] [datetime] NULL,
	[InsertedBy] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[StaffListId] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TaxMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TaxMaster](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[ResidentId] [int] NULL,
	[HouseId] [int] NULL,
	[GenYear] [int] NULL,
	[GenMonth] [int] NULL,
	[HomeTax] [decimal](10, 2) NULL,
	[LightTax] [decimal](10, 2) NULL,
	[HealthTax] [decimal](10, 2) NULL,
	[WaterTax] [decimal](10, 2) NULL,
	[BusinessTax] [decimal](10, 2) NULL,
	[ShopTax] [decimal](10, 2) NULL,
	[NoticeFee] [decimal](10, 2) NULL,
	[WarrantFee] [decimal](10, 2) NULL,
	[OtherTax] [decimal](10, 2) NULL,
	[Remark] [nvarchar](50) NULL,
	[IsActive] [bit] NULL,
	[InsertDateTime] [date] NULL,
	[PaidAmount] [decimal](10, 2) NULL,
	[TotalAmt]  AS (((((([LightTax]+[HealthTax])+[BusinessTax])+[ShopTax])+[NoticeFee])+[WarrantFee])+[OtherTax]),
	[HTPayId] [int] NULL,
	[WTPayId] [int] NULL,
	[OTPayId] [int] NULL,
 CONSTRAINT [PK_TaxMaster_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Village]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Village](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[GramPanchayatID] [int] NULL,
	[VillageName] [nvarchar](100) NULL,
	[AddressDetails] [nvarchar](100) NULL,
	[PinCode] [int] NULL,
	[IsActive] [bit] NULL,
	[InsertDateTime] [datetime] NULL,
	[EmailID] [varchar](50) NULL,
	[PhoneNumber] [nvarchar](50) NULL,
 CONSTRAINT [PK_Village_ID] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = ON, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 80) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[BirthMaster] ADD  CONSTRAINT [DF_BirthMaster_MotherId]  DEFAULT ((0)) FOR [MotherId]
GO
ALTER TABLE [dbo].[BirthMaster] ADD  CONSTRAINT [DF_BirthMaster_FatherId]  DEFAULT ((0)) FOR [FatherId]
GO
ALTER TABLE [dbo].[BirthMaster] ADD  CONSTRAINT [DF_BirthMaster_InsertDateTime]  DEFAULT (getdate()) FOR [InsertDateTime]
GO
ALTER TABLE [dbo].[DeathMaster] ADD  CONSTRAINT [DF__DeathMast__IsApp__1BC821DD]  DEFAULT ((0)) FOR [IsApprove]
GO
ALTER TABLE [dbo].[DeathMaster] ADD  CONSTRAINT [DF__DeathMast__IsAct__1CBC4616]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[DemandBillDetails] ADD  CONSTRAINT [DF__DemandBil__IsAct__1D4655FB]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[NoticeBoard] ADD  CONSTRAINT [DF_NoticeBoard_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [dbo].[NotificationMaster] ADD  DEFAULT (getdate()) FOR [NotifDatetime]
GO
ALTER TABLE [dbo].[NotificationMaster] ADD  DEFAULT ((0)) FOR [IsView]
GO
ALTER TABLE [dbo].[NotificationMaster] ADD  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF__NOTIFICAT__ISACT__6BE40491]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Notifications] ADD  CONSTRAINT [DF_NOTIFICATIONS_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
ALTER TABLE [dbo].[OccasionDetails] ADD  CONSTRAINT [DF_OccasionDetails_IsActive]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_UpdatedateTime]  DEFAULT (getdate()) FOR [UpdatedateTime]
GO
ALTER TABLE [dbo].[RequestCertificate] ADD  CONSTRAINT [DF_RequestCertificate_InsertDate]  DEFAULT (getdate()) FOR [InsertDate]
GO
ALTER TABLE [dbo].[Resident] ADD  CONSTRAINT [DF__Resident__IsActi__4AB81AF0]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Resident] ADD  CONSTRAINT [DF_Resident_MaritalStatusID]  DEFAULT ((1)) FOR [MaritalStatusID]
GO
ALTER TABLE [dbo].[Resident] ADD  CONSTRAINT [DF_Resident_PhysDisableStatusID]  DEFAULT ((1)) FOR [PhysDisableStatusID]
GO
ALTER TABLE [dbo].[Resident] ADD  CONSTRAINT [DF_Resident_SpouseID]  DEFAULT ((0)) FOR [SpouseID]
GO
ALTER TABLE [dbo].[Staff] ADD  CONSTRAINT [DF__Staff__IsActive__3A81B327]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TaxMaster] ADD  CONSTRAINT [DF__TaxMaster__IsAct__498EEC8D]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[TaxMaster] ADD  CONSTRAINT [DF__TaxMaster__Inser__4A8310C6]  DEFAULT (getdate()) FOR [InsertDateTime]
GO
ALTER TABLE [dbo].[Village] ADD  CONSTRAINT [DF__Village__IsActiv__1C873BEC]  DEFAULT ((1)) FOR [IsActive]
GO
ALTER TABLE [dbo].[Village] ADD  CONSTRAINT [DF__Village__InsertD__1D7B6025]  DEFAULT (getdate()) FOR [InsertDateTime]
GO
ALTER TABLE [dbo].[AccountMapping]  WITH CHECK ADD  CONSTRAINT [RK_AccountMapping_GrampanchayatID] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[AccountMapping] CHECK CONSTRAINT [RK_AccountMapping_GrampanchayatID]
GO
ALTER TABLE [dbo].[AccountMapping]  WITH CHECK ADD  CONSTRAINT [RK_AccountMapping_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[AccountMapping] CHECK CONSTRAINT [RK_AccountMapping_StaffID]
GO
ALTER TABLE [dbo].[BalanceAmount]  WITH CHECK ADD  CONSTRAINT [RK_BalanceAmount_GrampanchayatID] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[BalanceAmount] CHECK CONSTRAINT [RK_BalanceAmount_GrampanchayatID]
GO
ALTER TABLE [dbo].[BirthMaster]  WITH CHECK ADD  CONSTRAINT [RK_BirthMaster_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[BirthMaster] CHECK CONSTRAINT [RK_BirthMaster_GramPanchayatID]
GO
ALTER TABLE [dbo].[ConsumableStockRegister_15]  WITH CHECK ADD  CONSTRAINT [RK_15_ConsumableStockRegister_GrampanchayatId] FOREIGN KEY([GrampanchayatId])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[ConsumableStockRegister_15] CHECK CONSTRAINT [RK_15_ConsumableStockRegister_GrampanchayatId]
GO
ALTER TABLE [dbo].[DeathMaster]  WITH CHECK ADD  CONSTRAINT [RK_DeathMaster_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[DeathMaster] CHECK CONSTRAINT [RK_DeathMaster_GramPanchayatID]
GO
ALTER TABLE [dbo].[DeathMaster]  WITH CHECK ADD  CONSTRAINT [RK_DeathMaster_ResidentID] FOREIGN KEY([ResidentID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[DeathMaster] CHECK CONSTRAINT [RK_DeathMaster_ResidentID]
GO
ALTER TABLE [dbo].[DemandBillDetails]  WITH CHECK ADD  CONSTRAINT [RK_DemandBillDetails_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[DemandBillDetails] CHECK CONSTRAINT [RK_DemandBillDetails_GramPanchayatID]
GO
ALTER TABLE [dbo].[DemandBillDetails]  WITH CHECK ADD  CONSTRAINT [RK_DemandBillDetails_HouseID] FOREIGN KEY([HouseID])
REFERENCES [dbo].[House] ([ID])
GO
ALTER TABLE [dbo].[DemandBillDetails] CHECK CONSTRAINT [RK_DemandBillDetails_HouseID]
GO
ALTER TABLE [dbo].[DemandBillDetails]  WITH CHECK ADD  CONSTRAINT [RK_DemandBillDetails_RaiseBy] FOREIGN KEY([RaiseBy])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[DemandBillDetails] CHECK CONSTRAINT [RK_DemandBillDetails_RaiseBy]
GO
ALTER TABLE [dbo].[DemandBillDetails]  WITH CHECK ADD  CONSTRAINT [RK_DemandBillDetails_ResidentId] FOREIGN KEY([ResidentId])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[DemandBillDetails] CHECK CONSTRAINT [RK_DemandBillDetails_ResidentId]
GO
ALTER TABLE [dbo].[DisputeMaster]  WITH CHECK ADD  CONSTRAINT [RK_DisputeMaster_GrampanchayatID] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[DisputeMaster] CHECK CONSTRAINT [RK_DisputeMaster_GrampanchayatID]
GO
ALTER TABLE [dbo].[DisputeMaster]  WITH CHECK ADD  CONSTRAINT [RK_DisputeMaster_ResidentID] FOREIGN KEY([ResidentID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[DisputeMaster] CHECK CONSTRAINT [RK_DisputeMaster_ResidentID]
GO
ALTER TABLE [dbo].[DisputeMaster]  WITH CHECK ADD  CONSTRAINT [RK_DisputeMaster_StaffID] FOREIGN KEY([StaffID])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[DisputeMaster] CHECK CONSTRAINT [RK_DisputeMaster_StaffID]
GO
ALTER TABLE [dbo].[EventManaging]  WITH CHECK ADD  CONSTRAINT [RK_EventManaging_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[EventManaging] CHECK CONSTRAINT [RK_EventManaging_GramPanchayatID]
GO
ALTER TABLE [dbo].[HeavyProductEntry_16]  WITH CHECK ADD  CONSTRAINT [RK_HeavyProductEntry_16_GrampanchayatId] FOREIGN KEY([GrampanchayatId])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[HeavyProductEntry_16] CHECK CONSTRAINT [RK_HeavyProductEntry_16_GrampanchayatId]
GO
ALTER TABLE [dbo].[HeavyProductEntry_16]  WITH CHECK ADD  CONSTRAINT [RK_HeavyProductEntry_16_InsertBy] FOREIGN KEY([InsertBy])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[HeavyProductEntry_16] CHECK CONSTRAINT [RK_HeavyProductEntry_16_InsertBy]
GO
ALTER TABLE [dbo].[House]  WITH CHECK ADD  CONSTRAINT [FK_House_VillageId] FOREIGN KEY([VillageId])
REFERENCES [dbo].[Village] ([ID])
GO
ALTER TABLE [dbo].[House] CHECK CONSTRAINT [FK_House_VillageId]
GO
ALTER TABLE [dbo].[House]  WITH CHECK ADD  CONSTRAINT [RK_House_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[House] CHECK CONSTRAINT [RK_House_GramPanchayatID]
GO
ALTER TABLE [dbo].[HouseTransfer]  WITH CHECK ADD  CONSTRAINT [PK_HouseTransfer_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[HouseTransfer] CHECK CONSTRAINT [PK_HouseTransfer_GramPanchayatID]
GO
ALTER TABLE [dbo].[HouseTransfer]  WITH CHECK ADD  CONSTRAINT [PK_HouseTransfer_HouseHeadID] FOREIGN KEY([HouseHeadID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[HouseTransfer] CHECK CONSTRAINT [PK_HouseTransfer_HouseHeadID]
GO
ALTER TABLE [dbo].[Marriage]  WITH CHECK ADD  CONSTRAINT [Rk_Marriage_FemaleID] FOREIGN KEY([FemaleID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[Marriage] CHECK CONSTRAINT [Rk_Marriage_FemaleID]
GO
ALTER TABLE [dbo].[Marriage]  WITH CHECK ADD  CONSTRAINT [Rk_Marriage_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[Marriage] CHECK CONSTRAINT [Rk_Marriage_GramPanchayatID]
GO
ALTER TABLE [dbo].[Marriage]  WITH CHECK ADD  CONSTRAINT [Rk_Marriage_MaleID] FOREIGN KEY([MaleID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[Marriage] CHECK CONSTRAINT [Rk_Marriage_MaleID]
GO
ALTER TABLE [dbo].[NoticeBoard]  WITH CHECK ADD  CONSTRAINT [RK_NoticeBoard_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[NoticeBoard] CHECK CONSTRAINT [RK_NoticeBoard_GramPanchayatID]
GO
ALTER TABLE [dbo].[NotificationMaster]  WITH CHECK ADD  CONSTRAINT [FK_NotificationMaster_CompanyMasterId] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[NotificationMaster] CHECK CONSTRAINT [FK_NotificationMaster_CompanyMasterId]
GO
ALTER TABLE [dbo].[NotificationMaster]  WITH CHECK ADD  CONSTRAINT [FK_NotificationMaster_ResidentId] FOREIGN KEY([ResidentId])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[NotificationMaster] CHECK CONSTRAINT [FK_NotificationMaster_ResidentId]
GO
ALTER TABLE [dbo].[OccasionDetails]  WITH CHECK ADD  CONSTRAINT [FK_OccasionDetails_OccasionMasterId] FOREIGN KEY([OccasionMasterId])
REFERENCES [dbo].[OccasionMaster] ([Id])
GO
ALTER TABLE [dbo].[OccasionDetails] CHECK CONSTRAINT [FK_OccasionDetails_OccasionMasterId]
GO
ALTER TABLE [dbo].[OccasionMaster]  WITH CHECK ADD  CONSTRAINT [FK_OccasionMaster_CompanyMasterId] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[OccasionMaster] CHECK CONSTRAINT [FK_OccasionMaster_CompanyMasterId]
GO
ALTER TABLE [dbo].[OccasionMaster]  WITH CHECK ADD  CONSTRAINT [FK_OccasionMaster_CustomerMasterId] FOREIGN KEY([VillageId])
REFERENCES [dbo].[Village] ([ID])
GO
ALTER TABLE [dbo].[OccasionMaster] CHECK CONSTRAINT [FK_OccasionMaster_CustomerMasterId]
GO
ALTER TABLE [dbo].[OccasionMaster]  WITH CHECK ADD  CONSTRAINT [FK_OccasionMaster_StaffId] FOREIGN KEY([SatffId])
REFERENCES [dbo].[Staff] ([ID])
GO
ALTER TABLE [dbo].[OccasionMaster] CHECK CONSTRAINT [FK_OccasionMaster_StaffId]
GO
ALTER TABLE [dbo].[RequestCertificate]  WITH CHECK ADD  CONSTRAINT [RK_RequestCertificate_GrampanchayatID] FOREIGN KEY([GrampanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[RequestCertificate] CHECK CONSTRAINT [RK_RequestCertificate_GrampanchayatID]
GO
ALTER TABLE [dbo].[RequestCertificate]  WITH CHECK ADD  CONSTRAINT [RK_RequestCertificate_HouseID] FOREIGN KEY([HouseID])
REFERENCES [dbo].[House] ([ID])
GO
ALTER TABLE [dbo].[RequestCertificate] CHECK CONSTRAINT [RK_RequestCertificate_HouseID]
GO
ALTER TABLE [dbo].[RequestCertificate]  WITH CHECK ADD  CONSTRAINT [RK_RequestCertificate_RequestFor] FOREIGN KEY([RequestFor])
REFERENCES [dbo].[RequestMaster] ([ID])
GO
ALTER TABLE [dbo].[RequestCertificate] CHECK CONSTRAINT [RK_RequestCertificate_RequestFor]
GO
ALTER TABLE [dbo].[RequestCertificate]  WITH CHECK ADD  CONSTRAINT [RK_RequestCertificate_ResidentID] FOREIGN KEY([ResidentID])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[RequestCertificate] CHECK CONSTRAINT [RK_RequestCertificate_ResidentID]
GO
ALTER TABLE [dbo].[Resident]  WITH CHECK ADD  CONSTRAINT [FK_Resident_VillageId] FOREIGN KEY([VillageId])
REFERENCES [dbo].[Village] ([ID])
GO
ALTER TABLE [dbo].[Resident] CHECK CONSTRAINT [FK_Resident_VillageId]
GO
ALTER TABLE [dbo].[Resident]  WITH CHECK ADD  CONSTRAINT [RK_Resident_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[Resident] CHECK CONSTRAINT [RK_Resident_GramPanchayatID]
GO
ALTER TABLE [dbo].[Resident]  WITH CHECK ADD  CONSTRAINT [RK_Resident_MaritalStatusID] FOREIGN KEY([MaritalStatusID])
REFERENCES [dbo].[MaritalStatus] ([ID])
GO
ALTER TABLE [dbo].[Resident] CHECK CONSTRAINT [RK_Resident_MaritalStatusID]
GO
ALTER TABLE [dbo].[Resident]  WITH CHECK ADD  CONSTRAINT [RK_Resident_PhysDisableStatusID] FOREIGN KEY([PhysDisableStatusID])
REFERENCES [dbo].[PhysDisableStatus] ([ID])
GO
ALTER TABLE [dbo].[Resident] CHECK CONSTRAINT [RK_Resident_PhysDisableStatusID]
GO
ALTER TABLE [dbo].[RetailDemandRegisterr_11]  WITH CHECK ADD  CONSTRAINT [RK_RetailDemandRegisterr_11_GrampanchayatId] FOREIGN KEY([GrampanchayatId])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[RetailDemandRegisterr_11] CHECK CONSTRAINT [RK_RetailDemandRegisterr_11_GrampanchayatId]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [PK_Staff_DesignationID] FOREIGN KEY([DesignationID])
REFERENCES [dbo].[Designation] ([ID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [PK_Staff_DesignationID]
GO
ALTER TABLE [dbo].[Staff]  WITH CHECK ADD  CONSTRAINT [RK_Staff_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[Staff] CHECK CONSTRAINT [RK_Staff_GramPanchayatID]
GO
ALTER TABLE [dbo].[StaffListRegister_13]  WITH CHECK ADD  CONSTRAINT [RK_StaffListRegister_13_GrampanchayatId] FOREIGN KEY([GrampanchayatId])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[StaffListRegister_13] CHECK CONSTRAINT [RK_StaffListRegister_13_GrampanchayatId]
GO
ALTER TABLE [dbo].[TaxMaster]  WITH CHECK ADD  CONSTRAINT [RK_TaxMaster_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[TaxMaster] CHECK CONSTRAINT [RK_TaxMaster_GramPanchayatID]
GO
ALTER TABLE [dbo].[TaxMaster]  WITH CHECK ADD  CONSTRAINT [RK_TaxMaster_ResidentId] FOREIGN KEY([ResidentId])
REFERENCES [dbo].[Resident] ([ID])
GO
ALTER TABLE [dbo].[TaxMaster] CHECK CONSTRAINT [RK_TaxMaster_ResidentId]
GO
ALTER TABLE [dbo].[Village]  WITH CHECK ADD  CONSTRAINT [FK_Village_GramPanchayatID] FOREIGN KEY([GramPanchayatID])
REFERENCES [dbo].[GramPanchayat] ([ID])
GO
ALTER TABLE [dbo].[Village] CHECK CONSTRAINT [FK_Village_GramPanchayatID]
GO
/****** Object:  StoredProcedure [dbo].[SP_AccountMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[SP_AccountMaster]
(
@Action int=null,
@ID int=null,
@GrampanchayatID int=null,
@BillName varchar(50)=null,
@StaffID int=null,
@StaffName varchar(50)=null,
@MapKey varchar(100)=null,
@MapValue varchar(100)=null,
@IsActive bit=null,
@HouseId int=null,
@Amount decimal=null,
@DemandBillMasterId int=null,
@PaymentId int=null,
@TranPayId varchar(80)=null,
@TranOrderId varchar(80)=null,
@ResidentId int=null
)
AS
BEGIN
	IF @Action=1
		BEGIN
			Select AM.ID,BillName,S.FirstName+' '+S.LastName'Staff Name',MapKey,MapValue,AM.IsActive
			 from AccountMapping AM WITH (NOLOCK)
			left join Staff S on S.ID=AM.StaffID
			where AM.GrampanchayatID=@GrampanchayatID
		END
	IF @Action=2
		BEGIN
			update AccountMapping 
			set
			MapKey=@MapKey,
			MapValue=@MapValue
			,UpdateDateTime=GETDATE()
			,StaffID=@StaffID
			where ID=@ID
		END
	IF @Action=3
		BEGIN
			Select AM.ID,MapKey,MapValue,AM.IsActive
			 from AccountMapping AM WITH (NOLOCK)
			left join Staff S on S.ID=AM.StaffID
			where AM.ID=@ID
		END
	IF @Action=4
		BEGIN
			insert into Payment(PaymentDate,HouseId,Amount,PayModeID,IsActive,UpdatedateTime,Remark,GramPanchayatID,DemandBillMasterId)
			values(getdate(),@HouseId,@Amount,7,1,getdate(),'Razor-Pay Online Payment',@GramPanchayatID,@DemandBillMasterId)
			select @PaymentId = IDENT_CURRENT('Payment')
			select @PaymentId
		END
	IF @Action=5
		BEGIN
			update Payment set 
			TranPayId=@TranPayId,
			TranOrderId=@TranOrderId,
			UpdatedateTime=GETDATE()
			where PaymentId=@PaymentId

			if @DemandBillMasterId=2
				begin
					update TaxMaster
					set HTPayId=@PaymentId
					where isnull(HTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=3
				begin
					update TaxMaster
					set WTPayId=@PaymentId
					where isnull(WTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=4
				begin
					update TaxMaster
					set OTPayId=@PaymentId
					where isnull(OTPayId,0)=0 and HouseId=@HouseId
				end
		END

	IF @Action=6
		BEGIN
			insert into Payment(PaymentDate,HouseId,Amount,PayModeID,IsActive,UpdatedateTime,Remark,GramPanchayatID,DemandBillMasterId)
			values(getdate(),@HouseId,@Amount,7,1,getdate(),'Razor-Pay Online Payment',@GramPanchayatID,@DemandBillMasterId)
			select @PaymentId = IDENT_CURRENT('Payment')
			select @PaymentId

			update Payment set 
			TranPayId=@TranPayId,
			TranOrderId=@TranOrderId,
			UpdatedateTime=GETDATE()
			where PaymentId=@PaymentId

			if @DemandBillMasterId=2
				begin
					update TaxMaster
					set HTPayId=@PaymentId
					where isnull(HTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=3
				begin
					update TaxMaster
					set WTPayId=@PaymentId
					where isnull(WTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=4
				begin
					update TaxMaster
					set OTPayId=@PaymentId
					where isnull(OTPayId,0)=0 and HouseId=@HouseId
				end
				end
	IF @Action=7
		BEGIN
			insert into Payment(PaymentDate,HouseId,Amount,PayModeID,IsActive,UpdatedateTime,Remark,GramPanchayatID,DemandBillMasterId,TranPayId,TranOrderId)
			values(getdate(),@HouseId,@Amount,7,1,getdate(),'Razor-Pay Online Payment',@GramPanchayatID,@DemandBillMasterId,@TranPayId,@TranOrderId)
	         select @PaymentId = IDENT_CURRENT('Payment')
			select @PaymentId

			update DemandBillDetails
			   set PaidDate=getdate(),
			       Amount='0',
				   Status=1
			where ResidentId=@ResidentId  and HouseId=@HouseId and DemandBillMasterId=@DemandBillMasterId
			
			if @DemandBillMasterId=2
				begin
					update TaxMaster
					set HTPayId=@PaymentId
					where isnull(HTPayId,0)=0 and HouseId=@HouseId and ResidentId=@ResidentId 
				end
			else if @DemandBillMasterId=3
				begin
					update TaxMaster
					set WTPayId=@PaymentId
					where isnull(WTPayId,0)=0 and HouseId=@HouseId and ResidentId=@ResidentId
				end
			else if @DemandBillMasterId=4
				begin
					update TaxMaster
					set OTPayId=@PaymentId
					where isnull(OTPayId,0)=0 and HouseId=@HouseId and ResidentId=@ResidentId
				end
			end
END



--select * from Resident where id=12 and HouseID=312

--update DemandBillDetails set DemandBillMasterId=3,PaidDate=null,Amount=100,Status=0 where id=79
GO
/****** Object:  StoredProcedure [dbo].[SP_CashBook_5]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE procedure [dbo].[SP_CashBook_5]
(
@Action int=null,
@PaymentID int=null,
@HouseID int=null,
@Amount decimal(10,2)=null,
@IsActive bit=null,
@UpdateDateTime datetime=null,
@Remark nvarchar(100)=null,
@GrampanchayatID int=null,
@DemandBillMasterID int=null,
@PayModeID int=null,
@ResidentID int=null,
@CreditNo int=null,
@ChequeNumber int=null,
@PersonName nvarchar(50)=null,
@CreditedApproveDate date=null,
@IsCredited bit=null,
@BalanceAmount numeric(10,2)=null,
@ChequeCreditID nvarchar(50)=null,
@ProductName nvarchar(50)=null,
@Count int=null,
@Weight int=null,
@Unit nvarchar(50)=null,
@IsCount bit=null,
@Fromdate date=null,
@Todate date=null
)
AS
BEGIN
	IF @Action=1--LIST(Index)
		BEGIN
			Select PaymentId,H.PropertyNo,isnull(R.FirstName+' '+R.LastName,''),Amount,Isnull(cast(IsCredit as int),0),
			cast(PaymentDate as nvarchar(50)) from Payment P
			left join Resident R on R.ID=P.ResidentID
			left join House h on H.ID=P.HouseId
			where P.PaymentDate between @Fromdate and @Todate
		END
	IF @Action=2--DETAIL
		BEGIN
			Select PaymentId,G.VillageName,H.PropertyNo,isnull(R.FirstName+' '+R.LastName,''),Amount,isnull(TranPayId,''),isnull(TranOrderId,'')
			,Remark,isnull(D.BillName,''),isnull(PM.PaymentName,''),isnull(CreditNo,0),isnull(ChequeNumber,0),isnull(PersonName,''),
			isnull(cast(CreditedApproveDate as nvarchar(50)),'9999-99-99')
			,Isnull(cast(IsCredit as int),0),cast(PaymentDate as nvarchar(50)),isnull(ProductName,''),Isnull([Count],0),Isnull([Weight],0)
			,Isnull(unit,''),Isnull(cast(IsCount as int),0) from Payment P
			left join Resident R on R.ID=P.ResidentID
			left join House h on H.ID=P.HouseId
			left join GramPanchayat G on G.ID=P.GramPanchayatID
			left join DemandBillMaster D on D.ID=P.DemandBillMasterId
			left join PaymentMethod PM on PM.ID=P.PayModeID
			where PaymentId=@PaymentID
		END
	IF @Action=3--Get balance Amount
		BEGIN
			select @BalanceAmount=Amount from BalanceAmount
			select @BalanceAmount
		END
	IF @Action=4--Create 
		BEGIN
			select @HouseID=HouseID from Resident where ID=@ResidentID

			Insert into Payment(PaymentDate,HouseId,Amount,IsActive,UpdatedateTime,Remark,GramPanchayatID,DemandBillMasterId
			,PayModeID,ResidentID,CreditNo,ChequeNumber,PersonName,IsCredit,ProductName,[Count],[Weight],Unit,IsCount)
			values
			(GETDATE(),@HouseID,@Amount,1,GETDATE(),@Remark,@GrampanchayatID,@DemandBillMasterID,@PayModeID,@ResidentID,@CreditNo
			,@ChequeNumber,@PersonName,@IsCredited,@ProductName,@Count,@Weight,@Unit,@IsCount)

			 set @PaymentId = IDENT_CURRENT('Payment')   


			if @DemandBillMasterId=2 AND @IsCredited = 1 
				begin
					update TaxMaster
					set HTPayId=@PaymentId
					where isnull(HTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=3 AND @IsCredited = 1 
				begin
					update TaxMaster
					set WTPayId=@PaymentId
					where isnull(WTPayId,0)=0 and HouseId=@HouseId
				end
			else if @DemandBillMasterId=4 AND @IsCredited = 1 
				begin
					update TaxMaster
					set OTPayId=@PaymentId
					where isnull(OTPayId,0)=0 and HouseId=@HouseId
				end

			IF @IsCredited = 1 AND @PayModeID = 1
			BEGIN
				select @BalanceAmount=Amount from BalanceAmount

				update BalanceAmount
				set
				Amount=@BalanceAmount+@Amount,
				UpdatedDate=GETDATE()
			END

			IF @IsCredited = 0 AND @PayModeID = 1
			BEGIN
				select @BalanceAmount=Amount from BalanceAmount

				update BalanceAmount
				set
				Amount=@BalanceAmount-@Amount,
				UpdatedDate=GETDATE()
			END
		END
	IF @Action=5--ResidentDropdown
		BEGIN
			Select ID,FirstName+' '+LastName from Resident
		END
	IF @Action=6--BillDropdown
		BEGIN
			Select ID,BillName from DemandBillMaster
		END
	IF @Action=7--PaymentName
		BEGIN
			Select ID,PaymentName from PaymentMethod
		END
	IF @Action=8--Cheque Approve INDEX
		BEGIN
			select PaymentId,isnull(R.FirstName+' '+R.LastName,''),isnull(PersonName,''),Amount,isnull(ChequeNumber,0),cast(CreditedApproveDate as nvarchar(50)) from Payment P
			left join Resident R on R.ID=P.ResidentID
			where CreditedApproveDate is not null
		END
	IF @Action=9
		BEGIN
			select PaymentId,isnull(ChequeNumber,0) from Payment where CreditedApproveDate is null AND PayModeID=3
		END
	IF @Action=10
		BEGIN
			update Payment
			set CreditedApproveDate = @CreditedApproveDate
			where PaymentId in (@ChequeCreditID)
		END
	IF @Action=11
		BEGIN
			Select G.VillageName,G.District,isnull(PersonName,''),isnull(ProductName,''),isnull([Count],0),isnull([Weight],0),isnull(Unit,''),
			isnull(Amount,0),cast(ISNULL(IsCount,0) as int),cast(GETDATE() as varchar(50)) from Payment P
			 join Grampanchayat G on G.ID=P.GramPanchayatID
			where PaymentId=@PaymentID
		END
	IF @Action=12--INDEX OF N-6
		BEGIN
			Select PaymentId,cast(PaymentDate as varchar(50)),H.PropertyNo,
			isnull(PersonName,''),Amount,cast(isnull(IsCredit,0) as int) 
			from Payment P
			left join House H on H.ID=P.HouseId
			where P.PaymentDate between @Fromdate and @Todate
		END
	IF @Action=13--Excel Report
		BEGIN
			Select PaymentId,G.VillageName,H.PropertyNo,isnull(R.FirstName+' '+R.LastName,''),Amount,isnull(TranPayId,''),isnull(TranOrderId,'')
			,Remark,isnull(D.BillName,''),isnull(PM.PaymentName,''),isnull(CreditNo,0),isnull(ChequeNumber,0),isnull(PersonName,''),
			isnull(cast(CreditedApproveDate as nvarchar(50)),'9999-99-99')
			,Isnull(cast(IsCredit as int),0),cast(PaymentDate as nvarchar(50)),isnull(ProductName,''),Isnull([Count],0),Isnull([Weight],0)
			,Isnull(unit,''),Isnull(cast(IsCount as int),0) from Payment P
			left join Resident R on R.ID=P.ResidentID
			left join House h on H.ID=P.HouseId
			left join GramPanchayat G on G.ID=P.GramPanchayatID
			left join DemandBillMaster D on D.ID=P.DemandBillMasterId
			left join PaymentMethod PM on PM.ID=P.PayModeID
			where P.PaymentDate between @Fromdate and @Todate
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Dashboard]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_Dashboard]
(
@Action int=null,
@HouseID int=null,
@ResidentID int=null,
 @Hometax decimal=null,
  @WaterTax decimal=null,
   @OtherTax decimal=null
)
AS
BEGIN
	IF @Action=1--TOTAL PENDING TAXES
		BEGIN
			SELECT    sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))  from TaxMaster TM-- where IsPaid=0
		END
	IF @Action=2--TOTAL NO OF HOUSE
		BEGIN
			SELECT COUNT(ID) from House
		END
	IF @Action=3--PENDING REQUESTS
		BEGIN
			SELECT COUNT(Id) FROM RequestCertificate WHERE IsApprove=0 
		END
	IF @Action=4--TOTAL REQUEST
		BEGIN
			SELECT COUNT(Id) FROM RequestCertificate WHERE IsActive=1 
		END
	IF @Action=5--ALL Notification
		BEGIN
			SELECT Parameter'Person ID',ControllerName'Form Name',CreatedDate'Requested Date' from Notifications order by [Requested Date] asc
		END
	IF @Action=6--TOTAL Taxes
		BEGIN
				 begin		
				      Select  * from(
                             select top 5 
                             isnull(RS.FirstName+' '+RS.LastName ,'')'ReisdentName',
                            isnull(HO.PropertyNo,'')PropertyNo,isnull(HO.RegisterNo,'')RegisterNo,
                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0)) 'HomeTax',
                             sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0)) 'WaterTax',
                             sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'OtherTax',

                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'AllPending'
                             from House HO WITH(NOLOCK)
                             join Resident RS on RS.ID=HO.HouseHeadID --and HO.ID=@HouseId
                             left join TaxMaster  TM on TM.HouseId=Ho.ID and TM.ResidentId=RS.ID and TM.IsActive=1
                        group by RS.ID,RS.FirstName,RS.LastName,HO.PropertyNo,HO.RegisterNo,HO.ID,TM.HTPayId,TM.WTPayId,TM.OTPayId,TM.GramPanchayatID)a1
						order by AllPending desc
			--where IsPaid=0
		END
		END
	If @Action = 7
	  Begin	     	 
	     Select    
		 (SELECT COUNT(Id) FROM Notifications WHERE IsActive=1)'Pending',
		 (SELECT COUNT(Id) FROM Notifications WHERE IsActive=0)'Resolved',
		 (SELECT COUNT(Id) FROM Notifications) 'All'
		 into #Temp
		 
		 select * from #Temp  
	  end
	    If @Action = 8
	  Begin	     	 
	      SELECT 'TotalPendingTaxexs' as 'Name',Cast(sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
		   + sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
		   + sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))as int) 'VALUE' from TaxMaster TM-- where IsPaid=0 ---TOTAL PENDING TAXES
		union all
		   SELECT 'TotalNoOfHouse' as 'Name',CAST(COUNT(ID)as int)'VALUE'  from House --TOTAL NO OF HOUSE
		union all 
		   SELECT 'PndingRequest' as 'Name',CAST(COUNT(Id)as int)'VALUE' from RequestCertificate WHERE IsApprove=0 --PENDING REQUESTS
		union all
		   SELECT 'TotalRequest' as 'Name',CAST (COUNT(Id)as int)'VALUE'  FROM RequestCertificate WHERE IsActive=1  --TOTAL REQUEST
	  end
--============================================================NOTICE==========================================================================
		IF @Action=9
		BEGIN
			Select top 3 Title,Description,cast(InsertDate as varchar(50))InsertDate,cast(ToDate as varchar(50))ToDate from NoticeBoard where ToDate >= GETDATE() and (NoticeFor=2 OR NoticeFor=3 ) 
		END
--============================================================Event==========================================================================
		IF @Action=10
		BEGIN
			SELECT top 3 EventTitle,EventDescription,cast(EventFrom as varchar(50))EventFrom,cast(EventTo as varchar(50))EventTo from EventManaging
			 where EventTo >= GETDATE() and (EventFor=2 or EventFor=3)
		END

--============================================================Pending Tax==========================================================================
		IF @Action=11
		BEGIN


			SELECT @Hometax=isnull(sum(HomeTax),0) from TaxMaster where HTPayId is null and HouseId=@HouseID
			SELECT @WaterTax=isnull(sum(WaterTax),0) from TaxMaster where WTPayId is null and HouseId=@HouseID
			SELECT @OtherTax=isnull(sum(TotalAmt),0) from TaxMaster where OTPayId is null and HouseId=@HouseID

			select @Hometax'HomeTax',@WaterTax'WaterTax',@OtherTax'OtherTAx'
		END
--================================================================Certificate Requests==================================================================
	IF @Action=12
	BEGIN
			select rc.ID,rm.CertificateName,IsApprove,Remark from RequestCertificate RC
			join RequestMaster RM on rm.ID=rc.RequestFor
			 where HouseID=@HouseID
	end
--================================================================Dispute==================================================================
	IF @Action=13
	BEGIN
			select top 3 DM.ID,Subject,Details,Status,AdminRemark from DisputeMaster DM
			where ResidentID=@ResidentID and CloseDate is null and IsAgainstResident=1
	end

--================================================================Demand==================================================================
	IF @Action=14
	BEGIN
			select top 6 DBD.ID,DBM.BillName,Status,Amount,cast(RaiseDate as varchar(15))RaiseDate from DemandBillDetails DBD
			join DemandBillMaster DBM on DBM.ID=DBD.DemandBillMasterId
			 where HouseID=@HouseID and PaidDate is null
	end
--================================================================Pending Payment=========================================================================
	IF @Action=15
	BEGIN
		SELECT @Hometax=isnull(sum(HomeTax),0) from TaxMaster where HTPayId is null
			SELECT @WaterTax=isnull(sum(WaterTax),0) from TaxMaster where WTPayId is null
			SELECT @OtherTax=isnull(sum(TotalAmt),0) from TaxMaster where OTPayId is null 

			select @Hometax'HomeTax',@WaterTax'WaterTax',@OtherTax'OtherTAx'
	END
--================================================================Payed Payment=========================================================================
	IF @Action=16
	BEGIN

		SELECT @Hometax=isnull(sum(HomeTax),0) from TaxMaster where HTPayId is not null
			SELECT @WaterTax=isnull(sum(WaterTax),0) from TaxMaster where WTPayId is not null
			SELECT @OtherTax=isnull(sum(TotalAmt),0) from TaxMaster where OTPayId is not null 
			select @Hometax'HomeTax',@WaterTax'WaterTax',@OtherTax'OtherTAx'
	END
--=================================================================Certificate Request============================================================================
IF @Action=17
BEGIN

declare @ResidentCertificate int=null,@NoDuesCertificate int=null,@ToiletCertificate int=null,@BirthCertificate int=null,
@MarriageCertificate int=null,@DeathCertificate int=null

select @ResidentCertificate= COUNT(ID) from RequestCertificate where RequestFor=1 and IsApprove=0
select @NoDuesCertificate= COUNT(ID) from RequestCertificate where RequestFor=2 and IsApprove=0
select @ToiletCertificate= COUNT(ID) from RequestCertificate where RequestFor=3 and IsApprove=0
select @BirthCertificate= COUNT(ID) from RequestCertificate where RequestFor=4 and IsApprove=0
select @MarriageCertificate= COUNT(ID) from RequestCertificate where RequestFor=5 and IsApprove=0
select @DeathCertificate= COUNT(ID) from RequestCertificate where RequestFor=6 and IsApprove=0

select @ResidentCertificate'ResidentCertificate',@NoDuesCertificate'NoDuesCertificate',@ToiletCertificate'ToiletCertificate',@BirthCertificate'BirthCertificate',@MarriageCertificate'MarriageCertificate',@DeathCertificate'DeathCertificate'
END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_DemandBill]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_DemandBill] --14
(
@Action int=null,
@DemandBillMasterID int=null,
@DemandBillName nvarchar(100)=null,
@DemandBillDetailID int=null,
@ResidentID int=null,
@RaisedByID int=null,
@Status int=null,
@Amount decimal(10,2)=null,
@RaisedDate datetime=null,
@PaidDate datetime=null,
@SearchText nvarchar(100)=null,
@ID int=null,
@HomeTax decimal(10,2)=null,
@LightTax decimal(10,2)=null,
@HealthTax decimal(10,2)=null,
@WaterTax decimal(10,2)=null,
@BusinessTax decimal(10,2)=null,
@ShopTax decimal(10,2)=null,
@NoticeFee decimal(10,2)=null,
@WarrantFee decimal(10,2)=null,
@OtherTax decimal(10,2)=null,
@TotalAmount decimal(10,2)=null,
@HomeTaxC decimal(10,2)=null,
@LightTaxC decimal(10,2)=null,
@HealthTaxC decimal(10,2)=null,
@WaterTaxC decimal(10,2)=null,
@BusinessTaxC decimal(10,2)=null,
@ShopTaxC decimal(10,2)=null,
@NoticeFeeC decimal(10,2)=null,
@WarrantFeeC decimal(10,2)=null,
@OtherTaxC decimal(10,2)=null,
@TotalAmountC decimal(10,2)=null,
@HouseID int=null,
@GramPanchayatId int=null,
@Fromdate date=null,
@Todate date=null,
@Residentname varchar(200)=null
)
AS
BEGIN
	IF @Action=1
		BEGIN

					select * into #Res from Resident
					Select  R.ID,isnull(R.HouseID,0),isnull(CAST(R.Title as varchar(50)),'')+' '+isnull(CAST(R.FirstName as varchar(50)),'')+' '+isnull(CAST(R.LastName as varchar(50)),'')'Name',
					isnull(R.AdharCardNo,''),isnull(R.MobileNo,''),isnull(R.EmailID,''),H.PropertyNo
					 from Resident R 
					 left join House H on h.ID=r.HouseID	
		 
					 where (FirstName like '%'+@SearchText+'%') OR (R.EmailID like '%'+@SearchText+'%') OR (MobileNo like '%'+@SearchText+'%') OR (AdharCardNo like '%'+@SearchText+'%')
		END
		IF @Action=2
			BEGIN
				select 
							@HomeTax=isnull(SUM(isnull(HomeTax,0)),0) 
							,@LightTax=isnull(SUM(isnull(LightTax,0)),0) 
							,@HealthTax=isnull(SUM(isnull(HealthTax,0)),0) 
							,@WaterTax=isnull(SUM(isnull(WaterTax,0)),0) 
							,@BusinessTax=isnull(SUM(isnull(BusinessTax,0)),0) 
							,@ShopTax=isnull(SUM(isnull(ShopTax,0)),0) 
							,@NoticeFee=isnull(SUM(isnull(NoticeFee,0)),0) 
							,@WarrantFee=isnull(SUM(isnull(WarrantFee,0)),0) 
							,@OtherTax=isnull(SUM(isnull(OtherTax,0)),0) 
							,@TotalAmount=isnull(SUM(isnull(TotalAmt,0)),0) 
							from TaxMaster where HouseId=@HouseID  and IsActive=1-- and IsPaid=0

							--select * into #Res from Resident
							Select top 1 cast(@HomeTax as varchar(50))+'|'+cast(@LightTax as varchar(50))+'|'+cast(@HealthTax as varchar(50))+'|'+cast(@WaterTax as varchar(50))+'|'+
							cast(@BusinessTax as varchar(50))+'|'+cast(@ShopTax as varchar(50))+'|'+
							cast(@NoticeFee as varchar(50))+'|'+cast(@WarrantFee as varchar(50))+'|'+cast(@OtherTax as varchar(50))+'|'+cast(@TotalAmount as varchar(50))'Taxes'
							 from Resident R 
							 left join MaritalStatus M on M.ID=R.MaritalStatusID
							left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
							left join House H on H.ID=R.HouseID			
							left join Grampanchayat G on G.ID=R.GramPanchayatID
							left join TaxMaster TM on TM.ResidentId=R.ID
							 where R.ID=@ResidentID
			END
		IF @Action=3
			BEGIN
				Select * from DemandBillMaster
			END
		IF @Action=4
			BEGIN
				insert into DemandBillDetails(DemandBillMasterId,ResidentId,RaiseBy,Status,Amount,RaiseDate,HouseID) 
				values (@DemandBillMasterID,@ResidentID,@RaisedByID,0,@Amount,GETDATE(),@HouseID)

				select @ID= IDENT_CURRENT('DemandBillMaster')
				--=====================================================================================================================================

				Exec USP_NotificationMaster 2,null,@GrampanchayatID,@ResidentID,3,'PAY BILL','Grampanchayat Requested To Pay Bill'

				select @ID
			END
		IF @Action=5
			BEGIN
				Select DD.ID,isnull(DM.BillName,'')BillName,R.FirstName,S.FirstName,Status,cast(RaiseDate as varchar(50)),isnull(cast(PaidDate as varchar(50)),''),H.PropertyNo,Amount,isnull(DD.ResidentId,0)ResidentId,isnull(DD.HouseID,0)HouseID from DemandBillDetails DD
				left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
				left join Resident R on r.ID=dd.ResidentId
				left join House H on h.ID=r.HouseID
				left join Staff S on S.ID=DD.RaiseBy
				where  DD.RaiseDate between @Fromdate and @Todate
			END
		IF @Action=6
			BEGIN
				Delete from DemandBillDetails where ID=@DemandBillDetailID
			END
		IF @Action=7
			BEGIN

				Exec USP_NotificationMaster 3,null,1,@ResidentId,3,null,null

				Select DD.ID,isnull(DM.BillName,'')BillName,R.FirstName,Status,cast(RaiseDate as varchar(50)),isnull(cast(PaidDate as varchar(50)),''),H.PropertyNo,Amount from DemandBillDetails DD
				left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
				left join Resident R on r.ID=dd.ResidentId
				left join House H on h.ID=r.HouseID
				left join Staff S on S.ID=DD.RaiseBy
				where DD.HouseID=@HouseID  and DD.ResidentId=@ResidentID
			END
		IF @Action=1101
			BEGIN

				Exec USP_NotificationMaster 3,null,1,@ResidentId,3,null,null

				Select DD.ID,DM.BillName,R.FirstName,Status,cast(RaiseDate as varchar(50)),isnull(cast(PaidDate as varchar(50)),''),H.PropertyNo,Amount from DemandBillDetails DD
				left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
				left join Resident R on r.ID=dd.ResidentId
				left join House H on h.ID=r.HouseID
				left join Staff S on S.ID=DD.RaiseBy
				where DD.ResidentId=@ResidentID and DD.HouseID=@HouseID  and (R.FirstName like '%'+@SearchText+'%') OR (DM.BillName like '%'+@SearchText+'%')

			END
		IF @Action=1102
			BEGIN
			 if  @SearchText is null
				 begin
					Select DD.ID,isnull(DM.BillName,'')BillName,R.FirstName,S.FirstName,Status,cast(RaiseDate as varchar(50)),isnull(cast(PaidDate as varchar(50)),''),H.PropertyNo,Amount,isnull(DD.ResidentId,0)ResidentId,isnull(DD.HouseID,0)HouseID from DemandBillDetails DD
					left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
					left join Resident R on r.ID=dd.ResidentId
					left join House H on h.ID=r.HouseID
					left join Staff S on S.ID=DD.RaiseBy
					where DD.RaiseDate between @Fromdate and @Todate  and (R.FirstName like '%'+@SearchText+'%') OR (DM.BillName like '%'+@SearchText+'%')
				  end
			  else
				  begin
			  		Select DD.ID,isnull(DM.BillName,'')BillName,R.FirstName,S.FirstName,Status,cast(RaiseDate as varchar(50)),isnull(cast(PaidDate as varchar(50)),''),H.PropertyNo,Amount,isnull(DD.ResidentId,0)ResidentId,isnull(DD.HouseID,0)HouseID from DemandBillDetails DD
					left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
					left join Resident R on r.ID=dd.ResidentId
					left join House H on h.ID=r.HouseID
					left join Staff S on S.ID=DD.RaiseBy
					where (R.FirstName like '%'+@SearchText+'%') OR (DM.BillName like '%'+@SearchText+'%') 	and  DD.RaiseDate between @Fromdate and @Todate
				  end
			END
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------Search Demand Bill For Mobile App---------------------------------------------------------------------------------------------------------
			IF @Action=8
		  BEGIN

					select * into #Res1 from Resident
					Select  R.ID,isnull(R.HouseID,0)HouseID,isnull(CAST(R.Title as varchar(50)),'')+' '+isnull(CAST(R.FirstName as varchar(50)),'')+' '+isnull(CAST(R.LastName as varchar(50)),'')'Name',
					isnull(H.PropertyNo,'')PropertyNo,isnull(R.AdharCardNo,'')AdharCardNo,isnull(R.MobileNo,'')MobileNo,isnull(R.EmailID,'')EmailID
					 from Resident R 
					 left join MaritalStatus M on M.ID=R.MaritalStatusID
					left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
					left join House H on H.ID=R.HouseID 
					left join Grampanchayat G on G.ID=R.GramPanchayatID
					left join TaxMaster TM on TM.ResidentId=R.ID	
		 
					 where (FirstName like '%'+@SearchText+'%') OR (R.EmailID like '%'+@SearchText+'%') OR (MobileNo like '%'+@SearchText+'%') OR (AdharCardNo like '%'+@SearchText+'%')OR (PropertyNo like '%'+@SearchText+'%')
					  and R.GramPanchayatID=@GramPanchayatId
	    	END

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------Demand List For Mobile App-----------------------------------------------------------------------------------------------------------
         IF @Action=9
			BEGIN
				Select DD.ID,DM.BillName,R.FirstName'ResidentFirstName',S.FirstName'StaffFirstName',Status,cast(RaiseDate as varchar(50))RaiseDate,isnull(cast(PaidDate as varchar(50)),'')PaidDate from DemandBillDetails DD
				left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
				left join Resident R on r.ID=dd.ResidentId
				left join Staff S on S.ID=DD.RaiseBy
			END
			
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------Tax Details ForMobile App--------------------------------------------------------------------------------------------
	IF @Action=10
			BEGIN
				select 
							@HomeTax=isnull(SUM(isnull(HomeTax,0)),0) 
							,@LightTax=isnull(SUM(isnull(LightTax,0)),0) 
							,@HealthTax=isnull(SUM(isnull(HealthTax,0)),0) 
							,@WaterTax=isnull(SUM(isnull(WaterTax,0)),0) 
							,@BusinessTax=isnull(SUM(isnull(BusinessTax,0)),0) 
							,@ShopTax=isnull(SUM(isnull(ShopTax,0)),0) 
							,@NoticeFee=isnull(SUM(isnull(NoticeFee,0)),0) 
							,@WarrantFee=isnull(SUM(isnull(WarrantFee,0)),0) 
							,@OtherTax=isnull(SUM(isnull(OtherTax,0)),0) 
							,@TotalAmount=isnull(SUM(isnull(TotalAmt,0)),0) 
							from TaxMaster where HouseId=@HouseID and IsActive=1 --nd IsPaid=0 

							--select * into #Res from Resident
							Select top 1 cast(@HomeTax as varchar(50))HomeTax,cast(@LightTax as varchar(50))LightTax,cast(@HealthTax as varchar(50))HealthTax,cast(@WaterTax as varchar(50))WaterTax,
							cast(@BusinessTax as varchar(50))BusinessTax,cast(@ShopTax as varchar(50))ShopTax,
							cast(@NoticeFee as varchar(50))NoticeFee,cast(@WarrantFee as varchar(50))WarrantFee,cast(@OtherTax as varchar(50))OtherTax,cast(@TotalAmount as varchar(50))TotalAmount
							 from Resident R 
							 left join MaritalStatus M on M.ID=R.MaritalStatusID
							left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
							left join House H on H.ID=R.HouseID			
							left join Grampanchayat G on G.ID=R.GramPanchayatID
							left join TaxMaster TM on TM.ResidentId=R.ID
							 where R.ID=@ResidentID
			END
			
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------Generate Bill For Mobile App-------------------------------------------------------------------------------------------------

  IF @Action=11
			BEGIN
				
				insert into DemandBillDetails(DemandBillMasterId,ResidentId,RaiseBy,Status,Amount,RaiseDate) 
				values (@DemandBillMasterID,@ResidentID,@RaisedByID,0,@Amount,GETDATE())
				select @ID= IDENT_CURRENT('DemandBillMaster')
				select @ID
			END
			
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
	IF @Action=12 -----Demand bill list for mbile app
			BEGIN

				Exec USP_NotificationMaster 3,null,1,@ResidentId,3,null,null

				Select DD.ID,DM.BillName,R.FirstName,Status,Amount,cast(RaiseDate as varchar(50))RaiseDate,isnull(cast(PaidDate as varchar(50)),'')PaidDate from DemandBillDetails DD
				left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
				left join Resident R on r.ID=dd.ResidentId
				left join Staff S on S.ID=DD.RaiseBy
				where DD.HouseID=@HouseID  and DD.ResidentId=@ResidentID
			END

	IF @Action=13
	BEGIN
		Select DD.ID,isnull(DM.BillName,'')BillName,R.FirstName,S.FirstName,Status,cast(RaiseDate as varchar(50))RaiseDate,isnull(cast(PaidDate as varchar(50)),'')PaidDate,H.PropertyNo,Amount from DemandBillDetails DD
		left join DemandBillMaster DM on dm.ID=dd.DemandBillMasterId
		left join Resident R on r.ID=dd.ResidentId
		left join House H on h.ID=r.HouseID
		left join Staff S on S.ID=DD.RaiseBy
		where  DD.GramPanchayatID=@GramPanchayatId --and DD.RaiseDate between @Fromdate and @Todate
	END

IF @Action=14
	BEGIN   

    
         select
             @HomeTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax,0) else 0 end),0))
            ,@LightTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.LightTax,0) else 0 end),0))
            ,@HealthTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HealthTax,0) else 0 end),0))                                      
            ,@WaterTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WaterTax,0) else 0 end),0))      
            ,@NoticeFee=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.NoticeFee,0) else 0 end),0))          
            ,@WarrantFee=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WarrantFee,0) else 0 end),0))                      
            ,@TotalAmount=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax+TM.TotalAmt,0) else 0 end),0))
          
            ,@HomeTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax,0) else 0 end),0))
            ,@LightTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.LightTax,0) else 0 end),0))
            ,@HealthTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HealthTax,0) else 0 end),0))                                      
            ,@WaterTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WaterTax,0) else 0 end),0))      
            ,@NoticeFeeC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.NoticeFee,0) else 0 end),0))          
            ,@WarrantFeeC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WarrantFee,0) else 0 end),0))                      
            ,@TotalAmountC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax+TM.TotalAmt,0) else 0 end),0))
          
            +sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
            +sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))
            from TaxMaster TM WITH(NOLOCK)
            left join Resident R on r.ID=TM.ResidentId
            left join House H on h.ID=TM.HouseID
            join DemandBillDetails DD on DD.ResidentId=TM.ResidentId  and DD.HouseID=TM.HouseId
            where  DD.ResidentId=@ResidentID and DD.HouseID=@HouseID
          
            select top 1
            cast(@HomeTax as varchar(50))HomeTaxP,cast(@LightTax as varchar(50))LightTaxP,cast(@HealthTax as varchar(50))HealthTaxP,cast(@WaterTax as varchar(50))WaterTaxP,cast(@NoticeFee as varchar(50))NoticeFeeP,
            cast(@WarrantFee as varchar(50))WarrantFeeP,cast(@TotalAmount as varchar(10))TotalAmount,

            cast(@HomeTaxC as varchar(50))HomeTaxC,cast(@LightTaxC as varchar(50))LightTaxC,cast(@HealthTaxC as varchar(50))HealthTaxC,cast(@WaterTaxC as varchar(50))WaterTaxC,cast(@NoticeFeeC as varchar(50))NoticeFeeC,
            cast(@WarrantFeeC as varchar(50))WarrantFeeC,cast(@TotalAmountC as varchar(10))TotalAmountC,
            isnull(cast(R.FirstName+''+R.SpouseName+''+R.LastName as varchar(100)),'')'ResidentName',isnull(cast(H.PropertyNo as varchar(100)),'')PropertyNo,G.VillageName,
			cast(TM.InsertDateTime as varchar(20))InsertDateTime,cast(@HomeTax+@HomeTaxC as varchar(100))'SumHomeTax',cast(@LightTax+@LightTaxC as varchar(100))'SumLightTax',cast(@HealthTax+@HealthTaxC as varchar(100))'SumHealthTax'
			,cast(@WaterTax+@WaterTaxC as varchar(100))'SumWaterTax',cast(@NoticeFee+@NoticeFeeC as varchar(100))'SumNoticeFee',cast(@WarrantFee+@WarrantFeeC as varchar(100))'SumWarranteeFee',cast(@TotalAmount+@TotalAmountC as varchar(100))'SumTotalTax',G.District
            from TaxMaster TM WITH(NOLOCK)
            left join Resident R on r.ID=TM.ResidentId
            left join House H on h.ID=TM.HouseID
            left join Village VL on VL.ID=H.VillageId
			  join Grampanchayat G on G.ID=TM.GrampanchayatId
            left join DemandBillDetails DD on DD.ResidentId=TM.ResidentId  and DD.HouseID=TM.HouseId
			where  DD.ResidentId=@ResidentID and DD.HouseID=@HouseID
	
	END
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- 
END
GO
/****** Object:  StoredProcedure [dbo].[SP_Dispute]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_Dispute]
(
@Action int=null,
@ID int=null,
@GrampanchayatID int=null,
@Subject nvarchar(100)=null,
@Details nvarchar(max)=null,
@ResidentID int=null,
@StaffID int=null,
@Documents nvarchar(50)=null,
@IsActive bit=null,
@Status int=null,
@RaiseDate datetime=null,
@CloseDate datetime=null,
@DropdownValue int=null,
@IsAgainstResident int=null,
@AdminRemark nvarchar(max)=null,
@ResidentRemark nvarchar(max)=null,
@SearchText nvarchar(100)=null,
@URL varchar(100)=null,
@Fromdate datetime=null,
@Todate datetime=null
)
AS 
BEGIN
	IF @Action=1
		BEGIN
			update DisputeMaster set Status=1 where Status=0
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State,IsAgainstResident,cast(Subject as varchar(18)),cast(Details as varchar(18)),cast(R.ID as varchar(50))+' | '+R.FirstName+' '+R.LastName,
			cast(S.ID as varchar(50))+' | '+S.FirstName+' '+S.LastName,Documents,cast(isnull(DM.AdminRemark,'') as varchar(500)),cast(isnull(DM.ResidentRemark,'') as varchar(500))
			,Status,cast(RaiseDate as varchar(50)),cast(CloseDate as varchar(50))
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=0 and DM.RaiseDate between @Fromdate and @Todate
		END
	IF @Action=2
		BEGIN
		update DisputeMaster set Status=1 where Status=0

			Exec USP_NotificationMaster 3,null,1,@ResidentID,2,null,null

			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State,IsAgainstResident,Subject,Details,isnull(R.FirstName,'')+' '+isnull(R.LastName,''),
			isnull(S.FirstName,'')+' '+isnull(S.LastName,''),isnull(Documents,'')
			,Status,cast(RaiseDate as varchar(50)),cast(CloseDate as varchar(50)),cast(isnull(DM.AdminRemark,'') as varchar(500)),cast(isnull(DM.ResidentRemark,'') as varchar(500))
			 from DisputeMaster DM	
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=1 and DM.ResidentID=@ResidentID
		END

	IF @Action=3
		BEGIN
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State,IsAgainstResident,cast(Subject as varchar(18)),cast(Details as varchar(18)),cast(R.ID as varchar(50))+' | '+R.FirstName+' '+R.LastName,
			cast(S.ID as varchar(50))+' | '+S.FirstName+' '+S.LastName,Documents,cast(isnull(DM.AdminRemark,'') as varchar(500)),cast(isnull(DM.ResidentRemark,'') as varchar(500))
			,Status,cast(RaiseDate as varchar(50)),cast(CloseDate as varchar(50))
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=@DropdownValue and DM.Status=@Status and DM.RaiseDate between @Fromdate and @Todate
		END
	IF @Action=4
		BEGIN
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State,IsAgainstResident,Subject,Details,isnull(R.FirstName,'')+' '+isnull(R.LastName,''),
			isnull(S.FirstName,'')+' '+isnull(S.LastName,''),isnull(Documents,'')
			,Status,cast(RaiseDate as varchar(50)),cast(CloseDate as varchar(50)),cast(isnull(DM.AdminRemark,'') as varchar(500)),cast(isnull(DM.ResidentRemark,'') as varchar(500))
			 from DisputeMaster DM	
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=@DropdownValue and DM.ResidentID=@ResidentID and DM.Status=@Status
		END
	IF @Action=5
		BEGIN
			Insert into DisputeMaster(GrampanchayatID,IsAgainstResident,Subject,Details,ResidentID,StaffID,Documents,Status,RaiseDate,AdminRemark,IsActive,updatedatetime)
			values(@GrampanchayatID,@IsAgainstResident,@Subject,@Details,@ResidentID,@StaffID,@Documents,0,GETDATE(),@AdminRemark,1,getdate())

				insert into NotificationMaster (GrampanchayatID,ResidentId,NotifDatetime,NotifType,NotifHeader,NotifDescription,IsView,IsActive)
				values (@GrampanchayatID,@ResidentID,getdate(),2,'DISPUTE & COMPLAINTS','Dispute Subject: '+@Subject+' & Description: '+@Details,0,1)

				Exec USP_NotificationMaster 2,null,@GrampanchayatID,@ResidentID,2,'DISPUTE & COMPLAINTS','Dispute Raised By Grampanchayat'
		END
	IF @Action=6
		BEGIN
		if @Status=3
			begin
				update DisputeMaster
				set 
				Status=@Status,
				AdminRemark=@AdminRemark,
				CloseDate=GETDATE()
				,updatedatetime=GETDATE()
				where ID=@ID
			end
		else
			begin
				update DisputeMaster
				set 
				Status=@Status,
				AdminRemark=@AdminRemark
				,updatedatetime=GETDATE()
				where ID=@ID
			end
		END
	if @Action=7
		BEGIN
			Select  R.ID,isnull(R.HouseID,0),isnull(CAST(R.Title as varchar(50)),'')+' '+isnull(CAST(R.FirstName as varchar(50)),'')+' '+isnull(CAST(R.LastName as varchar(50)),'')'Name',
			isnull(R.AdharCardNo,''),isnull(R.MobileNo,''),isnull(R.EmailID,'')
			 from Resident R 
			where (FirstName like '%'+@SearchText+'%') OR (R.EmailID like '%'+@SearchText+'%') OR (MobileNo like '%'+@SearchText+'%') OR (AdharCardNo like '%'+@SearchText+'%')
		END
	IF @Action=1001
		BEGIN
			Select cast(DM.ID as nvarchar(10))+'|'+G.VillageName+' '+G.Block+' '+G.State+'|'+cast(isnull(IsAgainstResident,0) as nvarchar(10))+'|'+cast(Subject as nvarchar(150))+'|'+
			cast(Details as nvarchar(150))+' | '+isnull(R.FirstName,'')+' '+isnull(R.LastName,'')+'|'+
			isnull(S.FirstName,'')+' '+isnull(S.LastName,'')+'|'+isnull(Documents,'')+'|'+cast(isnull(DM.AdminRemark,'') as nvarchar(max))+'|'+cast(isnull(DM.ResidentRemark,'') as nvarchar(max))
			+'|'+cast(Status as varchar(10))+'|'+cast(RaiseDate as nvarchar(50))+'|'+cast(isnull(CloseDate,'1999-04-05') as nvarchar(50))
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID 
			 where DM.ID=@ID
		END
--====================================================================================================================================================================================
	IF @Action=1002  -----------Verify Resident
		BEGIN
		if @Status=3
			begin
				update DisputeMaster
				set 
				Status=@Status,
				ResidentRemark=@ResidentRemark,
				CloseDate=GETDATE()
				,updatedatetime=GETDATE()
				where ID=@ID
			end
		else
			begin
				update DisputeMaster
				set 
				Status=@Status,
				ResidentRemark=@ResidentRemark
				,updatedatetime=GETDATE()
				where ID=@ID
			end
		END
--====================================================================================================================================================================================
	IF @Action=1003-----Create For Resident
		BEGIN
			Insert into DisputeMaster(GrampanchayatID,IsAgainstResident,Subject,Details,ResidentID,Documents,Status,RaiseDate,ResidentRemark,IsActive,UpdateDateTime)
			values(@GrampanchayatID,@IsAgainstResident,@Subject,@Details,@ResidentID,@Documents,0,GETDATE(),@ResidentRemark,1,GETDATE())


		END
--====================================================================================================================================================================================
		IF @Action=8 ----Admin list for Mobile App
		BEGIN
			update DisputeMaster set Status=1 where Status=0
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State'Grampanchayat Name',IsAgainstResident,cast(Subject as varchar(18))Subject,cast(Details as varchar(18))Details,cast(R.ID as varchar(50))+' '+R.FirstName+' '+R.LastName'ResidentName',
			cast(S.ID as varchar(50))+'  '+S.FirstName+' '+S.LastName 'StaffName',Documents,cast(isnull(DM.AdminRemark,'') as varchar(18))AdminRemark,cast(isnull(DM.ResidentRemark,'') as varchar(18))ResidentRemark
			,Status,cast(RaiseDate as varchar(50))RaiseDate,cast(CloseDate as varchar(50))CloseDate
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=0
		END
--====================================================================================================================================================================================

IF @Action=9   --- Resident List for Mobile APp
		BEGIN
		update DisputeMaster set Status=1 where Status=0
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State'GrampanchayatName',IsAgainstResident,Subject,Details,R.FirstName+' '+R.LastName'Residentname',
			S.FirstName+' '+S.LastName'StaffName',isnull(@URL+Documents,'')'Documents'
			,Status,RaiseDate,CloseDate
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=1 and DM.ResidentID=@ResidentID
		END
--====================================================================================================================================================================================

	IF @Action=10 -----admin search dropdown wise-status dropdown
		BEGIN
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State'GrampanchayatName',IsAgainstResident,cast(Subject as varchar(18))Subject,cast(Details as varchar(18))Details,cast(R.ID as varchar(50))+' '+R.FirstName+' '+R.LastName 'ResidentName',
			cast(S.ID as varchar(50))+' '+S.FirstName+' '+S.LastName 'StaffName',Documents,cast(isnull(DM.AdminRemark,'') as varchar(18))AdminRemark,cast(isnull(DM.ResidentRemark,'') as varchar(18))ResidentRemark
			,Status,cast(RaiseDate as varchar(50))RaiseDate,cast(CloseDate as varchar(50))CloseDate
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=@DropdownValue and DM.Status=@Status
		END
--====================================================================================================================================================================================

	IF @Action=11----Resident search dropdown wise-status dropdown
		BEGIN
			Select DM.ID,G.VillageName+' '+G.Block+' '+G.State'GrampanchayatName',IsAgainstResident,Subject,Details,R.FirstName+' '+R.LastName'Residentname',
			isnull(S.FirstName+' '+S.LastName,'')'StaffName',Documents
			,Status,RaiseDate,CloseDate
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID
			 left join Staff S on S.ID=DM.StaffID
			 where DM.IsActive=1 and DM.IsAgainstResident=@DropdownValue and DM.ResidentID=@ResidentID and DM.Status=@Status
		END
--====================================================================================================================================================================================
IF @Action=12
		BEGIN
			Select cast(DM.ID as nvarchar(10))ID,G.VillageName+' '+G.Block+' '+G.State 'GrampanchayatName', IsAgainstResident,cast(Subject as nvarchar(150))Subject,
			cast(Details as nvarchar(150))Details,R.FirstName+' '+R.LastName 'ResidentName',
			S.FirstName+' '+S.LastName'StaffName',isnull(@URL+Documents,'')'Documents'
			,cast(isnull(DM.AdminRemark,'') as nvarchar(max))'AdminRemark',cast(isnull(DM.ResidentRemark,'') as nvarchar(max))'ResidentRemark',
			Status,cast(RaiseDate as nvarchar(50))'RaiseDate',cast(CloseDate as nvarchar(50))'CloseDate'
			 from DisputeMaster DM
			 left join Grampanchayat G on G.ID=DM.GrampanchayatID
			 left join Resident R on r.ID=Dm.ResidentID 
			 left join Staff S on S.ID=DM.StaffID 
			 where DM.ID=@ID
		END
--====================================================================================================================================================================================
END
GO
/****** Object:  StoredProcedure [dbo].[SP_EventManaging]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_EventManaging]
(
@Action int=null,
@ID int=null,
@GrampanchayatID int=null,
@EventTitle nvarchar(500)=null,
@EventDescription nVarchar(max)=null,
@FromDate datetime=null,
@ToDate datetime=null,
@IsActive bit=null,
@EventFor int=null
)
AS
BEGIN
	IF @Action=1
		BEGIN
			IF @EventFor=1
				BEGIN
					select ID,GramPanchayatID,isnull(EventTitle,'')EventTitle,isnull(EventDescription,'')EventDescription,EventFrom,EventTo,IsActive from EventManaging 
					where GramPanchayatID=@GrampanchayatID and EventTo>=GETDATE() and (EventFor=1 or EventFor=3)
				END
			IF @EventFor=2
				BEGIN
					select ID,GramPanchayatID,isnull(EventTitle,'')EventTitle,isnull(EventDescription,'')EventDescription,EventFrom,EventTo,IsActive from EventManaging 
					where GramPanchayatID=@GrampanchayatID and EventTo>=GETDATE() and (EventFor=2 or EventFor=3)
				END
			IF @EventFor=3
				BEGIN
					select ID,GramPanchayatID,isnull(EventTitle,'')EventTitle,isnull(EventDescription,'')EventDescription,EventFrom,EventTo,IsActive from EventManaging 
					where GramPanchayatID=@GrampanchayatID and EventTo>=GETDATE()
				END
		END
	IF @Action=2
		BEGIN
			INSERT INTO EventManaging(GramPanchayatID,EventTitle,EventDescription,EventFrom,EventTo,IsActive,EventFor)
			VALUES (@GrampanchayatID,@EventTitle,@EventDescription,@FromDate,@ToDate,@IsActive,@EventFor)
		END
	IF @Action=3
		BEGIN
			DELETE FROM EventManaging WHERE ID=@ID
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_HeavyProductEntry_16]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_HeavyProductEntry_16]
(
@Action int=null,
@HeavyProductID int=null,
@GrampanchayatID int=null,
@Name nvarchar(50)=null,
@Description nvarchar(150)=null,
@PurchaseDate Date=null,
@PurchaseDetail nvarchar(150)=null,
@CountOrConclusion nvarchar(50)=null,
@Price numeric(10,2)=null,
@StartApproveBy int=null,
@DisposeCountOrConclusion nvarchar(50)=null,
@DiposeCertificate nvarchar(50)=null,
@ReceivedAmount numeric(10,2)=null,
@ReceivedDate Date=null,
@RemainAmount numeric(10,2)=null,
@SarpanchID int=null,
@EndApproveBy int=null,
@Remark nvarchar(150)=null,
@InsertedBy int=null,
@Fromdate date=null,
@Todate date=null
)
AS
BEGIN
	IF @Action=1--INDEX
		BEGIN
			Select HeavyProductEntryId,Name,ReceivedAmount,RemainAmount,cast(PurchaseDate as nvarchar(50)) from HeavyProductEntry_16
			where IsDelete=0 and PurchaseDate between @Fromdate and @Todate
		END
--==============================================================================================================================
	IF @Action=2--Detail
		BEGIN
			Select top 1 HeavyProductEntryId,G.VillageName,Name,Description,cast(PurchaseDate as nvarchar(50)),PurchaseDetail,CountOrConclusion
			,Price,S.FirstName+' '+s.LastName'StartApproveBy',DisposeCountOrConclusion,DisposeCertificate,ReceivedAmount
			,cast(ReceivedDate as varchar(50)),RemainAmount,S1.FirstName+' '+S1.LastName'Sarpanch',S2.FirstName+' '+S2.LastName'EndApproveBy'
			,Remark,H16.IsActive,cast(InsertDateTime as nvarchar(50)),S3.FirstName+' '+S3.LastName'InsertedBy'
			 from HeavyProductEntry_16 H16  
			  join Grampanchayat G on G.ID=H16.GrampanchayatId
			  join Staff S on S.ID=H16.StartApprovedBy
			  join Staff S1 on S1.ID=H16.SarpanchId
			  join Staff S2 on S2.ID=H16.EndApprovedBy
			  join Staff S3 on S2.ID=H16.InsertBy
			where H16.IsDelete=0 and H16.HeavyProductEntryId=@HeavyProductID
		END
--==============================================================================================================================
	IF @Action=3--Create
		BEGIN
			Insert into HeavyProductEntry_16
				(GrampanchayatId,Name,Description,PurchaseDate,PurchaseDetail,CountOrConclusion,Price,StartApprovedBy
				,DisposeCountOrConclusion,DisposeCertificate,ReceivedAmount,ReceivedDate,RemainAmount,SarpanchId,EndApprovedBy,
				Remark,IsDelete,IsActive,InsertDateTime,InsertBy)
			values
			(@GrampanchayatID,@Name,@Description,@PurchaseDate,@PurchaseDetail,@CountOrConclusion,@Price,@StartApproveBy,@DisposeCountOrConclusion
			,@DiposeCertificate,@ReceivedAmount,@ReceivedDate,@RemainAmount,@SarpanchID,@EndApproveBy,@Remark,0,1,GETDATE(),@InsertedBy)
		END
--==============================================================================================================================
	IF @Action=4--EDIT
		BEGIN
			Select HeavyProductEntryId,Name,Description,PurchaseDate,PurchaseDetail,CountOrConclusion,Price,StartApprovedBy
			,DisposeCountOrConclusion,DisposeCertificate,ReceivedAmount,ReceivedDate,RemainAmount,SarpanchId,EndApprovedBy,
			Remark,IsActive from HeavyProductEntry_16
			where HeavyProductEntryId=@HeavyProductID
		END
--==============================================================================================================================
	IF @Action=5--Update
		BEGIN
			Update HeavyProductEntry_16
			set 
			 Name=@Name
			,Description=@Description
			,PurchaseDate=@PurchaseDate
			,PurchaseDetail=@PurchaseDetail
			,CountOrConclusion=@CountOrConclusion
			,Price=@Price
			,StartApprovedBy=@StartApproveBy
			,DisposeCountOrConclusion=@DisposeCountOrConclusion
			,DisposeCertificate=@DiposeCertificate
			,ReceivedAmount=@ReceivedAmount
			,ReceivedDate=@ReceivedDate
			,RemainAmount=@RemainAmount
			,@SarpanchID=@SarpanchID
			,EndApprovedBy=@EndApproveBy
			,Remark=@Remark
			,InsertDateTime=GETDATE()
			,InsertBy=@InsertedBy
			where HeavyProductEntryId=@HeavyProductID
		END
--==============================================================================================================================
	IF @Action=6--Delete
		BEGIN
			Update HeavyProductEntry_16
			set 
			IsDelete=1
			where HeavyProductEntryId=@HeavyProductID
		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_NoticeBoard]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--  SP_NoticeBoard 4,0,1,'','','','',1,1,0,1

CREATE Procedure [dbo].[SP_NoticeBoard]
(
@Action int=null,
@NoticeBoardID int=null,
@GrampanchayatID int=null,
@Title nvarchar(500)=null,
@Description nvarchar(max)=null,
@Insertdate date=null,
@ToDate date=null,
@IsActive bit=null,
@NoticeFor int=null,
--@Members varchar(50) = null
@IsStaff int = null,
@UserId int = null,
@Members varchar(max) = null,
@SearchBy nvarchar(100) = null
)
AS
BEGIN
	IF @Action=1
		BEGIN
			IF @NoticeFor=1 -- Staff and Admin
				BEGIN

					SELECT ID,GramPanchayatID,Title,Description,cast(InsertDate as varchar(50)),cast(ToDate as varchar(50)),IsActive FROM NoticeBoard 
					where IsActive=1 and GramPanchayatID=@GrampanchayatID and ToDate>=cast(GETDATE() as date) and (NoticeFor=1 or NoticeFor=3)
				END
			IF @NoticeFor=2 -- Resident and Admin
				BEGIN
					SELECT ID,GramPanchayatID,Title,Description,cast(InsertDate as varchar(50)),cast(ToDate as varchar(50)),IsActive FROM NoticeBoard 
					where IsActive=1 and GramPanchayatID=@GrampanchayatID and ToDate>=cast(GETDATE() as date) and (NoticeFor=2 or NoticeFor=3)
				END
			IF @NoticeFor=3 -- Admin
				BEGIN
					SELECT ID,GramPanchayatID,Title,Description,cast(InsertDate as varchar(50)),cast(ToDate as varchar(50)),IsActive FROM NoticeBoard 
					where IsActive=1 and GramPanchayatID=@GrampanchayatID and ToDate>=cast(GETDATE() as date) 
				END
			 
		END
	IF @Action=2
		BEGIN

			INSERT INTO NoticeBoard(GramPanchayatID,Title,[Description],ToDate,IsActive,NoticeFor,Members)
			VALUES (@GrampanchayatID,@Title,@Description,@ToDate,@IsActive,@NoticeFor,@Members)

			if @Members is not null and @NoticeFor = 5
			Begin
			     declare cur1 cursor for
				 select content from dbo.StringSplit(@Members,',') tbl

				 open cur1
				 declare @ResidentId as int
				 fetch next from cur1 into @ResidentId	 

				 while @@FETCH_STATUS=0
			     begin	

				 Exec USP_NotificationMaster 2,null,@GrampanchayatID,@ResidentId,1,@Title,@Description

				 --insert into NotificationMaster (GrampanchayatID,ResidentId,NotifDatetime,NotifType,NotifHeader,NotifDescription,IsView,IsActive)
				 --values (@GrampanchayatID,@ResidentId,getdate(),1,@Title,@Description,0,1)

			     fetch next from cur1 into @ResidentId
			 end
		       close cur1
		       deallocate cur1	 
			end
			--select * from NotificationMaster

		END
	IF @Action=3
		BEGIN
			DELETE FROM NoticeBoard WHERE ID=@NoticeBoardID
		END
	IF @Action=4
	   Begin
	          
			  SELECT ID,GramPanchayatID,Title,Description,cast(InsertDate as varchar(50))InsertDate,cast(ToDate as varchar(50))ToDate,IsActive from
			  NoticeBoard where 

			  (@IsStaff = 1 and NoticeFor = 1) 					 
			  OR (@IsStaff = 1 and NoticeFor = 4 and '1' = dbo.fun_QueryCSVColumn (Members,',',@UserId,'exact contains') ) 
			 
			  OR (@IsStaff = 0 and NoticeFor = 2) 					 
			  OR (@IsStaff = 0 and NoticeFor = 5  and '1' = dbo.fun_QueryCSVColumn (Members,',',@UserId,'exact contains') ) 

			  OR NoticeFor = 3

			  and IsActive=1 and GramPanchayatID=@GrampanchayatID and ToDate>=cast(GETDATE() as date)
			  order by InsertDate desc
	   end
     IF @Action = 5 -- Fetch Staff
	  Begin
	      select ID,isnull(FirstName,''),Isnull(LastName,''),isnull(Gender,''),isnull(EmailId,''),isnull(MobileNumber,'') 
          from Staff with(nolock)
          where GramPanchayatID=@GrampanchayatID
	  end  

	  IF @Action = 6 -- Fetch Resident
	  Begin
	      select ID,isnull(FirstName,''),Isnull(LastName,''),isnull(Gender,''),isnull(EmailId,''),isnull(MobileNo,'') 
		  from Resident with(nolock)
		  where GramPanchayatID=@GrampanchayatID
	  end  
	  IF @Action = 7 --Fetch Staff Filterwise
	  Begin
	     Declare @SQL as varchar(max) = null
	        set @SQL='select ID,isnull(FirstName,''''),Isnull(LastName,''''),isnull(Gender,''''),isnull(EmailId,''''),isnull(MobileNumber,'''') 
            from Staff with(nolock)
		    where GramPanchayatID = '+convert(varchar(10),@GramPanchayatID)+' '
			IF len(@SearchBy)>0
			Begin
			 set @SQL= @SQL +' and (FirstName = N'''+ @SearchBy+''''+ ' OR LastName = N'''+ @SearchBy+''''+ ' OR MobileNumber = N'''+ @SearchBy+''''+ ' OR EmailId = N'''+ @SearchBy+''''+ ') Order By ID'			 
			end
			Else
			Begin
				set @SQL= @SQL +' Order By ID' 
			End
			Exec(@SQL)
	  End

	  IF @Action = 8 --Fetch Resident Filterwise
	  Begin
	        Declare @SQL_ as varchar(max) = null
	        set @SQL_=' select ID,isnull(FirstName,''),Isnull(LastName,''),isnull(Gender,''),isnull(EmailId,''),isnull(MobileNo,'') 
		    from Resident with(nolock)
		    where GramPanchayatID = '+convert(varchar(10),@GramPanchayatID)+' '
			IF len(@SearchBy)>0
			Begin
			 set @SQL_= @SQL_ +' and (FirstName = N'''+ @SearchBy+''''+ ' OR LastName = N'''+ @SearchBy+''''+ ' OR MobileNo = N'''+ @SearchBy+''''+ ' OR EmailId = N'''+ @SearchBy+''''+ ') Order By ID'			 
			end
			Else
			Begin
				set @SQL_= @SQL_ +' Order By ID' 
			End
			Exec(@SQL_)
	  End
END

GO
/****** Object:  StoredProcedure [dbo].[SP_RequestDemand]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_RequestDemand]
(
@Action int=null,
@ID int=null,
@ResidentID int=null,
@Grampanchayat int=null,
@RequestForID int=null,
@HouseID int=null,
@InsertDate int=null,
@IsApprove int=null,
@IsActive bit=null,
@Purpose varchar(200)=null,
@RequestCetificateName varchar(100)=null,
@SupportingDocument  nvarchar(150)=null,
@RoleId int=null,
@Status int=null,
@StaffApproveID int=null,
@AdminApproveID int=null,
@StaffApproveDate datetime=null,
@AdminApproveDate datetime=null,
@URL varchar(100)=null,
@IsApproveName varchar(100)=null,
@Fromdate date=null,
@Todate date=null
)
AS 
BEGIN
--=========================================================================================RESIDENT LIST OF REQUEST==================================================================================
	IF @Action=1
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,IsApprove,RC.Remark,rm.IsDiffer,isnull(RequestID,0)RequestID from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.HouseID=@HouseID and RC.GrampanchayatID=@Grampanchayat and RequestFor=1 
		END

--============================================================================================RESIDENT INSERT/REQUEST=======================================================================
	IF @Action=2
		BEGIN
			select @ID= IDENT_CURRENT('RequestCertificate')+1
			insert into RequestCertificate(ResidentID,GrampanchayatID,RequestFor,IsApprove,IsActive,Remark,HouseID,SupportingDocument,RequestID,UpdateDateTime) 
			values (@ResidentID,@Grampanchayat,@RequestForID,0,1,@Purpose,@HouseID,@SupportingDocument,@ID,GETDATE())


			IF @RequestForID=1 
			begin
			set @RequestCetificateName='Resident Certificate'
			end

			IF @RequestForID=2
			begin
			set @RequestCetificateName='No Dues Certificate'
			end

			IF @RequestForID=3
			begin
			set @RequestCetificateName='Toilet Certificate'
			end

		Exec USP_NotificationMaster 2,0,@Grampanchayat,@ResidentID,0,'REQUEST CERTIFICATE','Your Request Is Genereated And Soon Will Get Verified By Grampanchayat'


			 select @ID= IDENT_CURRENT('RequestCertificate')
			 Declare @ResidentName varchar(50)=null
			 select @ResidentName= FirstName from Resident where ID=@ResidentID
				 	  ---For Notifications--
	  Insert Into Notifications (GrampanchayatId,NotificationName,ControllerName,ActionName,Parameter) 
	  Values (@Grampanchayat,convert(varchar(50),@ResidentName)+' is requesting for '+@RequestCetificateName,'Request certificates','EditNotification',@ID)

		END
--===============================================================================================DELETE FOR RESIDENT
	IF @Action=3
		BEGIN
			Delete from RequestCertificate where ID=@ID
		END
--=========================================================================================No Dues LIST OF REQUEST==================================================================================
	IF @Action=4
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,IsApprove,RC.Remark,RC.SupportingDocument from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.HouseID=@HouseID and RC.GrampanchayatID=@Grampanchayat and RequestFor=2

			update NotificationMaster
				set IsView=1
				where GrampanchayatID=@Grampanchayat and ResidentId=@ResidentId and NotifType=0 and IsView=0

					Exec USP_NotificationMaster 3,null,1,@ResidentId,0,null,null
		END
--=========================================================================================Toilet LIST OF REQUEST==================================================================================
	IF @Action=5
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,IsApprove,RC.Remark,RC.SupportingDocument from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.HouseID=@HouseID and RC.GrampanchayatID=@Grampanchayat and RequestFor=3
		END 
--=========================================================================================RESIDENT LIST OF REQUEST==================================================================================
	IF @Action=6
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,RC.Remark,IsApprove,RC.SupportingDocument,
			RM.IsDiffer,isnull(RequestID,0)RequestID,ResidentID from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.GrampanchayatID=@Grampanchayat and RC.UpdateDateTime between @Fromdate and @Todate--and (IsApprove=@RoleId or IsApprove=@Status)
		END
--=========================================================================================Update ALL LIST OF REQUEST by staff==================================================================================
	IF @Action=7
		BEGIN
			update RequestCertificate set 
			IsApprove=@IsApprove,
			StaffApproveID=@StaffApproveID,
			StaffApproveDate=GETDATE()
			,UpdateDateTime=GETDATE()
			where ID=@ID and GrampanchayatID=@Grampanchayat

				 
			select @ResidentID=ResidentID from RequestCertificate where ID=@ID 
			select RequestFor=@RequestForID from RequestCertificate where ID=@ID 

			IF @RequestForID=1 
			begin
			set @RequestCetificateName='Resident Certificate'
			end

			IF @RequestForID=2
			begin
			set @RequestCetificateName='No Dues Certificate'
			end

			IF @RequestForID=3
			begin
			set @RequestCetificateName='Toilet Certificate'
			end
			--====================================================================
			IF @IsApprove=0
			begin
			set @IsApproveName='Pending'
			end

			IF @IsApprove=1
			begin
			set @IsApproveName='1 Step Of Approval Is Done,Waiting for Final Approval'
			end

			IF @IsApprove=2
			begin
			set @IsApproveName='Approved'
			end

			IF @IsApprove=3
			begin
			set @IsApproveName='Rejected'
			end

		Exec USP_NotificationMaster 2,null,GrampanchayatID,ResidentId,0,'REQUEST CERTIFICATE','Your Request Is Genereated And Soon Will Get Verified By Grampanchayat'

		END
--=========================================================================================Update ALL LIST OF REQUEST by admin==================================================================================
	IF @Action=14
		BEGIN
			update RequestCertificate set 
			IsApprove=@IsApprove,
			AdminApproveID=@AdminApproveID,
			AdminApproveDate=GETDATE()
			,UpdateDateTime=GETDATE()
			where ID=@ID and GrampanchayatID=@Grampanchayat
			 
			select @ResidentID=ResidentID from RequestCertificate where ID=@ID 
			select RequestFor=@RequestForID from RequestCertificate where ID=@ID 

			IF @RequestForID=1 
			begin
			set @RequestCetificateName='Resident Certificate'
			end

			IF @RequestForID=2
			begin
			set @RequestCetificateName='No Dues Certificate'
			end

			IF @RequestForID=3
			begin
			set @RequestCetificateName='Toilet Certificate'
			end
			--====================================================================
			IF @IsApprove=0
			begin
			set @IsApproveName='Pending'
			end

			IF @IsApprove=1
			begin
			set @IsApproveName='1 Step Of Approval Is Done,Waiting for Final Approval'
			end

			IF @IsApprove=2
			begin
			set @IsApproveName='Approved'
			end

			IF @IsApprove=3
			begin
			set @IsApproveName='Rejected'
			end
		Exec USP_NotificationMaster 2,null,GrampanchayatID,ResidentId,0,'REQUEST CERTIFICATE','Your Request Is Genereated And Soon Will Get Verified By Grampanchayat'


		END
--=========================================================================================Edit LIST OF REQUEST==================================================================================
	IF @Action=8
		BEGIN
			Select RC.ID,IsApprove,RC.SupportingDocument from RequestCertificate RC
			where RC.GrampanchayatID=@Grampanchayat and ID=@ID
		END
--================================================================================================CURRENT MARRIAGE ID==============================================================================

IF @Action=9
	BEGIN
		 select @ID =IDENT_CURRENT('RequestCertificate')
		 select @ID+1
	END  
--=========================================================================================SEARCH FIELD BASED ON STATUS=========================================================================
IF @Action=10
	BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,RC.Remark,IsApprove,RC.SupportingDocument,RM.IsDiffer,isnull(RequestID,0)RequestID,ResidentID from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.GrampanchayatID=@Grampanchayat and IsApprove=@Status and RC.UpdateDateTime between @Fromdate and @Todate
	END

	--=========================================================================================for mopbile app LIST OF All REQUEST==================================================================================
	IF @Action=11
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,RC.Remark,IsApprove,isnull(@URL+RC.SupportingDocument,'')'SupportingDocument' ,
			RM.IsDiffer,isnull(RequestID,0)RequestID,ResidentID from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.GrampanchayatID=@Grampanchayat 
		END
--=========================================================================================for mopbile app View OR Edit OF All REQUEST==================================================================================
	IF @Action=12
		BEGIN
			Select RC.ID,H.PropertyNo,R.FirstName,R.AdharCardNo,RM.CertificateName,RC.Remark,IsApprove,
			RC.SupportingDocument,isnull(@URL+RC.SupportingDocument,'')'SupportingDocument' ,
			RM.IsDiffer,isnull(RequestID,0)RequestID,ResidentID from RequestCertificate RC
			left join RequestMaster RM on RM.ID=RC.RequestFor
			left join Resident R on R.ID=RC.ResidentID
			left join House H on H.ID=RC.HouseID
			where RC.GrampanchayatID=@Grampanchayat and Rc.ID=@ID and RM.IsDiffer!=4
		END
		--========================================================================================= Mobile App Update ALL LIST OF REQUEST==================================================================================
	IF @Action=13
		BEGIN
			update RequestCertificate set 
			IsApprove=@IsApprove
			,UpdateDateTime=GETDATE()
			where ID=@ID and GrampanchayatID=@Grampanchayat 

		END
END

GO
/****** Object:  StoredProcedure [dbo].[SP_ResidentNotification]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE Procedure [dbo].[SP_ResidentNotification]
(
@Action int=null,
@GrampanchayatID int=null,
@ResidentID int=null,
@NotificationDate date=null,
@NotificationType int=null,
@NotificationHeader varchar(100)=null,
@NotificationDescription Varchar(500)=null,
@IsView bit=null,
@IsActive bit=null
)
AS
BEGIN
	IF @Action=1
		BEGIN
			Select Id,cast(NotifDatetime as varchar(50))NotifDatetime,NotifHeader,NotifDescription,NotifType from NotificationMaster where ResidentId=@ResidentID and IsActive=1
		END
	IF @Action=2
		BEGIN
			Select cast(count(id) as varchar(15)) from NotificationMaster where ResidentId=@ResidentID and IsView=0
		END
END
GO
/****** Object:  StoredProcedure [dbo].[SP_VillageMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- SP_VillageMaster 5,0,1,'','','',0,'','','',''

CREATE procedure [dbo].[SP_VillageMaster]
(
@Action int=null,
@ID int=null,
@GramPanchayatID int=null,
@VillageName varchar(50)=null,
@AddressDetails varchar(100)=null,
@PinCode int=null,
@IsActive bit=null,
@InsertDateTime datetime=null,
@PhoneNumber nvarchar(50)=null,
@EmailID varchar(50)=null,
@SearchBy nvarchar(50) = null
)
AS 
BEGIN
	IF @Action=1
		BEGIN 
			SELECT V.ID,V.GramPanchayatID,G.State,g.GramCode,V.VillageName,V.AddressDetails,V.PinCode,V.PhoneNumber,V.EmailID,V.IsActive,V.InsertDateTime from Village V
			left join Grampanchayat G on G.ID=V.GramPanchayatID
			where GramPanchayatID=@GramPanchayatID
		END
	IF @Action=2
		BEGIN
			Insert into Village (GramPanchayatID,VillageName,AddressDetails,PinCode,PhoneNumber,EmailID,IsActive,InsertDateTime) 
			values (@GramPanchayatID,@VillageName,@AddressDetails,@PinCode,@PhoneNumber,@EmailID,1,GETDATE())
		END
	IF @Action=5
		BEGIN
			SELECT V.ID,V.GramPanchayatID,G.State,g.GramCode,V.VillageName,V.AddressDetails,cast(V.PinCode as int)PinCode,V.PhoneNumber,V.EmailID,V.IsActive,V.InsertDateTime from Village V
			left join Grampanchayat G on G.ID=V.GramPanchayatID
			where V.ID=@ID
		END
	IF @Action=3
		BEGIN
			Update Village set 
			VillageName=@VillageName,
			AddressDetails=@AddressDetails,
			PinCode=@PinCode,
			PhoneNumber=@PhoneNumber,
			EmailID=@EmailID,
			IsActive=1,
			InsertDateTime=GETDATE()
			where ID=@ID
		END
	IF @Action=4
		BEGIN
			Delete from Village where ID=@ID
		END
	IF @Action=10
		BEGIN 
			SELECT V.ID,V.GramPanchayatID,G.State,g.GramCode,V.VillageName,V.AddressDetails,cast(V.PinCode as int)PinCode,V.PhoneNumber,V.EmailID,V.IsActive,V.InsertDateTime from Village V
			left join Grampanchayat G on G.ID=V.GramPanchayatID
			where GramPanchayatID=@GramPanchayatID
		END
	IF @Action=6
		BEGIN 
		    Declare @STR as Varchar(MAX) = ''

			SET @STR = 'SELECT V.ID,V.GramPanchayatID,G.State,g.GramCode,V.VillageName,V.AddressDetails,V.PinCode,V.PhoneNumber,V.EmailID,V.IsActive,V.InsertDateTime 
			from Village V
			left join Grampanchayat G on G.ID=V.GramPanchayatID
			where GramPanchayatID='+convert(varchar(10),@GramPanchayatID)
			if len(@SearchBy)>0
			Begin
				Set @STR = @STR + ' and (V.VillageName = N'''+ @SearchBy+''''+ ' OR convert(varchar(10),V.PinCode) = N'''+ @SearchBy+''''+ ')'
			end
			PRINT(@STR)
			EXEC(@STR)

		END
END
GO
/****** Object:  StoredProcedure [dbo].[UPS_BirthMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- UPS_BirthMaster  1,0,0,1
CREATE PROC [dbo].[UPS_BirthMaster]
(
	@Action int,
    @ID int = null,
	@ResidentID int= null,
	@GramPanchayatID int = null, 
	@BirthDate date= null,
	@BirthPlace nvarchar(500)= null,
	@PersonName nvarchar(50)= null,
	@Gender nvarchar(50)= null,

	@MotherID int= null,
	@MotherAdhar nvarchar(20)= null,
	@MotherEducation nvarchar(50)= null,
	@MotherJob nvarchar(50)= null,
	@MotherMarriageAge int= null,

	@FatherID int= null,
	@FatherAdhar nvarchar(20)= null,
	@FatherEducation nvarchar(50)= null,
	@FatherJob nvarchar(50)= null,

	@CurrAddress nvarchar(50)= null,
	@CurrVillage nvarchar(50)= null,
	@CurrIsStayVillage bit= null,
	@CurrDisrict nvarchar(50)= null,
	@CurrState nvarchar(50)= null,

	@PerAddress nvarchar(50)= null,
	@PerIsStayVillage bit= null,
	@PerVillage nvarchar(50)= null,
	@PerDisrict nvarchar(50)= null,
	@PerState nvarchar(50)= null,
	
	@Religion nvarchar(50)= null,
	@ChildCount int= null,
	@DeliveryPlace nvarchar(50)= null,
	@DeliveryType nvarchar(50)= null,
	@BabyWeight decimal(10,2)= null,
	@DeliveryDuration decimal(10,2)= null,

	@InformerName nvarchar(50)= null,
	@InformerAdd nvarchar(50)= null,
	@InformerSign nvarchar(50)= null,

	@RegiNumber nvarchar(50)= null,
	@RegiDate date= null,
	@RegiOrg nvarchar(50)= null,
	@RegiCityVillage nvarchar(50)= null,
	@RegiDistrict nvarchar(50)= null,
	@RegiRemarks nvarchar(50)= null,
	@RegiName nvarchar(50)= null,
	@RegiCode nvarchar(50)= null,

	@VillageName nvarchar(50)= null,
	@VillageCode nvarchar(50)= null,
	@TalukaName nvarchar(50)= null,
	@TalukaCode nvarchar(50)= null,
	@DistrictName nvarchar(50)= null,
	@DistrictCode nvarchar(50)= null,	 

	@IsApprove int= null,
	@HouseIds int=null,
	@RequestCetificateName varchar(100)=null,
	@RequestCertificateID int=null
)
AS 
BEGIN TRY 
BEGIN TRANSACTION Trans_BirthMaster   

	Declare @LastName as nvarchar(50),@HouseID as int ,@MotherName as nvarchar(50),@FatherName as nvarchar(50)

    IF @Action = 1 
    Begin
	  select * ,Rc.ID'RequestCertificateID' from BirthMaster join RequestCertificate RC on RC.RequestID=BirthMaster.ID
	  where BirthMaster.GramPanchayatID = @GramPanchayatID
	end

	IF @Action = 2 
	Begin	 
	  IF @FatherID > 0
	  Begin
		  select @LastName = LastName,@HouseID=HouseID, @FatherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@FatherID 
	  end
	  Else 
	    Begin
		   select @LastName = LastName,@HouseID=HouseID, @FatherName = FatherName from Resident where Id=@ResidentID 
		end   

	  IF @MotherID > 0 
	  Begin
		select @MotherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@MotherID 
	  End
	  Else
	  Begin
		  select @MotherName = MotherName from Resident where Id=@ResidentID 
	  End

	  if @ResidentID = 0 AND @ResidentID is null
	  Begin
		Insert Into Resident (GramPanchayatID,FirstName,LastName,FatherID,MotherID,Gender,BirthDate,BirthPlace,HouseID,IsActive)
	    values (@GramPanchayatID,@PersonName,@LastName,@FatherID,@MotherID,@Gender,@BirthDate,@BirthPlace,@HouseID,0)
	    set @ResidentID = IDENT_CURRENT('Resident')	
	  end	  
	  ---For BirthMaster----

	  Insert Into BirthMaster(ResidentID,GramPanchayatID,BirthDate,BirthPlace,PersonName,Gender,MotherName,MotherAdhar,MotherEducation,MotherJob,MotherMarriageAge,FatherName,FatherAdhar,FatherEducation,FatherJob,CurrAddress,CurrVillage,CurrIsStayVillage,CurrDisrict
	                         ,CurrState,PerAddress,PerIsStayVillage,PerVillage,PerDisrict,PerState,Religion,ChildCount,DeliveryPlace,DeliveryType,BabyWeight,DeliveryDuration,InformerName,InformerAdd,InformerSign,RegiNumber,RegiDate,RegiOrg,RegiCityVillage,RegiDistrict
							 ,RegiRemarks,RegiName,RegiCode,VillageName,VillageCode,TalukaName,TalukaCode,DistrictName,DistrictCode,IsApprove,MotherId,FatherId,UpdateDateTime)
	  values(@ResidentID,@GramPanchayatID,@BirthDate,@BirthPlace,@PersonName,@Gender,@MotherName,@MotherAdhar,@MotherEducation,@MotherJob,@MotherMarriageAge,@FatherName,@FatherAdhar,@FatherEducation,@FatherJob,@CurrAddress,@CurrVillage,@CurrIsStayVillage,@CurrDisrict
	                         ,@CurrState,@PerAddress,@PerIsStayVillage,@PerVillage,@PerDisrict,@PerState,@Religion,@ChildCount,@DeliveryPlace,@DeliveryType,@BabyWeight,@DeliveryDuration,@InformerName,@InformerAdd,@InformerSign,@RegiNumber,@RegiDate,@RegiOrg,@RegiCityVillage,@RegiDistrict
							 ,@RegiRemarks,@RegiName,@RegiCode,@VillageName,@VillageCode,@TalukaName,@TalukaCode,@DistrictName,@DistrictCode,@IsApprove,@MotherID,@FatherID,GETDATE())
	  select @ID= IDENT_CURRENT('BirthMaster')

	  ---For Notifications--
	  Insert Into Notifications (GrampanchayatId,NotificationName,ControllerName,ActionName,Parameter) 
	  Values (@GramPanchayatID,@PersonName+' '+@LastName+' is requesting for BirthMaster','BirthMaster','Edit',@ID)

	  ----------------------
	  --FOR REQUEST DEMAND LIST---
	  set @RequestCetificateName='Birth Certificate'
	  insert into RequestCertificate(ResidentID,GrampanchayatID,RequestFor,IsApprove,IsActive,Remark,HouseID,SupportingDocument,RequestID,UpdateDateTime) 
	values (@ResidentID,@GramPanchayatID,4,0,1,@RegiRemarks,@HouseID,'',@ID,GETDATE())
	  --------------------------------
	Exec USP_NotificationMaster 2,null,@GramPanchayatID,@ResidentID,0,'REQUEST CERTIFICATE ','Your Request For Birth Certificate Is Genereated And Soon Will Get Verified By Grampanchayat'

	end

	If @Action = 3 
	 Begin
	   delete from BirthMaster where ID=@ID
	 end
    
	If @Action = 4
	 Begin
	   	  select * ,Rc.ID'RequestCertificateID' from BirthMaster join RequestCertificate RC on RC.RequestID=BirthMaster.ID where BirthMaster.ID=@ID
	 end
    
	If @Action = 5
	 Begin
	  select @LastName = LastName,@HouseID=HouseID, @FatherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@FatherID 
	  select @MotherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@MotherID 

	   if @IsApprove = 1
	   Begin
	       Update Resident set IsActive= 1 where ID = @ResidentID
	   end

	   if @ID>0
	   Begin
	     update Notifications set IsActive=0 where parameter = @ID and ControllerName = 'BirthMaster'
	   end

	   Update BirthMaster set	    
		 ResidentID=@ResidentID
		,GramPanchayatID=@GramPanchayatID
		,BirthDate=@BirthDate
		,BirthPlace=@BirthPlace
		,PersonName=@PersonName
		,Gender=@Gender
		,MotherName=@MotherName
		,MotherAdhar=@MotherAdhar
		,MotherEducation=@MotherEducation
		,MotherJob=@MotherJob
		,MotherMarriageAge=@MotherMarriageAge
		,FatherName=@FatherName
		,FatherAdhar=@FatherAdhar
		,FatherEducation=@FatherEducation
		,FatherJob=@FatherJob
		,CurrAddress=@CurrAddress
		,CurrVillage=@CurrVillage
		,CurrIsStayVillage=@CurrIsStayVillage
		,CurrDisrict=@CurrDisrict
		,CurrState=@CurrState
		,PerAddress=@PerAddress
		,PerIsStayVillage=@PerIsStayVillage
		,PerVillage=@PerVillage
		,PerDisrict=@PerDisrict
		,PerState=@PerState
		,Religion=@Religion
		,ChildCount=@ChildCount
		,DeliveryPlace=@DeliveryPlace
		,DeliveryType=@DeliveryType
		,BabyWeight=@BabyWeight
		,DeliveryDuration=@DeliveryDuration
		,InformerName=@InformerName
		,InformerAdd=@InformerAdd
		,InformerSign=@InformerSign
		,RegiNumber=@RegiNumber
		,RegiDate=@RegiDate
		,RegiOrg=@RegiOrg
		,RegiCityVillage=@RegiCityVillage
		,RegiDistrict=@RegiDistrict
		,RegiRemarks=@RegiRemarks
		,RegiName=@RegiName
		,RegiCode=@RegiCode
		,VillageName=@VillageName
		,VillageCode=@VillageCode
		,TalukaName=@TalukaName
		,TalukaCode=@TalukaCode
		,DistrictName=@DistrictName
		,DistrictCode=@DistrictCode
		,IsApprove=@IsApprove
		,MotherId=@MotherID
		,FatherId=@FatherID
		,UpdateDateTime=GETDATE()
		where ID=@ID
		select @ID
	 end

	 IF @Action=11--Resident Birth Certificate
	 begin
	 select BM.ID,BM.BirthDate,BM.BirthPlace,PersonName,BM.MotherName,BM.FatherName,BM.IsApprove from BirthMaster BM
	 left join Resident R on R.ID=BM.ResidentID
	 where R.HouseID=@HouseIds and  BM.GramPanchayatID = @GramPanchayatID

	Exec USP_NotificationMaster 3,null,@GramPanchayatID,@ResidentId,0,null,null


	 end 

	 If @Action = 12
	 Begin
	  select  ID,ResidentID,GramPanchayatID,BirthDate,BirthPlace,PersonName,Gender,MotherName,isnull(MotherAdhar,''),isnull(MotherEducation,''),isnull(MotherJob,''),MotherMarriageAge,FatherName,
	  isnull(FatherAdhar,''),isnull(FatherEducation,''),isnull(FatherJob,''),isnull(CurrAddress,''),isnull(CurrVillage,''),CurrIsStayVillage,isnull(CurrDisrict,''),isnull(CurrState,'')
	  ,isnull(PerAddress,''),PerIsStayVillage,isnull(PerVillage,''),
	  isnull(PerDisrict,''),isnull(PerState,''),
	  isnull(Religion,''),ChildCount,isnull(DeliveryPlace,''),isnull(DeliveryType,''),BabyWeight,DeliveryDuration,isnull(InformerName,''),isnull(InformerAdd,''),isnull(InformerSign,'')
	  ,isnull(RegiNumber,''),RegiDate,isnull(RegiOrg,''),
	  isnull(RegiCityVillage,''),isnull(RegiDistrict,''),
	  isnull(RegiRemarks,''),isnull(RegiName,''),isnull(RegiCode,''),isnull(VillageName,''),isnull(VillageCode,''),isnull(TalukaName,''),isnull(TalukaCode,''),isnull(DistrictName,''),isnull(DistrictCode,''),
	  IsApprove,MotherId,FatherId from BirthMaster where ResidentID=@ResidentID
	 end


------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	 If @Action = 13 --update birth certicate for mobile app
	 Begin
	  --select @LastName = LastName,@HouseID=HouseID, @FatherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@FatherID 
	  --select @MotherName = ISNULL(Title,'')+' '+ISNULL(FirstName,'')+' '+ISNULL(LastName,'') from Resident where Id=@MotherID 

	   if @IsApprove = 1
	   Begin
	       Update Resident set IsActive= 1 where ID = @ResidentID
	   end

	   if @ID>0
	   Begin
	     update Notifications set IsActive=0 where parameter = @ID and ControllerName = 'BirthMaster'
	   end

	   Update BirthMaster set	    		 
		IsApprove=@IsApprove		
		,UpdateDateTime=GETDATE()
		where ID=@ID

		update RequestCertificate set 
			IsApprove=@IsApprove
			,UpdateDateTime=GETDATE()
			where ID=@RequestCertificateID and GrampanchayatID=@GramPanchayatID	
	 end

	 
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
If @Action = 14  --------For Mobile app View Birth MAster
	 Begin
	   	 
		select BM.*   ,RC.ID'RequestCertificateID',RC.RequestFor from RequestCertificate RC 
		join Birthmaster BM on RC.RequestID=BM.ID 
		join Birthmaster BM1 on Rc.RequestFor= BM1.ID
		where BM.ID=@ID and BM.GramPanchayatID=@GramPanchayatID 
	 end

------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------



COMMIT TRANSACTION Trans_BirthMaster   
END TRY
BEGIN CATCH      
IF @@TRANCOUNT > 0  
 ROLLBACK TRANSACTION Trans_BirthMaster   
 ------------------------------------------------------------------------  
 INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
 VALUES (ERROR_NUMBER(),'USP_House',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
 ------------------------------------------------------------------------  
SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
END CATCH 


 
GO
/****** Object:  StoredProcedure [dbo].[USP_15_ConsumableStockRegister]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	<Priyanka Phapale>
-- Create date: 07-06-2021
-- Description:	15_ConsumableStockRegister Insert, Update, Delete,GET,Active, Dactive
-- =============================================
-- [[USP_15_ConsumableStockRegister]]4,3,'testng service','10.00','1.00','false',1

CREATE Proc [dbo].[USP_15_ConsumableStockRegister]
(
 @Action int 
,@ID int =null
,@GrampanchayatId int =null
,@Date date =null
,@InitialRemain decimal =null
,@TotalCountOrConclusion nvarchar(250)=null
,@Total decimal =null
,@GivenToOrDate date=null
,@GivenCountOrConclusion nvarchar(250)=null
,@Remain decimal =null
,@GivenBy nvarchar(250)=null
,@ReceivedBy nvarchar(250)=null
,@Remark nvarchar(250)=null
,@IsActive bit=null
,@Deleted bit=null
,@InsertedBy int=null
,@SearchText varchar(50) =null
,@Fromdate date=null
 ,@Todate date=null
 
)
as
BEGIN
if @Action = 1 -- Index
begin
  SET NOCOUNT ON;
  select ConsumableStockRegId,cast(Date as varchar(20))Date,InitialRemain,TotalCountOrConclusion ,Total,cast(GivenToOrDate as varchar(20))GivenToOrDate,GivenCountOrConclusion,Remain,GivenBy,ReceivedBy,Remark,IsActive from ConsumableStockRegister_15 with(nolock)  where Deleted=0
end
if @Action = 2 -- Insert
begin
  insert into ConsumableStockRegister_15 (GrampanchayatId,Date,InitialRemain,TotalCountOrConclusion,Total,GivenToOrDate,GivenCountOrConclusion,Remain,GivenBy,ReceivedBy,Remark,IsActive,Deleted,InsertDateTime,InsertedBy)
  values (@GrampanchayatId,@Date,@InitialRemain,@TotalCountOrConclusion,@Total,@GivenToOrDate,@GivenCountOrConclusion,@Remain,@GivenBy,@ReceivedBy,@Remark,1,0,GETDATE(),@InsertedBy)
end
if @Action = 3 -- Select for edit
begin
   SET NOCOUNT ON;
    select ConsumableStockRegId,cast(Date as varchar(20))Date,InitialRemain,TotalCountOrConclusion ,Total,cast(GivenToOrDate as varchar(20))GivenToOrDate,GivenCountOrConclusion,Remain,GivenBy,ReceivedBy,Remark,IsActive  from ConsumableStockRegister_15 with(nolock) where ConsumableStockRegId=@ID
end
if @Action = 4 -- Update
begin
   update ConsumableStockRegister_15 set 
   GrampanchayatId=@GrampanchayatId,
   Date=@Date,
   InitialRemain=@InitialRemain,
   TotalCountOrConclusion=@TotalCountOrConclusion,
   Total=@Total,
   GivenToOrDate=@GivenToOrDate,
   GivenCountOrConclusion=@GivenCountOrConclusion,
   Remain=@Remain,
   GivenBy=@GivenBy,
   ReceivedBy=@ReceivedBy,
   Remark=@Remark,
   IsActive=1,
   Deleted=0,
   InsertDateTime=GETDATE(),
   InsertedBy=@InsertedBy
   where ConsumableStockRegId=@ID

   SELECT @ID
end
if @Action = 5 -- Delete
begin
  update ConsumableStockRegister_15 set Deleted = 1 where ConsumableStockRegId=@ID
end
IF @Action=6---SEARCH
BEGIN

SET NOCOUNT ON;
   select ConsumableStockRegId,cast(Date as varchar(20))Date,InitialRemain,TotalCountOrConclusion ,Total,cast(GivenToOrDate as varchar(20))GivenToOrDate,GivenCountOrConclusion,Remain,GivenBy,ReceivedBy,Remark,IsActive 
   from ConsumableStockRegister_15 with(nolock)
   where Deleted=0 and InitialRemain like '%'+@SearchText+'%'or TotalCountOrConclusion like '%'+@SearchText+'%'or Remain like '%'+@SearchText+'%' and Date between @Fromdate and @Todate 
			
END
IF @Action=7----Details
BEGIN
  select ConsumableStockRegId,cast(Date as varchar(20))Date,InitialRemain,TotalCountOrConclusion ,Total,cast(GivenToOrDate as varchar(20))GivenToOrDate,GivenCountOrConclusion,Remain,GivenBy,ReceivedBy,Remark,IsActive from ConsumableStockRegister_15 with(nolock) 
  where Deleted=0
END

END
GO
/****** Object:  StoredProcedure [dbo].[USP_DeathMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--  USP_DeathMaster 3,1,1

CREATE Proc [dbo].[USP_DeathMaster]   
(  
	@Action int  
	,@GramPanchayatID int=null
	,@ResidentID int=null
	,@DeathMasterID int=null
	
	,@DeathDate date=null
	,@PersonName nvarchar(50)=null
	,@Age int=null
	,@AgeType nvarchar(20)=null
	
	,@MotherName nvarchar(50)=null
	,@MotherAdhar nvarchar(20)=null
	,@FatherName nvarchar(50)=null
	,@FatherAdhar nvarchar(20)=null
	,@SpouseName nvarchar(50)=null
	,@SpouseAdhar nvarchar(20)=null
	
	,@CurrAddress nvarchar(50)=null
	,@CurrVillage nvarchar(50)=null
	,@CurrIsStayVillage bit=null
	,@CurrDisrict nvarchar(50)=null
	,@CurrState nvarchar(50)=null
	,@PerAddress nvarchar(50)=null
	,@PerIsStayVillage bit=null
	,@PerVillage nvarchar(50)=null
	,@PerDisrict nvarchar(50)=null
	,@PerState nvarchar(50)=null
	
	,@DeathPlaceType nvarchar(50)=null
	,@DeathPlaceDetails nvarchar(50)=null
	,@Religion nvarchar(50)=null
	,@JobBusiness nvarchar(50)=null
	,@MedicalTreatmentType nvarchar(50)=null
	,@MedicalInstitutes nvarchar(50)=null
	,@IsMedicallyCertified bit=null
	,@DeathReason nvarchar(50)=null
	,@IsDeathDuringPregnancy bit=null
	,@PregnancyDetails nvarchar(50)=null
	,@AddictionDetails nvarchar(50)=null
	,@AddictionDuration nvarchar(50)=null
	
	,@InformerName nvarchar(50)=null
	,@InformerAdd nvarchar(50)=null
	,@InformerSign nvarchar(50)=null
	
	,@RegiNumber nvarchar(50)=null
	,@RegiDate date=null
	,@RegiOrg nvarchar(50)=null
	,@RegiCityVillage nvarchar(50)=null
	,@RegiDistrict nvarchar(50)=null
	,@RegiRemarks nvarchar(50)=null
	
	,@RegisetrName nvarchar(50)=null
	,@RegisetrCode nvarchar(50)=null
	,@VillageName nvarchar(50)=null
	,@VillageCode nvarchar(50)=null
	,@TalukaName nvarchar(50)=null
	,@TalukaCode nvarchar(50)=null
	,@DistrictName nvarchar(50)=null
	,@DistrictCode nvarchar(50)=null
	
	,@HandoverDate date=null
	,@HandoverBy nvarchar(50)=null
	,@HandoverByAdd nvarchar(50)=null
	,@HandoverBySign nvarchar(50)=null
	
	,@DocWrittenApp nvarchar(50)=null
	,@DocGuaranteeApp nvarchar(50)=null
	,@DocFuneralApp nvarchar(50)=null
	
	,@IsApprove Int=null
	,@IsActive bit=null
	,@InsertDateTime datetime2=null,

	@HouseId Int=null,
	@RequestCertificateID int =null,
	@URL varchar(100)=null
)  
as  
begin Try      
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=1 --fetch  
begin  
 exec [dbo].[SP_KILL_SPID]; 
 Select ID,DeathDate,PersonName,CurrAddress+','+CurrVillage'CurrAddCurrVillage',PerAddress+','+PerVillage'PerAddressPerVillage',ResidentID
 ,cast((case when (select count(ID) from Resident RS where RS.ID=DM.ResidentID)>0 then 1 else 0 end) as bit)CountID,
 IsApprove
 from DeathMaster DM
 where GramPanchayatID=@GramPanchayatID
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=2 --fetch specific  
begin  
select
		DM.ID,isnull(DeathDate,'')DeathDate,isnull(PersonName,'')PersonName,isnull(AdharCardNo,'')AdharCardNo,isnull(Gender,'')Gender
	,isnull(DM.MotherName,'')MotherName,isnull(MotherAdhar,'')MotherAdhar,isnull(DM.FatherName,'')FatherName,isnull(FatherAdhar,'')FatherAdhar,isnull(DM.SpouseName,'')SpouseName,isnull(SpouseAdhar,'')SpouseAdhar
	,isnull(CurrAddress,'')CurrAddress,isnull(CurrVillage,'')CurrVillage,isnull(CurrIsStayVillage,'')CurrIsStayVillage,isnull(CurrDisrict,'')CurrDisrict,isnull(CurrState,'')CurrState
	,isnull(PerAddress,'')PerAddress,isnull(PerVillage,'')PerVillage,isnull(PerIsStayVillage,'')PerIsStayVillage,isnull(PerDisrict,'')PerDisrict,isnull(PerState,'')PerState

	,isnull(Age,'')Age,isnull(AgeType,'')AgeType
	,isnull(DeathPlaceType,'')DeathPlaceType,isnull(DeathPlaceDetails,'')DeathPlaceDetails
	,isnull(Religion,'')Religion,isnull(JobBusiness,'')JobBusiness
	,isnull(MedicalTreatmentType,'')MedicalTreatmentType,isnull(MedicalInstitutes,'')MedicalInstitutes,isnull(IsMedicallyCertified,'')IsMedicallyCertified

	,isnull(DeathReason,'')DeathReason,isnull(IsDeathDuringPregnancy,'')IsDeathDuringPregnancy,isnull(PregnancyDetails,'')PregnancyDetails
	,isnull(AddictionDetails,'')AddictionDetails,isnull(AddictionDuration,'')AddictionDuration
	
	,isnull(InformerName,'')InformerName,isnull(InformerAdd,'')InformerAdd,isnull(InformerSign,'')InformerSign

	,isnull(RegiNumber,'')RegiNumber,isnull(RegiDate,'')RegiDate,isnull(RegiOrg,'')RegiOrg,isnull(RegiCityVillage,'')RegiCityVillage,isnull(RegiDistrict,'')RegiDistrict,isnull(RegiRemarks,'')RegiRemarks,isnull(RegisetrName,'')RegisetrName,isnull(RegisetrCode,'')RegisetrCode
	
	,isnull(VillageName,'')VillageName,isnull(VillageCode,'')VillageCode,isnull(TalukaName,'')TalukaName,isnull(TalukaCode,'')TalukaCode,isnull(DistrictName,'')DistrictName,isnull(DistrictCode,'')DistrictCode

	,isnull(HandoverDate,'')HandoverDate,isnull(HandoverBy,'')HandoverBy,isnull(HandoverByAdd,'')HandoverByAdd,isnull(HandoverBySign,'')HandoverBySign
	--,isnull(DocWrittenApp,'')DocWrittenApp,isnull(DocGuaranteeApp,'')DocGuaranteeApp,isnull(DocFuneralApp,'')DocFuneralApp
	,isnull(@URL+DocWrittenApp,'')'DocWrittenApp'
	,isnull(@URL+DocGuaranteeApp,'')'DocGuaranteeApp'
	,isnull(@URL+DocFuneralApp,'')'DocFuneralApp'
	,isnull(IsApprove,'')IsApprove,isnull(DM.IsActive,'')IsActive,isnull(InsertDateTime,'')InsertDateTime
	,cast((case when (select count(ID)ID from Resident RS where RS.ID=DM.ResidentID)>0 then 1 else 0 end) as bit)ID

 from DeathMaster DM
 join Resident RD on DM.ResidentID=RD.ID
 where DM.ID=@DeathMasterID --and Dm.GramPanchayatID=1
end  
-----------------------------------------------------  

-----------------------------------------------------  
if @Action=3 --insert
begin  
		 insert into DeathMaster(ResidentID,GramPanchayatID,DeathDate,PersonName,MotherName,MotherAdhar,FatherName,FatherAdhar,SpouseName,SpouseAdhar
		 ,CurrAddress,CurrVillage,CurrIsStayVillage,CurrDisrict,CurrState,PerAddress,PerIsStayVillage,PerVillage,PerDisrict,PerState,Age,AgeType
		 ,DeathPlaceType,DeathPlaceDetails,Religion,JobBusiness,MedicalTreatmentType,MedicalInstitutes,IsMedicallyCertified,DeathReason
		 ,IsDeathDuringPregnancy,PregnancyDetails,AddictionDetails,AddictionDuration,InformerName,InformerAdd,InformerSign
		 ,RegiNumber,RegiDate,RegiOrg,RegiCityVillage,RegiDistrict,RegiRemarks,RegisetrName,RegisetrCode,VillageName,VillageCode,TalukaName,TalukaCode,DistrictName,DistrictCode
		 ,HandoverDate,HandoverBy,HandoverByAdd,HandoverBySign,DocWrittenApp,DocGuaranteeApp,DocFuneralApp,UpdateDateTime)

		 values (@ResidentID,@GramPanchayatID,@DeathDate,@PersonName,@MotherName,@MotherAdhar,@FatherName,@FatherAdhar,@SpouseName,@SpouseAdhar
		 ,@CurrAddress,@CurrVillage,@CurrIsStayVillage,@CurrDisrict,@CurrState,@PerAddress,@PerIsStayVillage,@PerVillage,@PerDisrict,@PerState,@Age,@AgeType
		 ,@DeathPlaceType,@DeathPlaceDetails,@Religion,@JobBusiness,@MedicalTreatmentType,@MedicalInstitutes,@IsMedicallyCertified,@DeathReason
		 ,@IsDeathDuringPregnancy,@PregnancyDetails,@AddictionDetails,@AddictionDuration,@InformerName,@InformerAdd,@InformerSign
		 ,@RegiNumber,@RegiDate,@RegiOrg,@RegiCityVillage,@RegiDistrict,@RegiRemarks,@RegisetrName,@RegisetrCode,@VillageName,@VillageCode,@TalukaName,@TalukaCode,@DistrictName,@DistrictCode
		 ,@HandoverDate,@HandoverBy,@HandoverByAdd,@HandoverBySign,@DocWrittenApp,@DocGuaranteeApp,@DocFuneralApp,GETDATE())

		 set @DeathMasterID=IDENT_CURRENT('DeathMaster');

		 		select @HouseID= R.HouseID from DeathMaster M
				left Join Resident R on R.ID=M.ResidentID
				where M.ResidentID=@ResidentID

		--For Notifications--
        Insert Into Notifications (NotificationName,ControllerName,ActionName,Parameter,GrampanchayatId) 
		Values (isnull(@PersonName,'')+' is requesting for DeathCertificate','DeathMaster','Edit',@DeathMasterID,@GramPanchayatID)
		----------------------
	  insert into RequestCertificate(ResidentID,GrampanchayatID,RequestFor,IsApprove,IsActive,Remark,HouseID,SupportingDocument,RequestID,UpdateDateTime) 
		values (@ResidentID,@GramPanchayatID,6,0,1,'',@HouseID,'',@DeathMasterID,GETDATE())

		 update DeathMaster
		 set DocWrittenApp=cast(@DeathMasterID as varchar(5))+@DocWrittenApp
			,DocGuaranteeApp=cast(@DeathMasterID as varchar(5))+@DocGuaranteeApp
			,DocFuneralApp=cast(@DeathMasterID as varchar(5))+@DocFuneralApp
		 where ID=@DeathMasterID
		  --------------------------------
	Exec USP_NotificationMaster 2,null,@GramPanchayatID,@ResidentID,0,'REQUEST CERTIFICATE ','Your Request For Birth Certificate Is Genereated And Soon Will Get Verified By Grampanchayat'
		select IDENT_CURRENT('DeathMaster')

end 
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=4 --update  
begin  
 update DeathMaster
set
	ResidentID=@ResidentID
	,GramPanchayatID=@GramPanchayatID
	,DeathDate=@DeathDate
	,PersonName=@PersonName
	,MotherName=@MotherName
	,MotherAdhar=@MotherAdhar
	,FatherName=@FatherName
	,FatherAdhar=@FatherAdhar
	,SpouseName=@SpouseName
	,SpouseAdhar=@SpouseAdhar
	,CurrAddress=@CurrAddress
	,CurrVillage=@CurrVillage
	,CurrIsStayVillage=@CurrIsStayVillage
	,CurrDisrict=@CurrDisrict
	,CurrState=@CurrState
	,PerAddress=@PerAddress
	,PerIsStayVillage=@PerIsStayVillage
	,PerVillage=@PerVillage
	,PerDisrict=@PerDisrict
	,PerState=@PerState
	,Age=@Age
	,AgeType=@AgeType
	,DeathPlaceType=@DeathPlaceType
	,DeathPlaceDetails=@DeathPlaceDetails
	,Religion=@Religion
	,JobBusiness=@JobBusiness
	,MedicalTreatmentType=@MedicalTreatmentType
	,MedicalInstitutes=@MedicalInstitutes
	,IsMedicallyCertified=@IsMedicallyCertified
	,DeathReason=@DeathReason
	,IsDeathDuringPregnancy=@IsDeathDuringPregnancy
	,PregnancyDetails=@PregnancyDetails
	,AddictionDetails=@AddictionDetails
	,AddictionDuration=@AddictionDuration
	,InformerName=@InformerName
	,InformerAdd=@InformerAdd
	,InformerSign=@InformerSign
	,RegiNumber=@RegiNumber
	,RegiDate=@RegiDate
	,RegiOrg=@RegiOrg
	,RegiCityVillage=@RegiCityVillage
	,RegiDistrict=@RegiDistrict
	,RegiRemarks=@RegiRemarks
	,RegisetrName=@RegisetrName
	,RegisetrCode=@RegisetrCode
	,VillageName=@VillageName
	,VillageCode=@VillageCode
	,TalukaName=@TalukaName
	,TalukaCode=@TalukaCode
	,DistrictName=@DistrictName
	,DistrictCode=@DistrictCode
	,HandoverDate=@HandoverDate
	,HandoverBy=@HandoverBy
	,HandoverByAdd=@HandoverByAdd
	,HandoverBySign=@HandoverBySign
	,IsApprove=@IsApprove
	,IsActive=@IsActive
	,UpdateDateTime=GETDATE()
where ID=@DeathMasterID
update Notifications set IsActive= 0 where Parameter = @DeathMasterID and ControllerName ='DeathMaster'
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=5 --delete  
begin  
 delete from DeathMaster where id=@DeathMasterID
end
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=6 --select resident  
begin  
  Select ID,FirstName+' '+LastName+':'+Gender+':'+AdharCardNo
 from Resident RS
 where GramPanchayatID=@GramPanchayatID and IsActive=1
end
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=7 --select resident  details
begin  
Declare @Result nvarchar(max),@ResidentName nvarchar(50),@Adhar nvarchar(50),@Gender nvarchar(50),@Address nvarchar(50),@FatherID int,@MotherID int,@SpouseID int;
  select * into #Resi from Resident where GramPanchayatID=@GramPanchayatID and IsActive=1;
  --select * from #Resi

  Select @GramPanchayatID=GramPanchayatID,@ResidentID=ID,@ResidentName=FirstName+' '+LastName,@Adhar=AdharCardNo,@Gender=Gender,@Address=Address,@FatherID=FatherID,@MotherID=MotherID,@SpouseID=@SpouseID 
  from #Resi where ID=@ResidentID;

  Select @FatherName=FirstName+' '+LastName,@FatherAdhar=AdharCardNo from #Resi where ID=@FatherID;
  Select @MotherName=FirstName+' '+LastName,@MotherAdhar=AdharCardNo from #Resi where ID=@MotherID;
  Select @SpouseName=FirstName+' '+LastName,@SpouseAdhar=AdharCardNo from #Resi where ID=@SpouseID;
  
  select @Result = COALESCE(@Result + '~', '')+cast(isnull(@GramPanchayatID,'') as nvarchar(10))--0
  +'#'+cast(isnull(@ResidentID,'') as nvarchar(10))+'#'+isnull(@ResidentName,'')+'#'+isnull(@Gender,'')+'#'+isnull(@Adhar,'')+'#'+isnull(@Address,'')--5
  +'#'+cast(isnull(@FatherID,'') as nvarchar(10))+'#'+isnull(@FatherName,'')+'#'+isnull(@FatherAdhar,'')--8
  +'#'+cast(isnull(@MotherID,'') as nvarchar(10))+'#'+isnull(@MotherName,'')+'#'+isnull(@MotherAdhar,'')--11
  +'#'+cast(isnull(@SpouseID,'') as nvarchar(10))+'#'+isnull(@SpouseName,'')+'#'+isnull(@SpouseAdhar,'')--14

  select @Result
end
-----------------------------------------------------   
-----------------------------------------------------  
--RESIDENT LOGIN DEATH LIST
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=11 --fetch  
begin  
 Select DM.ID,DeathDate,PersonName,ISNULL(CurrAddress,'')+','+ISNULL(CurrVillage,'')'Current Address',ISNULL(PerAddress,'')+','+ISNULL(PerVillage,'')'Permenent Address'
 ,cast((case when (select count(ID) from Resident RS where RS.ID=DM.ResidentID)>0 then 1 else 0 end) as bit)'IsUse',DM.IsApprove
 from DeathMaster DM
 LEFT JOIN Resident R on R.ID=DM.ResidentID
 where DM.GramPanchayatID=@GramPanchayatID and R.HouseID=@HouseId 

	Exec USP_NotificationMaster 3,null,@GramPanchayatID,@ResidentId,0,null,null

end  
-----------------------------------------------------  
if @Action=12 --fetch specific  
begin  
select
	DM.ID,isnull(DeathDate,''),isnull(PersonName,''),isnull(AdharCardNo,''),isnull(Gender,'')
	,isnull(DM.MotherName,''),isnull(MotherAdhar,''),isnull(DM.FatherName,''),isnull(FatherAdhar,''),isnull(DM.SpouseName,''),isnull(SpouseAdhar,'')
	,isnull(CurrAddress,''),isnull(CurrVillage,''),CurrIsStayVillage,isnull(CurrDisrict,''),isnull(CurrState,'')
	,isnull(PerAddress,''),isnull(PerVillage,''),PerIsStayVillage,isnull(PerDisrict,''),isnull(PerState,'')
	,isnull(Age,''),isnull(AgeType,'')
	,isnull(DeathPlaceType,''),isnull(DeathPlaceDetails,'')
	,isnull(Religion,''),isnull(JobBusiness,'')
	,isnull(MedicalTreatmentType,''),isnull(MedicalInstitutes,''),isnull(IsMedicallyCertified,'')
	,isnull(DeathReason,''),isnull(IsDeathDuringPregnancy,''),isnull(PregnancyDetails,'')
	,isnull(AddictionDetails,''),isnull(AddictionDuration,'')
	,isnull(InformerName,''),isnull(InformerAdd,''),isnull(InformerSign,'')
	,isnull(RegiNumber,''),isnull(RegiDate,''),isnull(RegiOrg,''),isnull(RegiCityVillage,''),isnull(RegiDistrict,''),isnull(RegiRemarks,''),isnull(RegisetrName,''),isnull(RegisetrCode,'')
	,isnull(VillageName,''),isnull(VillageCode,''),isnull(TalukaName,''),isnull(TalukaCode,''),isnull(DistrictName,''),isnull(DistrictCode,'')
	,isnull(HandoverDate,''),isnull(HandoverBy,''),isnull(HandoverByAdd,''),isnull(HandoverBySign,'')
	,isnull(DocWrittenApp,''),isnull(DocGuaranteeApp,''),isnull(DocFuneralApp,'')
	--,isnull('http://grampanchayat.akeria.in/DeathImage/'+DocWrittenApp,'')'DocWrittenApp'
	--,isnull('http://grampanchayat.akeria.in/DeathImage/'+DocGuaranteeApp,'')'DocGuaranteeApp'
	--,isnull('http://grampanchayat.akeria.in/DeathImage/'+DocFuneralApp,'')'DocFuneralApp'
	,isnull(IsApprove,''),isnull(DM.IsActive,''),isnull(InsertDateTime,'')
	,cast((case when (select count(ID) from Resident RS where RS.ID=DM.ResidentID)>0 then 1 else 0 end) as bit)

 from DeathMaster DM
 join Resident RD on DM.ResidentID=RD.ID
 where DM.ResidentID=@ResidentID
end  




------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
	 If @Action = 13 --update Death certicate for mobile app
	 Begin
	 update DeathMaster set	
		IsApprove=@IsApprove	
		where ID=@DeathMasterID
------------------------------------------------------------------------------------------------------------------------
	 update Notifications set IsActive= 0 where Parameter = @DeathMasterID and ControllerName ='DeathMaster'
------------------------------------------------------------------------------------------------------------------------
	 update RequestCertificate set 
		IsApprove=@IsApprove
		where ID=@RequestCertificateID and GrampanchayatID=@GramPanchayatID	
	 end

	 
------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
If @Action = 14  --------For Mobile app View Death MAster
	 Begin
	   
    select DM.*  
	,isnull(@URL+DM.DocWrittenApp,'')'DocWrittenApp'
	,isnull(@URL+DM.DocGuaranteeApp,'')'DocGuaranteeApp'
	,isnull(@URL+DM.DocFuneralApp,'')'DocFuneralApp'
	,RC.ID'RequestCertificateID',RC.RequestFor from RequestCertificate RC 
	join DeathMaster DM on RC.RequestID=DM.ID 
	join DeathMaster DM1 on Rc.RequestFor= DM1.ID
	where DM.ID=@DeathMasterID and DM.GramPanchayatID=@GramPanchayatID
  
  END------------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------------
if @Action=15 --Death Details For Mobile App
begin  
select
		DM.ID,isnull(DeathDate,'')DeathDate,isnull(PersonName,'')PersonName,isnull(AdharCardNo,'')AdharCardNo,isnull(Gender,'')Gender
	,isnull(DM.MotherName,'')MotherName,isnull(MotherAdhar,'')MotherAdhar,isnull(DM.FatherName,'')FatherName,isnull(FatherAdhar,'')FatherAdhar,isnull(DM.SpouseName,'')SpouseName,isnull(SpouseAdhar,'')SpouseAdhar
	,isnull(CurrAddress,'')CurrAddress,isnull(CurrVillage,'')CurrVillage,isnull(CurrIsStayVillage,'')CurrIsStayVillage,isnull(CurrDisrict,'')CurrDisrict,isnull(CurrState,'')CurrState
	,isnull(PerAddress,'')PerAddress,isnull(PerVillage,'')PerVillage,isnull(PerIsStayVillage,'')PerIsStayVillage,isnull(PerDisrict,'')PerDisrict,isnull(PerState,'')PerState

	,isnull(Age,'')Age,isnull(AgeType,'')AgeType
	,isnull(DeathPlaceType,'')DeathPlaceType,isnull(DeathPlaceDetails,'')DeathPlaceDetails
	,isnull(Religion,'')Religion,isnull(JobBusiness,'')JobBusiness
	,isnull(MedicalTreatmentType,'')MedicalTreatmentType,isnull(MedicalInstitutes,'')MedicalInstitutes,isnull(IsMedicallyCertified,'')IsMedicallyCertified

	,isnull(DeathReason,'')DeathReason,isnull(IsDeathDuringPregnancy,'')IsDeathDuringPregnancy,isnull(PregnancyDetails,'')PregnancyDetails
	,isnull(AddictionDetails,'')AddictionDetails,isnull(AddictionDuration,'')AddictionDuration
	
	,isnull(InformerName,'')InformerName,isnull(InformerAdd,'')InformerAdd,isnull(InformerSign,'')InformerSign

	,isnull(RegiNumber,'')RegiNumber,isnull(RegiDate,'')RegiDate,isnull(RegiOrg,'')RegiOrg,isnull(RegiCityVillage,'')RegiCityVillage,isnull(RegiDistrict,'')RegiDistrict,isnull(RegiRemarks,'')RegiRemarks,isnull(RegisetrName,'')RegisetrName,isnull(RegisetrCode,'')RegisetrCode
	
	,isnull(VillageName,'')VillageName,isnull(VillageCode,'')VillageCode,isnull(TalukaName,'')TalukaName,isnull(TalukaCode,'')TalukaCode,isnull(DistrictName,'')DistrictName,isnull(DistrictCode,'')DistrictCode

	,isnull(HandoverDate,'')HandoverDate,isnull(HandoverBy,'')HandoverBy,isnull(HandoverByAdd,'')HandoverByAdd,isnull(HandoverBySign,'')HandoverBySign
	--,isnull(DocWrittenApp,'')DocWrittenApp,isnull(DocGuaranteeApp,'')DocGuaranteeApp,isnull(DocFuneralApp,'')DocFuneralApp
	,isnull(@URL+DM.DocWrittenApp,'')'DocWrittenApp'
	,isnull(@URL+DM.DocGuaranteeApp,'')'DocGuaranteeApp'
	,isnull(@URL+DM.DocFuneralApp,'')'DocFuneralApp'
	,isnull(IsApprove,'')IsApprove,isnull(DM.IsActive,'')IsActive,isnull(InsertDateTime,'')InsertDateTime
	,cast((case when (select count(ID)ID from Resident RS where RS.ID=DM.ResidentID)>0 then 1 else 0 end) as bit)ID

 from DeathMaster DM
 join Resident RD on DM.ResidentID=RD.ID
 where DM.ID=@DeathMasterID
 END
 -----------------------------------------------------  

-----------------------------------------------------  
if @Action=16 --insert For Mobile Application
begin  
		 insert into DeathMaster(ResidentID,GramPanchayatID,DeathDate,PersonName,MotherName,MotherAdhar,FatherName,FatherAdhar,SpouseName,SpouseAdhar
		 ,CurrAddress,CurrVillage,CurrIsStayVillage,CurrDisrict,CurrState,PerAddress,PerIsStayVillage,PerVillage,PerDisrict,PerState,Age,AgeType
		 ,DeathPlaceType,DeathPlaceDetails,Religion,JobBusiness,MedicalTreatmentType,MedicalInstitutes,IsMedicallyCertified,DeathReason
		 ,IsDeathDuringPregnancy,PregnancyDetails,AddictionDetails,AddictionDuration,InformerName,InformerAdd,InformerSign
		 ,RegiNumber,RegiDate,RegiOrg,RegiCityVillage,RegiDistrict,RegiRemarks,RegisetrName,RegisetrCode,VillageName,VillageCode,TalukaName,TalukaCode,DistrictName,DistrictCode
		 ,HandoverDate,HandoverBy,HandoverByAdd,HandoverBySign,DocWrittenApp,DocGuaranteeApp,DocFuneralApp,UpdateDateTime)

		 values (@ResidentID,@GramPanchayatID,@DeathDate,@PersonName,@MotherName,@MotherAdhar,@FatherName,@FatherAdhar,@SpouseName,@SpouseAdhar
		 ,@CurrAddress,@CurrVillage,@CurrIsStayVillage,@CurrDisrict,@CurrState,@PerAddress,@PerIsStayVillage,@PerVillage,@PerDisrict,@PerState,@Age,@AgeType
		 ,@DeathPlaceType,@DeathPlaceDetails,@Religion,@JobBusiness,@MedicalTreatmentType,@MedicalInstitutes,@IsMedicallyCertified,@DeathReason
		 ,@IsDeathDuringPregnancy,@PregnancyDetails,@AddictionDetails,@AddictionDuration,@InformerName,@InformerAdd,@InformerSign
		 ,@RegiNumber,@RegiDate,@RegiOrg,@RegiCityVillage,@RegiDistrict,@RegiRemarks,@RegisetrName,@RegisetrCode,@VillageName,@VillageCode,@TalukaName,@TalukaCode,@DistrictName,@DistrictCode
		 ,@HandoverDate,@HandoverBy,@HandoverByAdd,@HandoverBySign,@DocWrittenApp,@DocGuaranteeApp,@DocFuneralApp,GETDATE())

		 set @DeathMasterID=IDENT_CURRENT('DeathMaster');

		 		select @HouseID= R.HouseID from DeathMaster M
				left Join Resident R on R.ID=M.ResidentID
				where M.ResidentID=@ResidentID

		--For Notifications--
        Insert Into Notifications (NotificationName,ControllerName,ActionName,Parameter,GrampanchayatId) 
		Values (isnull(@PersonName,'')+' is requesting for DeathCertificate','DeathMaster','Edit',@DeathMasterID,@GramPanchayatID)
		----------------------
	  insert into RequestCertificate(ResidentID,GrampanchayatID,RequestFor,IsApprove,IsActive,Remark,HouseID,SupportingDocument,RequestID,UpdateDateTime) 
		values (@ResidentID,@GramPanchayatID,6,0,1,'',@HouseID,'',@DeathMasterID,GETDATE())

		 --update DeathMaster
		 --set DocWrittenApp=cast(@DeathMasterID as varchar(5))+@DocWrittenApp
			--,DocGuaranteeApp=cast(@DeathMasterID as varchar(5))+@DocGuaranteeApp
			--,DocFuneralApp=cast(@DeathMasterID as varchar(5))+@DocFuneralApp
		 --where ID=@DeathMasterID
		  --------------------------------
	Exec USP_NotificationMaster 2,null,@GramPanchayatID,@ResidentID,0,'REQUEST CERTIFICATE ','Your Request For Birth Certificate Is Genereated And Soon Will Get Verified By Grampanchayat'
		select IDENT_CURRENT('DeathMaster')

end 
 ---====================================================================================================================================================
end try      
begin catch      
IF @@TRANCOUNT > 0  
-- ROLLBACK TRANSACTION Trans_StaffDetails   
 ------------------------------------------------------------------------  
 INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
  VALUES (ERROR_NUMBER(),'USP_House',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
 ------------------------------------------------------------------------  
 SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
end catch 
GO
/****** Object:  StoredProcedure [dbo].[USP_DESIGNATION]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



--  select * from Designation

CREATE PROC [dbo].[USP_DESIGNATION] 
(
  @ActionId int ,
  @ID Int = null,
  @DesignationName nvarchar(50) = null,
  @IsActive bit = null	  	
)
AS 
BEGIN
  IF @ACTIONID = 1 
   BEGIN
     SELECT * FROM DESIGNATION
   END 
  ELSE IF @ACTIONID = 2 
   BEGIN
     INSERT INTO DESIGNATION (DESIGNATIONNAME,ISACTIVE)
	 VALUES (@DESIGNATIONNAME,@ISACTIVE)
	 SELECT IDENT_CURRENT('DESIGNATION')
   END
   ELSE IF @ACTIONID = 3
    BEGIN
		UPDATE DESIGNATION SET DESIGNATIONNAME=@DESIGNATIONNAME ,  ISACTIVE=@ISACTIVE WHERE ID=@ID
		SELECT @ID
	END
   ELSE IF @ACTIONID = 4 
     BEGIN
	   DELETE FROM DESIGNATION WHERE ID= @ID
	 END
   IF @ACTIONID = 5 
   BEGIN
     SELECT * FROM DESIGNATION WHERE ID= @ID
   END 
   IF @ACTIONID = 6 
   BEGIN
     SELECT * FROM DESIGNATION WHERE IsActive = 1
   END 
   -------------------------------------------------------------------------
   ------------------------ Add Desg For Mobile App-------------------------
    ELSE IF @ACTIONID = 7
   BEGIN
     INSERT INTO DESIGNATION (DESIGNATIONNAME,ISACTIVE)
	 VALUES (@DESIGNATIONNAME,@ISACTIVE)
   END
   
   -------------------------------------------------------------------------
   ------------------------ DropDown All For Mobile App-------------------------
     IF @ACTIONID = 8
   BEGIN
      SELECT 'DesignationName' as 'Name' ,ID as 'ID',DesignationName as 'VALUE' FROM DESIGNATION  WHERE IsActive = 1 --- DesignationName
	 
	 SELECT ID,DesignationName FROM DESIGNATION WHERE IsActive = 1 --- DesignationName
	 
     select ID,StatusName from MaritalStatus ---Marital Status
	 select ID,Categories from PhysDisableStatus ---Physically Challenged	
	 select ID,Title+' '+FirstName+' '+LastName+' '+isnull(FatherName,'')FatherName from Resident where  Gender = 'Male' and MaritalStatusID<>1 --FatherName 
	 select ID,Title+' '+FirstName+' '+LastName+' '+isnull(MotherName,'')MotherName from Resident where  Gender = 'Female' and MaritalStatusID <> 1 ----MotherName
	 select ID,(Title+' '+FirstName+' '+LastName)SpouseName from Resident   ---Spouse Name
	 Select ID,PropertyNo  from House where  IsActive = 1  ---House Number

   END 
END
GO
/****** Object:  StoredProcedure [dbo].[USP_ExceptionLog]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

create proc [dbo].[USP_ExceptionLog](
@PROC_NAME	varchar	(50)
,@EERROR_NUMBER	varchar	(100)
,@EERROR_SEVERITY	varchar	(100)
,@EERROR_STATE	varchar	(100)
,@EERROR_PROCEDURE	varchar	(100)
,@EERROR_LINE	varchar	(100)
,@EERROR_MESSAGE varchar(max)
)
as
begin
INSERT INTO ExceptionLog (PROC_NAME,EERROR_NUMBER,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE,InsertDateTime) 
VALUES (@PROC_NAME,@EERROR_NUMBER,@EERROR_SEVERITY,@EERROR_STATE,@EERROR_PROCEDURE,@EERROR_LINE,@EERROR_MESSAGE,GETDATE()); 
end
GO
/****** Object:  StoredProcedure [dbo].[USP_GramPanchayat]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
  
  
--exec [USP_House] 1,null,1  
  
CREATE Proc [dbo].[USP_GramPanchayat]   
(  
 @Action int  
 ,@GramPanchayatID int=null  
 ,@GramCode nvarchar(50)=null  
 ,@VillageName nvarchar(50)=null  
 ,@Block nvarchar(50)=null  
 ,@District nvarchar(50)=null  
 ,@State nvarchar(50)=null  
 ,@Pincode nvarchar(50)=null  
 ,@ContactNo nvarchar(50)=null  
 ,@EmailID nvarchar(50)=null  
 ,@IsActive bit=null  
)  
as  
begin Try      
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=1 --fetch  
begin  
 exec [dbo].[SP_KILL_SPID]  
 Select ID,GramCode,VillageName,Block,District,State,Pincode,ContactNo,EmailID
 from GramPanchayat HS  
 where ID=@GramPanchayatID  
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=2 --update  
begin  
 update GramPanchayat   
 set  
  VillageName=@VillageName  
  ,Block=@Block  
  ,District=@District  
  ,State=@State  
  ,Pincode=@Pincode  
  ,ContactNo=@ContactNo  
  ,EmailID=@EmailID  
 where ID=@GramPanchayatID  
end  
-----------------------------------------------------  
-----------------------------------------------------  
end try      
begin catch      
IF @@TRANCOUNT > 0  
 ROLLBACK TRANSACTION Trans_StaffDetails   
 ------------------------------------------------------------------------  
 INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
  VALUES (ERROR_NUMBER(),'USP_House',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
 ------------------------------------------------------------------------  
 SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
end catch 
GO
/****** Object:  StoredProcedure [dbo].[USP_House]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
 
  
--exec [USP_House] 1,null,1  
  
CREATE Proc [dbo].[USP_House]   
(  
 @Action int  
 ,@HouseID int=null  
 ,@GramPanchayatID int=null  
 ,@HouseHeadID int=null  
 ,@PropertyNo nvarchar(50)=null  
 ,@RegisterNo nvarchar(50)=null  
 ,@RegisterYear nvarchar(50)=null  
 ,@Area decimal(10,2)=null  
 ,@HomeTax decimal(10,2)=null  
 ,@LightTax decimal(10,2)=null  
 ,@HealthTax decimal(10,2)=null  
 ,@WaterTax decimal(10,2)=null  
 ,@BusinessTax decimal(10,2)=null  
 ,@ShopTax decimal(10,2)=null  
 ,@NoticeFee decimal(10,2)=null  
 ,@WarrantFee decimal(10,2)=null  
 ,@OtherTax decimal(10,2)=null  
 ,@HDescription nvarchar(50)=null  
 ,@IsActive bit=null
 ,@villageid int=null
 ,@SearchBy nvarchar(50)=null
)  
as  
begin Try      
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=1 --fetch  
begin  
  exec [dbo].[SP_KILL_SPID]  
  Select HS.ID,isnull(RS.FirstName,'')+' '+isnull(RS.LastName,'') 'Name' --,HS.HouseHeadID
 ,PropertyNo,RegisterNo,RegisterYear,isnull(Area,0),isnull(HomeTax,0),isnull(LightTax,0),isnull(HealthTax,0),isnull(WaterTax,0),isnull(BusinessTax,0),isnull(ShopTax,0),isnull(NoticeFee,0),isnull(WarrantFee,0),isnull(OtherTax,0),HDescription
 ,cast((select case when count(*)>0 then 1 else 0 end from Resident where HouseID=HS.ID) as bit) 'IsUse',V.VillageName,HS.VillageId
 from House HS with(nolock)
 join Village V on V.ID=HS.VillageId 
 left join Resident RS with(nolock) on HS.HouseHeadID=RS.ID
 where HS.GramPanchayatID=@GramPanchayatID and HS.IsActive=1 and HS.HouseHeadID>0 and HomeTax>0 and WaterTax>0
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=2 --fetch specific  
begin   
Select HS.ID,isnull(RS.FirstName,'')+' '+isnull(RS.LastName,'')  'Name'
 ,isnull(PropertyNo,'')PropertyNo,isnull(RegisterNo,'')RegisterNo,isnull(RegisterYear,'')RegisterYear,isnull(Area,0)Area,isnull(HomeTax,0)HomeTax,isnull(LightTax,0)LightTax,isnull(HealthTax,0)HealthTax,isnull(WaterTax,0)WaterTax
 ,isnull(BusinessTax,0)BusinessTax,
 isnull(ShopTax,0)ShopTax,isnull(NoticeFee,0)NoticeFee,isnull(WarrantFee,0)WarrantFee,isnull(OtherTax,0)OtherTax,isnull(HDescription,'') 'HDescription',isnull(G.VillageName,'')GVillageName,
 isnull(g.[Block],'')Block,isnull(G.District,'')District,isnull(HS.IsActive,0)IsActive,isnull(hs.VillageId,0)VillageId,isnull(v.VillageName,'')VillageName,isnull(HS.HouseHeadID,0)HouseHeadID
 from House HS with(nolock)
 left join Village V on V.ID=HS.VillageId 
 left join Resident RS with(nolock) on HS.HouseHeadID=RS.ID 
 left join Grampanchayat g with(nolock) on g.ID = HS.GramPanchayatID
 where HS.GramPanchayatID=@GramPanchayatID and HS.ID=@HouseID and HS.IsActive=1
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=3 --save  
begin  
 insert into House (GramPanchayatID,HouseHeadID,PropertyNo,RegisterNo,RegisterYear,Area,HomeTax,LightTax,HealthTax,WaterTax,BusinessTax,ShopTax,NoticeFee,WarrantFee,OtherTax,HDescription,IsActive,VillageId)  
 values (@GramPanchayatID,@HouseHeadID,@PropertyNo,@RegisterNo,@RegisterYear,@Area,@HomeTax,@LightTax,@HealthTax,@WaterTax,@BusinessTax,@ShopTax,@NoticeFee,@WarrantFee,@OtherTax,@HDescription,@IsActive,@villageid);
   
 set @HouseID = IDENT_CURRENT('House');
  
 insert into HouseTransfer (GramPanchayatID,HouseID,HouseHeadID,PropertyNo,RegisterNo,UpdaeDate,IsActive)  
 values (@GramPanchayatID,@HouseID,@HouseHeadID,@PropertyNo,@RegisterNo,getdate(),1);

 update Resident Set HouseID=@HouseID where ID=@HouseHeadID;
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=4 --update  
begin  
 update House   
 set  
  GramPanchayatID=@GramPanchayatID  
  ,HouseHeadID=@HouseHeadID  
  ,PropertyNo=@PropertyNo  
  ,RegisterNo=@RegisterNo  
  ,RegisterYear=@RegisterYear  
  ,Area=@Area  
  ,HomeTax=@HomeTax  
  ,LightTax=@LightTax  
  ,HealthTax=@HealthTax  
  ,WaterTax=@WaterTax  
  ,BusinessTax=@BusinessTax  
  ,ShopTax=@ShopTax  
  ,NoticeFee=@NoticeFee  
  ,WarrantFee=@WarrantFee  
  ,OtherTax=@OtherTax  
  ,HDescription=@HDescription  
  ,IsActive=@IsActive
  ,VillageId=@villageid  
 where ID=@HouseID  
  
 update Resident Set HouseID=@HouseID where ID=@HouseHeadID;

 if (select count(ID) from House where HouseHeadID=@HouseHeadID)=0  
 begin  
  insert into HouseTransfer (GramPanchayatID,HouseID,HouseHeadID,PropertyNo,RegisterNo,UpdaeDate,IsActive)  
  values (@GramPanchayatID,@HouseID,@HouseHeadID,@PropertyNo,@RegisterNo,getdate(),1)  
 end  
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=5 --delete  
begin  
 if (select count(ID) from Resident where HouseID=@HouseID)=0  
 begin  
  --delete from House where ID=@HouseID  
  update House Set IsActive=0 where ID=@HouseID;
 end  
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=6 --fetch resident details  
begin  
 select ID,FirstName+' '+LastName,AdharCardNo from Resident where GramPanchayatID=@GramPanchayatID  
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=7 --fetch house transfer  
begin  
 select HT.ID,HT.PropertyNo,HT.RegisterNo,RS.FirstName+' '+RS.LastName'Name',convert(nvarchar(10),HT.UpdaeDate,103)'UpdaeDate'  
 from HouseTransfer HT  
 join House HU on HU.ID=HT.HouseID and HT.GramPanchayatID=@GramPanchayatID
 join Resident RS on RS.ID=HT.HouseHeadID  
end  
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=8 --fetch Active House For Dropdown  
begin  
    Select ID,PropertyNo  from House where GramPanchayatID = @GramPanchayatID and IsActive = 1  
end  

-----------------------------------------------------  
-----------------------------------------------------  

if @Action=11 --resident house history 
begin  
 select HT.ID,HT.PropertyNo,HT.RegisterNo,RS.FirstName+' '+RS.LastName,convert(nvarchar(10),HT.UpdaeDate,103)  
 from HouseTransfer HT  
 join House HU on HU.ID=HT.HouseID and HT.GramPanchayatID=@GramPanchayatID
 join Resident RS on RS.ID=HT.HouseHeadID
 where HT.HouseID=@HouseID  
end  

If @Action = 12
begin
    Declare @SQL as nvarchar(max) = null 

	SET @SQL = 'Select HS.ID,isnull(RS.FirstName,'''')+'' ''+isnull(RS.LastName,'''') ''Name''
	,isnull(PropertyNo,''''),Isnull(RegisterNo,''''),isnull(RegisterYear,''''),isnull(Area,0),isnull(HomeTax,0),isnull(LightTax,0),isnull(HealthTax,0),isnull(WaterTax,0),isnull(BusinessTax,0),isnull(ShopTax,0),isnull(NoticeFee,0),isnull(WarrantFee,0),isnull(OtherTax,0),HDescription
	,cast((select case when count(*)>0 then 1 else 0 end from Resident where HouseID=HS.ID) as bit) ''IsUse'',isnull(V.VillageName,''''),HS.VillageId
	from House HS with(nolock)
	join Village V on V.ID=HS.VillageId 
	left join Resident RS with(nolock) on HS.HouseHeadID=RS.ID
	where HS.GramPanchayatID='+convert(varchar(10),@GramPanchayatID)+' and HS.IsActive=1'
	IF len(@SearchBy)>0
	Begin
	  SET @SQL = @SQL+' and (isnull(RS.FirstName,'''') = N'''+ @SearchBy+''''+ ' OR isnull(RS.LastName,'''') = N'''+ @SearchBy+''''+ '  OR isnull(PropertyNo,'''') = N'''+ @SearchBy+''''+ 'OR Isnull(RegisterNo,'''') = N'''+ @SearchBy+''''+ ')'
	end
	print (@SQL)
	EXEC(@SQL)
end

end try      
begin catch      
IF @@TRANCOUNT > 0  
 ROLLBACK TRANSACTION Trans_StaffDetails   
 ------------------------------------------------------------------------  
 INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
  VALUES (ERROR_NUMBER(),'USP_House',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
 ------------------------------------------------------------------------  
 SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
end catch 
GO
/****** Object:  StoredProcedure [dbo].[USP_Marriage]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_Marriage 3,0,1,7,7,'03-27-2021','',0,0,'','','','','','','','','','',0,'03-27-2021',1

--  USP_Marriage 3,0,1,7,7,cast(GETDATE() as date),'',0,0,'','','','','','','','','','',0,cast(GETDATE() as date),1

CREATE procedure [dbo].[USP_Marriage]
(
@Action int=null,
@ID int=null,
@GramPanchayatID int=null,
@MaleID int=null,
@FemaleID int=null,
@MarriageDate date=null,
@MarriagePlace nvarchar(50)=null,
@VolumeNo nvarchar(50)=null,
@SerialNo nvarchar(50)=null,
@WeddPhoto nvarchar(150)=null,
@BoardPaper nvarchar(150)=null,
@MaleAdharPhoto nvarchar(150)=null,
@FemaleAdharPhoto nvarchar(150)=null,
@MalePanPhoto nvarchar(150)=null,
@FemalePanPhoto nvarchar(150)=null,
@WitnessSign nvarchar(150)=null,
@MaleBirthOrSchoolCert nvarchar(150)=null,
@FemaleBirthOrSchoolCert  nvarchar(150)=null,
@ApprovBy int=null,
@IsApprove int=null,
@ApprovDate date=null,
@ResidentID int=null,
@RequestCertificateID int =null,
@URL varchar(100)=null
)
AS
Begin TRY
--BEGIN TRANSACTION Trans_Marriage  

--========================================================================================MARRIAGE DATA LIST===========================================================================================================
IF @Action=1
	BEGIN
		select M.ID,R.FirstName'Male',RI.FirstName'Female',MarriagePlace,cast(MarriageDate as varchar(50))'MarriageDate',Isapprove from Marriage M
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		where M.GramPanchayatID = @GramPanchayatID
	END
--========================================================================================MARRIAGE DETAILS===========================================================================================================

IF @Action=2
	BEGIN
		select M.ID,cast(R.FirstName as varchar(50))+' | '+cast(R.AdharCardNo as varchar(50))'MaleData',cast(RI.FirstName as varchar(50))+' | '+cast(RI.AdharCardNo as varchar(50))'FemaleData',cast(MarriageDate as varchar(50))'MarriageDate',isnull(MarriagePlace,''),isnull(VolumeNo,0),isnull(SerialNo,0),
		isnull(WeddPhoto,'')'WeddPhoto',isnull(BoardPaper,'')'BoardPaper',isnull(MaleAdharPhoto,'')'MaleAdharPhoto',isnull(FemaleAdharPhoto,'')'FemaleAdharPhoto',
		isnull(MalePanPhoto,'')'MalePanPhoto',isnull(FemalePanPhoto,'')'FemalePanPhoto',isnull(WitnessSign,'')'WitnessSign',isnull(MaleBirthOrSchoolCert,'')'MaleBirthOrSchoolCert',isnull(FemaleBirthOrSchoolCert,'')'FemaleBirthOrSchoolCert',
	cast(isnull(ApprovDate,'') as varchar(50))'ApprovDate',R.AdharCardNo,IsApprove,R.Address+' '+RI.Address from Marriage M
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		Where M.ID=@ID
	END

--========================================================================================CREATE MARRIAGE CERTIFICATE===========================================================================================================

IF @Action=3
	BEGIN
	  Insert into Marriage(GramPanchayatID,MaleID,FemaleID,MarriageDate,MarriagePlace,VolumeNo,SerialNo,WeddPhoto,BoardPaper,
		 MaleAdharPhoto,FemaleAdharPhoto,MalePanPhoto,FemalePanPhoto,WitnessSign,MaleBirthOrSchoolCert,FemaleBirthOrSchoolCert,ApprovDate,IsApprove,UpdateDateTime)
	  values(@GramPanchayatID,@MaleID,@FemaleID,@MarriageDate,@MarriagePlace,@VolumeNo,@SerialNo,@WeddPhoto,@BoardPaper,
		     @MaleAdharPhoto,@FemaleAdharPhoto,@MalePanPhoto,@FemalePanPhoto,@WitnessSign,@MaleBirthOrSchoolCert,@FemaleBirthOrSchoolCert,@ApprovDate,@IsApprove,GETDATE())

				select @ID= IDENT_CURRENT('Marriage')
				declare @MaleName varchar(50)=null,@FemaleName varchar(50)=null, @HouseID int=null
				select @MaleName= FirstName from Resident where ID=@MaleID
				select @FemaleName= FirstName from Resident where ID=@FemaleID

	  Insert Into Notifications (GrampanchayatId,NotificationName,ControllerName,ActionName,Parameter) 
	  Values (@GramPanchayatID,@MaleName+' '+@FemaleName+' is requesting for Marriage Certificate','Marriage','EditNotification',@ID)
		
				select @HouseID= R.HouseID from Marriage M
				left Join Resident R on R.ID=M.MaleID
				where M.MaleID=@MaleID

	  insert into RequestCertificate(ResidentID,GrampanchayatID,RequestFor,IsApprove,IsActive,Remark,HouseID,SupportingDocument,RequestID,UpdateDateTime) 
		values (@MaleID,@GramPanchayatID,5,0,1,'',@HouseID,'',@ID,GETDATE())

		Exec USP_NotificationMaster 2,null,@GramPanchayatID,@ResidentID,0,'REQUEST CERTIFICATE ','Your Request For Birth Certificate Is Genereated And Soon Will Get Verified By Grampanchayat'
	END
--========================================================================================EDIT MARRIAGE CERTIFICATE===========================================================================================================

IF @Action=4
	BEGIN
		Update Marriage
		set
			GramPanchayatID=@GramPanchayatID,
			MaleID=@MaleID,
			FemaleID=@FemaleID,
			MarriageDate=@MarriageDate,
			MarriagePlace=@MarriagePlace,
			VolumeNo=@VolumeNo,
			SerialNo=@SerialNo,
			ApprovDate=@ApprovDate,
			IsApprove=@IsApprove
			,UpdateDateTime=GETDATE()
		where ID=@ID
		update Notifications set IsActive= 0 where Parameter = @ID and ControllerName ='Marriage'
	END

--========================================================================================DELETE MARRIAGE CERTIFICATE===========================================================================================================

IF @Action=5
	BEGIN
		 delete from Marriage where ID=@ID
	END
--=================================================================================================DROPDOWN==========================================================================================================

IF @Action=6--RESIDENT NAME
	BEGIN
		select ID,cast(FirstName as varchar(10))+' '+cast(LastName as varchar(10))'Residential_Name' from Resident where GramPanchayatID=@GramPanchayatID
	END

IF @Action=7--STAFF NAME(APPROVE BY)
	BEGIN
		SELECT ID,cast(FirstName as varchar(10))+' '+cast(LastName as varchar(10))'Staff_Name' from Staff  where GramPanchayatID=@GramPanchayatID
	END

--================================================================================================CURRENT MARRIAGE ID==============================================================================

IF @Action=8
	BEGIN
		 select @ID =IDENT_CURRENT('Marriage')
		 select @ID+1
	END  

--======================================================================================================EDIT MARRIAGE DETAIL========================================================================================================
IF @Action=9
	BEGIN
		select M.ID,MaleID,FemaleID,cast(MarriageDate as varchar(50))'MarriageDate',isnull(MarriagePlace,''),isnull(VolumeNo,0),isnull(SerialNo,0),
		isnull(WeddPhoto,'')'WeddPhoto',isnull(BoardPaper,'')'BoardPaper',isnull(MaleAdharPhoto,'')'MaleAdharPhoto',isnull(FemaleAdharPhoto,'')'FemaleAdharPhoto',
		isnull(MalePanPhoto,'')'MalePanPhoto',isnull(FemalePanPhoto,'')'FemalePanPhoto',isnull(WitnessSign,'')'WitnessSign',isnull(MaleBirthOrSchoolCert,'')'MaleBirthOrSchoolCert',isnull(FemaleBirthOrSchoolCert,'')'FemaleBirthOrSchoolCert',
		cast(ApprovDate as varchar(50))'ApprovDate',IsApprove from Marriage M
		Where M.ID=@ID
	END

--===========================================================================================================RESIDENT MARRIAGE LIST===================================================================================================
IF @Action=11
	BEGIN
		select M.ID,R.FirstName'Male',RI.FirstName'Female',MarriagePlace,cast(MarriageDate as varchar(50))'MarriageDate',IsApprove from Marriage M
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		where M.GramPanchayatID = @GramPanchayatID and (MaleID=@ResidentID or FemaleID=@ResidentID)

			Exec USP_NotificationMaster 3,null,@GramPanchayatID,@ResidentId,0,null,null
	END
--=========================================================================================================Resident Marriage Certificate=====================================================================================================
IF @Action=12
	BEGIN
		select M.ID,cast(R.FirstName as varchar(50))+' | '+cast(R.AdharCardNo as varchar(50))'MaleData',cast(RI.FirstName as varchar(50))+' | '+cast(RI.AdharCardNo as varchar(50))'FemaleData',cast(MarriageDate as varchar(50))'MarriageDate',MarriagePlace,VolumeNo,SerialNo,
		isnull(WeddPhoto,'')'WeddPhoto',isnull(BoardPaper,'')'BoardPaper',isnull(MaleAdharPhoto,'')'MaleAdharPhoto',isnull(FemaleAdharPhoto,'')'FemaleAdharPhoto',
		isnull(MalePanPhoto,'')'MalePanPhoto',isnull(FemalePanPhoto,'')'FemalePanPhoto',isnull(WitnessSign,'')'WitnessSign',isnull(MaleBirthOrSchoolCert,'')'MaleBirthOrSchoolCert',isnull(FemaleBirthOrSchoolCert,'')'FemaleBirthOrSchoolCert',
		cast(ApprovDate as varchar(50))'ApprovDate',R.AdharCardNo,IsApprove,R.Address+' '+RI.Address from Marriage M
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		Where (M.MaleID=@ResidentID or M.FemaleID=@ResidentID)
	END
	--========================================================================================EDIT RESIDENT MARRIAGE CERTIFICATE===========================================================================================================

IF @Action=13
	BEGIN
		Update Marriage
		set
			GramPanchayatID=@GramPanchayatID,
			MaleID=@MaleID,
			FemaleID=@FemaleID,
			MarriageDate=@MarriageDate,
			MarriagePlace=@MarriagePlace,
			VolumeNo=@VolumeNo,
			SerialNo=@SerialNo,
			WeddPhoto=@WeddPhoto,
			BoardPaper=@BoardPaper,
			MaleAdharPhoto=@MaleAdharPhoto,
			FemaleAdharPhoto=@FemaleAdharPhoto,
			MalePanPhoto=@MalePanPhoto,
			FemalePanPhoto=@FemalePanPhoto,
			WitnessSign=@WitnessSign,
			MaleBirthOrSchoolCert=@MaleBirthOrSchoolCert,
			FemaleBirthOrSchoolCert=@FemaleBirthOrSchoolCert,
			ApprovDate=@ApprovDate,
			IsApprove=@IsApprove
			,UpdateDateTime=GETDATE()
		where ID=@ID
	END
--==============================================================================================================================================================================================================

	--========================================================================================Details For API MARRIAGE CERTIFICATE===========================================================================================================

IF @Action=14
	BEGIN

   select M.ID,cast(R.FirstName as varchar(50))+' | '+cast(R.AdharCardNo as varchar(50))'MaleData',cast(RI.FirstName as varchar(50))+' | '+cast(RI.AdharCardNo as varchar(50))'FemaleData',
   cast(MarriageDate as varchar(50))'MarriageDate',isnull(MarriagePlace,'')'MarriagePlace',isnull(VolumeNo,0)'VolumeNo',isnull(SerialNo,0)'SerialNo',
		isnull(@URL+WeddPhoto,'')'WeddPhoto',isnull(@URL+BoardPaper,'')'BoardPaper',
		isnull(@URL+MaleAdharPhoto,'')'MaleAdharPhoto',
		isnull(@URL+FemaleAdharPhoto,'')'FemaleAdharPhoto',
		isnull(@URL+MalePanPhoto,'')'MalePanPhoto',isnull(@URL+FemalePanPhoto,'')'FemalePanPhoto',
		isnull(@URL+WitnessSign,'')'WitnessSign',isnull(@URL+MaleBirthOrSchoolCert,'')'MaleBirthOrSchoolCert',
		isnull(@URL+FemaleBirthOrSchoolCert,'')'FemaleBirthOrSchoolCert',
	cast(isnull(ApprovDate,'') as varchar(50))'ApprovDate',R.AdharCardNo,IsApprove from Marriage M
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		Where M.ID=@ID
		END
--==============================================================================================================================================================================================================


--==============================================================================================================================================================================================================
	 If @Action = 15 --update Marriage certicate for mobile app
	 Begin
	Update Marriage	set
		IsApprove=@IsApprove
		,UpdateDateTime=GETDATE()
		where ID=@ID
		
------------------------------------------------------------------------------------------------------------------------
	update Notifications set IsActive= 0 where Parameter = @ID and ControllerName ='Marriage'
------------------------------------------------------------------------------------------------------------------------
	update RequestCertificate set 
		IsApprove=@IsApprove
		,UpdateDateTime=GETDATE()
		where ID=@RequestCertificateID and GrampanchayatID=@GramPanchayatID	
	 end

	 
--==============================================================================================================================================================================================================

If @Action = 16  --------For Mobile app View Marriage MAster
	 Begin
	   
         select M.ID,cast(R.FirstName as varchar(50))+' | '+cast(R.AdharCardNo as varchar(50))'MaleData',cast(RI.FirstName as varchar(50))+' | '+cast(RI.AdharCardNo as varchar(50))'FemaleData',
        cast(MarriageDate as varchar(50))'MarriageDate',isnull(MarriagePlace,'')'MarriagePlace',isnull(VolumeNo,0)'VolumeNo',isnull(SerialNo,0)'SerialNo',
		isnull(@URL+WeddPhoto,'')'WeddPhoto',isnull(@URL+BoardPaper,'')'BoardPaper',
		isnull(@URL+MaleAdharPhoto,'')'MaleAdharPhoto',
		isnull(@URL+FemaleAdharPhoto,'')'FemaleAdharPhoto',
		isnull(@URL+MalePanPhoto,'')'MalePanPhoto',isnull(@URL+FemalePanPhoto,'')'FemalePanPhoto',
		isnull(@URL+WitnessSign,'')'WitnessSign',isnull(@URL+MaleBirthOrSchoolCert,'')'MaleBirthOrSchoolCert',
		isnull(@URL+FemaleBirthOrSchoolCert,'')'FemaleBirthOrSchoolCert',
	    cast(isnull(ApprovDate,'') as varchar(50))'ApprovDate',R.AdharCardNo,M.IsApprove   ,RC.ID'RequestCertificateID',RC.RequestFor from RequestCertificate RC 
		join Marriage M on RC.RequestID=M.ID 
		join RequestMaster M1 on Rc.RequestFor= M1.ID
		left join Resident R on R.ID=M.MaleID
		left join Resident RI on RI.ID=M.FemaleID
		where    M.ID=@ID and M.GramPanchayatID=@GramPanchayatID
  
  END
---==============================================================================================================================================================================================================


--COMMIT TRANSACTION Trans_Marriage
END TRY
BEGIN CATCH      
IF @@TRANCOUNT > 0  
--ROLLBACK TRANSACTION Trans_Marriage 
 ------------------------------------------------------------------------  
 INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
 VALUES (ERROR_NUMBER(),'USP_House',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
 ------------------------------------------------------------------------  
SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
END CATCH 



GO
/****** Object:  StoredProcedure [dbo].[USP_NotificationMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--  exec [USP_NotificationMaster] 5,1,1,1

CREATE Proc [dbo].[USP_NotificationMaster]
(
@Action int,
@NotificationMasterId int=null,
@GrampanchayatID int=null,
@ResidentId int=null,

--@NotifDatetime datetime=null,
@NotifType int=null,
@NotifHeader nvarchar(100)=null,
@NotifDescription nvarchar(max)=null
--@IsView bit=null
)
as
begin
-----------------------------------------------------
-----------------------------------------------------
if @Action=1 --show notification
begin
	select * from
	NotificationMaster with(nolock)
	where isnull(ResidentId,@ResidentId)=@ResidentId
	order by id desc
end
-----------------------------------------------------
-----------------------------------------------------
else if @Action=2 --add notification
begin
    Declare @ControllerName as varchar(50),@ActionName as varchar(50)

	If @NotifType = 1
	Begin
	   select @ControllerName = 'NoticeBoard',@ActionName='AllNotices'
	end
	Else If @NotifType = 2
	Begin
	   select @ControllerName = 'Dispute',@ActionName='ResidentIndex'
	end
	Else If @NotifType = 3
	Begin
	   select @ControllerName = 'DemandBill',@ActionName='ResidentDemandTaxDetail'
	end
	else if @NotifType =0 
	begin
	   select @ControllerName = 'Notification',@ActionName='RequestCertificate'
	end

	insert into NotificationMaster (GrampanchayatID,ResidentId,NotifDatetime,NotifType,NotifHeader,NotifDescription,IsView,IsActive,ControllerName,ActionName)
	values (@GrampanchayatID,@ResidentId,getdate(),@NotifType,@NotifHeader,@NotifDescription,0,1,@ControllerName,@ActionName)
end
-----------------------------------------------------
-----------------------------------------------------
else if @Action=3 --update 0:CertificateRequest,1:Notice,2:Dispute
begin
	update NotificationMaster
	set IsView=1
	where GrampanchayatID=@GrampanchayatID and ResidentId=@ResidentId and NotifType=@NotifType
end
-----------------------------------------------------
-----------------------------------------------------
else if @Action=4 -- For Notification 
begin
  select top 5 * from NotificationMaster where ResidentId = @ResidentId order by id desc
end
-----------------------------------------------------
-----------------------------------------------------
else if @Action=5 -- For 
begin
	Declare  @HouseId as int=0

	select @HouseId = HouseId from Resident where ID=@ResidentId

	select RC.ID,RM.CertificateName,convert(varchar(10),InsertDate,105),case when RC.IsApprove = 0 then 'Pending' when RC.IsApprove = 1 then 'Staff Approve' when RC.IsApprove = 2 then 'Admin Approve'	when RC.IsApprove = 3 then 'Rejected ' end 'Status',isnull(Remark,''),isnull(FirstName,'')+' '+isnull(LastName,'')'ResidentName'
	from RequestCertificate RC with(nolock)  
	join RequestMaster RM with(nolock) on RM.id=RC.RequestFor
	join Resident R with(nolock) on R.ID=RC.ResidentID
	where RC.HouseID=@HouseId
	order by RC.Id desc
end
end 


--select * from Resident
GO
/****** Object:  StoredProcedure [dbo].[USP_OccasionDetails]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Proc [dbo].[USP_OccasionDetails]
(
  @Action int ,  
  @OccasionMasterId int = null,
  @PhotoName varchar(200) = null,
  @PhotoPath varchar(50)= null
)
as 
begin
    If @Action = 1
	begin
	  Insert into OccasionDetails (OccasionMasterId,PhotoName,ImagePath)
	  Values (@OccasionMasterId,@PhotoName,@PhotoPath)
	end 
	If @Action = 2
	Begin
	   select * from OccasionDetails where OccasionMasterId = @OccasionMasterId
	end
end

--select * from OccasionDetails





GO
/****** Object:  StoredProcedure [dbo].[USP_OccasionMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_OccasionMaster 1,0,1

CREATE Proc [dbo].[USP_OccasionMaster]
(
    @Action int ,
	@Id  int = null,
	@GrampanchayatID int = null,
	@VillageId int = null,
	@SatffId int = null,
	@OccasionDate date = null,
	@OccasionName nvarchar(100) = null,
	@OccasionDescription nvarchar(max) = null,
	@IsActive bit = null,
	@URL varchar(100)=null,
	@Fromdate datetime=null,
	@Todate datetime=null
)
as
begin
	If @Action = 1 -- GET
	 Begin
	   Select isnull(G.VillageName,'')'GrampanchayatName',isnull(V.VillageName,'')'VillageName',Isnull(S.FirstName,'')+' '+isnull(s.LastName,'')'StaffName',isnull(convert(varchar(10),o.OccasionDate,105),'')OccasionDate,ISNULL(o.OccasionName,'')OccasionName,ISNULL(OccasionDescription,'')OccasionDescription,o.Id
	   from occasionmaster o with(nolock) 
	   join Village v with(nolock) on v.ID=o.VillageId
	   join Grampanchayat g with(nolock) on g.ID=o.GrampanchayatID
	   join Staff s with(nolock) on s.ID=o.SatffId
	   where o.GrampanchayatID = @GrampanchayatID and o.OccasionDate between @Fromdate and @Todate
	 end
    -----------------------------------------------------------------
	If @Action = 2 -- Insert
	 Begin
	    Insert into OccasionMaster (GrampanchayatID,VillageId,SatffId,OccasionDate,OccasionName,OccasionDescription,IsActive)
		values(@GrampanchayatID,@VillageId,@SatffId,@OccasionDate,@OccasionName,@OccasionDescription,1)
	 end
	-----------------------------------------------------------------
	If @Action = 3 -- Update
	 Begin
	   Update OccasionMaster set 
	    GrampanchayatID=@GrampanchayatID
	   ,VillageId=@VillageId
	   ,SatffId=@SatffId
	   ,OccasionDate=@OccasionDate
	   ,OccasionName=@OccasionName
	   ,OccasionDescription=@OccasionDescription
	   ,IsActive=@IsActive
	   Where ID=@Id
	 end
	 -----------------------------------------------------------------
	 If @Action = 4 --Delete 
	  Begin
	    Update OccasionMaster set IsActive=0 where Id=@Id
	  end
	  -----------------------------------------------------------------
	  If @Action = 5 -- Fetch
	   Begin
	     Select  * from OccasionMaster where id= @Id
	   end

	   If @Action = 6 -- GET
	 Begin
	   Select isnull(G.VillageName,'')'GrampanchayatName',isnull(V.VillageName,'')'VillageName',Isnull(S.FirstName,'')+' '+isnull(s.LastName,'')'StaffName',isnull(convert(varchar(10),
	   o.OccasionDate,105),'')OccasionDate,ISNULL(o.OccasionName,'')OccasionName,ISNULL(OccasionDescription,'')OccasionDescription,o.Id,
	   isnull(@URL+OD.PhotoName,'')'PhotoName'
	   from occasionmaster o with(nolock) 
	   join Village v with(nolock) on v.ID=o.VillageId
	   join Grampanchayat g with(nolock) on g.ID=o.GrampanchayatID
	   join Staff s with(nolock) on s.ID=o.SatffId
	   join OccasionDetails OD with(nolock) on OD.OccasionMasterId=O.Id
	   where o.GrampanchayatID = @GrampanchayatID
	 end
end

GO
/****** Object:  StoredProcedure [dbo].[USP_RESIDENT]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROC [dbo].[USP_RESIDENT]
(   
    @ActionID int = null,
	@ID int = null	,
	@GramPanchayatID int= null,
	@FirstName nvarchar(50)= null, 
	@LastName nvarchar(50)= null,
	@FatherID int= null,
	@MotherID int= null,
	@Gender nvarchar(50)= null,
	@BirthDate DateTime = null,
	@BirthPlace nvarchar(50)= null,
	@HouseID int= null,
	@AdharCardNo nvarchar(50)= null,
	@Address nvarchar(50)= null,
	@LoginPass nvarchar(50)= null,
	@IsActive bit = null,
	@MaritalStatusID int = null,
	@PhysDisableStatusID int = null,
	@Title nvarchar(50)=null,
	@FatherName nvarchar(50)=null,
	@MotherName nvarchar(50)=null,
	@SpouseId int =null,
	@SpouseName nvarchar(50)=null,
	@MiddleName nvarchar(50)=null,
	 @ResidentId int=null,
	 @HomeTax decimal(10,2)=null,
	 @LightTax decimal(10,2)=null,
	 @HealthTax decimal(10,2)=null,
	 @WaterTax decimal(10,2)=null,
	 @BusinessTax decimal(10,2)=null,
	@ShopTax decimal(10,2)=null,
	@NoticeFee decimal(10,2)=null,
	@WarrantFee decimal(10,2)=null,
	@OtherTax decimal(10,2)=null,
	@TotalAmount decimal(10,2)=null,
	@IsBirthGen bit=null,
	@IsDeathGen bit=null,
	@IsMarriageGen bit=null,
	@IsResidentCertificate bit=0,
	@IsNoDuesCertificate bit=0,
	@IsToiletCertificate bit=0,
	@MobileNo varchar(50)= null,
	@EmailID varchar(50)= null,
	@VillageId int =null,
	@SerachText varchar(50)=null,
	@SearchBy nvarchar(50)=null,
	@HTPayId int =null,
	@WTPayId int =null,
	@OTPayId int =null
)
As 
Begin
-----------------------------------------------------  
    IF @ActionID = 1 
	 Begin
			select R.ID,R.GramPanchayatID,R.FirstName,R.LastName,isnull(FatherID,0)'FatherID',isnull(MotherID,0)'MotherID',Gender,isnull(H.PropertyNo,'')'PropertyNo',AdharCardNo
			,Address,isnull(LoginPass,'')'LoginPass',R.IsActive from Resident R with(nolock)
			left join House H with(nolock) on H.ID=R.HouseID
		    where R.GramPanchayatID = @GramPanchayatID and R.IsActive=1  and isnull(HouseID,0)>0
			order by ID
			--select * from Resident order by ID
	 end
----------------------------------------------------- 
    IF @ActionID = 2 -- Father
	 Begin
	   select * from Resident where GramPanchayatID = @GramPanchayatID and Gender = 'Male' and MaritalStatusID<>1
	 end
----------------------------------------------------- 
	IF @ActionID = 3 -- Mother
	 Begin
	   select * from Resident where GramPanchayatID = @GramPanchayatID and Gender = 'Female' and MaritalStatusID <> 1
	 end
----------------------------------------------------- 
	 IF @ActionID = 9 -- Spouse
	 Begin
	   select * from Resident where GramPanchayatID = @GramPanchayatID --and Gender = 'Female' and MaritalStatusID <> 1
	 end
----------------------------------------------------- 
    IF @ActionID = 4 -- MaritalStatus
	 Begin
	   select * from MaritalStatus 
	 end 
----------------------------------------------------- 
	IF @ActionID = 5 -- PhysicallyDisabled
	 Begin
	   select * from PhysDisableStatus 
	 end 
----------------------------------------------------- 
	IF @ActionID = 6 -- Save
	 Begin
	    IF @ID = 0
		 Begin
		 if @HouseID = 0
		 set @HouseID=null;
		   Insert Into Resident (GramPanchayatID,FirstName,LastName,FatherID,MotherID,Gender,BirthDate,BirthPlace,HouseID,AdharCardNo,Address,LoginPass,IsActive,MaritalStatusID,PhysDisableStatusID,Title,SpouseID,SpouseName,FatherName,MotherName,MiddleName,MobileNo,EmailID,VillageId)
		   values (@GramPanchayatID,@FirstName,@LastName,@FatherID,@MotherID,@Gender,@BirthDate,@BirthPlace,@HouseID,@AdharCardNo,@Address,@LoginPass,@IsActive,@MaritalStatusID,@PhysDisableStatusID,@Title,@SpouseId,@SpouseName,@FatherName,@MotherName,@MiddleName,@MobileNo,@EmailID,@VillageId)
		   select IDENT_CURRENT('Resident')
		 end
		Else 
		 Begin
		   update Resident set 
		    FirstName=@FirstName
		   ,LastName=@LastName
		   ,FatherID=@FatherID
		   ,MotherID=@MotherID
		   ,Gender=@Gender
		   ,BirthDate=@BirthDate
		   ,BirthPlace=@BirthPlace
		   ,HouseID=@HouseID
		   ,AdharCardNo=@AdharCardNo
		   ,Address=@Address
		   ,LoginPass=@LoginPass
		   ,IsActive=@IsActive
		   ,MaritalStatusID=@MaritalStatusID
		   ,PhysDisableStatusID=@PhysDisableStatusID
		   ,Title=@Title
		   ,SpouseID=@SpouseId
		   ,SpouseName=@SpouseName
		   ,FatherName=@FatherName
		   ,MotherName=@MotherName
		   ,MiddleName=@MiddleName
		   ,MobileNo=@MobileNo
		   ,EmailID=@EmailID
		   ,VillageId=@VillageId
		    where ID= @ID 
			select @ID
		 end
	 end
----------------------------------------------------- 
	 If @ActionID = 7  -- Edit
	  Begin

	    select id,GramPanchayatID,isnull(Title,'')'Title',FirstName,LastName,isnull(FatherID,0)'FatherID',isnull(MotherID,0)'MotherID',Gender,isnull(HouseID,0)'HouseID',isnull(AdharCardNo,'')'AdharCardNo',
	   Address,isnull(LoginPass,'')'LoginPass',IsActive,MaritalStatusID,PhysDisableStatusID,SpouseID
	   ,isnull(SpouseName,'')'SpouseName',isnull(FatherName,'')'FatherName',isnull(MotherName,'')'MotherName',isnull(MiddleName,'')'MiddleName',isnull(MobileNo,'')'MobileNo',isnull(EmailID,'')'EmailID'
	    into #Res2 from Resident

		select R.ID,R.GramPanchayatID,isnull(Title,'')'Title',FirstName,LastName ,
		isnull((select FirstName+' '+LastName from #Res2 f where f.ID=r.FatherID),0)'FatherNameID'--,R.FatherID,
		,isnull((select FirstName+' '+LastName from #Res2 m where m.ID=r.MotherID),0)'MotherNameID'--,R.MotherID,
		,Gender,isnull(HouseID,0)'HouseID',isnull(AdharCardNo,'')'AdharCardNo',Address,isnull(LoginPass,'')'LoginPass',R.IsActive,MaritalStatusID,PhysDisableStatusID,
		isnull((select FirstName+' '+LastName from #Res2 s where s.ID=r.SpouseID),0)'SpouseNameID'--,R.SpouseID,
		 ,isnull(SpouseName,'')'SpouseName',isnull(FatherName,'')'FatherName',isnull(MotherName,'')'MotherName',isnull(MiddleName,'')'MiddleName',isnull(MobileNo,'')'MobileNo',isnull(R.EmailID,'')'EmailID',
		M.StatusName'MaritalStatusID',isnull(H.PropertyNo,'')PropertyNo,PS.Categories'PhysDisableStatusID',R.VillageId,V.VillageName	
        from Resident R with(nolock)

		left join MaritalStatus M on M.ID=R.MaritalStatusID
		left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
		left join House H on H.ID=R.HouseID 
		join Village V on V.ID=R.VillageId

		 where R.ID= @ID and R.IsActive=1

	  end
----------------------------------------------------- 
	 If @ActionID = 8
	 Begin
	   Delete from Resident where ID=@ID	   
	 end
--=========================================================================================================RESIDENT=========================================================================
	IF @ActionID=11
	BEGIN

	select 
		@HomeTax=isnull(SUM(isnull(HomeTax,0)),0) 
		,@LightTax=isnull(SUM(isnull(LightTax,0)),0) 
		,@HealthTax=isnull(SUM(isnull(HealthTax,0)),0) 
		,@WaterTax=isnull(SUM(isnull(WaterTax,0)),0) 
		,@BusinessTax=isnull(SUM(isnull(BusinessTax,0)),0) 
		,@ShopTax=isnull(SUM(isnull(ShopTax,0)),0) 
		,@NoticeFee=isnull(SUM(isnull(NoticeFee,0)),0) 
		,@WarrantFee=isnull(SUM(isnull(WarrantFee,0)),0) 
		,@OtherTax=isnull(SUM(isnull(OtherTax,0)),0) 
		,@TotalAmount=isnull(SUM(isnull(TotalAmt,0)),0) 
		from TaxMaster where HouseId=(select HouseId from Resident where ID=@ID)  and IsActive=1 --and IsPaid=0
		--
			--if isnull(@TotalAmount,0)=0
			--begin
			select @IsBirthGen=count(isnull(ID,0)) from BirthMaster where ResidentId=@ID  and (IsApprove=2)
			select @IsDeathGen=count(isnull(ID,0)) from DeathMaster where ResidentId=@ID  and (IsApprove=2)
			select @IsMarriageGen=count(isnull(ID,0)) from Marriage where (MaleID=@ID OR FemaleID=@ID) and (IsApprove=2)
			
			select @IsResidentCertificate=count(isnull(ID,0)) from RequestCertificate where ResidentID=@ID  and IsApprove=2 and RequestFor=1
			select @IsNoDuesCertificate=count(isnull(ID,0)) from RequestCertificate where ResidentID=@ID  and IsApprove=2 and RequestFor=2
			select @IsToiletCertificate=count(isnull(ID,0)) from RequestCertificate where ResidentID=@ID  and IsApprove=2 and RequestFor=3
			--end

	select * into #Res from Resident
	SELECT top 1  R.ID,R.GramPanchayatID,isnull(CAST(R.Title as varchar(50)),'')+' '+isnull(CAST(R.FirstName as varchar(50)),'')+' '+Isnull(CAST(R.LastName as varchar(50)),'')'Name',
	(select FirstName+' '+LastName from #Res f where f.ID=r.FatherID)'Father Name',(select FirstName+' '+LastName from #Res m where m.ID=r.MotherID)'Mother Name',
	(select FirstName+' '+LastName from #Res s where s.ID=r.SpouseID)'Spouse Name',
	R.Gender,H.PropertyNo,R.AdharCardNo,R.Address,M.StatusName'Marital Status',PS.Categories'PhysDisable Status',--isnull(R.SpouseName,'')'Spouse Name',
	--,isnull(R.FatherName,'')'Father Name',isnull(R.MotherName,'')'Mother Name',
	cast(G.VillageName as nvarchar(50))'VillageName',G.Pincode,cast(G.Block as nvarchar(50))'Block',cast(G.District as nvarchar(50))'District',cast(GETDATE() as varchar(50))'Date'
	,R.SpouseName,R.FatherName,R.MotherName,

	@HomeTax 'HomeTax',@LightTax 'LightTax',@HealthTax 'HealthTax',@WaterTax 'WaterTax',@BusinessTax 'BusinessTax',@ShopTax 'ShopTax'
	,@NoticeFee 'NoticeFee',@WarrantFee 'WarrantFee',@OtherTax 'OtherTax',@TotalAmount 'TotalAmount',isnull(@IsBirthGen,0)'IsBirthGen',isnull(@IsDeathGen,0) 'IsDeathGen',isnull(@IsMarriageGen,0) 'IsMarriageGen',R.FirstName
		,R.MotherID,R.FatherID,isnull(@IsResidentCertificate,0)'IsResidentGen',isnull(@IsNoDuesCertificate,0) 'IsNoDuesGen',isnull(@IsToiletCertificate,0) 'IsToiletGen',MobileNo,R.EmailID,V.VillageName,H.PropertyNo
	 from Resident R

	left join MaritalStatus M on M.ID=R.MaritalStatusID
	left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
	left join House H on H.ID=R.HouseID 
	left join Village V on V.ID=H.VillageId
	left join Grampanchayat G on G.ID=R.GramPanchayatID
	left join TaxMaster TM on TM.ResidentId=R.ID
	 where R.ID=@ID
	END
--=========================================================================================================RESIDENT LOGIN=========================================================================
	 If @ActionID = 12  -- Login
	  Begin
	    select  CAST(R.ID AS VARCHAR(10))+'$'+UPPER(FIRSTNAME + ' '+ LASTNAME)+'|'+(Address)+'|'+CAST(HouseID as varchar(10))
		+'|'+CAST(GramPanchayatID as varchar(10))+'|'+CAST(EmailID as varchar(50))+'|'+CAST(MobileNo as varchar(10))  'LOGINNAME' 
		from Resident R with(nolock) where AdharCardNo=@AdharCardNo and LoginPass=@LoginPass
	  end

--=========================================================================================================RESIDENT DETAILSHOUSE=========================================================================

	 IF @ActionID =13
	 BEGIN
		
		Select ID,isnull(CAST(Title as varchar(50)),'')+' '+isnull(CAST(FirstName as varchar(50)),'')+' '+isnull(CAST(LastName as varchar(50)),'')'Full Name',
		AdharCardNo,Address,Gender,isnull(EmailID,'')EmailID,isnull(MobileNo,'')MobileNo,isnull(HouseID,0)HouseID from Resident	where HouseID=@HouseID and GramPanchayatID=@GramPanchayatID and IsActive=1
	 END
--=========================================================================================================RESIDENT DETAILSHOUSE=========================================================================
	 IF @ActionID =14
	 BEGIN

		select 
			@HomeTax=sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))										
			,@WaterTax=sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))					
			
			,@LightTax= sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.LightTax,0) else 0 end),0))
			,@HealthTax=sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.HealthTax,0) else 0 end),0))
			,@BusinessTax=sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.BusinessTax,0) else 0 end),0))
			,@ShopTax=sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.ShopTax,0) else 0 end),0))
			,@NoticeFee=sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.NoticeFee,0) else 0 end),0))
			,@WarrantFee=sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.WarrantFee,0) else 0 end),0))
			,@OtherTax= sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))

			,@TotalAmount=sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))

			+sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
			+sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))
			from TaxMaster TM WITH(NOLOCK) where  TM.HouseId=@HouseID and TM.IsActive=1 --group by TM.HomeTax,TM.WaterTax,TM.OtherTax

		select * into #Res1 from Resident
		SELECT top 1 R.ID,R.GramPanchayatID,CAST(R.Title as varchar(50))+' '+CAST(R.FirstName as varchar(50))+' '+CAST(R.LastName as varchar(50))'Name',
		(select FirstName+' '+LastName from #Res1 f where f.ID=r.FatherID)'Father Name',(select FirstName+' '+LastName from #Res1 m where m.ID=r.MotherID)'Mother Name',
		(select FirstName+' '+LastName from #Res1 s where s.ID=r.SpouseID)'Spouse Name',
		R.Gender,H.PropertyNo,R.AdharCardNo,R.Address,M.StatusName'Marital Status',PS.Categories'PhysDisable Status',isnull(R.SpouseName,'')'Spouse Name'
		,isnull(R.FatherName,'')'Father Name',isnull(R.MotherName,'')'Mother Name',
		cast(G.VillageName as nvarchar(50))'VillageName',G.Pincode,cast(G.Block as nvarchar(50))'Block',cast(G.District as nvarchar(50))'District',cast(GETDATE() as varchar(50))'Date',

		cast(@HomeTax as decimal(10,2))'Home Taxes',cast(@LightTax as decimal(10,2))'Light Taxes'   ,
		cast(@HealthTax as decimal(10,2))'Health Taxes',cast(@WaterTax as decimal(10,2))'Water Taxes' ,cast(@BusinessTax as decimal(10,2))'Bussiness Taxes' ,cast(@ShopTax as decimal(10,2))'Shop Taxes' 
		,cast(@NoticeFee as decimal(10,2))'Notice Taxes' ,cast(@WarrantFee as decimal(10,2))'Warrent Taxes' ,cast(@OtherTax as decimal(10,2))'Other Taxes' 
		,cast(@TotalAmount as decimal(10,2))'Total Taxes' 
	    from Resident R

		left join MaritalStatus M on M.ID=R.MaritalStatusID
		left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
		left join House H on H.ID=R.HouseID 
		left join Grampanchayat G on G.ID=R.GramPanchayatID
		left join TaxMaster TM on TM.ResidentId=R.ID
		 where R.ID=@ID and R.HouseID=@HouseID and R.IsActive=1
	 END
-----------------------------------------------------  
	 If @ActionID = 15  -- Login for Mobile App
	 Begin
	        select  CAST(R.ID AS VARCHAR(10))'ResidentId',UPPER(FIRSTNAME + ' '+ LASTNAME)'ResidentName',UPPER([Address])'ResidentAddress',CAST(HouseID as varchar(10))'HouseId',GP.ID'GrampanchayatID',
			GP.GramCode,GP.VillageName,GP.Block,GP.District,GP.State,GP.Pincode,GP.ContactNo,GP.EmailID
			from Resident R with(nolock) join Grampanchayat GP on R.GramPanchayatID=GP.ID
		    where AdharCardNo=@AdharCardNo and LoginPass=@LoginPass
	 end
-----------------------------------------------------  
	if @ActionID=16 --fetch resident for select househead 
	begin  
	 exec [dbo].[SP_KILL_SPID]  
	 Select distinct RS.ID,RS.FirstName+' '+RS.LastName 'Name',RS.AdharCardNo
	 from Resident RS with(nolock) 
	 --join GramPanchayat GP on RS.GramPanchayatID=GP.ID  
	 --left join House HS with(nolock) on HS.HouseHeadID=RS.ID
	 --left join Resident RS with(nolock) on HS.HouseHeadID=RS.ID
	 where RS.GramPanchayatID=@GramPanchayatID and RS.IsActive=1 and RS.ID not in (Select distinct HouseHeadID from House with(nolock))
	end  	
-----------------------------------------------------  
	if @ActionID=17 --fetch resident for select househead --MObile Appp dopdown
	begin  
	 exec [dbo].[SP_KILL_SPID]  
     
	 Select distinct RS.ID,RS.FirstName+' '+RS.LastName 'Name'from Resident RS with(nolock) 
	 where RS.GramPanchayatID=@GramPanchayatID and RS.IsActive=1 and RS.ID not in (Select distinct HouseHeadID from House with(nolock)) -- HouseHeadId
		
	end  	
-----------------------------------------------------  
	if @ActionID=18 --Resident DropDown --MObile Appp dopdown
	begin  
	 exec [dbo].[SP_KILL_SPID]  
	SELECT 'DesignationName' as 'Name',ID as 'ID',DesignationName as 'VALUE' FROM DESIGNATION  WHERE IsActive = 1 --- DesignationName
	union all
	select 'MaritalStatus' as 'Name',ID as 'ID',StatusName as 'VALUE' from MaritalStatus  ---Marital Status
	union all
	select 'PhysicallyChallenged' as 'Name',ID as 'ID' ,Categories as 'VALUE' from PhysDisableStatus ---Physically Challenged	
	union all
	Select 'HouseHeadID' as 'Name' ,ID as 'ID',FirstName+' '+LastName 'VALUE' from Resident  with(nolock) 
	where GramPanchayatID=1 and IsActive=1 and ID not in (Select distinct HouseHeadID from House with(nolock)) -- HouseHeadId
	union all
	select 'FatherName' as 'Name' ,ID as 'ID',(Title+' '+FirstName+' '+LastName+' '+isnull(FatherName,'')) as 'VALUE'  from Resident where  Gender = 'Male' and MaritalStatusID<>1 --and  GramPanchayatID=@GramPanchayatID --FatherName 
	union all
	select 'MotherName' as 'Name',ID as 'ID',Title+' '+FirstName+' '+LastName as 'VALUE' from Resident where  Gender = 'Female' and MaritalStatusID <> 1 --and  GramPanchayatID=@GramPanchayatID----MotherName
	union all
	select 'SpouseName' as 'Name' ,ID as 'ID',isnull((Title+' '+FirstName+' '+LastName),'') as 'VALUE' from Resident where IsActive=1 --where  GramPanchayatID=@GramPanchayatID  ---Spouse Name
	union all
	Select 'HouseNumber' as 'Name' ,ID as 'ID',PropertyNo as 'VALUE'  from House where  IsActive = 1 --and  GramPanchayatID=@GramPanchayatID ---House Number  
	union All
	 select'Village' as 'Name' ,ID as 'ID',VillageName as 'VALUE' from Village where GramPanchayatID=1
	 union All
	 select'BillMaster' as 'Name' ,ID as 'ID',BillName as 'VALUE' from DemandBillMaster
	  union All
	 select'PayModeMatser' as 'Name' ,ID as 'ID',Name as 'VALUE' from PaymentModeMaster where IsActive=1
	  
	end  
--===================================================================================================================================================================================================
-----------------------------------------------------  
	if @ActionID=19 --Resident search --MObile Appp dopdown
	begin  
	
	select * into #search1
	from Resident where GramPanchayatID=@GramPanchayatID

	select * from #search1 where AdharCardNo like '%'+ isnull(@SerachText,'')+'%'
	union 
	select * from #search1 where MobileNo like '%'+ isnull(@SerachText,'')+'%'
	union
	select * from #search1 where FirstName like '%'+ isnull(@SerachText,'')+'%'
	union 
	select * from #search1 where LastName like '%'+ isnull(@SerachText,'')+'%'

	end	
-----------------------------------------------------  
	if @ActionID=20 --House search --MObile Appp dopdown
	begin  
	
	select * into #search2
	from House where GramPanchayatID=@GramPanchayatID
	select #search2.*,r.FirstName+' '+r.LastName  'HouseHeadName' from #search2 join resident r on  #search2.HouseHeadID=r.ID where r.FirstName+' '+r.LastName  like '%'+ isnull(@SerachText,'')+'%' 	
	or PropertyNo like '%'+ isnull(@SerachText,'')+'%'
	or RegisterYear like '%'+ isnull(@SerachText,'')+'%'

	end	
-----------------------------------------------------  
	if @ActionID=21 --Staff search --MObile Appp dopdown
	begin  
	
	 select * into #search3 
	from Staff where GramPanchayatID=@GramPanchayatID
	
	select #search3.* from #search3 join Designation d on d.ID = #search3.DesignationID where d.DesignationName like '%'+ isnull(@SerachText,'')+'%'
	or MobileNumber like '%'+ isnull(@SerachText,'')+'%'
	or FirstName+ ' '+ LastName like '%'+ isnull(@SerachText,'')+'%'

	end	
-----------------------------------------------------  
	if @ActionID=22 --Tax search --MObile Appp dopdown
	begin  
	select * into #search4 
	from TaxMaster  where GramPanchayatID=@GramPanchayatID
	
	select distinct #search4.*, rs.FirstName+' '+rs.LastName'HouseHeadName',HO.PropertyNo,Ho.RegisterNo from #search4 
	join House HO on #search4.HouseId=HO.ID --join Resident RS on HO.HouseHeadID=RS.ID
	join Resident RS on #search4.ResidentId=RS.ID
	 where rs.FirstName+' '+rs.LastName like '%'+ isnull(@SerachText,'')+'%'
	or HO.PropertyNo like '%'+ isnull(@SerachText,'')+'%'
	or GenYear like '%'+ isnull(@SerachText,'')+'%'

	--select * into #search4 
	--from TaxMaster  where GramPanchayatID=@GramPanchayatID
	
	--select distinct #search4.* from #search4  join House HO on #search4.HouseId=HO.ID --join Resident RS on HO.HouseHeadID=RS.ID
	--join Resident RS on #search4.ResidentId=RS.ID
	-- where rs.FirstName+' '+rs.LastName like '%'+ isnull(@SerachText,'')+'%'
	--or HO.PropertyNo like '%'+ isnull(@SerachText,'')+'%'
	--or GenYear like '%'+ isnull(@SerachText,'')+'%'

	end		
-----------------------------------------------------  
	if @ActionID=23 --House Transfer search --MObile Appp dopdown
	begin 
	
	select * into #search5 from HouseTransfer where GramPanchayatID=@GramPanchayatID
	 select  distinct #search5.*,  rs.FirstName+' '+rs.LastName 'houseHeadNane' from #search5
	 join Resident RS on #search5.HouseHeadID=RS.ID
	 join House HU on HU.ID=#search5.HouseID 
	 where  rs.FirstName+' '+rs.LastName like '%'+ isnull(@SerachText,'')+'%'
	  or #search5.PropertyNo like '%'+ isnull(@SerachText,'')+'%' 


	 --select * into #search5
	 -- from house where GramPanchayatID=@GramPanchayatID
	 -- select distinct #search5.* from #search5  
	 -- join Resident RS on #search5.HouseHeadID=RS.ID
	 -- where rs.FirstName+' '+rs.LastName like '%'+ isnull(@SerachText,'')+'%'
	 -- or #search5.PropertyNo like '%'+ isnull(@SerachText,'')+'%' 
	

	end	
----------------------------------------------------- 
    If @ActionID=24
	 Begin  
	        Declare @SQL as varchar(max) = null
	        set @SQL='select R.ID,R.GramPanchayatID,isnull(R.FirstName,''''),isnull(R.LastName,''''),isnull(FatherID,0)''FatherID'',isnull(MotherID,0)''MotherID'',Gender,isnull(H.PropertyNo,'''')''PropertyNo'',isnull(AdharCardNo,'''')
			,isnull(Address,''''),isnull(LoginPass,'''')''LoginPass'',R.IsActive from Resident R with(nolock)
			left join House H with(nolock) on H.ID=R.HouseID
		    where R.GramPanchayatID = '+convert(varchar(10),@GramPanchayatID)+' and R.IsActive=1'
			IF len(@SearchBy)>0
			Begin
			 set @SQL= @SQL +' and (R.FirstName = N'''+ @SearchBy+''''+ ' OR R.LastName = N'''+ @SearchBy+''''+ ' OR H.PropertyNo = N'''+ @SearchBy+''''+ ' OR R.AdharCardNo = N'''+ @SearchBy+''''+ ') Order By R.ID'			 
			end
			Else
			Begin
				set @SQL= @SQL +' Order By R.ID' 
			End
			Exec(@SQL)
	 end
------------------------------------------------------
	if @ActionID=25 --fetch resident for select househead 
		begin  
		 exec [dbo].[SP_KILL_SPID]  
		 Select distinct RS.ID,isnull(RS.FirstName,'')+' '+isnull(RS.LastName,'') 'Name',RS.AdharCardNo
		 from Resident RS with(nolock) 		 
		 where RS.GramPanchayatID=@GramPanchayatID and RS.IsActive=1 --and RS.ID not in (Select distinct HouseHeadID from House with(nolock))
		end  
		----------------------------------------------------- 
	 If @ActionID =26  -- Edit Resident For Moble App
	  Begin

	   select id,GramPanchayatID,isnull(Title,'')'Title',FirstName,LastName,isnull(FatherID,0)'FatherID',isnull(MotherID,0)'MotherID',Gender,isnull(HouseID,0)'HouseID',isnull(AdharCardNo,'')'AdharCardNo',
	   Address,isnull(LoginPass,'')'LoginPass',IsActive,MaritalStatusID,PhysDisableStatusID,SpouseID
	   ,isnull(SpouseName,'')'SpouseName',isnull(FatherName,'')'FatherName',isnull(MotherName,'')'MotherName',isnull(MiddleName,'')'MiddleName',isnull(MobileNo,'')'MobileNo',isnull(EmailID,'')'EmailID'
	    into #Res3 from Resident

		select R.ID,R.GramPanchayatID,isnull(Title,'')'Title',FirstName,LastName ,
		isnull((select FirstName+' '+LastName from #Res3 f where f.ID=r.FatherID),0)'FatherNameID',R.FatherID,
		isnull((select FirstName+' '+LastName from #Res3 m where m.ID=r.MotherID),0)'MotherNameID',R.MotherID,
		Gender,isnull(HouseID,0)'HouseID',isnull(H.PropertyNo,'')PropertyNo,isnull(AdharCardNo,'')'AdharCardNo',Address,isnull(LoginPass,'')'LoginPass',R.IsActive,MaritalStatusID,PhysDisableStatusID,
		isnull((select FirstName+' '+LastName from #Res2 s where s.ID=r.SpouseID),0)'SpouseNameID',R.SpouseID,
		 isnull(SpouseName,'')'SpouseName',isnull(FatherName,'')'FatherName',isnull(MotherName,'')'MotherName',isnull(MiddleName,'')'MiddleName',isnull(MobileNo,'')'MobileNo',isnull(R.EmailID,'')'EmailID',
		M.StatusName'MaritalStatusID',PS.Categories'PhysDisableStatusID',R.VillageId,V.VillageName	
        from Resident R with(nolock)

		left join MaritalStatus M on M.ID=R.MaritalStatusID
		left join PhysDisableStatus PS on PS.ID=R.PhysDisableStatusID
		left join House H on H.ID=R.HouseID 
		join Village V on V.ID=R.VillageId

		 where R.ID= @ID and R.IsActive=1

	  end
----------------------------------------------------- 
end
GO
/****** Object:  StoredProcedure [dbo].[USP_RetailDemandRegisterr_11]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:	<Priyanka Phapale>
-- Create date: 17-06-2021
-- Description:	[USP_RetailDemandRegisterr_11] Insert, Update, Delete,GET,Active, Dactive
-- =============================================
-- [[USP_RetailDemandRegisterr_11]]4,3,'testng service','10.00','1.00','false',1 RetailDemandRegisterr_11


CREATE Proc [dbo].[USP_RetailDemandRegisterr_11]
(
 @Action int 
,@ID int =null
,@GrampanchayatId int =null
,@SerialNumber int =null
,@PersonName nvarchar(250)=null
,@PersonAddress nvarchar(250)=null
,@NatureofDemand nvarchar(250)=null
,@AuthorityforDemand nvarchar(250)=null
,@WeekofDemand decimal=null
,@AmountofDemand decimal=null
,@TotalAmountofDemand decimal=null
,@PaymentNumandDOB nvarchar(250)=null
,@AmountRecoveredReceiptNumandDate nvarchar(250)=null
,@RecoveredAmount decimal=null
,@DiscountOrderNumandDate nvarchar(250)=null
,@DiscountAmount decimal=null
,@Balance decimal=null
,@Shera nvarchar(250)=null
,@IsActive bit=null
,@Deleted bit=null
,@InsertedBy int=null
,@SearchText varchar(50) =null,
@Fromdate date=null,
@Todate date=null
 
)
as
BEGIN
if @Action = 1 -- Index
begin
  SET NOCOUNT ON;
  select RetailsDemandRegId,SerialNumber,PersonName,PersonAddress,NatureofDemand,AuthorityforDemand,WeekofDemand,AmountofDemand,TotalAmountofDemand,PaymentNumandDOB,AmountRecoveredReceiptNumandDate
  ,RecoveredAmount,DiscountOrderNumandDate,DiscountAmount,Balance,Shera,IsActive 
  from RetailDemandRegisterr_11 with(nolock)  where Deleted=0  and  InsertDateTime between @Fromdate and @Todate
end
if @Action = 2 -- Insert
begin
  insert into RetailDemandRegisterr_11(GrampanchayatId,SerialNumber,PersonName,PersonAddress,NatureofDemand,AuthorityforDemand,WeekofDemand,AmountofDemand,TotalAmountofDemand,PaymentNumandDOB,AmountRecoveredReceiptNumandDate,RecoveredAmount,DiscountOrderNumandDate,DiscountAmount,Balance,Shera,IsActive,Deleted,InsertDateTime,InsertedBy)
                             values (@GrampanchayatId,@SerialNumber,@PersonName,@PersonAddress,@NatureofDemand,@AuthorityforDemand,@WeekofDemand,@AmountofDemand,@TotalAmountofDemand,@PaymentNumandDOB,@AmountRecoveredReceiptNumandDate,@RecoveredAmount,@DiscountOrderNumandDate,@DiscountAmount,@Balance,@Shera,1,0,GETDATE(),@InsertedBy)
end
if @Action = 3 -- Select for edit
begin
  SET NOCOUNT ON;
  select RetailsDemandRegId,SerialNumber,PersonName,PersonAddress,NatureofDemand,AuthorityforDemand,WeekofDemand,AmountofDemand,TotalAmountofDemand,PaymentNumandDOB,AmountRecoveredReceiptNumandDate
  ,RecoveredAmount,DiscountOrderNumandDate,DiscountAmount,Balance,Shera,IsActive 
  from RetailDemandRegisterr_11 with(nolock)  where Deleted=0
 end
if @Action = 4 -- Update
begin
   update RetailDemandRegisterr_11 set 
   GrampanchayatId=@GrampanchayatId,
   SerialNumber=@SerialNumber,
   PersonName=@PersonName,
   PersonAddress=@PersonAddress,
   NatureofDemand=@NatureofDemand,
   AuthorityforDemand=@AuthorityforDemand,
   WeekofDemand=@WeekofDemand,
   AmountofDemand=@AmountofDemand,
   TotalAmountofDemand=@TotalAmountofDemand,
   PaymentNumandDOB=@PaymentNumandDOB,
   AmountRecoveredReceiptNumandDate=@AmountRecoveredReceiptNumandDate,
   RecoveredAmount=@RecoveredAmount,
   DiscountOrderNumandDate=@DiscountOrderNumandDate,
   DiscountAmount=@DiscountAmount,
   Balance=@Balance,
   Shera=@Shera,   
   IsActive=1,
   Deleted=0,
   InsertDateTime=GETDATE(),
   InsertedBy=@InsertedBy
   where RetailsDemandRegId=@ID

 

   SELECT @ID
end
if @Action = 5 -- Delete
begin
  update RetailDemandRegisterr_11 set Deleted = 1 where RetailsDemandRegId=@ID
end
IF @Action=6---SEARCH
BEGIN
 SET NOCOUNT ON;
   select RetailsDemandRegId,SerialNumber,PersonName,PersonAddress,NatureofDemand,AuthorityforDemand,WeekofDemand,AmountofDemand,TotalAmountofDemand,PaymentNumandDOB,AmountRecoveredReceiptNumandDate
  ,RecoveredAmount,DiscountOrderNumandDate,DiscountAmount,Balance,Shera,IsActive 
   from RetailDemandRegisterr_11 with(nolock)  
   where  PersonName like '%'+@SearchText+'%'or PersonAddress like '%'+@SearchText+'%'or AuthorityforDemand like '%'+@SearchText+'%'
    and Deleted=0 and  InsertDateTime between @Fromdate and @Todate
            
END
IF @Action=7----Details
BEGIN
 SET NOCOUNT ON;
  select RetailsDemandRegId,SerialNumber,PersonName,PersonAddress,NatureofDemand,AuthorityforDemand,WeekofDemand,AmountofDemand,TotalAmountofDemand,PaymentNumandDOB,AmountRecoveredReceiptNumandDate
  ,RecoveredAmount,DiscountOrderNumandDate,DiscountAmount,Balance,Shera,IsActive 
  from RetailDemandRegisterr_11 with(nolock)  where Deleted=0 and RetailsDemandRegId=@ID
  END
  
END
 
GO
/****** Object:  StoredProcedure [dbo].[USP_STAFF]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

 --   USP_STAFF  1,'','',0,'','',0,'','','','','','','','',1,1,'','Vishal'

CREATE PROC [dbo].[USP_STAFF]
(
  @ACTIONID INT,
  @USERNAME NVARCHAR(50)=null,
  @PASSWORD NVARCHAR(50)=null,
  @ID Int  = null,
  @FirstName nvarchar(50)=null,
  @LastName nvarchar(50)=null,
  @DesignationID int = null,
  @StartDate date = null,
  @EndDate date = null,
  @BirthDay date = null,
  @Gender varchar(50)= null,
  @AdharNumber varchar(50)= null,
  @Address nvarchar(500) = null,
  @Email nvarchar(50)= null,
  @MobileNo varchar(10)= null,
  @GramPanchayatID int = null,
  @IsActive bit = null,
  @LoginPass nvarchar(50) = null,
  @SearchBy NVARCHAR(MAX) = null
)
AS
BEGIN
  IF @ACTIONID = 1
   BEGIN
     SELECT CAST(EM.ID AS VARCHAR(10))+'$'+UPPER(FIRSTNAME + ' '+ LASTNAME)+'|'+UPPER(DESIGNATIONNAME)  'LOGINNAME'
	 FROM STAFF EM WITH(NOLOCK)
	 JOIN DESIGNATION RM WITH(NOLOCK) ON EM.DESIGNATIONID=RM.ID 
	 WHERE EM.ISACTIVE=1 
	 AND LOGINPASS=@PASSWORD AND (MOBILENUMBER=@USERNAME OR EMAILID=@USERNAME) AND CAST(GETDATE()AS DATE) BETWEEN cast(em.StartDate as date) AND cast(eM.EndDate as date)
   END
  Else If @ACTIONID = 2
  Begin
    select FirstName,LastName,DesignationName,Gender,EmailId,MobileNumber,S.ID 
	from Staff s with(nolock)
	join Designation d with(nolock) on d.ID=s.DesignationID
	where GramPanchayatID = @GramPanchayatID
  end
  Else If @ACTIONID = 3 
  Begin
    Insert Into Staff (DesignationID,StartDate,EndDate,FirstName,LastName,Gender,BirthDate,AdharCardNo,Address,IsActive,LoginPass,EmailId,MobileNumber,GramPanchayatID)
	values (@DesignationID,@StartDate,@EndDate,@FirstName,@LastName,@Gender,@BirthDay,@AdharNumber,@Address,@IsActive,@LoginPass,@Email,@MobileNo,@GramPanchayatID)
	Select IDENT_CURRENT('Staff')
  end
  Else If @ACTIONID = 4 
  Begin
    Select S.ID,S.DesignationID,S.StartDate,S.EndDate,S.FirstName,S.LastName,S.Gender,S.BirthDate,S.AdharCardNo,S.Address,S.IsActive,S.LoginPass,S.EmailId,S.MobileNumber,S.GramPanchayatID,D.DesignationName from Staff S
	left join Designation D on D.ID=S.DesignationID
	 where S.ID= @ID
  end
  Else If @ACTIONID = 5 
   Begin
     Delete from Staff where Id = @ID
   end
  Else If @ACTIONID = 6 
   Begin
     Update Staff set 
	  DesignationID = @DesignationID
	 ,StartDate=@StartDate
	 ,EndDate=@EndDate
	 ,FirstName=@FirstName
	 ,LastName=@LastName
	 ,Gender=@Gender
	 ,BirthDate=@BirthDay
	 ,AdharCardNo=@AdharNumber
	 ,Address=@Address
	 ,LoginPass=@LoginPass
	 ,EmailId=@Email
	 ,MobileNumber=@MobileNo
	 where Id= @ID
	 Select @ID
   end
   -------------------------------------------------------------------------------------------------------------------------
   ------------------------------------ /* AdminLogin MobileApp */ -------------------------------------------------------------------
  Else IF @ACTIONID = 7
   BEGIN
		select CAST(S.ID AS VARCHAR(10))StaffId,(FIRSTNAME + ' '+ LASTNAME)'Name',ISNULL(D.DesignationName,'')DesignationName,
		ISNULL(S.AdharCardNo,'')AdharCardNo,ISNULL(S.Address,'')Address,isnull(S.GramPanchayatID,0)GramPanchayatID,isnull(S.EmailId,'')EmailId,isnull(S.MobileNumber,'')MobileNumber,
		G.VillageName,G.State,G.GramCode,G.District from Staff S
		left join Grampanchayat G on G.ID=S.GramPanchayatID
		join Designation D with(NOLOCK) ON S.DesignationID=D.ID
		where S.IsActive=1
	  AND S.LOGINPASS=@PASSWORD AND (S.MOBILENUMBER=@USERNAME OR S.EMAILID=@USERNAME) AND CAST(GETDATE()AS DATE) BETWEEN cast(S.StartDate as date) AND cast(S.EndDate as date)
   END
   -------------------------------------------------------------------------------------------------------------------------
   ------------------------------------ /* Add New Staff MobileApp */ -------------------------------------------------------------------
  Else If @ACTIONID = 8 
	  Begin
	 
		Insert Into Staff (DesignationID,StartDate,EndDate,FirstName,LastName,Gender,BirthDate,AdharCardNo,Address,IsActive,LoginPass,EmailId,MobileNumber,GramPanchayatID)
		values (@DesignationID,@StartDate,@EndDate,@FirstName,@LastName,@Gender,@BirthDay,@AdharNumber,@Address,@IsActive,@LoginPass,@Email,@MobileNo,(select IDENT_CURRENT('GramPanchayat')))		
	  end
   ------------------------------------ /* Search Filter Web App */ --------------------------------------------------------
   Else If @ACTIONID = 9 
    Begin
	   Declare @SQL as varchar(max) = null
	   SET @SQL='select FirstName,LastName,DesignationName,Gender,EmailId,MobileNumber,S.ID 
	   from Staff s with(nolock)
	   join Designation d with(nolock) on d.ID=s.DesignationID
	   where GramPanchayatID = '+CONVERT(VARCHAR(10),@GramPanchayatID)
	   IF len(@SearchBy)>0
	   Begin
	     SET @SQL= @SQL + ' and (s.firstName = N'''+ @SearchBy+''''+ ' OR s.LastName = N'''+ @SearchBy+''''+ ' OR s.Emailid = N'''+ @SearchBy+''''+ 'OR s.MobileNumber = N'''+ @SearchBy+''''+ ')'
	   end
	   Print(@SQL)
	   Exec(@SQL)
	End
END 
GO
/****** Object:  StoredProcedure [dbo].[USP_StaffListRegister_13]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


-- =============================================
-- Author:	<Priyanka Phapale>
-- Create date: 14-06-2021
-- Description:	USP_StaffListRegister_13 Insert, Update, Delete,GET,Active, Dactive
-- =============================================
-- [USP_StaffListRegister_13]4,3,'testng service','10.00','1.00','false',1 StaffListRegister_13

CREATE Proc [dbo].[USP_StaffListRegister_13]
(
 @Action int 
,@ID int =null
,@GrampanchayatId int =null
,@SerialNumber int =null
,@Designation nvarchar(250)=null
,@NumberOfPost  int =null
,@ApprovedPostOrderNumDate  date=null
,@PartTimeOrAnterior nvarchar(250)=null
,@Approvedpayscale nvarchar(250)=null
,@AssignedEmpName nvarchar(250)=null
,@AppointmentDate  date =null
,@SarpanchSignature nvarchar(250)=null
,@Signature nvarchar(250)=null
,@IsActive bit=null
,@Deleted bit=null
,@InsertedBy int=null
,@SearchText varchar(50) =null,
@Fromdate date=null,
@Todate date=null
 
)
as
BEGIN
if @Action = 1 -- Index
begin
  SET NOCOUNT ON;
  select StaffListId,SerialNumber,Designation,NumberOfPost,cast([ApprovedPostOrderNum&Date]
   as varchar(20))[ApprovedPostOrderNum&Date],PartTimeOrAnterior,Approvedpayscale,cast(AppointmentDate as varchar(20))AppointmentDate,
   SarpanchSignature,Signature,IsActive from StaffListRegister_13 with(nolock) 
    where Deleted=0 and  [ApprovedPostOrderNum&Date] between @Fromdate and @Todate
end
if @Action = 2 -- Insert
begin
  insert into StaffListRegister_13(GrampanchayatId,SerialNumber,Designation,NumberOfPost,[ApprovedPostOrderNum&Date],PartTimeOrAnterior,Approvedpayscale,AssignedEmpName,AppointmentDate,SarpanchSignature,Signature,IsActive,Deleted,InsertDateTime,InsertedBy)
  values (@GrampanchayatId,@SerialNumber,@Designation,@NumberOfPost,@ApprovedPostOrderNumDate,@PartTimeOrAnterior,@Approvedpayscale,@AssignedEmpName,@AppointmentDate,@SarpanchSignature,@Signature,1,0,GETDATE(),@InsertedBy)
end
if @Action = 3 -- Select for edit
begin
  SET NOCOUNT ON;
  select StaffListId,SerialNumber,Designation,NumberOfPost,cast([ApprovedPostOrderNum&Date] as varchar(20))[ApprovedPostOrderNum&Date],PartTimeOrAnterior,Approvedpayscale,cast(AppointmentDate as varchar(20))AppointmentDate,SarpanchSignature,Signature,IsActive from StaffListRegister_13 with(nolock)  where Deleted=0
end
if @Action = 4 -- Update
begin
   update StaffListRegister_13 set 
   GrampanchayatId=@GrampanchayatId,
   SerialNumber=@SerialNumber,
   Designation=@Designation,
   NumberOfPost=@NumberOfPost,
   [ApprovedPostOrderNum&Date]=@ApprovedPostOrderNumDate,
   PartTimeOrAnterior=@PartTimeOrAnterior,
   Approvedpayscale=@Approvedpayscale,
   AssignedEmpName=@AssignedEmpName,
   AppointmentDate=@AppointmentDate,
   SarpanchSignature=@SarpanchSignature,
   Signature=@Signature,
   IsActive=1,
   Deleted=0,
   InsertDateTime=GETDATE(),
   InsertedBy=@InsertedBy
   where StaffListId=@ID

   SELECT @ID
end
if @Action = 5 -- Delete
begin
  update StaffListRegister_13 set Deleted = 1 where StaffListId=@ID
end
IF @Action=6---SEARCH
BEGIN

 SET NOCOUNT ON;
  select StaffListId,SerialNumber,Designation,NumberOfPost,cast([ApprovedPostOrderNum&Date] as varchar(20))[ApprovedPostOrderNum&Date],
  PartTimeOrAnterior,Approvedpayscale,cast(AppointmentDate as varchar(20))AppointmentDate,
  SarpanchSignature,Signature,IsActive from StaffListRegister_13 with(nolock) 
 where Designation like '%'+@SearchText+'%'or [ApprovedPostOrderNum&Date] like '%'+@SearchText+'%'or AssignedEmpName like '%'+@SearchText+'%' 
 and Deleted=0 and  [ApprovedPostOrderNum&Date] between @Fromdate and @Todate
			
END
IF @Action=7----Details
BEGIN
 SET NOCOUNT ON;
  select StaffListId,SerialNumber,Designation,NumberOfPost,cast([ApprovedPostOrderNum&Date] as varchar(20))[ApprovedPostOrderNum&Date],PartTimeOrAnterior,Approvedpayscale,cast(AppointmentDate as varchar(20))AppointmentDate,SarpanchSignature,Signature,IsActive from StaffListRegister_13 with(nolock)  where Deleted=0
END

END
GO
/****** Object:  StoredProcedure [dbo].[USP_TaxMaster]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- USP_TaxMaster 24
CREATE Proc [dbo].[USP_TaxMaster]--24
(  
	 @Action int
	,@GramPanchayatId int =null
	,@TaxMasterId int=null
	,@ResidentId int=null
	,@HouseId int=null
	,@GenYear int=null
	,@GenMonth int=null
	,@HomeTax decimal(10,2)=null
	,@LightTax decimal(10,2)=null
	,@HealthTax decimal(10,2)=null
	,@WaterTax decimal(10,2)=null
	,@BusinessTax decimal(10,2)=null
	,@ShopTax decimal(10,2)=null
	,@NoticeFee decimal(10,2)=null
	,@WarrantFee decimal(10,2)=null
	,@OtherTax decimal(10,2)=null
	,@ISHomeTax bit=null
	,@ISLightTax bit=null
	,@ISHealthTax bit=null
	,@ISWaterTax bit=null
	,@ISBusinessTax bit=null
	,@ISShopTax bit=null
	,@ISNoticeFee bit=null
	,@ISWarrantFee bit=null
	--,@ISOtherTax bit=null
	,@Remark nvarchar(100)=null
	,@IsPaid bit=null
	,@IsActive bit=null
	,@TotalAmount decimal(10,2)=null
	,@PaymentDate date = null
	,@PaidAmount decimal(10,2)=null
	,@PayMode int = null
	,@TranPayId nvarchar(50)=null
	,@TranOrderId nvarchar(50)=null
	,@SearchText varchar(100)=null
	,@ddltype int =null
	,@Flag int=null
	,@DemandBillMasterID int=null
	,@RaiseBy int=null
	,@Status int=null
	,@Amount decimal(10,2)=null
	,@RaiseDate datetime=null
    ,@PaidDate datetime=null
	,@PaymentId int=null
	,@Type int=null
	,@Month int=null
	,@Year int=null
	,@Search varchar(100)=null,
	@Fromdate date=null,
	@Todate date=null,
	@HomeTaxC decimal(10,2)=null,
	@LightTaxC decimal(10,2)=null,
	@HealthTaxC decimal(10,2)=null,
	@WaterTaxC decimal(10,2)=null,
	@TotalAmountC decimal(10,2)=null
	
)  
as  
---begin Try      
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=1 --Show  
	begin  
		 exec [dbo].[SP_KILL_SPID]; 

			--  if  @SearchText is null
			--	 begin
			--		 Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo,TM.TotalAmt'OtherTax',TM.HomeTax,TM.WaterTax,TM.HTIsPaid,TM.WTIsPaid,TM.OTIsPaid,TM.ID --TM.IsPaid,
			--		 from TaxMaster TM
			--		 join House HO on TM.HouseId=HO.ID and TM.GramPanchayatId=@GramPanchayatId and TM.IsActive=1 and TM.GenYear=@GenYear and TM.GenMonth=@GenMonth
			--		 join Resident RS on HO.HouseHeadID=RS.ID
			--	 end
			--else
			--select * from (
			--			 Select  *,HomeTax+WaterTax+OtherTax 'AllPending' from(
			--			 select top 5
			--			 isnull(RS.FirstName+' '+RS.LastName ,'')'ReisdentName',
			--			isnull(HO.PropertyNo,'')PropertyNo,isnull(HO.RegisterNo,'')RegisterNo,
			--			 sum(isnull((case when HTIsPaid=0 then isnull(TM.HomeTax,0) else 0 end),0)) 'HomeTax',
			--			 sum(isnull((case when WTIsPaid=0 then isnull(TM.WaterTax,0) else 0 end),0)) 'WaterTax',
			--			 sum(isnull((case when OTIsPaid=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'OtherTax',isnull(TM.HTIsPaid,'')HTIsPaid,isnull(TM.WTIsPaid,'')WTIsPaid
			--			 ,isnull(TM.OTIsPaid,'')OTIsPaid,HO.ID 'HouseID',RS.ID'ResidentID'
			--			 --into #temp1
			--			 from House HO
			--			 join Resident RS on RS.ID=HO.HouseHeadID
			--			 left join TaxMaster  TM on TM.HouseId=Ho.ID and TM.ResidentId=RS.ID and TM.IsActive=1
			--			group by RS.ID,RS.FirstName,RS.LastName,HO.PropertyNo,HO.RegisterNo,HO.ID,TM.HTIsPaid,TM.WTIsPaid,TM.OTIsPaid)a1)a2
			--			order by AllPending desc
			--	Begin
			--		 Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo,TM.TotalAmt'OtherTax',TM.HomeTax,TM.WaterTax,TM.HTIsPaid,TM.WTIsPaid,TM.OTIsPaid,TM.ID --TM.IsPaid,
			--		 from TaxMaster TM
			--		 join House HO on TM.HouseId=HO.ID and TM.GramPanchayatId=@GramPanchayatId and TM.IsActive=1 and TM.GenYear=@GenYear and TM.GenMonth=@GenMonth
			--		 join Resident RS on HO.HouseHeadID=RS.ID
			--		 where  ((HO.PropertyNo like '%'+@SearchText+'%') OR (HO.RegisterNo like '%'+@SearchText+'%')) OR
			--		   (( RS.FirstName like '%'+@SearchText+'%') OR (RS.LastName like '%'+@SearchText+'%'))
			--	end
		    if  @SearchText is null or @SearchText=''
				 begin		
				      Select  * from(
                             select top 5 
                             isnull(RS.FirstName+' '+RS.LastName ,'')'ReisdentName',
                            isnull(HO.PropertyNo,'')PropertyNo,isnull(HO.RegisterNo,'')RegisterNo,
                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0)) 'HomeTax',
                             sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0)) 'WaterTax',
                             sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'OtherTax',
                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'AllPending',
                            HO.ID 'HouseID',RS.ID'ResidentID',isnull(TM.GramPanchayatID,0)GramPanchayatID--,isnull(TM.ID,0)'TaxMasterID'
                             --into #temp1
                             from House HO WITH(NOLOCK)
                             join Resident RS on RS.ID=HO.HouseHeadID --and HO.ID=@HouseId
                             left join TaxMaster  TM on TM.HouseId=Ho.ID and TM.ResidentId=RS.ID and TM.IsActive=1
							 where  TM.InsertDateTime between @Fromdate and @Todate
                        group by RS.ID,RS.FirstName,RS.LastName,HO.PropertyNo,HO.RegisterNo,HO.ID,TM.HTPayId,TM.WTPayId,TM.OTPayId,TM.GramPanchayatID)a1
						order by AllPending desc
						
				 end
			else
				Begin
						 select * from (
                             select top 5
                             isnull(RS.FirstName+' '+RS.LastName ,'')'ReisdentName',
                            isnull(HO.PropertyNo,'')PropertyNo,isnull(HO.RegisterNo,'')RegisterNo,
                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0)) 'HomeTax',
                             sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0)) 'WaterTax',
                             sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'OtherTax',
                             sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
							 + sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0)) 'AllPending',
                            HO.ID 'HouseID',RS.ID'ResidentID',isnull(TM.GramPanchayatID,0)GramPanchayatID--,isnull(TM.ID,0)'TaxMasterID'
                             --into #temp1
                             from House HO WITH(NOLOCK)
                             join Resident RS on RS.ID=HO.HouseHeadID
                             left join TaxMaster  TM on TM.HouseId=Ho.ID and TM.ResidentId=RS.ID and TM.IsActive=1
						 where  ((HO.PropertyNo like '%'+@SearchText+'%') OR (HO.RegisterNo like '%'+@SearchText+'%')) OR
					   (( RS.FirstName like '%'+@SearchText+'%') OR (RS.LastName like '%'+@SearchText+'%')) and TM.InsertDateTime between @Fromdate and @Todate
						group by RS.ID,RS.FirstName,RS.LastName,HO.PropertyNo,HO.RegisterNo,HO.ID,TM.HTPayId,TM.WTPayId,TM.OTPayId,TM.GramPanchayatID,TM.ID)a1
						order by AllPending desc
					
				end
	end     
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=2 --details  
begin  
		 exec [dbo].[SP_KILL_SPID]; 
		 Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo
		 ,TM.GenYear,TM.GenMonth,TM.HomeTax,TM.LightTax,TM.HealthTax,TM.WaterTax,TM.BusinessTax,TM.ShopTax,TM.NoticeFee,TM.WarrantFee,TM.OtherTax,TM.TotalAmt,TM.Remark,TM.HouseId--,TM.IsPaid
		 from TaxMaster TM WITH(NOLOCK)
		 join House HO on TM.HouseId=HO.ID and TM.ID=@TaxMasterId
		 join Resident RS on HO.HouseHeadID=RS.ID

 
end     
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=3 --delete-inactive  
	begin
	 Select @TotalAmount=TotalAmt --,@IsPaid = IsPaid 
	 from TaxMaster  WITH(NOLOCK) where id=@TaxMasterId
	 If(@TotalAmount>0 and @IsPaid=0)  
	 Begin
		Return 0
	 end
	 Else
	 Begin
		update TaxMaster set IsActive=0 where id=@TaxMasterId
	 end 
end     
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=4 --Update  
begin  
 update TaxMaster 
 set HomeTax=@HomeTax
 ,LightTax=@LightTax
 ,HealthTax=@HealthTax
 ,WaterTax=@WaterTax
 ,BusinessTax=@BusinessTax
 ,ShopTax=@ShopTax
 ,NoticeFee=@NoticeFee
 ,WarrantFee=@WarrantFee
 --,OtherTax=@OtherTax
 ,Remark=@Remark
-- ,IsPaid=@IsPaid
where id=@TaxMasterId
end  
-----------------------------------------------------   
if @Action=5 --fetch data for Edit  
begin  
  select * from TaxMaster WITH(NOLOCK) where ID=@TaxMasterId
end
-----------------------------------------------------   
if @Action=6 --generate bill
begin  
  declare @RowCount int=0
  select
  GramPanchayatID,HouseHeadID,ID 'HouseId'
  ,year(getdate()) 'GenYear',month(getdate()) 'GenMonth'
  ,case when isnull(@ISHomeTax,0)=1 then Isnull(HomeTax,0) else 0 end 'HomeTax'
  ,case when isnull(@ISLightTax,0)=1 then Isnull(LightTax,0) else 0 end 'LightTax'
  ,case when isnull(@ISHealthTax,0)=1 then Isnull(HealthTax,0) else 0 end 'HealthTax'
  ,case when isnull(@ISWaterTax,0)=1 then Isnull(WaterTax,0) else 0 end 'WaterTax'
  ,case when isnull(@ISBusinessTax,0)=1 then Isnull(BusinessTax,0) else 0 end 'BusinessTax'
  ,case when isnull(@ISShopTax,0)=1 then Isnull(ShopTax,0) else 0 end 'ShopTax'
  ,case when isnull(@ISNoticeFee,0)=1 then Isnull(NoticeFee,0) else 0 end 'NoticeFee'
  ,case when isnull(@ISWarrantFee,0)=1 then Isnull(WarrantFee,0) else 0 end 'WarrantFee'
  --,case when isnull(@ISOtherTax,0)=1 then Isnull(OtherTax,0) else 0 end 'OtherTax'
  ,0 'IsUpdated'
  into #House 
  from House with(nolock) where GramPanchayatID=@GramPanchayatId and IsActive=1

	select @RowCount=COUNT(HouseId) from #House where IsUpdated=0

	WHILE ( @RowCount> 0)
	BEGIN
	
		select top 1 @GenYear=GenYear,@GenMonth=GenMonth,@HouseId=HouseId,@ResidentId=HouseHeadID,@HomeTax=HomeTax,@LightTax=LightTax,@HealthTax=HealthTax,@WaterTax=WaterTax,@BusinessTax=BusinessTax,@ShopTax=ShopTax,@NoticeFee=NoticeFee,@WarrantFee=WarrantFee--,@OtherTax=OtherTax
		from #House where IsUpdated=0

		IF Not Exists (select 1 from TaxMaster where HouseId=@HouseId and GenMonth=@GenMonth and GenYear = @GenYear and GramPanchayatId = @GramPanchayatId and IsActive = 1)
		Begin
			  insert into TaxMaster (GramPanchayatID,ResidentId,HouseId,GenYear,GenMonth,HomeTax,LightTax,HealthTax,WaterTax,BusinessTax,ShopTax,NoticeFee,WarrantFee--,OtherTax
				,Remark,IsActive)--,IsPaid
		      values(@GramPanchayatId,@ResidentId,@HouseId,@GenYear,@GenMonth,@HomeTax,@LightTax,@HealthTax,@WaterTax,@BusinessTax,@ShopTax,@NoticeFee,@WarrantFee--,@OtherTax
				,@Remark,1)--0
		end

		Else 
		Begin
		    Update TaxMaster set
		    HomeTax=case when ISNULL(HomeTax,0) = 0 then @HomeTax else isnull(HomeTax,0) end
		   ,LightTax=case when ISNULL(LightTax,0) = 0 then @LightTax else isnull(LightTax,0) end
		   ,HealthTax=case when ISNULL(HealthTax,0) = 0 then @HealthTax else isnull(HealthTax,0) end
		   ,WaterTax=case when ISNULL(WaterTax,0) = 0 then @WaterTax else isnull(WaterTax,0) end
		   ,BusinessTax=case when ISNULL(BusinessTax,0) = 0 then @BusinessTax else isnull(BusinessTax,0) end
		   ,ShopTax=case when ISNULL(ShopTax,0) = 0 then @ShopTax else isnull(ShopTax,0) end
		   ,NoticeFee=case when ISNULL(NoticeFee,0) = 0 then @NoticeFee else isnull(NoticeFee,0) end
		   ,WarrantFee=case when ISNULL(WarrantFee,0) = 0 then @WarrantFee else isnull(WarrantFee,0) end
		   --,OtherTax=case when ISNULL(OtherTax,0) = 0 then @OtherTax else isnull(OtherTax,0) end

		    where HouseId = @HouseId and GenMonth = @GenMonth and GenYear = @GenYear and GramPanchayatId = @GramPanchayatId
		end
		update #House set IsUpdated=1 where HouseId=@HouseId
		set @RowCount = @RowCount-1
	END

end
-----------------------------------------------------
-----------------------------------------------------

If @Action = 7 
Begin
    Update TaxMaster set 
	--PaymentDate = @PaymentDate,
	--PaidAmount =  @PaidAmount,
	--PayMode =     @PayMode,
	--TranPayId =   @TranPayId,
	--TranOrderId = @TranOrderId,
	--IsPaid= @IsPaid,
	Remark = @Remark
	where ID=@TaxMasterId

end
-----------------------------------------------------  
-----------------------------------------------------  
if @Action = 8 
Begin
     select * from Grampanchayat WITH(NOLOCK) where ID=@GramPanchayatId 

     Select RS.FirstName+' '+RS.LastName,HO.PropertyNo,HO.RegisterNo
	 ,TM.GenYear,TM.GenMonth,TM.HomeTax,TM.LightTax,TM.HealthTax,TM.WaterTax,TM.BusinessTax,TM.ShopTax,TM.NoticeFee,TM.WarrantFee,TM.OtherTax,TM.TotalAmt,TM.Remark--TM.IsPaid,TranOrderId
	 ,Rs.[Address]
	 from TaxMaster TM WITH(NOLOCK)
	 join House HO on TM.HouseId=HO.ID and TM.ID=@TaxMasterId
	 join Resident RS on HO.HouseHeadID=RS.ID

end
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=11 --ResidenttaxShow  
begin  
	  Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo
	 ,TM.GenYear,TM.GenMonth,TM.HomeTax,TM.LightTax,TM.HealthTax,TM.WaterTax,TM.BusinessTax,TM.ShopTax,TM.NoticeFee,TM.WarrantFee,TM.OtherTax,TM.TotalAmt,isnull(TM.Remark,'')Remark--,TM.IsPaid
	 from TaxMaster TM WITH(NOLOCK)
	 join House HO on TM.HouseId=HO.ID and TM.GramPanchayatId=@GramPanchayatId and TM.IsActive=1 and TM.GenYear=@GenYear
	 join Resident RS on HO.HouseHeadID=RS.ID
	 where TM.HouseId=@HouseId
end    
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=12 --Payment List Show  Admin
begin  
if @Flag is not null 
  Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%') 
				order by TM.GenYear,TM.GenMonth
			end
			   
       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   and  PA.PaymentDate between @Fromdate and @Todate
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
				order by PA.PaymentDate
			end
			     
       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

 

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End
end      
-----------------------------------------------------  
-----------------------------------------------------  
if @Action=13 --details  
begin  
	 exec [dbo].[SP_KILL_SPID]; 
	 Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo
	 ,TM.GenYear,TM.GenMonth,TM.HomeTax,TM.LightTax,TM.HealthTax,TM.WaterTax,TM.BusinessTax,TM.ShopTax,TM.NoticeFee,TM.WarrantFee,TM.OtherTax,TM.TotalAmt,TM.Remark--,TM.IsPaid
	 from TaxMaster TM WITH(NOLOCK)
	 join House HO on TM.HouseId=HO.ID and TM.ID=@TaxMasterId
	 join Resident RS on HO.HouseHeadID=RS.ID
	 where Tm.HouseId=@HouseId
end    
-----------------------------------------------------  
if @Action = 14
Begin
     select * from Grampanchayat WITH(NOLOCK) where ID=@GramPanchayatId 

     Select RS.FirstName+' '+RS.LastName,HO.PropertyNo,HO.RegisterNo
	 ,TM.GenYear,TM.GenMonth,TM.HomeTax,TM.LightTax,TM.HealthTax,TM.WaterTax,TM.BusinessTax,TM.ShopTax,TM.NoticeFee,TM.WarrantFee,TM.OtherTax,TM.TotalAmt,TM.Remark,--TM.IsPaid,TranOrderId,
	 Rs.[Address]
	 from TaxMaster TM WITH(NOLOCK)
	 join House HO on TM.HouseId=HO.ID and TM.ID=@TaxMasterId
	 join Resident RS on HO.HouseHeadID=RS.ID
	  where Tm.HouseId=@HouseId

end 
--------------------------------------------------------------------
if @Action=15 --Show  
begin  
 exec [dbo].[SP_KILL_SPID]; 
 Select RS.FirstName+' '+RS.LastName'Name',HO.PropertyNo,HO.RegisterNo,TM.TotalAmt,TM.ID --,TM.IsPaid
 from TaxMaster TM WITH(NOLOCK)
 join House HO on TM.HouseId=HO.ID and TM.GramPanchayatId=@GramPanchayatId and TM.IsActive=1 and TM.GenYear=@GenYear and TM.GenMonth=@GenMonth and 
 ((HO.PropertyNo like '%'+@SearchText+'%') OR (HO.RegisterNo like '%'+@SearchText+'%'))

 join Resident RS on HO.HouseHeadID=RS.ID  and  (( RS.FirstName like '%'+@SearchText+'%') OR (RS.LastName like '%'+@SearchText+'%'))

end  

-----------------------------------------------------
-----------------------------------------------------

--If @Action = 16----SUm Home Tax,waterTax,Other Tax
--Begin
    
If @Action = 16
	--All Home Tax
	-- =================================================================================
	  --if @Flag is not null
  begin

		select 
			TM.ResidentId,TM.GenYear,TM.GenMonth
			,HO.PropertyNo,HO.RegisterNo
			,RS.FirstName+' '+RS.LastName 'ResidentName'
			,isnull(TM.HTPayId,0) HTPayId,TM.HomeTax,isnull(TM.WTPayId,0) WTPayId,TM.WaterTax,isnull(TM.OTPayId,0) OTPayId,TM.TotalAmt
		into #Temp1
		from TaxMaster  TM  WITH(NOLOCK)
			join House HO WITH(NOLOCK) on HO.ID=TM.HouseId and TM.HouseId=@HouseId and TM.GramPanchayatID=@GramPanchayatId
			join Resident RS WITH(NOLOCK) on RS.ID=HO.HouseHeadID
					
		select
			isnull(PropertyNo,'')PropertyNo,isnull(RegisterNo,'')RegisterNo,isnull(ResidentName,'')ResidentName
			,isnull(sum(case when isnull(HTPayId,0)=0 then isnull(HomeTax,0) else 0 end),0) 'TotalHomeTax'
			,isnull(sum(case when isnull(WTPayId,0)=0 then isnull(WaterTax,0) else 0 end),0) 'TotalWaterTax'
			,isnull(sum(case when isnull(OTPayId,0)=0 then isnull(TotalAmt,0) else 0 end),0) 'TotalOtherTax'
		from #Temp1
		group by PropertyNo,RegisterNo,ResidentName
  
end
--==================================================================================================================
if @Action=17 --Show  home tax ,water tax ,other tax
	begin    
		 

		select 
			@HomeTax=sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))										
			,@WaterTax=sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))					
			,@OtherTax= sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))
			,@TotalAmount=sum(isnull((case when ISNULL(TM.HTPayId,0)=0 then isnull(TM.HomeTax,0) else 0 end),0))
			+sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
			+sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))
			from TaxMaster TM WITH(NOLOCK) where  TM.HouseId=@HouseId  and TM.IsActive=1 --group by TM.HomeTax,TM.WaterTax,TM.OtherTax
			
			select 	cast(@HomeTax as varchar(50))+'|'+cast(@WaterTax as varchar(50))+'|'+cast(@OtherTax as varchar(50))
				+'|'+cast(@TotalAmount as varchar(10))'Taxes' 
			--from House HO
			--join Resident RS on RS.ID=HO.HouseHeadID
			--left join TaxMaster  TM on TM.HouseId=Ho.ID and TM.ResidentId=RS.ID and TM.IsActive=1 
			--where  RS.ID=@ResidentId
			
	end  
--==================================================================================================================
  if @Action=18 --Insert Demand Bill For Tax Master  
	  begin    		 		
			if (select count(ID) from DemandBillDetails  WITH(NOLOCK) where HouseID=@HouseId and Status=0)>0
			begin
				update DemandBillDetails
				set IsActive=0
				where HouseID=@HouseID and Status=0
			end
					
			insert into DemandBillDetails(DemandBillMasterId,ResidentId,RaiseBy,Status,Amount,RaiseDate,Remark,GramPanchayatID,HouseID,IsActive)
			values(@DemandBillMasterId,@ResidentId,@RaiseBy,0,@Amount,@RaiseDate,@Remark,@GramPanchayatID,@HouseId,1)

			select @DemandBillMasterId= IDENT_CURRENT('DemandBillMaster')
	
			Exec USP_NotificationMaster 2,null,@GramPanchayatID,@ResidentId,3,'PAY BILL','Grampanchayat Requested To Pay Bill'
			select @DemandBillMasterId	
			--select * from NotificationMaster
	   end  
--=====================================================================================================================================

  if @Action=19--Insert Payment For Tax Master  
	  Begin
			insert into Payment(PaymentDate,HouseId,Amount,PayModeID,IsActive,UpdatedateTime,Remark,GramPanchayatID,DemandBillMasterId)
			values(@PaymentDate,@HouseId,@Amount,@PayMode,1,getdate(),@Remark,@GramPanchayatID,@DemandBillMasterId)

			set @PaymentId = IDENT_CURRENT('Payment')
	

		if @DemandBillMasterId=2
			begin
				update TaxMaster
				set HTPayId=@PaymentId
				where isnull(HTPayId,0)=0 and HouseId=@HouseId
			end
		else if @DemandBillMasterId=3
			begin
				update TaxMaster
				set WTPayId=@PaymentId
				where isnull(WTPayId,0)=0 and HouseId=@HouseId
			end
		else if @DemandBillMasterId=4
				begin
				update TaxMaster
				set OTPayId=@PaymentId
			where isnull(OTPayId,0)=0 and HouseId=@HouseId
		end

			--update TaxMaster
			--set HTPayId=@PaymentId
			--where Id=@TaxMasterId

		select @PaymentId	
	End
--===================================================================================================================================
if @Action=1101
BEGIN
 select
 TM.ID 'TaxMasterID',GP.GramCode,VL.VillageName
 ,HO.PropertyNo,HO.RegisterNo,RS.FirstName+' '+ISNULL(RS.FatherName,ISNULL(RS.SpouseName,''))+' '+RS.LastName 'ResidentName',RS.Gender,isnull(RS.EmailID,'')
 ,isnull(RS.MobileNo,'')
 , DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
 , isnull(TM.HomeTax,0) 'HomeTax',case when isnull(TM.HTPayId,0)>0 then 'Yes' else 'No' end 'HomeTaxPaidStatus'
 , isnull(TM.WaterTax,0) 'WaterTax',case when isnull(TM.WTPayId,0)>0 then 'Yes' else 'No' end 'WaterTaxPaidStatus'
 , isnull(TM.LightTax,0) 'LightTax',isnull(TM.HealthTax,0) 'HealthTax',isnull(TM.BusinessTax,0) 'BusinessTax',isnull(TM.ShopTax,0) 'ShopTax',isnull(TM.NoticeFee,0) 'NoticeFee',isnull(TM.WarrantFee,0) 'WarrantFee', isnull(TM.TotalAmt,0) 'TotalAmt'
 ,case when isnull(TM.OTPayId,0)>0 then 'Yes' else 'No' end 'OtherTaxPaidStatus'

 from TaxMaster TM
 join Resident RS on TM.ResidentId=RS.ID and TM.IsActive=1 and TM.GramPanchayatID=@GramPanchayatID and (isnull(TM.HTPayId,0)=0 or isnull(TM.WTPayId,0)=0 or isnull(TM.OTPayId,0)=0)
 join House HO on TM.HouseId=Ho.ID
 join Village VL on VL.ID=HO.VillageId
 join Grampanchayat GP on GP.ID=TM.GramPanchayatID

 order by TM.ID
END
--=====================================================================================================================================
if @Action=20--Admint For Tax Master  

 Begin
 --if @SearchText!=''
	--Begin
		declare @Query varchar(max)='',@Filter varchar(max)=''
		---declare @Month int=0,--@Year int=0,@Type int=1--,@GramPanchayatID int=1

		--filter month dropdown,year dropdown, dropdown(1:All Tax Pending,2:Home Tax Pending,3:Water Tax Pending,4:Other Tax Pending,5:All Tax Paid,6:Home Tax Paid,7:Water Tax Paid,8:Other Tax Paid)
		--if isnull(@Month,0)>0
		--begin
		--set @Filter+=' and TM.GenMonth='+cast(@Month as varchar(10))
		--end
		if isnull(@Year,0)>0
		begin
		set @Filter+=' and TM.GenYear='+cast(@Year as varchar(10))
		end
		if isnull(@Type,0)>0
		begin
			set @Filter+=(select
			CASE
				WHEN @Type=1 THEN ' and isnull(TM.HTPayId,0)=0 and isnull(TM.WTPayId,0)=0 and isnull(TM.OTPayId,0)=0'--All Tax Pending
				WHEN @Type=2 THEN ' and isnull(TM.HTPayId,0)=0'--Home Tax Pending
				WHEN @Type=3 THEN ' and isnull(TM.WTPayId,0)=0'--Water Tax Pending
				WHEN @Type=4 THEN ' and isnull(TM.OTPayId,0)=0'--Other Tax Pending
				WHEN @Type=5 THEN ' and isnull(TM.HTPayId,0)=1 and isnull(TM.WTPayId,0)=1 and isnull(TM.OTPayId,0)=1'--All Tax Paid
				WHEN @Type=6 THEN ' and isnull(TM.HTPayId,0)=1'--Home Tax Paid
				WHEN @Type=7 THEN ' and isnull(TM.WTPayId,0)=1'--Water Tax Paid
				WHEN @Type=8 THEN ' and isnull(TM.OTPayId,0)=1'--Other Tax Paid
				ELSE 'TypeFilter'          
			END);
		end

		--set @Query+=' select top 10 TM.ID ''TaxMasterID'', HO.ID ''HouseID'',RS.ID ''ResidentID'','
		--set @Query+=' isnull(RS.FirstName+'' ''+RS.LastName ,'''') ''ReisdentName'','
		--set @Query+=' isnull(HO.PropertyNo,'''')PropertyNo,isnull(HO.RegisterNo,'''')RegisterNo,'
		
		set @Query+=' select top 10 TM.ID ''TaxMasterID'', DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))+''-''+cast(TM.GenYear as varchar(10)) ''Month-Year'','
		set @Query+=' isnull(TM.HomeTax,0) ''HomeTax'',isnull(TM.HTPayId,0) ''HTPayId'','
		set @Query+=' isnull(TM.WaterTax,0) ''WaterTax'',isnull(TM.WTPayId,0) ''WTPayId'','
		set @Query+=' isnull(TM.LightTax,0) ''LightTax'',isnull(TM.HealthTax,0) ''HealthTax'',isnull(TM.BusinessTax,0) ''BusinessTax'',isnull(TM.ShopTax,0) ''ShopTax'',isnull(TM.NoticeFee,0) ''NoticeFee'',isnull(TM.WarrantFee,0) ''WarrantFee'','
		set @Query+=' isnull(TM.TotalAmt,0) ''TotalAmt'',isnull(TM.OTPayId,0) ''OTPayId'',TM.GramPanchayatID'
		set @Query+=' from TaxMaster TM '
		set @Query+=' join Resident RS on TM.ResidentId=RS.ID and TM.IsActive=1 and TM.GramPanchayatID='+cast(@GramPanchayatID as varchar(10))+' and TM.HouseId='+cast(@HouseId as varchar(10))
		set @Query+=' join House HO on TM.HouseId=Ho.ID '
		set @Query+=' where 1=1 '+@Filter
		set @Query+=' order by TM.ID '
		exec (@Query)

	--	END
	End
---====================================================================================================================================================
if @Action=21 --Payment List Show   Resident House Wise
begin  
if @Flag is not null 
  Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId and PA.HouseId=@HouseId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%') 
				order by TM.GenYear,TM.GenMonth
			end

       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
				order by PA.PaymentDate
			end

       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End
end      

--============================================================MOBILE API=========================================================================
if @Action=22 --Payment List Show  Admin
begin  
if @Search is not null 
  Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%') 
				order by TM.GenYear,TM.GenMonth
			end
			   
       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   and  PA.PaymentDate between @Fromdate and @Todate
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
				order by PA.PaymentDate
			end
			     
       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

 

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End
else
 Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate
				order by TM.GenYear,TM.GenMonth
			end
			   
       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   and  PA.PaymentDate between @Fromdate and @Todate
				order by PA.PaymentDate
			end
			     
       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

 

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End
end 
--==============================================================RESIDENT PAYTMENT LIST=========================================================================================
if @Action=23 --Payment List Show   Resident House Wise
begin  
if @Search is not null 
  Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId and PA.HouseId=@HouseId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%') 
				order by TM.GenYear,TM.GenMonth
			end

       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   
				where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
				order by PA.PaymentDate
			end

       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            where (PropertyNo like '%'+@Search+'%' or RegisterNo like '%'+@Search+'%') or (FirstName like '%'+@Search+'%' or LastName like '%'+@Search+'%')
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End     
else
  Begin
      If @Flag = 1 -- Tax wise Payment
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				, cast(DATENAME( MONTH, DATEADD( MONTH, TM.GenMonth, -1))as varchar(10))+'-'+cast(TM.GenYear as varchar(10)) 'Month-Year'
				,case when DBM.ID=2 then TM.HomeTax when DBM.ID=3 then TM.WaterTax when DBM.ID=4 then TM.TotalAmt end 'PaidAmount'
				,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA  
				join TaxMaster TM on TM.HTPayId=PA.PaymentId or TM.WTPayId=PA.PaymentId or TM.OTPayId=PA.PaymentId and PA.HouseId=@HouseId
				join House HO on HO.ID=PA.HouseId 
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				order by TM.GenYear,TM.GenMonth
			end

       Else if @Flag  = 2  ----Transaction wise payment      
			 begin
				Select cast(PA.PaymentDate as varchar(10)) 'PaymentDate',HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
				,PA.Amount,PM.PaymentName 'PaymentName',DBM.BillName,isnull(PA.TranPayId,'')TranPayId,isnull(PA.TranOrderId,'')TranOrderId
				from Payment PA
				join House HO on HO.ID=PA.HouseId and  PA.PaymentDate between @Fromdate and @Todate and PA.HouseId=@HouseId
				join Resident RS on RS.ID=HO.HouseHeadID 
				join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
				join PaymentMethod PM on PM.ID=PA.PayModeID   
				order by PA.PaymentDate
			end

       else IF @Flag=3  ---Customer & Categoy Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount',DBM.BillName
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            join DemandBillMaster DBM on DBM.ID=PA.DemandBillMasterId
            group by HO.PropertyNo,RegisterNo,FirstName,LastName,DBM.BillName
            order by sum(PA.Amount) desc
         end

         else IF @Flag=4 ---Customer Wise Payment
          Begin
            Select HO.PropertyNo,RegisterNo,FirstName+' '+LastName 'ResidentName'
            ,sum(PA.Amount) 'Amount'
            from Payment PA
            join House HO on HO.ID=PA.HouseId  and PA.HouseId=@HouseId
            join Resident RS on RS.ID=HO.HouseHeadID
            group by HO.PropertyNo,RegisterNo,FirstName,LastName
            order by sum(PA.Amount) desc
           end
   End
end

IF @Action=24
	BEGIN   

    
         select
             @HomeTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax,0) else 0 end),0))
            ,@LightTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.LightTax,0) else 0 end),0))
            ,@HealthTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HealthTax,0) else 0 end),0))                                      
            ,@WaterTax=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WaterTax,0) else 0 end),0))      
           ,@TotalAmount=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) < cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax+TM.TotalAmt,0) else 0 end),0))
          
            ,@HomeTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax,0) else 0 end),0))
            ,@LightTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.LightTax,0) else 0 end),0))
            ,@HealthTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HealthTax,0) else 0 end),0))                                      
            ,@WaterTaxC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.WaterTax,0) else 0 end),0))      
                           
            ,@TotalAmountC=sum(isnull((case when cast(TM.InsertDateTime as varchar(50)) > cast(MONTH(GETDATE()) as varchar(50)) then isnull(TM.HomeTax+TM.TotalAmt,0) else 0 end),0))
          
            +sum(isnull((case when ISNULL(TM.WTPayId,0)=0 then isnull(TM.WaterTax,0) else 0 end),0))
            +sum(isnull((case when ISNULL(TM.OTPayId,0)=0 then isnull(TM.TotalAmt,0) else 0 end),0))
            from TaxMaster TM WITH(NOLOCK)
            left join Resident R on r.ID=TM.ResidentId
            left join House H on h.ID=TM.HouseID
            --join DemandBillDetails DD on DD.ResidentId=TM.ResidentId  and DD.HouseID=TM.HouseId
            where TM.HouseId=@HouseId	
          
            select top 1
            @HomeTax HomeTaxP,@LightTax LightTaxP,@HealthTax HealthTaxP,@WaterTax WaterTaxP,@TotalAmount TotalAmount,
           @HomeTaxC HomeTaxC,@LightTaxC LightTaxC,@HealthTaxC HealthTaxC,@WaterTaxC WaterTaxC,@TotalAmountC TotalAmountC,
            isnull(cast(R.FirstName+''+R.SpouseName+''+R.LastName as varchar(100)),'')'ResidentName',isnull(cast(H.PropertyNo as varchar(100)),'')PropertyNo,G.VillageName,
			cast(TM.InsertDateTime as varchar(20))InsertDateTime,@HomeTax+@HomeTaxC 'SumHomeTax',@LightTax+@LightTaxC 'SumLightTax',@HealthTax+@HealthTaxC'SumHealthTax'
			,@WaterTax+@WaterTaxC 'SumWaterTax',@TotalAmount+@TotalAmountC 'SumTotalTax',G.District,TM.ID
            from TaxMaster TM WITH(NOLOCK)
            left join Resident R on r.ID=TM.ResidentId
            left join House H on h.ID=TM.HouseID
            left join Village VL on VL.ID=H.VillageId
			 left join Grampanchayat G on G.ID=TM.GrampanchayatId
            left join DemandBillDetails DD on DD.ResidentId=TM.ResidentId  and DD.HouseID=TM.HouseId
			 where TM.HouseId=@HouseId
	
	END
-----------------------------------------------  
--------------------------------------------------------
-----------------------------------------------------  
--------------------------------------------------------
--end try      
--begin catch      
--IF @@TRANCOUNT > 0  
-- ROLLBACK TRANSACTION Trans_StaffDetails   
-- ------------------------------------------------------------------------  
-- INSERT INTO ExceptionLog (EERROR_NUMBER,PROC_NAME,EERROR_SEVERITY,EERROR_STATE,EERROR_PROCEDURE,EERROR_LINE,EERROR_MESSAGE)      
-- VALUES (ERROR_NUMBER(),'USP_TaxMaster',ERROR_SEVERITY(),ERROR_STATE(),ERROR_PROCEDURE(),ERROR_LINE(),ERROR_MESSAGE());   
-- ------------------------------------------------------------------------  
-- SELECT 'Error : ' + CAST(ERROR_NUMBER() as varchar) + ' : ' + CAST(ERROR_MESSAGE() as varchar);      
--end catch 
GO
/****** Object:  StoredProcedure [dbo].[USP_UPLOAD_EXCELDATA]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROC [dbo].[USP_UPLOAD_EXCELDATA]
(
  @Action int ,
  @UT_HOUSE dbo.UT_House readonly,
  @UT_Resident dbo.UT_Resident readonly
)
AS
Begin
IF @Action = 1
	BEGIN TRY    
		--BEGIN TRAN
		 DECLARE 
		 @GrampanchayatName nvarchar(100) =NULL,@HouseHeadName nvarchar(100) =NULL,@PropertyNo nvarchar(50) =NULL,@RegisterNo varchar(50) =NULL,@RegisterYear int =NULL,@Area numeric(18, 2) =NULL,
		 @HomeTax numeric(18, 2) =NULL,@LightTax numeric(18, 2) =NULL,@HealthTax numeric(18, 2) =NULL,@WaterTax numeric(18, 2) =NULL,@BusinessTax numeric(18, 2) =NULL,@ShopTax numeric(18, 2) =NULL,
		 @NoticeFee numeric(18, 2) =NULL,@WarrantFee numeric(18, 2) =NULL,@OtherTax numeric(18, 2) =NULL,@HDescription nvarchar(500) =NULL,@IsActive bit =NULL,@villagename nvarchar(50) =NULL

		 DECLARE CUR CURSOR FOR 
		 SELECT * FROM @UT_HOUSE
		 OPEN CUR

		 FETCH NEXT FROM CUR INTO @GrampanchayatName, @HouseHeadName,@PropertyNo,@RegisterNo,@RegisterYear,@Area,@HomeTax,@LightTax,@HealthTax,@WaterTax,@BusinessTax,@ShopTax,
								  @NoticeFee,@WarrantFee,@OtherTax,@HDescription,@IsActive,@villagename	
		 WHILE(@@FETCH_STATUS = 0)
		 BEGIN
		    Declare @GramPanchayatId int = 0,@HouseHeadId int = 0 , @VillageId int = 0
			select @GramPanchayatId = id from Grampanchayat where VillageName=@GrampanchayatName
			select @HouseHeadId = id from Resident where FirstName + ' '+ LastName = @HouseHeadName
			select @VillageId = id from Village where VillageName=@villagename			
			 
			IF not exists (select 1 from House where HouseHeadID=@HouseHeadId and GramPanchayatID=@GramPanchayatId and VillageId=@VillageId and PropertyNo=@PropertyNo and RegisterNo=@RegisterNo)
			Begin
			   insert into House (GramPanchayatID,HouseHeadID,PropertyNo,RegisterNo,RegisterYear,Area,HomeTax,LightTax,HealthTax,WaterTax,BusinessTax,ShopTax,NoticeFee,WarrantFee,OtherTax,HDescription,IsActive,VillageId)  
               values (@GramPanchayatID,@HouseHeadID,@PropertyNo,@RegisterNo,@RegisterYear,@Area,@HomeTax,@LightTax,@HealthTax,@WaterTax,@BusinessTax,@ShopTax,@NoticeFee,@WarrantFee,@OtherTax,@HDescription,@IsActive,@villageid);
			end			

			FETCH NEXT FROM CUR INTO @GrampanchayatName, @HouseHeadName,@PropertyNo,@RegisterNo,@RegisterYear,@Area,@HomeTax,@LightTax,@HealthTax,@WaterTax,@BusinessTax,@ShopTax,
								  @NoticeFee,@WarrantFee,@OtherTax,@HDescription,@IsActive,@villagename	
		 END
	  
		 CLOSE EmpCursor
		 DEALLOCATE EmpCursor		 
		 --COMMIT TRAN
		 SELECT IDENT_CURRENT ('HOUSE')
	END TRY
	BEGIN CATCH
		RAISERROR('Something went worng', 1,1)WITH SETERROR;
		RETURN;
	END CATCH
If @Action = 2 
    BEGIN TRY 
			DECLARE
			@GrampanchayatName_ nvarchar(50)=null,@Title nvarchar(10)=null,@FirstName nvarchar(50)=null,@MiddleName nvarchar(50)=null,@LastName nvarchar(50)=null,@FatherName nvarchar(50)=null,@MotherName nvarchar(50)=null,
			@Gender nvarchar(10)=null,@BithDate Date=null,@BirthPlace nvarchar(10)=null,@HouseNumber nvarchar(50)=null,@AdharCardNumber nvarchar(50)=null,@Address nvarchar(200)=null,@IsActive_ bit=null,@MaritalStatus nvarchar(50)=null,
			@PhyDisebleStatus nvarchar(50)=null,@SpouseName nvarchar(10)=null,@MobileNo nvarchar(50)=null,@EmailId  nvarchar(50)=null,@VillageName_ nvarchar(50)=null,@LoginPass nvarchar(50)=null

			DECLARE CUR CURSOR FOR 
		    SELECT * FROM @UT_Resident
		    OPEN CUR

		    FETCH NEXT FROM CUR INTO @GrampanchayatName_ ,@Title ,@FirstName ,@MiddleName ,@LastName ,@FatherName ,@MotherName ,
			                      @Gender ,@BithDate,@BirthPlace ,@HouseNumber ,@AdharCardNumber ,@Address ,@IsActive_,@MaritalStatus ,
			                      @PhyDisebleStatus ,@SpouseName ,@MobileNo ,@EmailId  ,@VillageName_ ,@LoginPass 

			 WHILE(@@FETCH_STATUS = 0)
			 BEGIN
				Declare @GramPanchayatId_ int = 0, @FatherId int = 0, @MotherId int = 0,@HouseId int = 0 ,@MaritalStatusId int = 0 ,@PhyDisabledid int = 0,@SpouseId int = 0, @VillageId_ int = 0

				select @GramPanchayatId_ = id from Grampanchayat where VillageName=@GrampanchayatName_
				select @HouseId = id from House where PropertyNo = @HouseNumber
				select @VillageId_ = id from Village where VillageName=@VillageName_			
				select @MaritalStatusId = id from MaritalStatus where StatusName=@MaritalStatus
				select @PhyDisabledid = id from PhysDisableStatus where Categories=@PhyDisebleStatus
				select @FatherId = id from Resident where FirstName + ' '+ LastName=@FatherName
				select @MotherId = id from Resident where FirstName + ' '+ LastName=@MotherName
				select @SpouseId = id from Resident where FirstName + ' '+ LastName=@SpouseName
			
			 
				--IF not exists (select 1 from Resident where HouseHeadID=@HouseHeadId and GramPanchayatID=@GramPanchayatId and VillageId=@VillageId and PropertyNo=@PropertyNo and RegisterNo=@RegisterNo)
				--Begin
				   Insert Into Resident (GramPanchayatID,FirstName,LastName,FatherID,MotherID,Gender,BirthDate,BirthPlace,HouseID,AdharCardNo,Address,LoginPass,IsActive
										,MaritalStatusID,PhysDisableStatusID,Title,SpouseID,SpouseName,FatherName,MotherName,MiddleName,MobileNo,EmailID,VillageId)
				   values (@GramPanchayatId_,@FirstName,@LastName,@FatherID,@MotherID,@Gender,@BithDate,@BirthPlace,@HouseID,@AdharCardNumber,@Address,@LoginPass,@IsActive_,@MaritalStatusId,
										@PhyDisabledid,@Title,@SpouseId,case when @SpouseId = 0 then @SpouseName else '' end, case when @FatherID = 0 then @FatherName else '' end,case when @MotherId= 0 then @MotherName else '' end,@MiddleName,@MobileNo,@EmailID,@VillageId_)
				--end			

				FETCH NEXT FROM CUR INTO @GrampanchayatName_ ,@Title ,@FirstName ,@MiddleName ,@LastName ,@FatherName ,@MotherName ,
									  @Gender ,@BithDate,@BirthPlace ,@HouseNumber ,@AdharCardNumber ,@Address ,@IsActive_,@MaritalStatus ,
									  @PhyDisebleStatus ,@SpouseName ,@MobileNo ,@EmailId  ,@VillageName_ ,@LoginPass 
			 END
	  
			 CLOSE EmpCursor
			 DEALLOCATE EmpCursor		 
			 --COMMIT TRAN
			 SELECT IDENT_CURRENT ('Resident')
    END TRY
	BEGIN CATCH
		RAISERROR('Something went worng', 1,1)WITH SETERROR;
		RETURN;
	END CATCH
End

--select * from House
GO
/****** Object:  StoredProcedure [dbo].[USP_VerifyData]    Script Date: 22-06-2021 10:51:22 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE proc [dbo].[USP_VerifyData] 
(
 @Action int,
 @Flag int=null
)
As

Begin
 IF @Action=1 --Resident
  Begin
		 select R.ID'ResidentID',R.GramPanchayatID,R.FirstName,R.LastName,isnull(FatherID,0)'FatherID',isnull(MotherID,0)'MotherID',Gender,AdharCardNo
		 ,Address,isnull(LoginPass,'')'LoginPass',R.IsActive,HouseID from Resident R with(nolock)
		 where isnull(houseid,0)=0
		 --WHERE HouseID IS NULL OR HouseID = '' or HouseID=0 --or FatherID IS NULL  or FatherID=0 or MotherID IS NULL  or MotherID=0;
  End
 Else IF @Action=2 -- House
  Begin
		SELECT ID,GramPanchayatID,HouseHeadID,ISNULL(PropertyNo,'')PropertyNo,isnull(RegisterNo,'')RegisterNo,isnull(RegisterYear,'')RegisterYear,isnull(Area,0)Area,isnull(HomeTax,0)HomeTax,
		isnull(LightTax,0)LightTax,isnull(HealthTax,0)HealthTax,isnull(WaterTax,0)WaterTax ,isnull(BusinessTax,0)BusinessTax,isnull(ShopTax,0)ShopTax,isnull(NoticeFee,0)NoticeFee,
		isnull(WarrantFee,0)WarrantFee,isnull(OtherTax,0)OtherTax,isnull(HDescription,'') 'HDescription'
		FROM House 
		WHERE isnull(HouseHeadID,0)=0  or isnull(HomeTax,0)=0 or isnull(WaterTax,0)=0;
		--WHERE HouseHeadID IS NULL OR HouseHeadID = '' or HouseHeadID=0 or HomeTax IS NULL  or HomeTax=0 or WaterTax IS NULL  or WaterTax=0;
  End
  Else IF @Action=3
 Begin
 if @Flag is not null 
  Begin
      If @Flag = 1 -- House
			 begin
				SELECT ID,GramPanchayatID,HouseHeadID,ISNULL(PropertyNo,''),isnull(RegisterNo,''),isnull(RegisterYear,''),isnull(Area,0),isnull(HomeTax,0),isnull(LightTax,0),isnull(HealthTax,0),
				isnull(WaterTax,0) ,isnull(BusinessTax,0),isnull(ShopTax,0),isnull(NoticeFee,0),isnull(WarrantFee,0),isnull(OtherTax,0),isnull(HDescription,'') 'HDescription'
				FROM House 
				WHERE HouseHeadID IS NULL OR HouseHeadID = '' or HouseHeadID=0 or HomeTax IS NULL  or HomeTax=0 or WaterTax IS NULL  or WaterTax=0;
			end
			   
       Else if @Flag  = 2  ----Resident 
			 begin
				select R.ID'ResidentID',R.GramPanchayatID,R.FirstName,R.LastName,isnull(FatherID,0)'FatherID',isnull(MotherID,0)'MotherID',Gender,AdharCardNo
				,Address,isnull(LoginPass,'')'LoginPass',R.IsActive,HouseID from Resident R with(nolock)
				WHERE HouseID IS NULL OR HouseID = '' or HouseID=0 --or FatherID IS NULL  or FatherID=0 or MotherID IS NULL  or MotherID=0;
			end   
     end
 End
END

	
GO
USE [master]
GO
ALTER DATABASE [Grampanchayat] SET  READ_WRITE 
GO
