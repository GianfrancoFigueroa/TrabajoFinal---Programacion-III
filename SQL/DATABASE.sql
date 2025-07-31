USE [master]
GO
/****** Object:  Database [CallCenter]    Script Date: 30/7/2025 21:05:16 ******/
CREATE DATABASE [CallCenter]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'CallCenter', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CallCenter.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'CallCenter_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\CallCenter_log.ldf' , SIZE = 73728KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [CallCenter] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [CallCenter].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [CallCenter] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [CallCenter] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [CallCenter] SET ARITHABORT OFF 
GO
ALTER DATABASE [CallCenter] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [CallCenter] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [CallCenter] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [CallCenter] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [CallCenter] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [CallCenter] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [CallCenter] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [CallCenter] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [CallCenter] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [CallCenter] SET  DISABLE_BROKER 
GO
ALTER DATABASE [CallCenter] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [CallCenter] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [CallCenter] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [CallCenter] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [CallCenter] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [CallCenter] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [CallCenter] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [CallCenter] SET RECOVERY FULL 
GO
ALTER DATABASE [CallCenter] SET  MULTI_USER 
GO
ALTER DATABASE [CallCenter] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [CallCenter] SET DB_CHAINING OFF 
GO
ALTER DATABASE [CallCenter] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [CallCenter] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [CallCenter] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [CallCenter] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [CallCenter] SET QUERY_STORE = ON
GO
ALTER DATABASE [CallCenter] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [CallCenter]
GO
/****** Object:  Table [dbo].[Clientes]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clientes](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[NomClien] [varchar](50) NOT NULL,
	[ApellClien] [varchar](100) NOT NULL,
	[DNIClien] [int] NOT NULL,
	[Tel] [varchar](25) NOT NULL,
	[Email] [varchar](100) NOT NULL,
	[Domicilio] [varchar](200) NOT NULL,
	[Provincias] [int] NULL,
	[localidad] [int] NULL,
	[Estado] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Estados]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Estados](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Estados] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Incidencia]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Incidencia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[IDcliente] [int] NOT NULL,
	[IDestado] [int] NOT NULL,
	[IDusuario] [int] NOT NULL,
	[Problematica] [varchar](1000) NOT NULL,
	[Comentarios] [varchar](1000) NULL,
	[Prioridad] [int] NULL,
	[TipoIncidencia] [int] NULL,
	[AsignadoA] [int] NULL,
	[FechaApertura] [datetime] NOT NULL,
	[UltimaActualizacion] [datetime] NOT NULL,
	[FechaCierre] [datetime] NULL,
	[NroReclamo] [varchar](50) NULL,
	[ComentarioFinal] [varchar](1000) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[localidades]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[localidades](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[localidad] [varchar](100) NOT NULL,
	[idprovincia] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Perfiles]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Perfiles](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Perfil] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[prioridad]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[prioridad](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Prioridad] [varchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[provincias]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[provincias](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[provincia] [varchar](70) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TipoIncidencia]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TipoIncidencia](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[TipoInc] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Nombre] [varchar](50) NOT NULL,
	[Apellido] [varchar](100) NOT NULL,
	[DNI] [int] NOT NULL,
	[IDPerf] [int] NOT NULL,
	[Pass] [varchar](200) NULL,
	[Email] [varchar](100) NULL,
	[Domicilio] [varchar](100) NULL,
	[Provincia] [int] NULL,
	[Localidad] [int] NULL,
	[FechaAlta] [datetime] NULL,
	[FechaBaja] [datetime] NULL,
	[Estado] [bit] NULL,
	[Tel] [char](20) NULL,
	[ImgUrl] [varchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Clientes] ON 
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio], [Provincias], [localidad], [Estado]) VALUES (3, N'Ana Maria', N'García', 28123456, N'11543219000', N'ana.garcia@email.com', N'Av. Rivadavia 123', 23, 221, 1)
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio], [Provincias], [localidad], [Estado]) VALUES (4, N'Luis', N'Martínez', 32987654, N'1167890123', N'luis.martinez@example.com', N'Calle Falsa 456', 2, 13, 1)
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio], [Provincias], [localidad], [Estado]) VALUES (5, N'Sofía', N'Rodríguez', 38765432, N'1123456789', N'sofia.rodriguez@example.com', N'Bv. Oroño 789', 3, 22, 1)
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio], [Provincias], [localidad], [Estado]) VALUES (6, N'Gian', N'Franco', 23456789, N'1122565216', N'figueroagian02@gmail.com', N'Av.SiempreViva', 1, 4, 1)
GO
INSERT [dbo].[Clientes] ([ID], [NomClien], [ApellClien], [DNIClien], [Tel], [Email], [Domicilio], [Provincias], [localidad], [Estado]) VALUES (7, N'Adrian', N'Suarez', 22445566, N'1122667788', N'adrian.suarez@email.com', N'Av.Corrientes 2354', 2, 13, 1)
GO
SET IDENTITY_INSERT [dbo].[Clientes] OFF
GO
SET IDENTITY_INSERT [dbo].[Estados] ON 
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (1, N'Abierto')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (2, N'Analisis')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (3, N'Cerrado')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (4, N'Reabierto')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (5, N'Asignado')
GO
INSERT [dbo].[Estados] ([ID], [Estados]) VALUES (6, N'Resuelto')
GO
SET IDENTITY_INSERT [dbo].[Estados] OFF
GO
SET IDENTITY_INSERT [dbo].[Incidencia] ON 
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (6, 3, 6, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-15T23:33:01.937' AS DateTime), CAST(N'2025-07-15T23:33:04.320' AS DateTime), CAST(N'2025-07-30T03:35:12.140' AS DateTime), N'INC-2025-0000006', N'CASO RESUELTO')
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (7, 4, 2, 3, N'PROBLEMATICA', N'Comentarios', 4, 3, 2, CAST(N'2025-07-15T23:41:53.203' AS DateTime), CAST(N'2025-07-30T20:52:39.227' AS DateTime), NULL, N'INC-2025-0000007', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (8, 5, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-21T23:58:27.610' AS DateTime), CAST(N'2025-07-21T23:58:27.610' AS DateTime), NULL, N'INC-2025-0000008', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (9, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-24T02:12:05.580' AS DateTime), CAST(N'2025-07-24T02:12:05.580' AS DateTime), NULL, N'INC-2025-0000009', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (10, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 3, CAST(N'2025-07-25T00:08:03.567' AS DateTime), CAST(N'2025-07-25T00:08:03.780' AS DateTime), NULL, N'INC-2025-0000010', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (11, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 4, 1, 18, CAST(N'2025-07-25T01:16:26.483' AS DateTime), CAST(N'2025-07-25T01:16:26.483' AS DateTime), NULL, N'INC-2025-0000011', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (12, 4, 1, 9, N'PROBLEMATICA', N'Comentarios', 3, 3, 9, CAST(N'2025-07-30T00:13:51.043' AS DateTime), CAST(N'2025-07-30T00:13:51.043' AS DateTime), NULL, N'INC-2025-0000012', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (13, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 4, 4, 19, CAST(N'2025-07-30T02:06:49.230' AS DateTime), CAST(N'2025-07-30T02:06:49.230' AS DateTime), NULL, N'INC-2025-0000013', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (14, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 4, 1, 18, CAST(N'2025-07-30T03:28:38.193' AS DateTime), CAST(N'2025-07-30T03:28:38.193' AS DateTime), NULL, N'INC-2025-0000014', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (15, 4, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-30T03:43:36.027' AS DateTime), CAST(N'2025-07-30T03:43:36.027' AS DateTime), NULL, N'INC-2025-0000015', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (16, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-30T03:56:54.327' AS DateTime), CAST(N'2025-07-30T03:56:54.327' AS DateTime), NULL, N'INC-2025-0000016', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (17, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 3, 1, 2, CAST(N'2025-07-30T03:58:38.913' AS DateTime), CAST(N'2025-07-30T03:58:38.913' AS DateTime), NULL, N'INC-2025-0000017', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (18, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 3, 1, CAST(N'2025-07-30T04:08:08.257' AS DateTime), CAST(N'2025-07-30T04:08:08.257' AS DateTime), NULL, N'INC-2025-0000018', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (19, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-30T04:24:11.670' AS DateTime), CAST(N'2025-07-30T04:24:11.670' AS DateTime), NULL, N'INC-2025-0000019', NULL)
GO
INSERT [dbo].[Incidencia] ([ID], [IDcliente], [IDestado], [IDusuario], [Problematica], [Comentarios], [Prioridad], [TipoIncidencia], [AsignadoA], [FechaApertura], [UltimaActualizacion], [FechaCierre], [NroReclamo], [ComentarioFinal]) VALUES (20, 6, 1, 3, N'PROBLEMATICA', N'Comentarios', 1, 1, 1, CAST(N'2025-07-30T04:28:34.533' AS DateTime), CAST(N'2025-07-30T04:28:34.533' AS DateTime), NULL, N'INC-2025-0000020', NULL)
GO
SET IDENTITY_INSERT [dbo].[Incidencia] OFF
GO
SET IDENTITY_INSERT [dbo].[localidades] ON 
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (1, N'La Plata', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (2, N'Mar del Plata', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (3, N'Bahía Blanca', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (4, N'Tandil', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (5, N'Olavarría', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (6, N'San Nicolás', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (7, N'Pergamino', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (8, N'Junín', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (9, N'Necochea', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (10, N'Tres Arroyos', 1)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (11, N'Córdoba Capital', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (12, N'Villa Carlos Paz', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (13, N'Río Cuarto', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (14, N'Villa María', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (15, N'Alta Gracia', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (16, N'San Francisco', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (17, N'Río Tercero', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (18, N'Cosquín', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (19, N'Jesús María', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (20, N'La Falda', 2)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (21, N'Santa Fe Capital', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (22, N'Rosario', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (23, N'Rafaela', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (24, N'Reconquista', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (25, N'Venado Tuerto', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (26, N'San Lorenzo', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (27, N'Villa Gobernador Gálvez', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (28, N'Casilda', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (29, N'Esperanza', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (30, N'Cañada de Gómez', 3)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (31, N'Mendoza Capital', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (32, N'San Rafael', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (33, N'Godoy Cruz', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (34, N'Guaymallén', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (35, N'Maipú', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (36, N'Luján de Cuyo', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (37, N'Las Heras', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (38, N'Tunuyán', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (39, N'Rivadavia', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (40, N'San Martín', 4)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (41, N'San Miguel de Tucumán', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (42, N'Yerba Buena', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (43, N'Tafí Viejo', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (44, N'Concepción', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (45, N'Banda del Río Salí', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (46, N'Aguilares', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (47, N'Monteros', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (48, N'Famaillá', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (49, N'Bella Vista', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (50, N'Lules', 5)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (51, N'Salta Capital', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (52, N'San Ramón de la Nueva Orán', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (53, N'Tartagal', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (54, N'General Güemes', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (55, N'Rosario de la Frontera', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (56, N'Metán', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (57, N'Cerrillos', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (58, N'Aguas Blancas', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (59, N'El Carril', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (60, N'Cafayate', 6)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (61, N'Paraná', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (62, N'Concordia', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (63, N'Gualeguaychú', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (64, N'Gualeguay', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (65, N'Villaguay', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (66, N'Colón', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (67, N'La Paz', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (68, N'Nogoyá', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (69, N'Victoria', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (70, N'Federal', 7)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (71, N'Posadas', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (72, N'Oberá', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (73, N'Eldorado', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (74, N'Puerto Iguazú', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (75, N'Apóstoles', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (76, N'Montecarlo', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (77, N'Jardín América', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (78, N'San Vicente', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (79, N'San Pedro', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (80, N'San Ignacio', 8)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (81, N'San Juan Capital', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (82, N'Rawson', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (83, N'Chimbas', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (84, N'Rivadavia', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (85, N'Pocito', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (86, N'Santa Lucía', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (87, N'Albardón', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (88, N'Caucete', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (89, N'San Martín', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (90, N'Angaco', 9)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (91, N'Neuquén Capital', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (92, N'Centenario', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (93, N'Plottier', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (94, N'Zapala', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (95, N'Cutral Có', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (96, N'Rincón de los Sauces', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (97, N'San Martín de los Andes', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (98, N'Chos Malal', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (99, N'Villa La Angostura', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (100, N'Junín de los Andes', 10)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (101, N'Formosa Capital', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (102, N'Clorinda', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (103, N'Pirané', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (104, N'El Colorado', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (105, N'Ibarreta', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (106, N'Las Lomitas', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (107, N'Ingeniero Juárez', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (108, N'Villa Escolar', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (109, N'Herradura', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (110, N'Misión Laishí', 11)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (111, N'San Fernando del Valle de Catamarca', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (112, N'Belén', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (113, N'Tinogasta', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (114, N'Andalgalá', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (115, N'Santa María', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (116, N'Recreo', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (117, N'Saujil', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (118, N'Fiambalá', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (119, N'Mutquín', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (120, N'La Puerta', 12)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (121, N'La Rioja Capital', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (122, N'Chilecito', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (123, N'Aimogasta', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (124, N'Chamical', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (125, N'Villa Unión', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (126, N'Chepes', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (127, N'Famatina', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (128, N'Ulapes', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (129, N'Villa Castelli', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (130, N'Aminga', 13)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (131, N'San Salvador de Jujuy', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (132, N'Palpalá', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (133, N'Perico', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (134, N'El Carmen', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (135, N'San Pedro de Jujuy', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (136, N'Libertador General San Martín', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (137, N'Tilcara', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (138, N'Humahuaca', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (139, N'Maimará', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (140, N'Purmamarca', 14)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (141, N'Viedma', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (142, N'San Carlos de Bariloche', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (143, N'General Roca', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (144, N'Cipolletti', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (145, N'Villa Regina', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (146, N'Allen', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (147, N'Catriel', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (148, N'Cinco Saltos', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (149, N'El Bolsón', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (150, N'Choele Choel', 15)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (151, N'Resistencia', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (152, N'Presidencia Roque Sáenz Peña', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (153, N'Villa Ángela', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (154, N'Charata', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (155, N'Machagai', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (156, N'Las Breñas', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (157, N'General San Martín', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (158, N'Juan José Castelli', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (159, N'Quitilipi', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (160, N'Pampa del Indio', 16)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (161, N'Corrientes Capital', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (162, N'Goya', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (163, N'Paso de los Libres', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (164, N'Curuzú Cuatiá', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (165, N'Mercedes', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (166, N'Monte Caseros', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (167, N'Esquina', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (168, N'Bella Vista', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (169, N'Saladas', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (170, N'Santo Tomé', 17)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (171, N'Río Gallegos', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (172, N'Caleta Olivia', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (173, N'El Calafate', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (174, N'Pico Truncado', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (175, N'Las Heras', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (176, N'Puerto Deseado', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (177, N'Perito Moreno', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (178, N'Puerto San Julián', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (179, N'Gobernador Gregores', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (180, N'Los Antiguos', 18)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (181, N'Santa Rosa', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (182, N'General Pico', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (183, N'Toay', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (184, N'Realicó', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (185, N'Eduardo Castex', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (186, N'Victorica', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (187, N'Intendente Alvear', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (188, N'General Acha', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (189, N'25 de Mayo', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (190, N'Catriló', 19)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (191, N'Santiago del Estero Capital', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (192, N'La Banda', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (193, N'Termas de Río Hondo', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (194, N'Añatuya', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (195, N'Fernández', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (196, N'Quimilí', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (197, N'Monte Quemado', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (198, N'Clodomira', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (199, N'Forres', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (200, N'Loreto', 20)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (201, N'Rawson', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (202, N'Trelew', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (203, N'Puerto Madryn', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (204, N'Comodoro Rivadavia', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (205, N'Esquel', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (206, N'Gaiman', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (207, N'Dolavon', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (208, N'Sarmiento', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (209, N'Rada Tilly', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (210, N'Trevelin', 21)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (211, N'Ushuaia', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (212, N'Río Grande', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (213, N'Tolhuin', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (214, N'San Sebastián', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (215, N'Puerto Almanza', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (216, N'Cullen', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (217, N'Lago Escondido', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (218, N'Cerro Sombrero', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (219, N'Villa Marina', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (220, N'Estancia Viamonte', 22)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (221, N'Palermo', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (222, N'Recoleta', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (223, N'Belgrano', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (224, N'Almagro', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (225, N'Caballito', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (226, N'Villa Urquiza', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (227, N'San Telmo', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (228, N'Retiro', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (229, N'Flores', 23)
GO
INSERT [dbo].[localidades] ([id], [localidad], [idprovincia]) VALUES (230, N'Barracas', 23)
GO
SET IDENTITY_INSERT [dbo].[localidades] OFF
GO
SET IDENTITY_INSERT [dbo].[Perfiles] ON 
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (1, N'Telefonista')
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (2, N'Administrador')
GO
INSERT [dbo].[Perfiles] ([ID], [Perfil]) VALUES (3, N'Supervisor')
GO
SET IDENTITY_INSERT [dbo].[Perfiles] OFF
GO
SET IDENTITY_INSERT [dbo].[prioridad] ON 
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (1, N'BAJA')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (2, N'MEDIA')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (3, N'ALTA')
GO
INSERT [dbo].[prioridad] ([ID], [Prioridad]) VALUES (4, N'URGENTE')
GO
SET IDENTITY_INSERT [dbo].[prioridad] OFF
GO
SET IDENTITY_INSERT [dbo].[provincias] ON 
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (1, N'Buenos Aires')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (2, N'Córdoba')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (3, N'Santa Fe')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (4, N'Mendoza')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (5, N'Tucumán')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (6, N'Salta')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (7, N'Entre Ríos')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (8, N'Misiones')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (9, N'San Juan')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (10, N'Neuquén')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (11, N'Formosa')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (12, N'Catamarca')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (13, N'La Rioja')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (14, N'San Luis')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (15, N'La Pampa')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (16, N'Santiago del Estero')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (17, N'Corrientes')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (18, N'Chaco')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (19, N'Río Negro')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (20, N'Chubut')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (21, N'Santa Cruz')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (22, N'Tierra del Fuego')
GO
INSERT [dbo].[provincias] ([id], [provincia]) VALUES (23, N'Ciudad de Buenos Aires')
GO
SET IDENTITY_INSERT [dbo].[provincias] OFF
GO
SET IDENTITY_INSERT [dbo].[TipoIncidencia] ON 
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (1, N'TECNICO')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (2, N'FACTURACION')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (3, N'SOPORTE')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (4, N'PRODUCTO')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (5, N'SUGERENCIA/MEJORA')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (6, N'QUEJA')
GO
INSERT [dbo].[TipoIncidencia] ([ID], [TipoInc]) VALUES (7, N'OTRO')
GO
SET IDENTITY_INSERT [dbo].[TipoIncidencia] OFF
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (1, N'Roberto', N'Fernández', 98765432, 1, N'pass123', N'roberto.fernandez@email.com', N'Calle 123', 2, 11, CAST(N'2024-11-29T00:00:00.000' AS DateTime), NULL, 1, N'1234567890          ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (2, N'Patricia', N'González', 87654321, 2, N'pass234', N'patricia.gonzalez@email.com', N'Calle 456', 4, 35, CAST(N'2023-01-09T00:00:00.000' AS DateTime), NULL, 1, N'541122467890        ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (3, N'Juan', N'Pérez', 76543210, 3, N'pass456', N'juan.perez@email.com', N'Calle 789', 8, 71, CAST(N'2023-05-19T00:00:00.000' AS DateTime), NULL, 1, N'541176543456        ', N'1.png')
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (4, N'Cristian', N'Bullrich', 44456455, 1, N'pepe123', N'cristian.b@gmail.com', N'Av.Estanislao 2244', 1, 7, CAST(N'2024-11-29T09:24:44.137' AS DateTime), NULL, 1, N'                    ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (9, N'Pedro', N'Lamote', 76456455, 1, N'pepe123', N'Pedrito.la@gmail.com', N'Av.Siempre Viva 225', 1, 2, CAST(N'2024-11-29T09:30:11.587' AS DateTime), NULL, 1, N'+5491176504276      ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (18, N'Manuel', N'Perez', 28508488, 2, N'pepepepe', N'Manuel.p@gmail.com', N'Acevedo 228', 1, 1, CAST(N'2024-11-29T09:55:32.833' AS DateTime), NULL, 1, N'+5491122337766      ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (19, N'Gianfranco', N'Figueroa', 44234342, 3, N'prueba123', N'figueroagian02@gmail.com', N'Av.Siempre Viva', 2, 11, CAST(N'2025-07-08T17:25:05.507' AS DateTime), NULL, 1, N'1134562354          ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (20, N'Ricardo', N'Alfano', 185048503, 1, N'pass123', N'ricardo.alfano@email.com', N'Av.Peron 123', 23, 226, CAST(N'2025-07-30T01:19:57.020' AS DateTime), NULL, 1, N'1122345234          ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (21, N'Ignacio', N'Damond', 19456788, 2, N'pass5', N'ignacio.damond@email.com', N'Av.Aguaraguazu 223', 8, 71, CAST(N'2025-07-30T18:39:04.420' AS DateTime), NULL, 1, N'1122334455          ', NULL)
GO
INSERT [dbo].[Usuarios] ([ID], [Nombre], [Apellido], [DNI], [IDPerf], [Pass], [Email], [Domicilio], [Provincia], [Localidad], [FechaAlta], [FechaBaja], [Estado], [Tel], [ImgUrl]) VALUES (22, N'Leonel', N'Insaurralde', 22233567, 2, N'pass123', N'leonel.insa@email.com', N'Av. Corrientes 234', 22, 211, CAST(N'2025-07-30T20:22:58.263' AS DateTime), NULL, 1, N'1122445566          ', NULL)
GO
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
GO
/****** Object:  Index [UQ__Clientes__312D663E1BA60191]    Script Date: 30/7/2025 21:05:16 ******/
ALTER TABLE [dbo].[Clientes] ADD UNIQUE NONCLUSTERED 
(
	[DNIClien] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [UQ__Usuarios__C035B8DD650FA70E]    Script Date: 30/7/2025 21:05:16 ******/
ALTER TABLE [dbo].[Usuarios] ADD UNIQUE NONCLUSTERED 
(
	[DNI] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Localidad] FOREIGN KEY([localidad])
REFERENCES [dbo].[localidades] ([id])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Localidad]
GO
ALTER TABLE [dbo].[Clientes]  WITH CHECK ADD  CONSTRAINT [FK_Provincia] FOREIGN KEY([Provincias])
REFERENCES [dbo].[provincias] ([id])
GO
ALTER TABLE [dbo].[Clientes] CHECK CONSTRAINT [FK_Provincia]
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDcliente])
REFERENCES [dbo].[Clientes] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDestado])
REFERENCES [dbo].[Estados] ([ID])
GO
ALTER TABLE [dbo].[Incidencia]  WITH CHECK ADD FOREIGN KEY([IDusuario])
REFERENCES [dbo].[Usuarios] ([ID])
GO
ALTER TABLE [dbo].[localidades]  WITH CHECK ADD  CONSTRAINT [FK_Provincia_L] FOREIGN KEY([idprovincia])
REFERENCES [dbo].[provincias] ([id])
GO
ALTER TABLE [dbo].[localidades] CHECK CONSTRAINT [FK_Provincia_L]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD FOREIGN KEY([IDPerf])
REFERENCES [dbo].[Perfiles] ([ID])
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Localidad_PP] FOREIGN KEY([Localidad])
REFERENCES [dbo].[localidades] ([id])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Localidad_PP]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Provincia_LL] FOREIGN KEY([Provincia])
REFERENCES [dbo].[provincias] ([id])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Provincia_LL]
GO
/****** Object:  Trigger [dbo].[NroReclamoFormato]    Script Date: 30/7/2025 21:05:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [dbo].[NroReclamoFormato]
ON [dbo].[Incidencia]
AFTER INSERT
AS
BEGIN
    UPDATE i
    SET NroReclamo = 'INC-' + CAST(YEAR(GETDATE()) AS VARCHAR) + '-' + RIGHT('0000000' + CAST(i.ID AS VARCHAR), 7)
    FROM Incidencia AS i
    INNER JOIN inserted AS ins ON i.ID = ins.ID;
END;
GO
ALTER TABLE [dbo].[Incidencia] ENABLE TRIGGER [NroReclamoFormato]
GO
USE [master]
GO
ALTER DATABASE [CallCenter] SET  READ_WRITE 
GO
