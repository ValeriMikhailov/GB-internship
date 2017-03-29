package ru.geekbrains_internship.statisticsapp.Daily;


import android.app.DatePickerDialog;
import android.content.Context;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.ArrayAdapter;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;

import com.jaredrummler.materialspinner.MaterialSpinner;

import java.text.SimpleDateFormat;
import java.util.Calendar;

import ru.geekbrains_internship.statisticsapp.R;

/**
 * Created by GooDi on 12.03.2017.
 */

public class DailyFragment extends Fragment implements View.OnFocusChangeListener {

    private EditText from, to;
    private DatePickerDialog chooseDate;

    public DailyFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {

        View view = inflater.inflate(R.layout.fragment_daily, container, false);

        getActivity().getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_ALWAYS_HIDDEN);

        //спиннер выбора сайта
        MaterialSpinner spinnerSite = (MaterialSpinner) view.findViewById(R.id.spinnerSiteDailyFragment);
        spinnerSite.setItems("lenta.ru", "pochta.ru", "android.com", "material.io", "mail.ru");
        spinnerSite.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });

        //спиннер выбора персоны
        MaterialSpinner spinnerPerson = (MaterialSpinner) view.findViewById(R.id.choosePerson);
        spinnerPerson.setItems("Путин", "Навальный", "Жириновский", "Медведев");
        spinnerPerson.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });

        //EditText для ввода дат
        from = (EditText) view.findViewById(R.id.from);
        from.setOnFocusChangeListener(this);
        to = (EditText) view.findViewById(R.id.to);
        to.setOnFocusChangeListener(this);

        ListView listView = (ListView) view.findViewById(R.id.listViewDailyFragment);
        final String[] names = new String[]{"Путин", "Навальный", "Жириновский", "Медведев"};
        ArrayAdapter<String> adapter = new ArrayAdapter<>(getActivity(), android.R.layout.simple_list_item_1, names);
        listView.setAdapter(adapter);

        MaterialSpinner spinner = (MaterialSpinner) view.findViewById(R.id.spinnerSiteDailyFragment);
        spinner.setItems("lenta.ru", "pochta.ru", "android.com", "material.io", "mail.ru");
        spinner.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
            }
        });

        getActivity().getWindow().setSoftInputMode(WindowManager.LayoutParams.SOFT_INPUT_STATE_HIDDEN);

        return view;
    }

    //вызывается когда сменился фокус на EditText
    //Потом проверка, если в фокусе, то инициализировать диалог выбора даты и показать
    @Override
    public void onFocusChange(View view, boolean hasFocus) {
        initDateDialog(view);
        if (hasFocus) {
            ((InputMethodManager) getActivity().getSystemService(Context.INPUT_METHOD_SERVICE))
                    .hideSoftInputFromWindow(view.getWindowToken(), 0);
            chooseDate.show();
        }

    }

    //инициализация диалога выбора даты
    private void initDateDialog(final View view) {
        Calendar calendar = Calendar.getInstance();
        final SimpleDateFormat dateFormat = new SimpleDateFormat("dd.MM.yyyy");
        chooseDate = new DatePickerDialog(getActivity(), new DatePickerDialog.OnDateSetListener() {
            @Override
            public void onDateSet(DatePicker datePicker, int year, int monthOfYear, int dayOfMonth) {
                Calendar newCalendar = Calendar.getInstance();
                newCalendar.set(year, monthOfYear, dayOfMonth);
                switch (view.getId()) {
                    case R.id.from:
                        from.setText(dateFormat.format(newCalendar.getTime()));
                        break;
                    case R.id.to:
                        to.setText(dateFormat.format(newCalendar.getTime()));
                        break;
                }

            }
        }, calendar.get(Calendar.YEAR),
                calendar.get(Calendar.MONTH),
                calendar.get(Calendar.DAY_OF_MONTH));
        //ограничение. нельзя выбрать дату больше текущей
        chooseDate.getDatePicker().setMaxDate(calendar.getTimeInMillis());
    }


}

