package com.example.ourtournament.Administracion;

import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.Toast;

import androidx.annotation.Nullable;

import com.example.ourtournament.MainActivity;
import com.example.ourtournament.Objetos.Goleadores;
import com.example.ourtournament.R;
import com.example.ourtournament.TablaGoleadores.AdaptadorListaGoleadores;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;

public class Administracion extends Fragment {
    FragmentManager AdminFragments;
    Button btn_Perfil, btn_Config;
    View VistaADevolver = null;
    private FragmentTransaction TransaccionesDeFragment;
    ArrayList<String> TorneosSeguidos = new ArrayList<String>();
    ArrayAdapter<String> adapter;
    ListView ListaDeAdministracion;

    @Override
    public View onCreateView(LayoutInflater inflador, @Nullable ViewGroup GrupoDeLaVista, Bundle savedInstanceState) {
        if (VistaADevolver == null) {
            VistaADevolver = inflador.inflate(R.layout.admin_principal, GrupoDeLaVista, false);
            AdminFragments = getFragmentManager();

            Referencias();
            SetearListeners();
            HardcodearLista();
        }
        return VistaADevolver;
    }

    /*private class TraerTorneosSeguidos extends AsyncTask<Integer,Void,ArrayList<Goleadores>> {
        @Override
        protected ArrayList<Goleadores> doInBackground(Integer... voids) {
            ArrayList<Goleadores> VecGoleadores = new ArrayList<>();
            try {
                String miURL = "http://10.0.2.2:55859/api/GetGoleadores/Torneo/1";
                URL miRuta = new URL(miURL);
                Log.d("conexion","estoy accediendo a la ruta: "+miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setRequestMethod("GET");
                if (miConexion.getResponseCode() == 200) {
                    Log.d("conexion","Me conecte perfectamente");
                    InputStream lector = miConexion.getInputStream();
                    InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                    JsonParser parseador = new JsonParser();
                    JsonArray VecGol = parseador.parse(lectorJSon).getAsJsonArray();

                    for (int i = 0; i < VecGol.size(); i++) {
                        JsonElement Elemento = VecGol.get(i);
                        Gson gson = new Gson();
                        Goleadores G = gson.fromJson(Elemento, Goleadores.class);
                        Log.d("conexion",String.valueOf(G.Goles1));
                        VecGoleadores.add(G);
                    }
                } else {
                    Log.d("Conexion", "Me pude conectar pero algo malo pasó");
                }
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {
                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return VecGoleadores;
        }
        protected void onPostExecute(ArrayList<Goleadores> VecGoleadores)
        {
            final MainActivity Principal = (MainActivity) getActivity();
            AdaptadorListaGoleadores Adapter = new AdaptadorListaGoleadores(Principal,R.layout.item_tabla_goleadores,VecGoleadores);
            ListaDeAdministracion.setAdapter(Adapter);
            //Carga.setVisibility(View.GONE);
        }
    }*/

    private void SetearListeners() {
        btn_Perfil.setOnClickListener(clickP);
        btn_Config.setOnClickListener(clickF);
    }

    private void Referencias() {
        ListaDeAdministracion = VistaADevolver.findViewById(R.id.ListaDeAdministracion);
        btn_Perfil = VistaADevolver.findViewById(R.id.btn_Perfil);
        btn_Config = VistaADevolver.findViewById(R.id.btn_Config);
    }

    private View.OnClickListener clickP = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            Perfil perf = new Perfil();
            IrAFragment(perf);
        }
    };

    private View.OnClickListener clickF = new View.OnClickListener() {
        @Override
        public void onClick(View v) {
            Configuracion conf = new Configuracion();
            IrAFragment(conf);
        }
    };

    public void IrAFragment(Fragment fragment){
        TransaccionesDeFragment=AdminFragments.beginTransaction();
        TransaccionesDeFragment.replace(R.id.Frame,fragment);
        TransaccionesDeFragment.commit();
        TransaccionesDeFragment.addToBackStack(null);
    }

    private void HardcodearLista() {
        TorneosSeguidos.add("Liga BBVA");
        TorneosSeguidos.add("Premier");
        TorneosSeguidos.add("Superliga");
        TorneosSeguidos.add("Ligue One");
        TorneosSeguidos.add("Liga MMX");
        TorneosSeguidos.add("Torneo Clausura");
        TorneosSeguidos.add("Torneo Apartura");

        adapter = new ArrayAdapter<String>(getContext(), android.R.layout.simple_list_item_1, TorneosSeguidos);
        ListaDeAdministracion.setAdapter(adapter);
    }
}
