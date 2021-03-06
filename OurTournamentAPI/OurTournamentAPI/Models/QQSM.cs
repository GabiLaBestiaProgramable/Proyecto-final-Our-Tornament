﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;

namespace OurTournamentAPI
{
    public class QQSM
    {
        private SqlConnection con;
        private SqlConnection Conectar()
        {
            //string constring = @"Server=LAPTOP-4HDMLNB7\SQLEXPRESS;Database=OurTournament;Trusted_Connection=True;";
            string constring = @"Server=DESKTOP-F0QOOGP\AAA;Database=OurTournament;Trusted_Connection=True;";
            SqlConnection a = new SqlConnection(constring);
            a.Open();
            return a;
        }

        private void Desconectar(SqlConnection con)
        {
            con.Close();
        }

        private SqlDataReader HacerSelect(String STRConsulta)
        {
            con = Conectar();
            SqlCommand Consulta = con.CreateCommand();
            Consulta.CommandType = CommandType.Text;
            Consulta.CommandText = STRConsulta;
            SqlDataReader Lector = Consulta.ExecuteReader();
            return Lector;
        }

        private SqlDataReader HacerStoredProcedured(String ST,Dictionary<String,object> Parametros)
        {
            con = Conectar();
            SqlCommand Consulta = new SqlCommand("dbo."+ST, con);
            Consulta.CommandType = CommandType.StoredProcedure;
            foreach (KeyValuePair<string, object> Param in Parametros)
            {
                Consulta.Parameters.AddWithValue(Param.Key,Param.Value);
            }
            SqlDataReader Lector = Consulta.ExecuteReader();
            return Lector;
        }

        private bool HacerInsertODelete(String STRConsulta)
        {
            bool Devolver = false;
            con = Conectar();
            SqlCommand Consulta = con.CreateCommand();
            Consulta.CommandType = CommandType.Text;
            try
            {
                Consulta.CommandText = STRConsulta;
                Consulta.ExecuteNonQuery();
                Devolver = true;
            }
            catch (Exception)
            {
            }
            Desconectar(con);
            return Devolver;
        }

        public List<Models.TorneoSeguido> TraerTorneosPorNombre(String Nombre,int IDUsuario)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@Nombre", Nombre);
            P.Add("@IDUsuario", IDUsuario);
            SqlDataReader Lector = HacerStoredProcedured("TraerTorneosPorNombre", P);

            Models.TorneoSeguido UnTorneo;
            List<Models.TorneoSeguido> ListaTorneos = new List<Models.TorneoSeguido>();
            while (Lector.Read())
            {
                int idtorneo = Convert.ToInt32(Lector["IDTorneo"]);
                string nombretorneo = Lector["NombreTorneo"].ToString();
                string contraseniadeadministrador = Lector["ContraseniaDeAdministrador"].ToString();
                string linkparaunirse = Lector["LinkParaUnirse"].ToString();
                Boolean Siguiendo = Convert.ToBoolean(Lector["Siguiendo"]);
                UnTorneo = new Models.TorneoSeguido(idtorneo, nombretorneo, contraseniadeadministrador, linkparaunirse,Siguiendo);
                ListaTorneos.Add(UnTorneo);
            }
            Desconectar(con);
            return ListaTorneos;
        }

        public bool InsertarTorneos(List<int> ListaTorneos)
        {
            bool Devolver;
            String C = "insert into Torneos(IDTorneo,NombreTorneo,ContraseniaDeAdministrador,LinkParaUnirse) " +
                "values (" + ListaTorneos[0] + "," + ListaTorneos[1] + "," + ListaTorneos[2] + "," + ListaTorneos[3] + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public Models.Torneo TraerTorneoPorID(int ID)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", ID);
            SqlDataReader Lector = HacerStoredProcedured("TraerTorneoPorID", P);
            Models.Torneo UnTorneo = new Models.Torneo();
            if (Lector.Read())
            {
                int idtorneo = Convert.ToInt32(Lector["IDTorneo"]);
                string nombretorneo = Lector["NombreTorneo"].ToString();
                string contraseniadeadministrador = Lector["ContraseniaDeAdministrador"].ToString();
                string linkparaunirse = Lector["LinkParaUnirse"].ToString();
                UnTorneo = new Models.Torneo(idtorneo, nombretorneo, contraseniadeadministrador, linkparaunirse);
            }
            Desconectar(con);
            return UnTorneo;
        }

        public List<int> TraerJornadasPorTorneo(int IDTorneo)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", IDTorneo);
            SqlDataReader Lector = HacerStoredProcedured("TraerJornadasPorTorneo", P);
            List<int> ListaJornadas = new List<int>();
            int jornada;
            while (Lector.Read())
            {
                jornada = Convert.ToInt32(Lector["JornadaDelTorneo"]);
                ListaJornadas.Add(jornada);
            }
            Desconectar(con);
            return ListaJornadas;
        }

        public List<Models.Partido> TraerPartidosPorJornada(int IDJornada, int IDTorneo)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", IDTorneo);
            P.Add("@IDJornada", IDJornada);
            SqlDataReader Lector = HacerStoredProcedured("TraerPartidosPorJornada", P);

            List<Models.Partido> ListaPartidos = new List<Models.Partido>();
            Models.Partido UnPartido;
            while (Lector.Read())
            {
                int IDPartido = Convert.ToInt32(Lector["IDPartido"]);
                DateTime FechaDeEncuentro = Convert.ToDateTime(Lector["FechaDeEncuentro"]);
                String NombreEquipoLocal = Lector["NombreEquipoLocal"].ToString();
                String NombreEquipoVisitante = Lector["NombreEquipoVisitante"].ToString();
                int IDEquipoLocal = Convert.ToInt32(Lector["IDEquipo1"]);
                int IDEquipoVisitante = Convert.ToInt32(Lector["IDEquipo2"]);
                int GolesLocal = Convert.ToInt32(Lector["GolesLocal"]);
                int GolesVisitante = Convert.ToInt32(Lector["GolesVisitante"]);
                int IDtorneo = Convert.ToInt32(Lector["IDTorneo"]);
                int IDjornada = Convert.ToInt32(Lector["JornadaDelTorneo"]);
                UnPartido = new Models.Partido(IDPartido, FechaDeEncuentro, NombreEquipoLocal, NombreEquipoVisitante, GolesLocal, GolesVisitante, IDtorneo, IDjornada, IDEquipoLocal, IDEquipoVisitante);
                ListaPartidos.Add(UnPartido);
            }
            Desconectar(con);
            return ListaPartidos;
        }

        public bool InsertarPartidos(Models.Partido Partidos)
        {
            bool Devolver;
            String C = "insert into Partidos(IDPartido,FechaDeEncuentro,JornadaDelTorneo,NombreEquipoLocal," +
                "NombreEquipoVisitante,GolesLocal,GolesVisitante,IDTorneo) values ('" + Partidos.IDPartido 
                + "','" + Partidos.FechaDeEncuentro + "','" + Partidos.Jornada + "','" + Partidos.NombreEquipoLocal 
                + "','" + Partidos.NombreEquipoVisitante + "','" + Partidos.GolesLocal + "','" + Partidos.GolesVisitante 
                + "','" + Partidos.IDTorneo + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public List<Models.Equipo> TraerListaDePosiciones(int IDTorneo)
        {
            //String C = "SELECT * FROM Equipos where Equipos.IDTorneo = " + IDTorneo + " order by Puntos desc,GolesAFavor desc";
            con = Conectar();
            SqlCommand Consulta = new SqlCommand("dbo.TraerListaPosiciones", con);
            Consulta.CommandType = CommandType.StoredProcedure;
            Consulta.Parameters.AddWithValue("@IDTorneo", IDTorneo);
            SqlDataReader Lector = Consulta.ExecuteReader();

            List<Models.Equipo> ListaPosiciones = new List<Models.Equipo>();
            Models.Equipo UnEquipo;
            while (Lector.Read())
            {
                int IDEquipo = Convert.ToInt32(Lector["IDEquipo"]);
                String NobreEquipo = Lector["NombreEquipo"].ToString();
                int IDtorneo = Convert.ToInt32(Lector["IDTorneo"]);
                int Puntos = Convert.ToInt32(Lector["Puntos"]);
                int GolesAFavor = Convert.ToInt32(Lector["GolesAFavor"]);
                int GolesEnContra = Convert.ToInt32(Lector["GolesEnContra"]);
                int PartidosJugados = Convert.ToInt32(Lector["PartidosJugados"]);
                UnEquipo = new Models.Equipo(IDEquipo, NobreEquipo, PartidosJugados, Puntos, GolesAFavor, GolesEnContra, IDtorneo);
                ListaPosiciones.Add(UnEquipo);
            }
            Desconectar(con);
            return ListaPosiciones;
        }

        public bool InsertarEquipos(List<int> ListaEquipos)
        {
            bool Devolver;
            String C = "insert into Equipos(IDEquipo,Nombre,PartidosJugados,Puntos,GolesAFavor,GolesEnContra,IDTorneo) " +
                "values (" + ListaEquipos[0] + "," + ListaEquipos[1] + "," + ListaEquipos[2] 
                + "," + ListaEquipos[3] + "," + ListaEquipos[4] + "," + ListaEquipos[5] + "," + ListaEquipos[6] + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public void InsertarTorneoSeguidoPorUsuario(List<int> lista)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDUsuario", lista[0]);
            P.Add("@IDTorneo", lista[1]);
            P.Add("@IDEquipoFavorito", lista[2]);
            HacerStoredProcedured("InsertarTorneoSeguidoPorUsuario", P);
        }

        public void DeleteTorneoSeguidoPorUsuario(List<int> lista)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDUsuario", lista[0]);
            P.Add("@IDTorneo", lista[1]);
            HacerStoredProcedured("DeleteTorneoSeguidoPorUsuario", P);
        }

        public List<Models.Goleadores> TraerListaGoleadores(int IDTorneo) {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", IDTorneo);
            SqlDataReader Lector = HacerStoredProcedured("TraerListaGoleadores", P);

            List<Models.Goleadores> Tablagoleadores = new List<Models.Goleadores>();
            Models.Goleadores UnGoleador;
            while (Lector.Read())
            {
                int IDUsuario = Convert.ToInt32(Lector["IdUsuario"]);
                String NombreUsuario = Lector["NombreDeUsuario"].ToString();
                String NombreEquipo = Lector["NombreEquipo"].ToString();
                int Goles = Convert.ToInt32(Lector["GolesEnTorneo"]);

                UnGoleador = new Models.Goleadores(IDUsuario, NombreUsuario, NombreEquipo, Goles);
                Tablagoleadores.Add(UnGoleador);
            }
            Desconectar(con);
            return Tablagoleadores;
        }

        public List<Models.GolesXUsuario> TraerGolesXusuario(int IDPartido)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDPartido", IDPartido);
            SqlDataReader Lector = HacerStoredProcedured("TraerGolesXusuario", P);

            List<Models.GolesXUsuario> Goles = new List<Models.GolesXUsuario>();
            Models.GolesXUsuario Gol;
            while (Lector.Read())
            {
                int IDpartido = Convert.ToInt32(Lector["IDPartido"]);
                int IDUsuario = Convert.ToInt32(Lector["IDUsuario"]);
                String NombreUsuario = Lector["NombreDeUsuario"].ToString();
                int CantidadGoles = Convert.ToInt32(Lector["CantidadGoles"]);
                String NombreEquipo = Lector["NombreEquipo"].ToString();

                Gol = new Models.GolesXUsuario(IDpartido, IDUsuario, NombreUsuario, CantidadGoles, NombreEquipo);
                Goles.Add(Gol);
            }
            Desconectar(con);
            return Goles;
        }

        public Models.Equipo TraerEquipoPorIDEquipo(int IDEquipo)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDEquipo", IDEquipo);
            SqlDataReader Lector = HacerStoredProcedured("TraerEquipoPorIDEquipo", P);

            Models.Equipo ElEquipo = new Models.Equipo();
            if (Lector.Read())
            {
                int IDEquipos = Convert.ToInt32(Lector["IDEquipo"]);
                String NobreEquipo = Lector["NombreEquipo"].ToString();
                int PartidosJugados = Convert.ToInt32(Lector["PartidosJugados"]);
                int Puntos = Convert.ToInt32(Lector["Puntos"]);
                int GolesAFavor = Convert.ToInt32(Lector["GolesAFavor"]);
                int GolesEnContra = Convert.ToInt32(Lector["GolesEnContra"]);
                int IDTorneos = Convert.ToInt32(Lector["IDTorneo"]);

                ElEquipo = new Models.Equipo(IDEquipos, NobreEquipo, PartidosJugados, Puntos, GolesAFavor, GolesEnContra, IDTorneos);
            }
            Desconectar(con);
            return ElEquipo;
        }

        public Models.Usuario TraerUsuarioPorNombreContrasenia(string NombreDeUsuario, string Contrasenia)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@NombreUsuario", NombreDeUsuario);
            P.Add("@Contrasenia", Contrasenia);
            SqlDataReader Lector = HacerStoredProcedured("TraerUsuarioPorNombreContrasenia", P);

            Models.Usuario ElUsuario = new Models.Usuario();
            if (Lector.Read())
            {

                int IDUsuarios = Convert.ToInt32(Lector["IDUsuario"]);
                string NombreUsuario = Convert.ToString(Lector["NombreDeUsuario"]);
                string contrasenia = Convert.ToString(Lector["Contrasenia"]);
                DateTime FechaDeNacimiento = Convert.ToDateTime(Lector["FechaDeNacimiento"]);
                string Email = Convert.ToString(Lector["Email"]);
                int GolesEnTorneo = Convert.ToInt32(Lector["GolesEnTorneo"]);

                ElUsuario = new Models.Usuario(IDUsuarios, NombreUsuario, contrasenia, FechaDeNacimiento, Email, GolesEnTorneo);
            }
            Desconectar(con);
            return ElUsuario;
        }

        public bool InsertarUsuario(Models.Usuario Usuario)
        {
            bool Devolver;
            String C = "insert into Usuarios(NombreDeUsuario,Contrasenia,FechaDeNacimiento,Email,GolesEnTorneo) values " +
                "('"+Usuario.NombreUsuario + "','" + Usuario.Contrasenia + "','" + Usuario.FechaDeNacimiento.ToString("yyyy-MM-dd")
                + "','" + Usuario.Email + "'," + Usuario.GolesEnTorneo + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public Models.Usuario TraerUsuariosPorID(int IDUsuario)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDUsuario", IDUsuario);
            SqlDataReader Lector = HacerStoredProcedured("TraerUsuariosPorID", P);

            Models.Usuario UnUsuario = new Models.Usuario();
            while (Lector.Read())
            {
                int IDUsuarios = Convert.ToInt32(Lector["IdUsuario"]);
                string NombreUsuario = Convert.ToString(Lector["NombreDeUsuario"]);
                string Contrasenia = Convert.ToString(Lector["Contrasenia"]);
                DateTime FechaDeNacimiento = Convert.ToDateTime(Lector["FechaDeNacimiento"]);
                string Email = Convert.ToString(Lector["Email"]);
                int GolesEnTorneo = Convert.ToInt32(Lector["GolesEnTorneo"]);

                UnUsuario = new Models.Usuario(IDUsuarios, NombreUsuario, Contrasenia, FechaDeNacimiento, Email, GolesEnTorneo);
            }
            Desconectar(con);
            return UnUsuario;
        }

        public List<Models.Torneo> TraerTorneosSeguidosPorUsuario(int IDUsuario)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDUsuario", IDUsuario);
            SqlDataReader Lector = HacerStoredProcedured("TraerTorneosSeguidosPorUsuario", P);

            List<Models.Torneo> TorneosSeguidosPorUsuario = new List<Models.Torneo>();
            Models.Torneo UnTorneo;

            while (Lector.Read())
            {
                int IdTorneo = Convert.ToInt32(Lector["IDTorneo"]);
                string NombreTorneo = Convert.ToString(Lector["NombreTorneo"]);
                string ContraseniaDeAdministrador = Convert.ToString(Lector["ContraseniaDeAdministrador"]);
                string LinkParaUnirse = Convert.ToString(Lector["LinkParaUnirse"]);

                UnTorneo = new Models.Torneo(IdTorneo, NombreTorneo, ContraseniaDeAdministrador, LinkParaUnirse);
                TorneosSeguidosPorUsuario.Add(UnTorneo);
            }
            Desconectar(con);
            return TorneosSeguidosPorUsuario;
        }

        public List<Models.Torneo> TraerTorneosParticipadosPorUsuario(int IDUsuario)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDUsuario", IDUsuario);
            SqlDataReader Lector = HacerStoredProcedured("TraerTorneosParticipadosPorUsuario", P);

            List<Models.Torneo> TorneosSeguidosPorUsuario = new List<Models.Torneo>();
            Models.Torneo UnTorneo;

            while (Lector.Read())
            {
                int IdTorneo = Convert.ToInt32(Lector["IDTorneo"]);
                string NombreTorneo = Convert.ToString(Lector["NombreTorneo"]);
                string ContraseniaDeAdministrador = Convert.ToString(Lector["ContraseniaDeAdministrador"]);
                string LinkParaUnirse = Convert.ToString(Lector["LinkParaUnirse"]);

                UnTorneo = new Models.Torneo(IdTorneo, NombreTorneo, ContraseniaDeAdministrador, LinkParaUnirse);
                TorneosSeguidosPorUsuario.Add(UnTorneo);
            }
            Desconectar(con);
            return TorneosSeguidosPorUsuario;
        }

        public List<Models.Noticia> TraerNoticiasPorTorneo (int IDTorneo)  
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", IDTorneo);
            SqlDataReader Lector = HacerStoredProcedured("TraerNoticiasPorTorneo", P);

            Models.Noticia UnaNoticia;
            List<Models.Noticia> TraerNoticiasPorTorneo = new List<Models.Noticia>();
            while(Lector.Read())
            {
                int IDtorneo = Convert.ToInt32(Lector["IDTorneo"]);
                int IDnoticia = Convert.ToInt32(Lector["IDNoticia"]);
                string Titulo = Lector["Titulo"].ToString();
                string Descripcion = Lector["Descripcion"].ToString();
                bool Destacada = Convert.ToBoolean(Lector["Destacada"]);
                int Foto = Convert.ToInt32(Lector["IDFoto"]);
                DateTime Fecha = Convert.ToDateTime(Lector["Fecha"]);
                UnaNoticia = new Models.Noticia(IDnoticia, IDtorneo, Titulo, Descripcion, Destacada, Foto, Fecha);
                TraerNoticiasPorTorneo.Add(UnaNoticia);
            }
            Desconectar(con);

            return TraerNoticiasPorTorneo;
        }

        public bool InstertarNoticias(Models.Noticia Noticia)
        {
            bool Devolver;
            String C = "insert into Noticias (IDNoticia,Titulo,Descripcion,IDFoto,IDTorneo,Fecha,Destacada) values " +
                "('" + Noticia.IDTorneo + "','" + Noticia.IDNoticia + "','" + Noticia.Titulo + "','" + Noticia.Descripcion 
                + "','" + Noticia.Destacada + "','" + Noticia.Foto + "','" + Noticia.Fecha + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public List<Models.Usuario> TraerJugadoresXEquipos(int IDEquipo)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDEquipo", IDEquipo);
            SqlDataReader Lector = HacerStoredProcedured("TraerJugadoresXEquipos", P);

            List<Models.Usuario> ListaUsuarios = new List<Models.Usuario>();
            Models.Usuario UnUsuario;
            while (Lector.Read())
            {
                int IDUsuarios = Convert.ToInt32(Lector["IDUsuario"]);
                string NombreUsuario = Convert.ToString(Lector["NombreDeUsuario"]);
                string Contrasenia = Convert.ToString(Lector["Contrasenia"]);
                DateTime FechaDeNacimiento = Convert.ToDateTime(Lector["FechaDeNacimiento"]);
                string Email = Convert.ToString(Lector["Email"]);
                int GolesEnTorneo = Convert.ToInt32(Lector["GolesEnTorneo"]);

                UnUsuario = new Models.Usuario(IDUsuarios, NombreUsuario, Contrasenia, FechaDeNacimiento, Email, GolesEnTorneo);
                ListaUsuarios.Add(UnUsuario);
            }
            Desconectar(con);
            return ListaUsuarios;
        }

        public bool InstertarJugadoresXEquipos(List<int> lista)
        {
            bool Devolver;
            String C = "insert into TorneosParticipadosXUsuario (IDUsuario,IDEquipo) values (IDUsuario =  " + lista[0] + " and IDEquipo = " + lista[1] + ")";
            return Devolver = HacerInsertODelete(C);
        }

        public List<Models.Equipo> TraerEquiposPorTorneo(int IDTorneo)
        {
            Dictionary<String, Object> P = new Dictionary<string, object>();
            P.Add("@IDTorneo", IDTorneo);
            SqlDataReader Lector = HacerStoredProcedured("TraerEquiposPorTorneo", P);

            List<Models.Equipo> ListaEquipos = new List<Models.Equipo>();
            Models.Equipo UnEquipo;
            while (Lector.Read())
            {
                int IDEquipo = Convert.ToInt32(Lector["IDEquipo"]);
                string Nombre = Convert.ToString(Lector["NombreEquipo"]);
                int PartidosJugados = Convert.ToInt32(Lector["PartidosJugados"]);
                int Puntos = Convert.ToInt32(Lector["Puntos"]);
                int GolesAFavor = Convert.ToInt32(Lector["GolesAFavor"]);
                int GolesEnContra = Convert.ToInt32(Lector["GolesEnContra"]);
                int IDtorneo = Convert.ToInt32(Lector["IDTorneo"]);

                UnEquipo = new Models.Equipo(IDEquipo, Nombre, PartidosJugados, Puntos, GolesAFavor, GolesEnContra,IDtorneo);
                ListaEquipos.Add(UnEquipo);
            }
            Desconectar(con);
            return ListaEquipos;
        }
    }
}


