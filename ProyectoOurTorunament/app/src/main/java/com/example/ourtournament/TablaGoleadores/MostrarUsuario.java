package com.example.ourtournament.TablaGoleadores;


import android.app.Fragment;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;
import androidx.annotation.Nullable;

import com.example.ourtournament.MainActivity;
import com.example.ourtournament.Objetos.Goleadores;
import com.example.ourtournament.Objetos.Preferencias;
import com.example.ourtournament.Objetos.Usuario;
import com.example.ourtournament.R;
import com.example.ourtournament.TablaPosiciones.TablaPosiciones;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.temporal.ChronoUnit;
import java.util.Date;

public class MostrarUsuario extends Fragment {
    TextView Nombre,Edad, Email, Equipo, Contrasenia,TXT4;
    Button Volver;
    ListView lista;
    MainActivity Principal;
    Preferencias P;
    Goleadores G;
    @Override
    public View onCreateView(LayoutInflater inflador, @Nullable ViewGroup GrupoDeLaVista, Bundle savedInstanceState) {
        final View VistaADevolver;
        VistaADevolver = inflador.inflate(R.layout.un_usuario, GrupoDeLaVista, false);

        TXT4 = VistaADevolver.findViewById(R.id.TXT4);
        Nombre = VistaADevolver.findViewById(R.id.Nombre);
        Edad = VistaADevolver.findViewById(R.id.Edad);
        Email = VistaADevolver.findViewById(R.id.Email);
        Equipo = VistaADevolver.findViewById(R.id.Equipo);
        Contrasenia = VistaADevolver.findViewById(R.id.Contrasenia);
        Volver =  VistaADevolver.findViewById(R.id.Volver);
        Principal = (MainActivity) getActivity();
        P = Principal.CargarSharedPreferences();

        String JSON = P.ObtenerString("ListaGoleadores","...");
        int GoleadorElegido = P.ObtenerInt("GoleadorElegido",-1);

        if (!JSON.equals("..."))
        {
            try {
                JsonParser parseador = new JsonParser();
                JsonArray VecGoleadores = parseador.parse(JSON).getAsJsonArray();
                JsonElement Elemento = VecGoleadores.get(GoleadorElegido);
                Gson gson = new Gson();
                G = gson.fromJson(Elemento, Goleadores.class);

            } catch (Exception e) {
                Log.d("conexion","Hubo un error:"+e);
            }

        }

        TraerUsuario Tarea = new TraerUsuario();
        Tarea.execute();
        Nombre.setText(G.NombreUsuario1);
        Contrasenia.setVisibility(View.GONE);
        TXT4.setVisibility(View.GONE);

        Volver.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                MainActivity Principal = (MainActivity) getActivity();
                TablaDeGoleadores TG = new TablaDeGoleadores();
                Principal.IrAFragment(TG);
            }
        });
        return VistaADevolver;
    }

    private class TraerUsuario extends AsyncTask<Void,Void,Usuario> {
        Usuario U;
        @Override
        protected Usuario doInBackground(Void... voids) {
            try {
                String miURL = "http://10.0.2.2:55859/api/GetUsuario/Usuario/"+G.IDUsuario1;
                Log.d("conexion", "estoy accediendo a la ruta " + miURL);
                URL miRuta = new URL(miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setRequestMethod("GET");
                if (miConexion.getResponseCode() == 200) {
                    Log.d("conexion", "me pude conectar perfectamente");
                    InputStream lector = miConexion.getInputStream();
                    InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                    JsonParser parseador = new JsonParser();
                    JsonObject Us = parseador.parse(lectorJSon).getAsJsonObject();
                    Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ss").create();
                    U = gson.fromJson(Us, Usuario.class);
                    Log.d("conexion","Traje al usuario: "+U.NombreUsuario);
                } else {
                    Log.d("Conexion", "Me pude conectar pero algo malo pasó");
                }
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {

                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return U;
        }
        protected void onPostExecute(Usuario U)
        {
            /*
            Date hoy = new Date();
            long edad = ChronoUnit.YEARS.between(U.FechaDeNacimiento, hoy);
            Edad.setText(String.valueOf(U.E))
            ;
             */
            Email.setText(String.valueOf(U.Email));
        }
    }


}
