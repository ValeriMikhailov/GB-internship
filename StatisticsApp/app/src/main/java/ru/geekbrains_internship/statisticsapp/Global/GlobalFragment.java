package ru.geekbrains_internship.statisticsapp.Global;

import android.os.AsyncTask;
import android.os.Bundle;
import android.support.v4.app.Fragment;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ListAdapter;
import android.widget.ListView;
import android.widget.ProgressBar;
import android.widget.ScrollView;
import android.widget.SimpleAdapter;
import android.widget.TextView;
import android.widget.Toast;

import com.jaredrummler.materialspinner.MaterialSpinner;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import ru.geekbrains_internship.statisticsapp.R;

/**
 * Created by GooDi on 12.03.2017.
 */

public class GlobalFragment extends Fragment {

    private static final String URL_BASIC = "http://52.89.213.205:9050/rest/user/";
    private final String TAG = "GlobalFragment";

    private ProgressBar progressBar; //индикатор загрузки данных в листвью

    ArrayList<HashMap<String, String>> personList; //данные для адаптера листвью
    ListView listView;
    MaterialSpinner spinner;
    List<String> sitesForSpinner; //данные для спиннера
    HashMap<String, Integer> siteItem; //список сайтов
    String name;
    String url;
    TextView jopa; //текст "нет данных" для листвью
    int idSite;
    SimpleAdapter adapter;

    public GlobalFragment() {
    }

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        View view = inflater.inflate(R.layout.fragment_global, container, false);

        jopa = (TextView) view.findViewById(R.id.jopa);
        jopa.setVisibility(View.INVISIBLE);
        progressBar = (ProgressBar) view.findViewById(R.id.progressBar);

        personList = new ArrayList<>();
        sitesForSpinner = new ArrayList<>();
        siteItem = new HashMap<>();

        listView = (ListView) view.findViewById(R.id.listViewGlobalFragment);

        spinner = (MaterialSpinner) view.findViewById(R.id.spinnerSiteGlobalFragment);

        //получаем список сайтов для спиннера
        new getSites().execute();

        //узнаем url для загрузки в листвью на основе выбранного пункта в спиннере
        WhatsUrl();

        //получаем список персон по url
        new GetPersonsGlobal().execute();

        spinner.setOnItemSelectedListener(new MaterialSpinner.OnItemSelectedListener<String>() {
            @Override
            public void onItemSelected(MaterialSpinner view, int position, long id, String item) {
                Toast.makeText(getActivity(), "Выбран " + item, Toast.LENGTH_SHORT).show();
                idSite = siteItem.get(item);
                Log.e(TAG, "idSite = " + String.valueOf(idSite));
                WhatsUrl();
                jopa.setVisibility(View.INVISIBLE);
                new GetPersonsGlobal().execute();
            }
        });

        return view;
    }

    /**
     * Asynctask для получения json по HTTP-запросу (список имен и количество упоминаний)
     */
    private class GetPersonsGlobal extends AsyncTask<Void, Void, Void> {

        @Override
        protected void onPreExecute() {
            super.onPreExecute();
            // показываем progressbar
            progressBar.setActivated(true);
            progressBar.setVisibility(View.VISIBLE);
            personList.clear();
        }

        @Override
        protected Void doInBackground(Void... arg0) {
            HttpHandler sh = new HttpHandler();

            // запрос по url и получение ответа
            String jsonStr = sh.makeServiceCall(url);

            Log.e(TAG, "Response from url: " + jsonStr);

            if (jsonStr != null) {
                try {
                    Thread.sleep(1000); //искусственная задержка для показать progressbar

                    JSONArray person = new JSONArray(jsonStr);

                    // проходимся по всем пунктам
                    for (int i = 0; i < person.length(); i++) {
                        JSONObject c = person.getJSONObject(i);

                        String personName = c.getString("personName");
                        String rank = c.getString("rank");

                        // hash map для каждого пункта листвью
                        HashMap<String, String> personItem = new HashMap<>();

                        // добавление каждого элемента в HashMap key => value
                        personItem.put("rank", rank);
                        personItem.put("personName", personName);

                        // добавление в лист
                        personList.add(personItem);
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
            if (progressBar.isActivated())
                progressBar.setVisibility(View.INVISIBLE);

            if (personList.isEmpty()) {
                listView.setVisibility(View.INVISIBLE);
                jopa.setVisibility(View.VISIBLE);

            } else {
                //обновляем данные в ListView
                adapter = new SimpleAdapter(getActivity(), personList,
                        R.layout.listview_item_global, new String[]{"personName", "rank"},
                        new int[]{R.id.personName, R.id.rank});
                listView.setVisibility(View.VISIBLE);
                listView.setAdapter(adapter);
            }
        }

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

                        int id = c.getInt("id");
                        name = c.getString("name");

                        // добавление каждого элемента в HashMap key => value
                        siteItem.put(name, id);
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
            spinner.setItems(sitesForSpinner);
        }
    }


    //метод определения нужного url для листвью в зависимости от выбранного пункта в спиннере
    private void WhatsUrl() {
        //определяем id выбранного в спиннере сайта
        //idSite = siteItem.get(name);
        //формируем url по этому id
        url = URL_BASIC + idSite;
        Log.e(TAG, url);
    }
}
