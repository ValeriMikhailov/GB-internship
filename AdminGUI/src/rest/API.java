package rest;

import model.Persons;
import model.Sites;
import retrofit2.Call;
import retrofit2.http.GET;
import retrofit2.http.Path;

import java.util.List;

/**
 * Created by StrategDZR on 18.03.2017.
 * REST API service with retrofit2
 */

public class API {

    public interface getPersonsData {

        //get person data
        @GET("rest/admin/person/{id}")
        Call<List<Persons>> getPD(
                @Path("id") String id);
    }

    public interface getSitesData {

        //get person data
        @GET("rest/admin/sites/{id}")
        Call<List<Sites>> getSD(
                @Path("id") String id);
    }

}
