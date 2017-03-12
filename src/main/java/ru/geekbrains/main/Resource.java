package ru.geekbrains.main;

import com.google.gson.Gson;
import ru.geekbrains.dbService.dataSets.Keyword;
import ru.geekbrains.dbService.dataSets.Person;
import ru.geekbrains.dbService.dataSets.Site;

import javax.ws.rs.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Locale;

@Path("rest")
public class Resource {


    /**
     * Get person info
     * @param stirngId String taken from url
     * @return Json string
     */
    @GET
    @Path("admin/person/{id}")
    @Produces("application/json")
    public String getPerson(@PathParam("id") String stirngId) {
        Gson gson = new Gson();
        int id = Integer.parseInt(stirngId);
        String json = gson.toJson(Main.repo.getPerson(id));
        return json;
    }

    /**
     * Creat person
     */
    @POST
    @Path("admin/person")
    @Consumes("application/json")
    public void createPerson(String massage) {
        Gson gson = new Gson();
        Person newPerson = gson.fromJson(massage, Person.class);
        Main.repo.createPerson(newPerson);
    }

    /**
     * Update person
     * @param personId
     */
    @PUT
    @Path("admin/person/{id}")
    @Consumes("application/json")
    public void updatePerson(@PathParam("id") String personId, String massage) {
        int id = Integer.parseInt(personId);
        Gson gson = new Gson();
        Person updatedPerson = gson.fromJson(massage, Person.class);
        Main.repo.updatePerson(id, updatedPerson);
    }

    /**
     * Remove person
     * @param personId
     */
    @DELETE
    @Path("admin/person/{id}")
    @Produces("application/json")
    public void deletePerson(@PathParam("id") String personId) {
        int id = Integer.parseInt(personId);
        Main.repo.deletePerson(id);
    }

    /**
     * Get all persons
     * @return Json string
     */
    @GET
    @Path("admin/person")
    @Produces("application/json")
    public String getAllPersons() {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getAllPersons());
        return json;
    }

    /**
     * Get keywords by personsId
     * @return Json string
     */
    @GET
    @Path("admin/person/{id}/keywords")
    @Produces("application/json")
    public String getKeywordsByPersonId(@PathParam("id") String personId) {
        int id = Integer.parseInt(personId);
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getKeywordsByPersonId(id));
        return json;
    }

    /**
     * Create keywords by personsId
     */
    @POST
    @Path("admin/person/{id}/keywords")
    @Consumes("application/json")
    public void createKeywordByPersonId(@PathParam("id") String personId, String massage) {
        int id = Integer.parseInt(personId);
        Gson gson = new Gson();
        Keyword keyword = gson.fromJson(massage, Keyword.class);
        Main.repo.createKeywordByPersonId(id, keyword);
    }

    /**
     * Update keywords by personsId
     */
    @PUT
    @Path("admin/person/{id}/keywords")
    @Consumes("application/json")
    public void updateKeywordByPersonId(@PathParam("id") String personId, String massage) {
        int id = Integer.parseInt(personId);
        Gson gson = new Gson();
        Keyword keyword = gson.fromJson(massage, Keyword.class);
        Main.repo.updateKeywordByPersonId(id,keyword.getId(),keyword);
    }
// TODO How to remove better?
    /**
     * Remove keywords by personsId
     */
    @DELETE
    @Path("admin/person/{id}/keywords")
    @Consumes("application/json")
    public void deleteKeywordByPersonId(@PathParam("id") String personId, String massage) {
        int id = Integer.parseInt(personId);
        Gson gson = new Gson();
        Keyword keyword = gson.fromJson(massage, Keyword.class);
        Main.repo.deleteKeywordByPersonId(id, keyword.getId()-1);
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
    @Produces("application/json")
    public String getEveryDayStat(@PathParam("siteId") String siteId, @PathParam("personId") String personId,
                                  @QueryParam("start") String startDate, @QueryParam("end") String endDate)  {
        Gson gson = new Gson();
        int sId = Integer.parseInt(siteId);
        int pId = Integer.parseInt(personId);
        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yy HH:mm:ss ", Locale.US);

        String json = null;
        try {
            json = gson.toJson(Main.repo.getEveryDayStat(sId,pId, formatter.parse(startDate),formatter.parse(endDate)));
        } catch (ParseException e) {
            json = "wrong date format";
        }
        return json;
    }

    /**
     * Get info about all sites
     * @return Json string
     */
    @GET
    @Path("admin/sites")
    @Produces("application/json")
    public String getAllSites() {
        Gson gson = new Gson();
        String json = gson.toJson(Main.repo.getAllSites());
        return json;
    }

    /**
     * Get total statistics
     * @param siteId
     * @return Json string
     */
    @GET
    @Path("user/{id}")
    @Produces("application/json")
    public String getAllSites(@PathParam("id") String siteId) {
        Gson gson = new Gson();
        int id = Integer.parseInt(siteId);
        String json = gson.toJson(Main.repo.getTotalStat(id));
        return json;
    }

    /**
     * Update site
     * @param siteId
     */
    @PUT
    @Path("admin/sites/{id}")
    @Consumes("application/json")
    public void updateSite(@PathParam("id") String siteId, String massage) {
        int id = Integer.parseInt(siteId);
        Gson gson = new Gson();
        Site updatedSite = gson.fromJson(massage, Site.class);
        Main.repo.updateSite(id, updatedSite);
    }

    /**
     * Creat site
     */
    @POST
    @Path("admin/sites")
    @Consumes("application/json")
    public void createSite(String massage) {
        Gson gson = new Gson();
        Site newSite = gson.fromJson(massage, Site.class);
        Main.repo.createSite(newSite);
    }

    /**
     * Remove site
     * @param siteId
     */
    @DELETE
    @Path("admin/sites/{id}")
    @Produces("application/json")
    public void deleteSite(@PathParam("id") String siteId) {
        int id = Integer.parseInt(siteId);
        Main.repo.deleteSite(id);
    }
}


