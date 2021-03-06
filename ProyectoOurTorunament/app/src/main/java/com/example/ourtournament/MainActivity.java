package com.example.ourtournament;

import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;
import androidx.lifecycle.ViewModelProvider;

import android.Manifest;
import android.animation.AnimatorSet;
import android.animation.ObjectAnimator;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.content.Context;
import android.content.SharedPreferences;
import android.content.res.AssetManager;
import android.graphics.Bitmap;
import android.graphics.Typeface;
import android.net.Uri;
import android.os.Bundle;
import android.provider.MediaStore;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;

import com.example.ourtournament.Administracion.Administracion;
import com.example.ourtournament.Fixture.Fixture;
import com.example.ourtournament.Fixture.MostrarPartido;
import com.example.ourtournament.Inicio.Inicio;
import com.example.ourtournament.Loguearse.Loguear;
import com.example.ourtournament.Objetos.Equipo;
import com.example.ourtournament.Objetos.Noticia;
import com.example.ourtournament.Objetos.Preferencias;
import com.example.ourtournament.TablaGoleadores.TablaDeGoleadores;
import com.example.ourtournament.TablaPosiciones.TablaPosiciones;

import java.sql.Date;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Timer;
import java.util.TimerTask;

public class MainActivity<task> extends AppCompatActivity {
    FragmentManager AdminFragments=getFragmentManager();
    FragmentTransaction TransaccionesDeFragment;
    Preferencias P;
    int IDUsuario;

    Button BTNFixture;
    Button BTNTablaDePosiciones;
    Button BTNInicio;
    Button BTNTablaDeGoleadores;
    Button BTNAdministracion;

    Fixture fixture = new Fixture();
    TablaDeGoleadores tablaDeGoleadores = new TablaDeGoleadores();
    Inicio inicio = new Inicio();
    TablaPosiciones tabladeposiciones = new TablaPosiciones();
    Administracion admin = new Administracion();

    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        P = CargarSharedPreferences();
        //P.EliminarInt("IDUsuario");
        IDUsuario = P.ObtenerInt("IDUsuario",-1);

        if(IDUsuario==-1)
        {
            Loguear logueo = new Loguear();
            IrAFragmentDePantallaVacia(logueo);
        }else
        {
            CargarGeneral();
        }

    }
    public Preferencias CargarSharedPreferences()
    {
        SharedPreferences aux = getSharedPreferences("DatosGenerales",MODE_PRIVATE);
        SharedPreferences.Editor editor = null;
        Preferencias P = new Preferencias(aux,editor);
        return P;
    }
    //  GENERAL
    public void CargarGeneral()
    {
        setContentView(R.layout.activity_main);
        BTNFixture = findViewById(R.id.Fixture);
        BTNTablaDePosiciones = findViewById(R.id.TablaDePosiciones);
        BTNInicio = findViewById(R.id.Inicio);
        BTNTablaDeGoleadores = findViewById(R.id.TablaDeGoleadores);
        BTNAdministracion = findViewById(R.id.Administracion);
        IrAInicio(null);
    }

    //Navegacion
    public void IrAFixture(View vista)
    {
        CambiarColor();
        BTNFixture.setBackgroundResource(R.drawable.icono_fixture_verde);

        IrAFragment(fixture,false);
    }

    public void IrATablaGoleadores(View vista)
    {
        CambiarColor();
        BTNTablaDeGoleadores.setBackgroundResource(R.drawable.icono_tabla_goleadores_verde);

        IrAFragment(tablaDeGoleadores,false);
    }

    public void IrAInicio(View vista) {
        CambiarColor();
        BTNInicio.setBackgroundResource(R.drawable.icono_inicio_verde);

        IrAFragment(inicio,false);
    }

    public void IrATablaPosiciones(View vista) {
        CambiarColor();
        BTNTablaDePosiciones.setBackgroundResource(R.drawable.icono_tabla_posiciones_verde);

        IrAFragment(tabladeposiciones,false);
    }

    public void IrAAdministracion(View vista) {
        CambiarColor();
        BTNAdministracion.setBackgroundResource(R.drawable.icono_admin_verde);

        IrAFragment(admin,false);
    }

    //Inicio

    public void CambiarColor()
    {
        BTNFixture.setBackgroundResource(R.drawable.icono_fixture);
        BTNTablaDeGoleadores.setBackgroundResource(R.drawable.icono_tabla_goleadores);
        BTNInicio.setBackgroundResource(R.drawable.icono_inicio);
        BTNTablaDePosiciones.setBackgroundResource(R.drawable.icono_tabla_posiciones);
        BTNAdministracion.setBackgroundResource(R.drawable.icono_admin);
    }

    public void IrAFragment(Fragment fragment,Boolean B){
        TransaccionesDeFragment=AdminFragments.beginTransaction();
        TransaccionesDeFragment.replace(R.id.Frame,fragment);
        TransaccionesDeFragment.commit();
        if (B)
        {
            TransaccionesDeFragment.addToBackStack(null);
        }
    }
    public void IrAFragmentDePantallaVacia(Fragment fragment){
        setContentView(R.layout.pantalla_vacia_con_fragment);
        TransaccionesDeFragment=AdminFragments.beginTransaction();
        TransaccionesDeFragment.replace(R.id.fragmentodepantallacompleta,fragment);
        TransaccionesDeFragment.commit();
        TransaccionesDeFragment.addToBackStack(null);
    }

}
