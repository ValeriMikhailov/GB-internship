package ru.geekbrains_internship.statisticsapp.Daily;

import android.os.Bundle;
import android.support.annotation.Nullable;
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

public class DailyFragment extends Fragment {
    public DailyFragment() {
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Nullable
    @Override
    public View onCreateView(LayoutInflater inflater, @Nullable ViewGroup container, @Nullable Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_daily, container, false);

        MaterialSpinner spinnerSite = (MaterialSpinner) view.findViewById(R.id.spinnerSiteDailyFragment);
        spinnerSite.setItems("lenta.ru", "pochta.ru", "android.com", "material.io", "mail.ru");
        spinnerSite.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });

        MaterialSpinner spinnerPerson = (MaterialSpinner) view.findViewById(R.id.choosePerson);
        spinnerPerson.setItems("Путин", "Навальный", "Жириновский", "Медведев");
        spinnerPerson.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });

        ListView listView = (ListView) view.findViewById(R.id.listViewDailyFragment);
        final String[] names = new String[] {"Путин", "Навальный", "Жириновский", "Медведев"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(getActivity(), android.R.layout.simple_list_item_1, names);
        listView.setAdapter(adapter);

        TextView lastUpdate = (TextView) view.findViewById(R.id.lastUpdateTextView);
        lastUpdate.setText(getResources().getString(R.string.last_update) + "  Это надо сделать!!!");

        MaterialSpinner spinner = (MaterialSpinner) view.findViewById(R.id.spinnerSiteDailyFragment);
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

