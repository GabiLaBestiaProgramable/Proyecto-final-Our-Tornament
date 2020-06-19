package com.example.ourtournament;

import androidx.annotation.Nullable;
import android.app.Fragment;
import android.app.FragmentManager;
import android.app.FragmentTransaction;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.Spinner;
import android.widget.TextView;

import java.util.ArrayList;

public class TablaDeGoleadores extends Fragment {

    FragmentManager AdminFragments;
    FragmentTransaction TransaccionesDeFragment;
    @Override
    public View onCreateView(LayoutInflater inflador, @Nullable ViewGroup GrupoDeLaVista, Bundle savedInstanceState) {

        View VistaADevolver;
        VistaADevolver = inflador.inflate(R.layout.tabla_de_goleadores, GrupoDeLaVista, false);

        AdminFragments=getFragmentManager();

        LlamarFragment();

        return VistaADevolver;
    }

    private void LlamarFragment() {
        FragmentoParaListaGoleadores Goleadores = new FragmentoParaListaGoleadores();
        TransaccionesDeFragment=AdminFragments.beginTransaction();
        TransaccionesDeFragment.replace(R.id.Frame,Goleadores);
        TransaccionesDeFragment.commit();
    }
}