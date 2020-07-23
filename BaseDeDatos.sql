USE [master]
GO
/****** Object:  Database [OurTournament]    Script Date: 22/07/2020 20:02:18 ******/
CREATE DATABASE [OurTournament]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'OurTournament', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\OurTournament.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'OurTournament_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\OurTournament_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [OurTournament] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [OurTournament].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [OurTournament] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [OurTournament] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [OurTournament] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [OurTournament] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [OurTournament] SET ARITHABORT OFF 
GO
ALTER DATABASE [OurTournament] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [OurTournament] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [OurTournament] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [OurTournament] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [OurTournament] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [OurTournament] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [OurTournament] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [OurTournament] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [OurTournament] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [OurTournament] SET  DISABLE_BROKER 
GO
ALTER DATABASE [OurTournament] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [OurTournament] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [OurTournament] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [OurTournament] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [OurTournament] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [OurTournament] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [OurTournament] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [OurTournament] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [OurTournament] SET  MULTI_USER 
GO
ALTER DATABASE [OurTournament] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [OurTournament] SET DB_CHAINING OFF 
GO
ALTER DATABASE [OurTournament] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [OurTournament] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [OurTournament] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [OurTournament] SET QUERY_STORE = OFF
GO
USE [OurTournament]
GO
/****** Object:  Table [dbo].[Equipos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[IDEquipo] [varchar](30) NOT NULL,
	[NombreEquipo] [varchar](20) NULL,
	[IDTorneo] [int] NULL,
	[Puntos] [int] NULL,
	[GolesAFavor] [int] NULL,
	[GolesEnContra] [int] NULL,
	[PartidosJugados] [int] NULL,
 CONSTRAINT [PK_Equipos] PRIMARY KEY CLUSTERED 
(
	[IDEquipo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Fotos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fotos](
	[IDFoto] [int] IDENTITY(1,1) NOT NULL,
	[Direccion] [varchar](40) NULL,
	[IDTorneo] [int] NULL,
 CONSTRAINT [PK_Fotos] PRIMARY KEY CLUSTERED 
(
	[IDFoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GolesXPartidos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GolesXPartidos](
	[IDUsuario] [int] NOT NULL,
	[IDPartido] [int] NOT NULL,
 CONSTRAINT [PK_GolesXPartidos] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListaDeEsperaParaTorneo]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ListaDeEsperaParaTorneo](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
 CONSTRAINT [PK_ListaDeEsperaParaTorneo] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDTorneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Noticias]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticias](
	[IDNoticia] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](40) NULL,
	[Descripcion] [varchar](300) NULL,
	[IDFoto] [int] NULL,
	[IDTorneo] [int] NULL,
	[Fecha] [date] NULL,
	[Destacada] [bit] NULL,
 CONSTRAINT [PK_Noticias] PRIMARY KEY CLUSTERED 
(
	[IDNoticia] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Partidos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partidos](
	[IDPartido] [int] IDENTITY(1,1) NOT NULL,
	[FechaDeEncuentro] [date] NULL,
	[JornadaDelTorneo] [int] NULL,
	[NombreEquipoLocal] [varchar](30) NULL,
	[NombreEquipoVisitante] [varchar](30) NULL,
	[GolesLocal] [int] NULL,
	[GolesVisitante] [int] NULL,
	[IDTorneo] [int] NULL,
 CONSTRAINT [PK_Partidos] PRIMARY KEY CLUSTERED 
(
	[IDPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeguidoresXTorneos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeguidoresXTorneos](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
	[IDEquipoFavorito] [varchar](30) NULL,
 CONSTRAINT [PK_SeguidoresXTorneos] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDTorneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Torneos]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Torneos](
	[IDTorneo] [int] IDENTITY(1,1) NOT NULL,
	[NombreTorneo] [varchar](20) NULL,
	[ContraseniaDeAdministrador] [varchar](20) NULL,
	[LinkParaUnirse] [varchar](40) NULL,
 CONSTRAINT [PK_Torneos] PRIMARY KEY CLUSTERED 
(
	[IDTorneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TorneosParticipadosXUsuario]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TorneosParticipadosXUsuario](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
	[Administrador] [bit] NULL,
 CONSTRAINT [PK_TorneosParticipadosXUsuario] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDTorneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 22/07/2020 20:02:19 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Usuarios](
	[IDUsuario] [int] IDENTITY(1,1) NOT NULL,
	[NombreDeUsuario] [varchar](20) NULL,
	[Contrasenia] [varchar](20) NULL,
	[FechaDeNacimiento] [date] NULL,
	[Email] [varchar](40) NULL,
	[GolesEnTorneo] [int] NULL,
	[IDEquipo] [varchar](30) NULL,
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'1', N'River Plate', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'2', N'Boca Juniors', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'3', N'Independiente', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'4', N'Racing', 1, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'5', N'SanLorenzo', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'6', N'Huracan', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'7', N'Barcelona', 2, NULL, NULL, NULL, NULL)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (N'8', N'Real Madrid', 2, NULL, NULL, NULL, NULL)
GO
SET IDENTITY_INSERT [dbo].[Partidos] ON 

INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (1, CAST(N'2020-04-05' AS Date), 1, N'River Plate', N'Boca juniors', 2, 1, 1)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (2, CAST(N'2020-11-10' AS Date), 1, N'Independiente', N'Racing', 6, 1, 1)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (3, CAST(N'2020-03-27' AS Date), 2, N'Boca Juniors', N'Racing', 2, 7, 1)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (4, CAST(N'2020-07-05' AS Date), 2, N'River Plate', N'Independiente', 1, 2, 1)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (5, CAST(N'2020-07-04' AS Date), 1, N'San Lorenzo', N'Huracan', 6, 5, 2)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [NombreEquipoLocal], [NombreEquipoVisitante], [GolesLocal], [GolesVisitante], [IDTorneo]) VALUES (6, CAST(N'2020-04-23' AS Date), 1, N'Barcelona', N'Real Madrid', 1, 1, 2)
SET IDENTITY_INSERT [dbo].[Partidos] OFF
GO
SET IDENTITY_INSERT [dbo].[Torneos] ON 

INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (1, N'Liga1', N'Admin', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (2, N'Liga2', N'Admin2', N'234')
SET IDENTITY_INSERT [dbo].[Torneos] OFF
GO
ALTER TABLE [dbo].[Equipos]  WITH CHECK ADD  CONSTRAINT [FK_Equipos_Torneos] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[Equipos] CHECK CONSTRAINT [FK_Equipos_Torneos]
GO
ALTER TABLE [dbo].[Fotos]  WITH CHECK ADD  CONSTRAINT [FK_Fotos_Torneos1] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[Fotos] CHECK CONSTRAINT [FK_Fotos_Torneos1]
GO
ALTER TABLE [dbo].[GolesXPartidos]  WITH CHECK ADD  CONSTRAINT [FK_GolesXPartidos_Partidos] FOREIGN KEY([IDPartido])
REFERENCES [dbo].[Partidos] ([IDPartido])
GO
ALTER TABLE [dbo].[GolesXPartidos] CHECK CONSTRAINT [FK_GolesXPartidos_Partidos]
GO
ALTER TABLE [dbo].[GolesXPartidos]  WITH CHECK ADD  CONSTRAINT [FK_GolesXPartidos_Usuarios] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuarios] ([IDUsuario])
GO
ALTER TABLE [dbo].[GolesXPartidos] CHECK CONSTRAINT [FK_GolesXPartidos_Usuarios]
GO
ALTER TABLE [dbo].[ListaDeEsperaParaTorneo]  WITH CHECK ADD  CONSTRAINT [FK_ListaDeEsperaParaTorneo_Torneos] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[ListaDeEsperaParaTorneo] CHECK CONSTRAINT [FK_ListaDeEsperaParaTorneo_Torneos]
GO
ALTER TABLE [dbo].[ListaDeEsperaParaTorneo]  WITH CHECK ADD  CONSTRAINT [FK_ListaDeEsperaParaTorneo_Usuarios] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuarios] ([IDUsuario])
GO
ALTER TABLE [dbo].[ListaDeEsperaParaTorneo] CHECK CONSTRAINT [FK_ListaDeEsperaParaTorneo_Usuarios]
GO
ALTER TABLE [dbo].[Noticias]  WITH CHECK ADD  CONSTRAINT [FK_Noticias_Fotos] FOREIGN KEY([IDFoto])
REFERENCES [dbo].[Fotos] ([IDFoto])
GO
ALTER TABLE [dbo].[Noticias] CHECK CONSTRAINT [FK_Noticias_Fotos]
GO
ALTER TABLE [dbo].[Noticias]  WITH CHECK ADD  CONSTRAINT [FK_Noticias_Torneos] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[Noticias] CHECK CONSTRAINT [FK_Noticias_Torneos]
GO
ALTER TABLE [dbo].[Partidos]  WITH CHECK ADD  CONSTRAINT [FK_Partidos_Torneos] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[Partidos] CHECK CONSTRAINT [FK_Partidos_Torneos]
GO
ALTER TABLE [dbo].[SeguidoresXTorneos]  WITH CHECK ADD  CONSTRAINT [FK_SeguidoresXTorneos_Equipos] FOREIGN KEY([IDEquipoFavorito])
REFERENCES [dbo].[Equipos] ([IDEquipo])
GO
ALTER TABLE [dbo].[SeguidoresXTorneos] CHECK CONSTRAINT [FK_SeguidoresXTorneos_Equipos]
GO
ALTER TABLE [dbo].[SeguidoresXTorneos]  WITH CHECK ADD  CONSTRAINT [FK_SeguidoresXTorneos_Torneos] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[SeguidoresXTorneos] CHECK CONSTRAINT [FK_SeguidoresXTorneos_Torneos]
GO
ALTER TABLE [dbo].[SeguidoresXTorneos]  WITH CHECK ADD  CONSTRAINT [FK_SeguidoresXTorneos_Usuarios] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuarios] ([IDUsuario])
GO
ALTER TABLE [dbo].[SeguidoresXTorneos] CHECK CONSTRAINT [FK_SeguidoresXTorneos_Usuarios]
GO
ALTER TABLE [dbo].[TorneosParticipadosXUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TorneosParticipadosXUsuario_Torneos1] FOREIGN KEY([IDTorneo])
REFERENCES [dbo].[Torneos] ([IDTorneo])
GO
ALTER TABLE [dbo].[TorneosParticipadosXUsuario] CHECK CONSTRAINT [FK_TorneosParticipadosXUsuario_Torneos1]
GO
ALTER TABLE [dbo].[TorneosParticipadosXUsuario]  WITH CHECK ADD  CONSTRAINT [FK_TorneosParticipadosXUsuario_Usuarios] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuarios] ([IDUsuario])
GO
ALTER TABLE [dbo].[TorneosParticipadosXUsuario] CHECK CONSTRAINT [FK_TorneosParticipadosXUsuario_Usuarios]
GO
ALTER TABLE [dbo].[Usuarios]  WITH CHECK ADD  CONSTRAINT [FK_Usuarios_Equipos] FOREIGN KEY([IDEquipo])
REFERENCES [dbo].[Equipos] ([IDEquipo])
GO
ALTER TABLE [dbo].[Usuarios] CHECK CONSTRAINT [FK_Usuarios_Equipos]
GO
USE [master]
GO
ALTER DATABASE [OurTournament] SET  READ_WRITE 
GO
