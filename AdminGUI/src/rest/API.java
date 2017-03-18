package rest;

import retrofit2.http.GET;


/**
 * Created by StrategDZR on 18.03.2017.
 * REST API with retrofit
 */

public interface API {

    //get common statistic
    @GET("/rest/user/{siteID}")

    //get daily statistic
    @GET("/rest/user/{siteID}/between?start=..&end=...")

    //get persons list
    @GET("/rest/user/persons")

    //get sites list
    @GET("/rest/user/sites")

    //get person
    @GET("/rest/admin/person/{id}")

    //get keywords
    @GET("/rest/admin/person/{id}/keywords")

    //get site
    @GET("/rest/admin/sites/{id}")
}