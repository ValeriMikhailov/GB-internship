package ru.geekbrains_internship.statisticsapp.Daily;


import android.app.DatePickerDialog;
import android.content.Context;
import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.text.TextUtils;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.jaredrummler.materialspinner.MaterialSpinner;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Set;

import ru.geekbrains_internship.statisticsapp.Global.HttpHandler;
import ru.geekbrains_internship.statisticsapp.R;

/**
 * Created by GooDi on 12.03.2017.
 */

public class DailyFragment extends Fragment implements View.OnFocusChangeListener {

    private static final String URL_BASIC = "http://52.89.213.205:9050/rest/user/";
    private final String TAG = "DailyFragment";

    private EditText from, to;
    private DatePickerDialog chooseDate;
    HashMap<String, Integer> siteItem; //список сайтов
    HashMap<String, Integer> personItem; //список персон
    ArrayList<HashMap<String, String>> statList; //данные для адаптера листвью
    String nameSite, namePerson;
    List<String> sitesForSpinner, personsForSpinner; //данные для спиннера
    MaterialSpinner spinnerSite, spinnerPerson;
    private ProgressBar progressBarStat; //индикатор загрузки данных в листвью
    ListView listView;
    TextView jopaStat; //текст "нет данных" для листвью
    TextView total; // текст для общего числа упоминаний персоны
    SimpleAdapter adapter;
    HashMap<String, String> statItem;

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

        siteItem = new HashMap<>();
        statList = new ArrayList<>();
        personItem = new HashMap<>();

        progressBarStat = (ProgressBar) view.findViewById(R.id.progressBarStat);
        total = (TextView) view.findViewById(R.id.textViewTotalCount);
        jopaStat = (TextView) view.findViewById(R.id.jopa_stat);

        //спиннер выбора сайта
        spinnerSite = (MaterialSpinner) view.findViewById(R.id.spinnerSiteDailyFragment);
        //получаем список сайтов для спиннера
        new getSites().execute();

        //спиннер выбора персоны
        spinnerPerson = (MaterialSpinner) view.findViewById(R.id.choosePerson);
        //получаем список персон для спиннера
        new GetPersonsDaily().execute();

        //EditText для ввода дат
        from = (EditText) view.findViewById(R.id.from);
        from.setOnFocusChangeListener(this);
        to = (EditText) view.findViewById(R.id.to);
        to.setOnFocusChangeListener(this);

        listView = (ListView) view.findViewById(R.id.listViewDailyFragment);
        //проверяем, если editText пустой
        if (TextUtils.isEmpty(from.getText().toString())) {}
        new GetStatisticsDaily().execute();


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

    /**
     * Asynctask для получения json по HTTP-запросу (список сайтов)
     */
    private class getSites extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Void doInBackground(Void... arg0) {
            HttpHandler sh = new HttpHandler();

            // запрос по url и получение ответа
            String jsonStr = sh.makeServiceCall(URL_BASIC + "sites");

            Log.e(TAG, "Response from url: " + jsonStr);

            if (jsonStr != null) {
                try {
                    JSONArray sites = new JSONArray(jsonStr);

                    // проходимся по всем пунктам
                    for (int i = 0; i < sites.length(); i++) {
                        JSONObject c = sites.getJSONObject(i);

                        int idSite = c.getInt("id");
                        nameSite = c.getString("name");

                        // добавление каждого элемента в HashMap key => value
                        siteItem.put(nameSite, idSite);
                    }
                } catch (final JSONException e) {
                    Log.e(TAG, "Json parsing error (spinner): " + e.getMessage());
                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            Toast.makeText(getActivity(),
                                    "Json parsing error (spinner): " + e.getMessage(),
                                    Toast.LENGTH_LONG)
                                    .show();
                        }
                    });
                }
            } else {
                Log.e(TAG, "Couldn't get json from server.");
                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getActivity(),
                                "Couldn't get json from server. Check LogCat for possible errors!",
                                Toast.LENGTH_LONG)
                                .show();
                    }
                });
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);

            //обновляем данные в спиннере
            sitesForSpinner = new ArrayList<>(siteItem.keySet());
            spinnerSite.setItems(sitesForSpinner);
        }
    }

    /**
     * Asynctask для получения json по HTTP-запросу (список персон)
     */
    private class GetPersonsDaily extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
        }

        @Override
        protected Void doInBackground(Void... arg0) {
            HttpHandler s = new HttpHandler();

            // запрос по url и получение ответа
            String jsonStr = s.makeServiceCall(URL_BASIC + "persons");

            Log.e(TAG, "Response from url: " + jsonStr);

            if (jsonStr != null) {
                try {
                    JSONArray persons = new JSONArray(jsonStr);

                    // проходимся по всем пунктам
                    for (int i = 0; i < persons.length(); i++) {
                        JSONObject p = persons.getJSONObject(i);

                        int idPerson = p.getInt("id");
                        namePerson = p.getString("name");

                        // добавление каждого элемента в HashMap key => value
                        personItem.put(namePerson, idPerson);
                    }
                } catch (final JSONException e) {
                    Log.e(TAG, "Json parsing error (spinner persons): " + e.getMessage());
                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            Toast.makeText(getActivity(),
                                    "Json parsing error (spinner persons): " + e.getMessage(),
                                    Toast.LENGTH_LONG)
                                    .show();
                        }
                    });
                }
            } else {
                Log.e(TAG, "Couldn't get json from server.");
                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getActivity(),
                                "Couldn't get json from server. Check LogCat for possible errors!",
                                Toast.LENGTH_LONG)
                                .show();
                    }
                });
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);

            //обновляем данные в спиннере
            personsForSpinner = new ArrayList<>(personItem.keySet());
            spinnerPerson.setItems(personsForSpinner);
        }
    }

    /**
     * Asynctask для получения json по HTTP-запросу (список имен и количество упоминаний)
     */
    private class GetStatisticsDaily extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // показываем progressbar
            progressBarStat.setActivated(true);
            progressBarStat.setVisibility(View.VISIBLE);
            statList.clear();
        }

        @Override
        protected Void doInBackground(Void... arg0) {
            HttpHandler sh = new HttpHandler();

            // запрос по url и получение ответа
            String jsonStr = sh.makeServiceCall("http://52.89.213.205:9050/rest/user/1/1/between?start=2017-01-01&end=2017-03-20");

            Log.e(TAG, "Response from url: " + jsonStr);

            if (jsonStr != null) {
                try {
                    Thread.sleep(500); //искусственная задержка для показать progressbar

                    JSONArray stat = new JSONArray(jsonStr);

                    // проходимся по всем пунктам
                    for (int i = 0; i < stat.length(); i++) {
                        JSONObject c = stat.getJSONObject(i);

                        String date = c.getString("date");
                        String countPages = c.getString("countNewPages");

                        // hash map для каждого пункта листвью
                        statItem = new HashMap<>();

                        // добавление каждого элемента в HashMap key => value
                        statItem.put("countNewPages", countPages);
                        statItem.put("date", date);

                        // добавление в лист
                        statList.add(statItem);
                    }
                } catch (final JSONException e) {
                    Log.e(TAG, "Json parsing error: " + e.getMessage());
                    getActivity().runOnUiThread(new Runnable() {
                        @Override
                        public void run() {
                            Toast.makeText(getActivity(),
                                    "Json parsing error: " + e.getMessage(),
                                    Toast.LENGTH_LONG)
                                    .show();
                        }
                    });
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            } else {
                Log.e(TAG, "Couldn't get json from server.");
                getActivity().runOnUiThread(new Runnable() {
                    @Override
                    public void run() {
                        Toast.makeText(getActivity(),
                                "Couldn't get json from server. Check LogCat for possible errors!",
                                Toast.LENGTH_LONG)
                                .show();
                    }
                });

            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);

            // убираем индикатор загрузки
            if (progressBarStat.isActivated())
                progressBarStat.setVisibility(View.INVISIBLE);

            if (statList.isEmpty()) {
                listView.setVisibility(View.INVISIBLE);
                jopaStat.setVisibility(View.VISIBLE);

            } else {
                //обновляем данные в ListView
                adapter = new SimpleAdapter(getActivity(), statList,
                        R.layout.listview_item_daily, new String[]{"date", "countNewPages"},
                        new int[]{R.id.date, R.id.count});
                listView.setVisibility(View.VISIBLE);
                listView.setAdapter(adapter);
                int countFinal = 0;
                Set tmp = statItem.keySet();
                Toast.makeText(getActivity(), "tmp = " + tmp.toString(), Toast.LENGTH_LONG).show();
                for (int i = 0; i < tmp.size(); i++){
                   // countFinal = countFinal;
                    //Log.e(TAG, "countFinal = ", countFinal);
                }
//                total.setText(countFinal);
            }
        }
    }
}