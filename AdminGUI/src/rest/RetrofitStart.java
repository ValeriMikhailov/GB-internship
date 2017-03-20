package rest;

import retrofit2.GsonConverterFactory;
import retrofit2.Retrofit;

/**
 * Created by user on 20/03/2017.
 * Retrofit starter
 */

public class RetrofitStart {

    private static final String serverURL = "http://52.89.213.205:8080";

    public static void main(String[] args) {

        Retrofit retrofit = new Retrofit.Builder()
                .baseUrl(serverURL)
                .addConverterFactory(GsonConverterFactory.create())
                .build();

        API api = retrofit.create(API.class);

        //TODO work with retrofit2
    }
}
