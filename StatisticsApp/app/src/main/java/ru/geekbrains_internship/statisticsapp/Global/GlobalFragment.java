package ru.geekbrains_internship.statisticsapp.Global;

import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.jaredrummler.materialspinner.MaterialSpinner;

import ru.geekbrains_internship.statisticsapp.R;

/**
 * Created by GooDi on 12.03.2017.
 */

public class GlobalFragment extends Fragment {

    public GlobalFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_global, container, false);

        ListView listView = (ListView) view.findViewById(R.id.listViewGlobalFragment);
        final String[] names = new String[] {"Путин", "Навальный", "Жириновский", "Медведев"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(getActivity(), android.R.layout.simple_list_item_1, names);
        listView.setAdapter(adapter);

        TextView lastUpdate = (TextView) view.findViewById(R.id.lastUpdateTextView);
        lastUpdate.setText(getResources().getString(R.string.last_update) + "  Это надо сделать!!!");

        MaterialSpinner spinner = (MaterialSpinner) view.findViewById(R.id.spinnerSiteGlobalFragment);
        spinner.setItems("lenta.ru", "pochta.ru", "android.com", "material.io", "mail.ru");
        spinner.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });
        return view;
    }
}
