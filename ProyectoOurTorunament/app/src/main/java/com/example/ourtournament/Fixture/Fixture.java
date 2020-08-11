package com.example.ourtournament.Fixture;

import androidx.annotation.Nullable;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import com.example.ourtournament.MainActivity;
import com.example.ourtournament.Objetos.Preferencias;
import com.example.ourtournament.R;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;
import java.util.ArrayList;

public class Fixture extends Fragment {
    FragmentManager AdminFragments;
    FragmentTransaction TransaccionesDeFragment;
    int ID;
    private Spinner spinner;
    @Override
    public View onCreateView(LayoutInflater inflador, @Nullable ViewGroup GrupoDeLaVista, Bundle savedInstanceState) {

        View VistaADevolver;
        VistaADevolver = inflador.inflate(R.layout.fixture, GrupoDeLaVista, false);
        spinner = VistaADevolver.findViewById(R.id.Jornadas);
        AdminFragments=getFragmentManager();

        final MainActivity Principal = (MainActivity) getActivity();
        Preferencias P = Principal.CargarSharedPreferences();
        ID = P.ObtenerInt("IDTorneo",-1);

        if(ID!=-1)
        {
            TraerJornadas Tarea = new TraerJornadas();
            Tarea.execute(ID);
        }
        return VistaADevolver;
    }

    public void MostrarListaPartidos()
    {
        FragmentoParaListaPartidos lista = new FragmentoParaListaPartidos();
        TransaccionesDeFragment=AdminFragments.beginTransaction();
        TransaccionesDeFragment.replace(R.id.FragmentoListaPartidos, lista);
        TransaccionesDeFragment.commit();
        TransaccionesDeFragment.addToBackStack(null);
    }


    private class TraerJornadas extends AsyncTask<Integer,Void,ArrayList<String>>
    {
        @Override
        protected ArrayList<String> doInBackground(Integer... voids) {
            ArrayList<String> listaJornada= new ArrayList<>();
            try {
                Log.d("conexion", "estoy accediendo al torneo "+ID);
                String miURL = "http://10.0.2.2:55859/api/GetJornadas/Torneo/" + ID;
                Log.d("conexion", "estoy accediendo a la ruta "+miURL);
                URL miRuta = new URL(miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setRequestMethod("GET");
                Log.d("conexion", "la conexion me devolvio: "+ miConexion.getResponseCode());
                if (miConexion.getResponseCode() == 200) {
                    Log.d("conexion", "me pude conectar perfectamente");
                    InputStream lector = miConexion.getInputStream();
                    InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                    JsonParser parseador = new JsonParser();
                    JsonArray VecJornadas = parseador.parse(lectorJSon).getAsJsonArray();
                    for (int i = 0; i < VecJornadas.size(); i++)
                    {
                        int Jornada = VecJornadas.get(i).getAsInt();
                        Log.d("conexion", "Traje jornada "+Jornada);
                        listaJornada.add("jornada "+Jornada);
                    }
                } else {
                    Log.d("Conexion", "Me pude conectar pero algo malo pasó");
                }
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {

                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return listaJornada;
        }
        protected void onPostExecute(ArrayList<String> lista)
        {
            final MainActivity Principal = (MainActivity) getActivity();
            Principal.SetListaJornadas(lista);
            Principal.SetJornadaElegida(lista.size()-1);
            ArrayAdapter<String> adapter = new ArrayAdapter<>(getActivity().getApplicationContext(),android.R.layout.select_dialog_singlechoice,lista);
            spinner.setAdapter(adapter);
            spinner.setSelection(lista.size()-1);
            spinner.setOnItemSelectedListener(new AdapterView.OnItemSelectedListener() {

                public void onItemSelected(AdapterView<?> adapterView, View view, int i, long l) {
                    if(i!=0)
                    {
                        Principal.SetJornadaElegida(i);
                        MostrarListaPartidos();
                    }

                }
                public void onNothingSelected(AdapterView<?> parent) {

                }
            });
        }
    }




}
