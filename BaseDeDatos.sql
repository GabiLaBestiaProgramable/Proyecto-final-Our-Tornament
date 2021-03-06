USE [master]
GO
/****** Object:  Database [OurTournament]    Script Date: 27/10/2020 18:49:51 ******/
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
/****** Object:  Table [dbo].[Equipos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Equipos](
	[IDEquipo] [int] NOT NULL,
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
/****** Object:  Table [dbo].[Fotos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Fotos](
	[IDFoto] [int] IDENTITY(1,1) NOT NULL,
	[Direccion] [varchar](200) NULL,
	[IDTorneo] [int] NULL,
 CONSTRAINT [PK_Fotos] PRIMARY KEY CLUSTERED 
(
	[IDFoto] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[GolesXUsuarioXPartidos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[GolesXUsuarioXPartidos](
	[IDUsuario] [int] NOT NULL,
	[IDPartido] [int] NOT NULL,
	[CantidadGoles] [int] NULL,
 CONSTRAINT [PK_GolesXPartidos] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[HistorialTorneosParticipados]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistorialTorneosParticipados](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
	[Creador] [bit] NOT NULL,
	[IDEquipo] [int] NOT NULL,
 CONSTRAINT [PK_HistorialTorneosParticipados] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ListaDeEsperaParaTorneo]    Script Date: 27/10/2020 18:49:51 ******/
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
/****** Object:  Table [dbo].[Noticias]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Noticias](
	[IDNoticia] [int] IDENTITY(1,1) NOT NULL,
	[Titulo] [varchar](80) NULL,
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
/****** Object:  Table [dbo].[Partidos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Partidos](
	[IDPartido] [int] IDENTITY(1,1) NOT NULL,
	[FechaDeEncuentro] [datetime] NULL,
	[JornadaDelTorneo] [int] NULL,
	[GolesLocal] [int] NULL,
	[GolesVisitante] [int] NULL,
	[IDTorneo] [int] NULL,
	[IDEquipo1] [int] NULL,
	[IDEquipo2] [int] NULL,
 CONSTRAINT [PK_Partidos] PRIMARY KEY CLUSTERED 
(
	[IDPartido] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SeguidoresXTorneos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SeguidoresXTorneos](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
	[IDEquipoFavorito] [int] NULL,
 CONSTRAINT [PK_SeguidoresXTorneos] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC,
	[IDTorneo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Torneos]    Script Date: 27/10/2020 18:49:51 ******/
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
/****** Object:  Table [dbo].[TorneosParticipadosXUsuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TorneosParticipadosXUsuario](
	[IDUsuario] [int] NOT NULL,
	[IDTorneo] [int] NOT NULL,
	[Creador] [bit] NULL,
	[IDEquipo] [int] NULL,
 CONSTRAINT [PK_TorneosParticipadosXUsuario_1] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Usuarios]    Script Date: 27/10/2020 18:49:51 ******/
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
 CONSTRAINT [PK_Usuarios] PRIMARY KEY CLUSTERED 
(
	[IDUsuario] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (1, N'River Plate', 1, 1, 3, 2, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (2, N'Boca Juniors', 1, 2, 2, 4, 6)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (3, N'Independiente', 1, 3, 6, 5, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (4, N'Racing', 1, 4, 4, 6, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (5, N'SanLorenzo', 1, 5, 6, 1, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (6, N'Huracan', 1, 6, 16, 2, 6)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (7, N'Barcelona', 1, 7, 5, 3, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (8, N'Real Madrid', 1, 8, 7, 2, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (9, N'Atletico Madrid', 1, 2, 9, 3, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (10, N'Nueva Chicago', 1, 5, 5, 1, 5)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (11, N'Bayern Munich', 1, 12, 20, 7, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (12, N'Leipzig', 1, 9, 10, 4, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (13, N'Dortmund', 1, 8, 13, 5, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (14, N'Wolfsburgo', 1, 10, 10, 10, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (15, N'Milan', 1, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (16, N'Colon', 9, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (17, N'Real betis', 8, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (18, N'Juventus', 6, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (19, N'Shalke04', 4, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (20, N'Atlanta', 7, 6, 6, 3, 2)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (21, N'Chacarita', 7, 2, 1, 2, 1)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (22, N'Manchester City', 2, 9, 5, 3, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (23, N'Manchester United', 2, 9, 6, 1, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (24, N'Chelsea', 2, 6, 4, 3, 3)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (25, N'Liverpool', 2, 12, 10, 1, 4)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (26, N'Wolverhampton', 3, 1, 1, 6, 7)
INSERT [dbo].[Equipos] ([IDEquipo], [NombreEquipo], [IDTorneo], [Puntos], [GolesAFavor], [GolesEnContra], [PartidosJugados]) VALUES (27, N'Leeds United', 3, 21, 35, 4, 7)
GO
SET IDENTITY_INSERT [dbo].[Fotos] ON 

INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (1, N'https://es.wikipedia.org/wiki/F%C3%BAtbol#/media/Archivo:Football_iu_1996.jpg', 1)
INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (2, N'https://www.mundodeportivo.com/rf/image_large/GODO/MD/p7/Futbol/Imagenes/2020/08/20/Recortada/20200820-637334974852781493_20200820052502-kufF-U48291400994803D-980x554@MundoDeportivo-Web.jpg', 1)
INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (3, N'https://www.rushbet.co/blog/wp-content/uploads/2019/12/shutterstock_1113319799-1000x605.jpg', 1)
INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (4, N'https://a.espncdn.com/combiner/i?img=/media/motion/2020/0826/evc_FUTBOL_20200826_no_event_name_3a87d4b3_692a_4e1141/evc_FUTBOL_20200826_no_event_name_3a87d4b3_692a_4e1141.jpg', 2)
INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (5, N'https://www.telam.com.ar/advf/imagenes/2020/03/5e691ced2fd99_1004x565.jpg', 2)
INSERT [dbo].[Fotos] ([IDFoto], [Direccion], [IDTorneo]) VALUES (6, N'https://cdn.aarp.net/content/dam/aarp/entertainment/television/2017/07/1140-world-cup-trophy-ball-trivia-esp.imgcache.rev4469921697c064fd0c53617c437e67d8.jpg', 2)
SET IDENTITY_INSERT [dbo].[Fotos] OFF
GO
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (1, 1, 2)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (1, 4, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (2, 1, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (2, 3, 2)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (3, 2, 3)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (3, 4, 2)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (4, 2, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (4, 3, 2)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (4, 13, 4)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (5, 1, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (5, 5, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (6, 5, 1)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (9, 13, 4)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (10, 12, 3)
INSERT [dbo].[GolesXUsuarioXPartidos] ([IDUsuario], [IDPartido], [CantidadGoles]) VALUES (15, 12, 2)
GO
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (1, 2)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (2, 3)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (3, 2)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (4, 5)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (5, 1)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (6, 2)
INSERT [dbo].[ListaDeEsperaParaTorneo] ([IDUsuario], [IDTorneo]) VALUES (7, 1)
GO
SET IDENTITY_INSERT [dbo].[Noticias] ON 

INSERT [dbo].[Noticias] ([IDNoticia], [Titulo], [Descripcion], [IDFoto], [IDTorneo], [Fecha], [Destacada]) VALUES (1, N'Suarez anota en su debut', N'El goleador uruguayo, nuevo refuerzo del Atletico de Madrid, marca un doblete en su debut y le de la victoria a los madrilenses.', 1, 1, CAST(N'2020-10-01' AS Date), 1)
INSERT [dbo].[Noticias] ([IDNoticia], [Titulo], [Descripcion], [IDFoto], [IDTorneo], [Fecha], [Destacada]) VALUES (2, N'Ansu Fati, la nueva promesa', N'El joven jugador nacionalizado español, llego a primera y la esta rompiendo marcando goles en todos los partidos.', 2, 1, CAST(N'2020-10-02' AS Date), 1)
INSERT [dbo].[Noticias] ([IDNoticia], [Titulo], [Descripcion], [IDFoto], [IDTorneo], [Fecha], [Destacada]) VALUES (3, N'La capitana del plantel mejicano festeja su triunfo', N'A traves de este triunfo, el conjunto mejicano consigue clasificar al mundial de futbol femenino', 3, 1, CAST(N'2020-10-08' AS Date), 0)
INSERT [dbo].[Noticias] ([IDNoticia], [Titulo], [Descripcion], [IDFoto], [IDTorneo], [Fecha], [Destacada]) VALUES (4, N'Polemica imagen durante un partido definitivo', N'Se filtra una imagen donde dos jugadores, en una situacion de disputa por el balon, quedan a centimetros de tocarle el miembro reproductor al oponente', 4, 1, CAST(N'2020-10-10' AS Date), 0)
INSERT [dbo].[Noticias] ([IDNoticia], [Titulo], [Descripcion], [IDFoto], [IDTorneo], [Fecha], [Destacada]) VALUES (5, N'Real Madrid festeja ganar el campeonato', N'El equipo Real Madrid se consagra campeon del torneo Liga1 y asi se abrazan dirante el festejo', 5, 1, CAST(N'2020-10-18' AS Date), 1)
SET IDENTITY_INSERT [dbo].[Noticias] OFF
GO
SET IDENTITY_INSERT [dbo].[Partidos] ON 

INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (1, CAST(N'2020-04-05T15:30:00.000' AS DateTime), 1, 2, 1, 1, 1, 2)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (2, CAST(N'2020-11-10T16:00:00.000' AS DateTime), 1, 3, 1, 1, 3, 4)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (3, CAST(N'2020-03-27T14:20:00.000' AS DateTime), 2, 2, 2, 1, 2, 4)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (4, CAST(N'2020-07-05T00:00:00.000' AS DateTime), 2, 1, 2, 1, 1, 3)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (5, CAST(N'2020-07-04T00:00:00.000' AS DateTime), 1, 1, 1, 1, 5, 6)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (6, CAST(N'2020-04-23T00:00:00.000' AS DateTime), 1, 1, 1, 2, 7, 8)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (7, CAST(N'2020-04-24T00:00:00.000' AS DateTime), 1, 1, 3, 5, 13, 11)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (8, CAST(N'2020-04-25T00:00:00.000' AS DateTime), 1, 2, 3, 5, 12, 14)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (9, CAST(N'2020-04-26T00:00:00.000' AS DateTime), 2, 1, 2, 2, 10, 9)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (10, CAST(N'2020-11-21T00:00:00.000' AS DateTime), 1, 2, 1, 7, 20, 21)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (11, CAST(N'2020-11-25T00:00:00.000' AS DateTime), 2, 0, 0, 1, 11, 13)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (12, CAST(N'2020-11-30T00:00:00.000' AS DateTime), 1, 3, 2, 1, 10, 15)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (13, CAST(N'2020-12-01T00:00:00.000' AS DateTime), 1, 4, 4, 1, 4, 9)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (14, CAST(N'2020-12-01T00:00:00.000' AS DateTime), 3, -1, -1, 1, 14, 6)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (15, CAST(N'2020-12-02T00:00:00.000' AS DateTime), 3, -1, -1, 1, 12, 3)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (16, CAST(N'2020-12-02T00:00:00.000' AS DateTime), 3, -1, -1, 1, 1, 7)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (17, CAST(N'2020-12-03T19:43:00.000' AS DateTime), 3, -1, -1, 1, 8, 5)
INSERT [dbo].[Partidos] ([IDPartido], [FechaDeEncuentro], [JornadaDelTorneo], [GolesLocal], [GolesVisitante], [IDTorneo], [IDEquipo1], [IDEquipo2]) VALUES (18, CAST(N'2020-11-18T18:40:00.000' AS DateTime), 2, 0, 0, 1, 5, 15)
SET IDENTITY_INSERT [dbo].[Partidos] OFF
GO
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (1, 6, NULL)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (1, 8, NULL)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (1, 10, NULL)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (2, 2, 2)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (3, 4, 3)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (4, 2, NULL)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (4, 4, 4)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (5, 5, 5)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (6, 5, 5)
INSERT [dbo].[SeguidoresXTorneos] ([IDUsuario], [IDTorneo], [IDEquipoFavorito]) VALUES (7, 7, 7)
GO
SET IDENTITY_INSERT [dbo].[Torneos] ON 

INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (1, N'Liga1', N'Admin', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (2, N'Liga2', N'Admin2', N'234')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (3, N'Superliga', N'Admin3', N'567')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (4, N'Santander', N'Admin4', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (5, N'Bundesliga', N'Admin5', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (6, N'CalcioA', N'Admin6', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (7, N'GambetaCorta', N'Admin7', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (8, N'Fortnite', N'Admin8', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (9, N'Los Riverplatenses', N'Admin9', N'123')
INSERT [dbo].[Torneos] ([IDTorneo], [NombreTorneo], [ContraseniaDeAdministrador], [LinkParaUnirse]) VALUES (10, N'Bokitapasiooon', N'Admin10', N'123')
SET IDENTITY_INSERT [dbo].[Torneos] OFF
GO
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (1, 1, 0, 1)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (2, 1, 0, 2)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (3, 1, NULL, 3)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (4, 1, 0, 4)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (5, 1, 0, 5)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (6, 1, 0, 6)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (7, 1, 0, 7)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (8, 1, 0, 8)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (9, 1, 0, 9)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (10, 1, 0, 10)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (11, 1, 0, 11)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (12, 1, 0, 12)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (13, 1, 0, 13)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (14, 1, 0, 14)
INSERT [dbo].[TorneosParticipadosXUsuario] ([IDUsuario], [IDTorneo], [Creador], [IDEquipo]) VALUES (15, 1, 0, 15)
GO
SET IDENTITY_INSERT [dbo].[Usuarios] ON 

INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (1, N'DamianGluk', N'Dami123', CAST(N'2003-05-08' AS Date), N'damigluk@gmail.com', 50)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (2, N'Ale', N'ale123', CAST(N'2003-11-11' AS Date), N'ale@gmail.com', 20)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (3, N'Gabo', N'gabo123', CAST(N'2004-11-11' AS Date), N'jojo@gmail.com', 30)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (4, N'Jorge', N'dale123', CAST(N'1999-11-11' AS Date), N'dale@gmail.com', 1)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (5, N'Cristiano', N'gol123', CAST(N'1990-12-10' AS Date), N'gol@gmail.com', 5)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (6, N'Lionel', N'camp123', CAST(N'2000-12-10' AS Date), N'camp@gmail.com', 6)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (7, N'Diego Armando', N'fallguys123', CAST(N'2020-10-08' AS Date), N'fall@gmail.com', 0)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (8, N'Samuel Eto', N'e2e', CAST(N'2002-03-09' AS Date), N'sxw@gmail.com', 3)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (9, N'Platini', N'plati888', CAST(N'1944-05-22' AS Date), N'platini@gmail.com', 2)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (10, N'Panenka', N'panenka32', CAST(N'1922-01-10' AS Date), N'panenka@gmail.com', 5)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (11, N'Riquelme', N'jroman10', CAST(N'1970-06-23' AS Date), N'juanRoman@gmail.com', 31)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (12, N'Luis enrique', N'luis44', CAST(N'1954-08-04' AS Date), N'luisEnriq@gmail.com', 7)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (13, N'Pele', N'pele400', CAST(N'1940-10-23' AS Date), N'pele@gmail.com', 18)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (14, N'Clemente Rodriguez', N'clemenBoca', CAST(N'1998-12-26' AS Date), N'clemen@gmail.com|', 5)
INSERT [dbo].[Usuarios] ([IDUsuario], [NombreDeUsuario], [Contrasenia], [FechaDeNacimiento], [Email], [GolesEnTorneo]) VALUES (15, N'Bochini', N'elbocha5', CAST(N'1954-06-14' AS Date), N'elBocha@gmail.com', 21)
SET IDENTITY_INSERT [dbo].[Usuarios] OFF
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
ALTER TABLE [dbo].[GolesXUsuarioXPartidos]  WITH CHECK ADD  CONSTRAINT [FK_GolesXPartidos_Partidos] FOREIGN KEY([IDPartido])
REFERENCES [dbo].[Partidos] ([IDPartido])
GO
ALTER TABLE [dbo].[GolesXUsuarioXPartidos] CHECK CONSTRAINT [FK_GolesXPartidos_Partidos]
GO
ALTER TABLE [dbo].[GolesXUsuarioXPartidos]  WITH CHECK ADD  CONSTRAINT [FK_GolesXPartidos_Usuarios] FOREIGN KEY([IDUsuario])
REFERENCES [dbo].[Usuarios] ([IDUsuario])
GO
ALTER TABLE [dbo].[GolesXUsuarioXPartidos] CHECK CONSTRAINT [FK_GolesXPartidos_Usuarios]
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
/****** Object:  StoredProcedure [dbo].[DeleteTorneoSeguidoPorUsuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[DeleteTorneoSeguidoPorUsuario]
	-- Add the parameters for the stored procedure here
	@IDTorneo int,
	@IDUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	delete from SeguidoresXTorneos where IDUsuario = @IDUsuario and IDTorneo = @IDTorneo
	
END
GO
/****** Object:  StoredProcedure [dbo].[InsertarTorneoSeguidoPorUsuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[InsertarTorneoSeguidoPorUsuario]
	-- Add the parameters for the stored procedure here
	@IDTorneo int,
	@IDUsuario int,
	@IDEquipoFavorito varchar(50)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	IF (@IDEquipoFavorito = -1)
	BEGIN
	insert into SeguidoresXTorneos(IDUsuario,IDTorneo,IDEquipoFavorito) values (@IDUsuario,@IDTorneo,NULL)
	END
	ELSE
	BEGIN
	insert into SeguidoresXTorneos(IDUsuario,IDTorneo,IDEquipoFavorito) values (@IDUsuario,@IDTorneo,@IDEquipoFavorito)
	END
	
END
GO
/****** Object:  StoredProcedure [dbo].[TraerEquipoPorIDEquipo]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerEquipoPorIDEquipo] 
	-- Add the parameters for the stored procedure here
	@IDEquipo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Equipos where Equipos.IDEquipo = @IDEquipo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerEquiposPorTorneo]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerEquiposPorTorneo]
	-- Add the parameters for the stored procedure here
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Equipos where IDTorneo = @IDTorneo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerGolesXusuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerGolesXusuario] 
	-- Add the parameters for the stored procedure here
	@IDPartido int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select IDPartido, GolesXUsuarioXPartidos.IDUsuario,NombreDeUsuario,CantidadGoles,
           Equipos.NombreEquipo from GolesXUsuarioXPartidos inner join Usuarios on Usuarios.IDUsuario = 
           GolesXUsuarioXPartidos.IDUsuario inner join TorneosParticipadosXUsuario on TorneosParticipadosXUsuario.IDUsuario = 
           Usuarios.IDUsuario inner join Equipos on TorneosParticipadosXUsuario.IDEquipo = Equipos.IDEquipo where
           GolesXUsuarioXPartidos.IDPartido = @IDPartido
END
GO
/****** Object:  StoredProcedure [dbo].[TraerJornadasPorTorneo]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerJornadasPorTorneo]
	-- Add the parameters for the stored procedure here
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Distinct JornadaDelTorneo FROM Partidos where Partidos.IDTorneo = +@IDTorneo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerJugadoresXEquipos]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerJugadoresXEquipos] 
	-- Add the parameters for the stored procedure here
	@IDEquipo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select * from Usuarios inner join TorneosParticipadosXUsuario on Usuarios.IDUsuario = TorneosParticipadosXUsuario.IDUsuario 
	where TorneosParticipadosXUsuario.IDEquipo = @IDEquipo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerListaGoleadores]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerListaGoleadores] 
	-- Add the parameters for the stored procedure here
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	select Usuarios.IDUsuario,NombreDeUsuario, Equipos.NombreEquipo,GolesEnTorneo from Usuarios inner join
           TorneosParticipadosXUsuario on Usuarios.IDUsuario = TorneosParticipadosXUsuario.IDUsuario inner join Equipos
           on Equipos.IDEquipo = TorneosParticipadosXUsuario.IDEquipo where TorneosParticipadosXUsuario.IDTorneo = @IDTorneo
           order by Usuarios.GolesEnTorneo desc
END
GO
/****** Object:  StoredProcedure [dbo].[TraerListaPosiciones]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TraerListaPosiciones]
    -- Add the parameters for the stored procedure here
    @IDTorneo int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here
    SELECT * FROM Equipos where Equipos.IDTorneo = @IDTorneo order by Puntos desc,GolesAFavor desc
END
GO
/****** Object:  StoredProcedure [dbo].[TraerNoticiasPorTorneo]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerNoticiasPorTorneo] 
	-- Add the parameters for the stored procedure here
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Noticias where IDTorneo = @IDTorneo order by Destacada DESC
END
GO
/****** Object:  StoredProcedure [dbo].[TraerPartidosPorJornada]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerPartidosPorJornada]
	-- Add the parameters for the stored procedure here
	@IDJornada int,
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Partidos.*,EquipoLocal.NombreEquipo As NombreEquipoLocal, EquipoVisitante.NombreEquipo AS NombreEquipoVisitante
          FROM Partidos INNER JOIN Equipos EquipoLocal ON Partidos.IDEquipo1 = EquipoLocal.IDEquipo
          INNER JOIN Equipos EquipoVisitante ON Partidos.IDEquipo2 = EquipoVisitante.IDEquipo
          where Partidos.JornadaDelTorneo = @IDJornada and Partidos.IDTorneo = + @IDTorneo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerTorneoPorID]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerTorneoPorID]
	-- Add the parameters for the stored procedure here
	@IDTorneo int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT * FROM Torneos where Torneos.IDTorneo = +@IDTorneo
END
GO
/****** Object:  StoredProcedure [dbo].[TraerTorneosParticipadosPorUsuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerTorneosParticipadosPorUsuario] 
	-- Add the parameters for the stored procedure here
	@IDUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Torneos.* FROM Torneos LEFT JOIN TorneosParticipadosXUsuario ON Torneos.IDTorneo = TorneosParticipadosXUsuario.IDTorneo 
	AND TorneosParticipadosXUsuario.IDUsuario = @IDUsuario where TorneosParticipadosXUsuario.IDUsuario IS NOT NULL 
	order by Torneos.NombreTorneo ASC
END
GO
/****** Object:  StoredProcedure [dbo].[TraerTorneosPorNombre]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[TraerTorneosPorNombre]
    -- Add the parameters for the stored procedure here
    @Nombre varchar(30),
	@IDUsuario int
AS
BEGIN
    -- SET NOCOUNT ON added to prevent extra result sets from
    -- interfering with SELECT statements.
    SET NOCOUNT ON;

    -- Insert statements for procedure here\

	IF @Nombre = '()' 
BEGIN
	SELECT Torneos.*, CASE WHEN SeguidoresXTorneos.IDUsuario IS NOT NULL THEN 1 ELSE 0 END AS Siguiendo FROM Torneos LEFT JOIN SeguidoresXTorneos ON Torneos.IDTorneo = SeguidoresXTorneos.IDTorneo AND SeguidoresXTorneos.IDUsuario = @IDUsuario order by Torneos.NombreTorneo ASC 
END
ELSE
BEGIN
	SELECT Torneos.*, CASE WHEN SeguidoresXTorneos.IDUsuario IS NOT NULL THEN 1 ELSE 0 END AS Siguiendo
    FROM Torneos LEFT JOIN SeguidoresXTorneos ON Torneos.IDTorneo = SeguidoresXTorneos.IDTorneo AND SeguidoresXTorneos.IDUsuario = @IDUsuario
    where NombreTorneo LIKE '%'+@Nombre+'%'
    order by Torneos.NombreTorneo ASC
END
END
GO
/****** Object:  StoredProcedure [dbo].[TraerTorneosSeguidosPorUsuario]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerTorneosSeguidosPorUsuario] 
	-- Add the parameters for the stored procedure here
	@IDUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Torneos.* FROM Torneos LEFT JOIN SeguidoresXTorneos ON Torneos.IDTorneo = SeguidoresXTorneos.IDTorneo 
	AND SeguidoresXTorneos.IDUsuario = @IDUsuario where SeguidoresXTorneos.IDUsuario IS NOT NULL order by Torneos.NombreTorneo ASC
END
GO
/****** Object:  StoredProcedure [dbo].[TraerUsuarioPorNombreContrasenia]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerUsuarioPorNombreContrasenia] 
	-- Add the parameters for the stored procedure here
	@NombreUsuario varchar(20),
	@Contrasenia varchar(20)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Usuarios where Usuarios.NombreDeUsuario = @NombreUsuario COLLATE Modern_Spanish_100_CS_AI and Usuarios.Contrasenia = @Contrasenia COLLATE Modern_Spanish_100_CS_AI
END
GO
/****** Object:  StoredProcedure [dbo].[TraerUsuariosPorID]    Script Date: 27/10/2020 18:49:51 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[TraerUsuariosPorID] 
	-- Add the parameters for the stored procedure here
	@IDUsuario int
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	Select * from Usuarios where Usuarios.IDUsuario = @IDUsuario
END
GO
USE [master]
GO
ALTER DATABASE [OurTournament] SET  READ_WRITE 
GO
