package com.example.ourtournament.Fixture;

import android.annotation.SuppressLint;
import android.content.Context;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.ourtournament.Objetos.GolesXUsuario;
import com.example.ourtournament.Objetos.Partido;
import com.example.ourtournament.R;
import com.squareup.picasso.Picasso;

import java.util.ArrayList;

import de.hdodenhof.circleimageview.CircleImageView;

public class AdaptadorGolesXPartido extends ArrayAdapter<GolesXUsuario>
{
    private ArrayList<GolesXUsuario> _ListaGoles;
    private Context _Contexto;
    private int _Resource;

    public AdaptadorGolesXPartido(ArrayList<GolesXUsuario> ListaGoles,int Resource, Context contexto)
    {

        super(contexto,Resource,ListaGoles);
        this._ListaGoles = ListaGoles;
        this._Contexto = contexto;
        this._Resource = Resource;
    }

    public GolesXUsuario getItem(int pos)
    {
        return _ListaGoles.get(pos);
    }

    @SuppressLint({"ViewHolder", "SetTextI18n"})
    public View getView(int pos, View VistaADevolver, ViewGroup GrupoActual)
    {
        LayoutInflater MiInflador;
        if(VistaADevolver == null)
        {
            MiInflador = LayoutInflater.from(this._Contexto);
            VistaADevolver = MiInflador.inflate(_Resource,null);
        }

        final CircleImageView Foto;
        TextView Nombre,Goles;

        Foto=VistaADevolver.findViewById(R.id.Foto);
        Nombre=VistaADevolver.findViewById(R.id.Nombre);
        Goles=VistaADevolver.findViewById(R.id.Goles);

        GolesXUsuario GU = getItem(pos);

        if (GU.IdUsuario != -1)
        {
            Nombre.setText(GU.NombreUsuario);
            String Palabra = " Goles";
            if (GU.Cantgoles ==1)
            {
                Palabra = " Gol";
            }
            Goles.setText(GU.Cantgoles+Palabra);
            String Ruta = "http://10.0.2.2:55859/Imagenes/Usuarios/ID"+ GU.IdUsuario+"_Perfil.JPG";
            Picasso.get().load(Ruta)
                    .into(Foto, new com.squareup.picasso.Callback() {
                        @Override
                        public void onSuccess() {
                        }

                        @Override
                        public void onError(Exception e) {
                            Foto.setImageResource(R.drawable.icono_persona);
                        }

                    });

        }else
        {
            Nombre.setText(GU.NombreUsuario);
            Foto.setVisibility(View.GONE);
            Goles.setVisibility(View.GONE);
            Nombre.setGravity(View.TEXT_ALIGNMENT_CENTER);
        }


        return VistaADevolver;
    }
}
