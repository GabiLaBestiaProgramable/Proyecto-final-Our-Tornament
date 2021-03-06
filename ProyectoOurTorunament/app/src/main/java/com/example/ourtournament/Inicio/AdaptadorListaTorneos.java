package com.example.ourtournament.Inicio;

import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.annotation.SuppressLint;
import android.content.Context;
import android.content.DialogInterface;
import android.content.res.ColorStateList;
import android.graphics.Color;
import android.net.Uri;
import android.os.AsyncTask;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.Button;
import android.widget.ListView;
import android.widget.TextView;

import androidx.appcompat.app.AlertDialog;

import com.example.ourtournament.Objetos.Equipo;
import com.example.ourtournament.Objetos.Torneo;
import com.example.ourtournament.Objetos.TorneoSeguido;
import com.example.ourtournament.R;
import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonParser;
import com.squareup.picasso.Picasso;

import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.Principal;
import java.util.ArrayList;
import java.util.Iterator;

import de.hdodenhof.circleimageview.CircleImageView;

public class AdaptadorListaTorneos extends ArrayAdapter<TorneoSeguido> {
    private ArrayList<TorneoSeguido> _ListaTorneos;
    private ArrayList<Boolean> _ListaAbiertos;
    private Context _Contexto;
    private int _Resource;
    private int _IDTorneo;
    private ListView Lista;
    private int IDUsuario;

    public AdaptadorListaTorneos(Context contexto, int Resource, ArrayList<TorneoSeguido> ListaTorneos, int IDTorneo, int Idusuario) {
        super(contexto, Resource, ListaTorneos);
        this._ListaTorneos = ListaTorneos;
        this._Contexto = contexto;
        this._Resource = Resource;
        this._IDTorneo = IDTorneo;
        this.IDUsuario = Idusuario;
        LLenarListaBoleans(ListaTorneos.size());
    }

    public void LLenarListaBoleans(int Cantidad)
    {
        _ListaAbiertos = new ArrayList<>();
        for (int i=0;i<Cantidad;i++)
        {
            _ListaAbiertos.add(false);
        }
    }

    @SuppressLint("ViewHolder")
    public View getView(final int pos, View VistaADevolver, ViewGroup GrupoActual) {
        LayoutInflater MiInflador;
        if (VistaADevolver == null) {
            MiInflador = LayoutInflater.from(this._Contexto);
            VistaADevolver = MiInflador.inflate(_Resource, null);
        }

        final ListView lista;
        final Button Seguir,VerEquipos;
        final CircleImageView FotoPerfil;
        TextView NombreTorneo;

        FotoPerfil = VistaADevolver.findViewById(R.id.PerfilTorneo);
        NombreTorneo = VistaADevolver.findViewById(R.id.Torneo);
        VerEquipos = VistaADevolver.findViewById(R.id.VerEquipos);

        Seguir = VistaADevolver.findViewById(R.id.BTNSeguir);
        lista = VistaADevolver.findViewById(R.id.list);
        final TorneoSeguido T = getItem(pos);

        if (T.Siguiendo) {
            Seguir.setBackgroundTintList(ColorStateList.valueOf(Color.rgb(33, 36, 35)));
            Seguir.setText("Siguiendo");
            Seguir.setTextColor(Color.rgb(60, 188, 128));
        } else {
            Seguir.setBackgroundTintList(ColorStateList.valueOf(Color.rgb(60, 188, 128)));
            Seguir.setText("seguir");
            Seguir.setTextColor(Color.rgb(0, 0, 0));
        }

        String Ruta = "http://10.0.2.2:55859/Imagenes/Torneos/ID" + T.IDTorneo + "_Perfil.JPG";
        Picasso.get().load(Ruta)
                .into(FotoPerfil, new com.squareup.picasso.Callback() {
                    @Override
                    public void onSuccess() {
                    }

                    @Override
                    public void onError(Exception e) {
                        FotoPerfil.setImageResource(R.drawable.icono_torneo);
                    }

                });
        NombreTorneo.setText(T.NombreTorneo);

        if (!_ListaAbiertos.get(pos)) {
            Animacion(VerEquipos, "rotation", 0, 0, 0);
            lista.setVisibility(View.GONE);
        } else {
            Animacion(VerEquipos, "rotation", 0, -180, 0);
            Lista = lista;
            _IDTorneo = T.IDTorneo;
            TraerEquipos Tarea = new TraerEquipos();
            Tarea.execute();
        }

        VerEquipos.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                if (!_ListaAbiertos.get(pos))
                {
                    for (int i=0;i<_ListaAbiertos.size();i++)
                    {
                        _ListaAbiertos.set(i,false);
                    }
                    _ListaAbiertos.set(pos,true);
                }else
                {
                    _ListaAbiertos.set(pos,false);
                }
                notifyDataSetChanged();
            }
        });
        Seguir.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                if (!T.Siguiendo) {
                    InsertarTorneoSeguido Tarea = new InsertarTorneoSeguido();
                    Tarea.execute(IDUsuario, T.IDTorneo, -1);
                    Seguir.setBackgroundTintList(ColorStateList.valueOf(Color.rgb(33, 36, 35)));
                    Seguir.setText("Siguiendo");
                    Seguir.setTextColor(Color.rgb(60, 188, 128));
                    T.Siguiendo = true;
                } else{
                    EliminarTorneoSeguido Tarea = new EliminarTorneoSeguido();
                    Tarea.execute(IDUsuario,T.IDTorneo);
                    Seguir.setBackgroundTintList(ColorStateList.valueOf(Color.rgb(60, 188, 128)));
                    Seguir.setText("seguir");
                    Seguir.setTextColor(Color.rgb(0, 0, 0));
                    T.Siguiendo = false;
                    /*
                    AlertDialog.Builder Alerta = new AlertDialog.Builder(getContext());
                    Alerta.setPositiveButton("Aceptar",Aceptar);
                    Alerta.setNegativeButton("Cancelar",null);
                    Alerta.setTitle("Dejar de seguir");
                    Alerta.setMessage("Deseas dejar de seguir al torneo "+T.NombreTorneo);
                    Alerta.create();
                    Alerta.show();
                     */
                }
            }
        });

        return VistaADevolver;
    }

    DialogInterface.OnClickListener Aceptar = new DialogInterface.OnClickListener() {
        @Override
        public void onClick(DialogInterface dialogInterface, int i) {
            /*
            EliminarTorneoSeguido Tarea = new EliminarTorneoSeguido();
            Tarea.execute(IDUsuario,T.IDTorneo);
            Seguir.setBackgroundTintList(ColorStateList.valueOf(Color.rgb(60, 188, 128)));
            Seguir.setText("seguir");
            Seguir.setTextColor(Color.rgb(0, 0, 0));
            T.Siguiendo = false;
             */
        }
    };
    public void Animacion(TextView objeto, String Nombre, int value, int value2, int Duracion) {
        ObjectAnimator Animacion = ObjectAnimator.ofFloat(objeto, Nombre, value, value2);
        Animacion.setDuration(Duracion);
        AnimatorSet SetDeAnimacion = new AnimatorSet();
        SetDeAnimacion.play(Animacion);
        SetDeAnimacion.start();
    }

    private class TraerEquipos extends AsyncTask<Void, Void, ArrayList<Equipo>> {
        @Override
        protected ArrayList<Equipo> doInBackground(Void... voids) {
            ArrayList<Equipo> listaEquipos = new ArrayList<>();
            try {
                String miURL = "http://10.0.2.2:55859/api/GetPosiciones/Torneo/" + _IDTorneo;
                Log.d("conexion", "estoy accediendo a la ruta " + miURL);
                URL miRuta = new URL(miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setRequestMethod("GET");
                if (miConexion.getResponseCode() == 200) {
                    Log.d("conexion", "me pude conectar perfectamente");
                    InputStream lector = miConexion.getInputStream();
                    InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                    JsonParser parseador = new JsonParser();
                    JsonArray VecEquipos = parseador.parse(lectorJSon).getAsJsonArray();
                    for (int i = 0; i < VecEquipos.size(); i++) {
                        JsonElement Elemento = VecEquipos.get(i);
                        Gson gson = new Gson();
                        Equipo E = gson.fromJson(Elemento, Equipo.class);
                        listaEquipos.add(E);
                    }
                } else {
                    Log.d("Conexion", "Me pude conectar pero algo malo pasó");
                }
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {
                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return listaEquipos;
        }

        protected void onPostExecute(ArrayList<Equipo> listaE) {
            Context contexto = getContext();
            AdaptadorListaEquiposPorTorneo Adaptador = new AdaptadorListaEquiposPorTorneo(contexto, R.layout.item_equipos_por_torneo, listaE);
            Lista.setAdapter(Adaptador);
            int Cantidad = listaE.size();
            if (Cantidad > 6)
            {
                Cantidad = 6;
            }
            Lista.getLayoutParams().height = 128 * Cantidad;
            Lista.setVisibility(View.VISIBLE);
        }
    }

    private class InsertarTorneoSeguido extends AsyncTask<Integer, Void, Boolean> {
        Boolean Resultado;
        @Override
        protected Boolean doInBackground(Integer... IDS) {
            try {
                String miURL = "http://10.0.2.2:55859/api/InsertTorneosSeguidos";
                Log.d("conexion", "estoy accediendo a la ruta " + miURL);
                URL miRuta = new URL(miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setDoInput(true);
                miConexion.setDoOutput(true);
                miConexion.setRequestProperty("Content-Type", "application/json");
                miConexion.setRequestProperty("Accept", "application/json");
                miConexion.setRequestMethod("POST");

                Log.d("conexion","Estoy insertando IDUsuario: "+IDS[0]+" y IDTorneo: "+IDS[1]);
                Gson gson = new Gson();
                String json = gson.toJson(IDS);
                OutputStream OS = miConexion.getOutputStream();
                OS.write(json.getBytes());
                OS.flush();

                int ResponseCode = miConexion.getResponseCode();
                Log.d("conexion", String.valueOf(ResponseCode));
                /*
                switch (ResponseCode)
                {
                    case 200:
                        Context C = getContext();
                        Toast T = Toast.makeText(C,"Seguimos el torneo con exito!", Toast.LENGTH_SHORT);
                        T.show();
                        break;
                    case 400:
                        Context Co = getContext();
                        Toast To = Toast.makeText(Co,"Bad request", Toast.LENGTH_SHORT);
                        To.show();
                        break;
                    case 404:
                        Context Con = getContext();
                        Toast Toa = Toast.makeText(Con,"Not Found", Toast.LENGTH_SHORT);
                        Toa.show();
                        break;
                }
                 */
                InputStream lector = miConexion.getInputStream();
                InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                JsonParser parseador = new JsonParser();
                Resultado = parseador.parse(lectorJSon).getAsBoolean();
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {
                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return Resultado;
        }

        protected void onPostExecute(Boolean R) {
            Log.d("conexion", String.valueOf(R));
        }
    }

    private class EliminarTorneoSeguido extends AsyncTask<Integer, Void, Boolean> {
        Boolean Resultado;
        @Override
        protected Boolean doInBackground(Integer... IDS) {
            try {
                String miURL = "http://10.0.2.2:55859/api/DeleteTorneosSeguidos";
                Log.d("conexion", "estoy accediendo a la ruta " + miURL);
                URL miRuta = new URL(miURL);
                HttpURLConnection miConexion = (HttpURLConnection) miRuta.openConnection();
                miConexion.setDoInput(true);
                miConexion.setDoOutput(true);
                miConexion.setRequestProperty("Content-Type", "application/json");
                miConexion.setRequestProperty("Accept", "application/json");
                miConexion.setRequestMethod("DELETE");

                Gson gson = new Gson();
                String json = gson.toJson(IDS);
                OutputStream OS = miConexion.getOutputStream();
                OS.write(json.getBytes());
                OS.flush();

                int ResponseCode = miConexion.getResponseCode();
                Log.d("conexion", String.valueOf(ResponseCode));

                InputStream lector = miConexion.getInputStream();
                InputStreamReader lectorJSon = new InputStreamReader(lector, "utf-8");
                JsonParser parseador = new JsonParser();
                Resultado = parseador.parse(lectorJSon).getAsBoolean();
                miConexion.disconnect();
            } catch (Exception ErrorOcurrido) {
                Log.d("Conexion", "Al conectar o procesar ocurrió Error: " + ErrorOcurrido.getMessage());
            }
            return Resultado;
        }

        protected void onPostExecute(Boolean R) {
            Log.d("conexion", String.valueOf(R));
        }
    }
}
