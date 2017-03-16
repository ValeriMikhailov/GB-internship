package ru.geekbrains.dbService;

import ru.geekbrains.dbService.dataSets.DateNewPages;
import ru.geekbrains.dbService.dataSets.PersonSiteRank;
import ru.geekbrains.dbService.dataSets.iDNameObject;

import java.util.ArrayList;
import java.util.List;

public interface Repository {

    ArrayList<PersonSiteRank> getTotalStat(String siteId);
    ArrayList<DateNewPages> getEveryDayStat(String siteId, String personId, String startDate, String endDate);

    List<iDNameObject> getAllPersons();
    iDNameObject getPerson(String personId);
    String createPerson(String name);
    void updatePerson(String personId,String name);
    void deletePerson(String personId);

    List<iDNameObject> getKeywordsByPersonId(String personId);
    String createKeywordByPersonId(String personId, String name);
    void updateKeywordByPersonId(String personId, String keywordId, String keyword);
    void deleteKeywordByPersonId(String personId, String keywordId);

    List<iDNameObject> getAllSites();
    iDNameObject getSite(String siteId);
    String createSite(String name);
    void updateSite(String siteId, String siteName);
    void deleteSite(String siteId);

    void closeConnection();


}
