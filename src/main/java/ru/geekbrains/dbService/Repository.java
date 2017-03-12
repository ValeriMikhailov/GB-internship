package ru.geekbrains.dbService;

import ru.geekbrains.dbService.dataSets.*;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public interface Repository {

    ArrayList<PersonRank> getTotalStat(int siteId);
    ArrayList<EveryDayStat> getEveryDayStat(int siteId, int personId, Date start, Date end);

    List<Person> getAllPersons();
    Person getPerson(int personId);
    boolean createPerson(Person person);
    boolean updatePerson(int personId, Person newPersonData);
    boolean deletePerson(int personId);

    List<Keyword> getKeywordsByPersonId(int personId);
    boolean createKeywordByPersonId(int personId, Keyword keyword);
    boolean updateKeywordByPersonId(int personId, int keywordId, Keyword newKeyword);
    boolean deleteKeywordByPersonId(int personId, int keywordId);

    boolean createSite(Site site);
    boolean updateSite(int siteId, Site newDataSite);
    Site getSite(int siteId);
    boolean deleteSite(int siteId);
    List<Site> getAllSites();

}
