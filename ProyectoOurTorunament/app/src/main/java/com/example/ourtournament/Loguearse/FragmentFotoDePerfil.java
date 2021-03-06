package com.example.ourtournament.Loguearse;

import android.Manifest;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.ContentResolver;
import android.content.Context;
import android.content.Intent;
import android.content.SharedPreferences;
import android.content.pm.PackageManager;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.example.ourtournament.MainActivity;
import com.example.ourtournament.Objetos.Preferencias;
import com.example.ourtournament.R;

import java.io.IOException;

import de.hdodenhof.circleimageview.CircleImageView;

public class FragmentFotoDePerfil extends Fragment{
    FragmentManager AdminFragments;
    Button Agregar,Quitar;
    CircleImageView Foto;
    Bitmap Imagen = null;
    int RequestCode,CodeElegirFoto = 23;
    @Override
    public View onCreateView(LayoutInflater inflador, @Nullable ViewGroup GrupoDeLaVista, Bundle savedInstanceState) {
        View VistaADevolver;
        VistaADevolver = inflador.inflate(R.layout.armar_foto_perfil, GrupoDeLaVista, false);
        AdminFragments=getFragmentManager();
        Quitar = VistaADevolver.findViewById(R.id.Quitar);
        Agregar = VistaADevolver.findViewById(R.id.Agregar);
        Foto = VistaADevolver.findViewById(R.id.Foto);


        Agregar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                MainActivity Principal = (MainActivity) getActivity();
                if (ContextCompat.checkSelfPermission(Principal,Manifest.permission.WRITE_EXTERNAL_STORAGE) != PackageManager.PERMISSION_GRANTED)
                {
                    ActivityCompat.requestPermissions(Principal,new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},RequestCode);
                }else {
                    Log.d("conexion","entre a buscar la foto");
                    Intent ObtenerFoto = new Intent(Intent.ACTION_GET_CONTENT);
                    ObtenerFoto.setType("image/*");
                    startActivityForResult(Intent.createChooser(ObtenerFoto,"Seleccione una foto"),CodeElegirFoto);
                }
            }
        });
        Quitar.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                MainActivity Principal = (MainActivity) getActivity();
                Bitmap icon = BitmapFactory.decodeResource(Principal.getResources(), R.drawable.icono_persona);
                Foto.setImageBitmap(icon);
            }
        });
        return VistaADevolver;
    }

    public void onActivityResult(int RequestCode, int ResultCode, @NonNull Intent DatosRecibidos) {
        super.onActivityResult(RequestCode, ResultCode, DatosRecibidos);

        if(RequestCode == CodeElegirFoto && ResultCode == -1)
        {
            String Ubicacion = String.valueOf(DatosRecibidos.getData());
            ContentResolver resolver = getActivity().getContentResolver();
            try {
                Imagen = MediaStore.Images.Media.getBitmap(resolver, Uri.parse(Ubicacion));
            } catch (Exception e) {
                Log.d("conexion","Ocurrio un error: "+e);
            }
            Foto.setImageBitmap(Imagen);
        }
    }
}


