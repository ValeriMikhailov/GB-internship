package ru.geekbrains.main;

import com.google.gson.Gson;

import javax.ws.rs.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;

@Path("rest")
public class Resource {

    /**
     * Get total statistics
     * @param id
     * @return Json string
     */
    @GET
    @Path("user/{siteId}")
    @Produces("application/json;charset=UTF-8")
    public String getTotalStatistics(@PathParam("siteId") String id) {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getTotalStat(id));
        return json;
    }

    /**
     * Get every day statistics
     * @param siteId
     * @param personId
     * @param startDate Date in the form of string for example 10.08.15 10:50:00
     * @param endDate Date in the form of string for example 10.08.15 10:50:00
     * @return Json string
     * @throws ParseException
     */
    @GET
    @Path("user/{siteId}/{personId}/between")
    @Produces("application/json;charset=UTF-8")
    public String getEveryDayStat(@PathParam("siteId") String siteId, @PathParam("personId") String personId,
                                  @QueryParam("start") String startDate, @QueryParam("end") String endDate)  {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getEveryDayStat(siteId,personId, startDate, endDate));
        return json;
    }

    /**
     * Get all persons
     * @return Json string
     */
    @GET
    @Path("user/persons")
    @Produces("application/json;charset=UTF-8")
    public String getAllPersons() {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getAllPersons());
        return json;
    }

    /**
     * Get person info
     * @param stringId
     * @return Json string
     */
    @GET
    @Path("admin/person/{id}")
    @Produces("application/json;charset=UTF-8")
    public String getPerson(@PathParam("id") String stringId) {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getPerson(stringId));
        return json;
    }

    /**
     * Creat person
     */
    @POST
    @Path("admin/person")
    @Produces("application/json;charset=UTF-8")
    public String createPerson(@QueryParam("name") String personName) {
        Gson gson = new Gson();
         return gson.toJson(Main.repo.createPerson(personName));
    }

    /**
     * Update person
     * @param personId
     */
    @PUT
    @Path("admin/person/{id}")
    public void updatePerson(@PathParam("id") String personId,@QueryParam("name") String personName) {
        Main.repo.updatePerson(personId,personName);
    }

    /**
     * Remove person
     * @param personId
     */
    @DELETE
    @Path("admin/person/{id}")
    public void deletePerson(@PathParam("id") String personId) {
        Main.repo.deletePerson(personId);
    }

    /**
     * Get keywords by personsId
     * @return Json string
     */
    @GET
    @Path("admin/person/{id}/keywords")
    @Produces("application/json;charset=UTF-8")
    public String getKeywordsByPersonId(@PathParam("id") String personId) {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getKeywordsByPersonId(personId));
        return json;
    }

    /**
     * Create keywords by personsId
     */
    @POST
    @Path("admin/person/{id}/keywords")
    @Produces("application/json;charset=UTF-8")
    public String createKeywordByPersonId(@PathParam("id") String personId,@QueryParam("name") String keyword) {
        Gson gson = new Gson();
        return gson.toJson(Main.repo.createKeywordByPersonId(personId, keyword));
    }

    /**
     * Update keywords by personsId
     */
    @PUT
    @Path("admin/person/{idP}/keywords/{idK}")
    public void updateKeywordByPersonId(@PathParam("idP") String personId,@PathParam("idK") String keywordId,
                                        @QueryParam("name") String keyword) {
        Main.repo.updateKeywordByPersonId(personId,keywordId,keyword);
    }

    @DELETE
    @Path("admin/person/{idP}/keywords/{idK}")
    public void deleteKeywordByPersonId(@PathParam("idP") String personId,@PathParam("idK") String keywordId) {
        Main.repo.deleteKeywordByPersonId(personId,keywordId);
    }

    /**
     * Get info about all sites
     * @return Json string
     */
    @GET
    @Path("user/sites")
    @Produces("application/json;charset=UTF-8")
    public String getAllSites() {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getAllSites());
        return json;
    }

    /**
     * Get site info
     * @return Json string
     */
    @GET
    @Path("admin/sites/{id}")
    @Produces("application/json;charset=UTF-8")
    public String getSite(@PathParam("id") String siteId) {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getSite(siteId));
        return json;
    }

    /**
     * Creat site
     */
    @POST
    @Path("admin/sites")
    @Produces("application/json;charset=UTF-8")
    public String createSite(@QueryParam("name") String name) {
        Gson gson = new Gson();
        return gson.toJson(Main.repo.createSite(name));
    }

    /**
     * Update site
     * @param siteId
     */
    @PUT
    @Path("admin/sites/{id}")
    public void updateSite(@PathParam("id") String siteId, @QueryParam("name") String siteName) {
        Main.repo.updateSite(siteId, siteName);
    }

    /**
     * Remove site
     * @param siteId
     */
    @DELETE
    @Path("admin/sites/{id}")
    public void deleteSite(@PathParam("id") String siteId) {
        Main.repo.deleteSite(siteId);
    }
}


