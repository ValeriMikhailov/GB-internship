package ru.geekbrains.dbService;

import ru.geekbrains.dbService.dataSets.*;

import java.text.SimpleDateFormat;
import java.util.*;

public class FakeDBService implements Repository {

    private ArrayList<Person> personList;
    private ArrayList<EveryDayStat> eveyDayStatList;
    private ArrayList<Site> siteList;
    private HashMap<Integer,ArrayList<PersonRank>> totalStatMap;
    private HashMap<Integer,ArrayList<Keyword>> personIdKeywordsMap;


    public FakeDBService() throws Exception{
        this.personList = new ArrayList<>();
        personList.add(new Person(1,"Путин"));
        personList.add(new Person(2,"Медведев"));

        this.siteList = new ArrayList<>();
        siteList.add(new Site(1,"Somewhere1.com"));
        siteList.add(new Site(2,"Somewhere2.com"));

        this.totalStatMap = new HashMap<>();
        ArrayList lst1 = new ArrayList();
        lst1.add(new PersonRank(1,"Путин",5));
        lst1.add(new PersonRank(1,"Медведев",3));
        totalStatMap.put(1,lst1);
        ArrayList lst2 = new ArrayList();
        lst2.add(new PersonRank(2,"Путин",1));
        lst2.add(new PersonRank(2,"Медведев",0));
        totalStatMap.put(2,lst2);

        this.personIdKeywordsMap = new HashMap<>();
        ArrayList list1 = new ArrayList();
        list1.add(new Keyword(1,"Путина",1));
        list1.add(new Keyword(2,"Путиным",1));
        personIdKeywordsMap.put(1,list1);
        ArrayList list2 = new ArrayList();
        list2.add(new Keyword(3,"Медведева",2));
        list2.add(new Keyword(4,"Медведевым",2));
        personIdKeywordsMap.put(2,list2);

        this.eveyDayStatList = new ArrayList<EveryDayStat>();
        SimpleDateFormat formatter = new SimpleDateFormat("dd.MM.yy HH:mm:ss", Locale.US);
        EveryDayStat ob1 = new EveryDayStat(1,"Путин",1,"somewhere1.com",formatter.parse("12.03.17 07:45:50"),1);
        EveryDayStat ob2 = new EveryDayStat(1,"Путин",1,"somewhere1.com",formatter.parse("12.04.17 07:45:50"),2);
        EveryDayStat ob3 = new EveryDayStat(1,"Путин",1,"somewhere1.com",formatter.parse("12.05.17 07:45:50"),3);
        EveryDayStat ob4 = new EveryDayStat(1,"Путин",1,"somewhere1.com",formatter.parse("12.06.17 07:45:50"),4);
        this.eveyDayStatList.add(ob1);
        this.eveyDayStatList.add(ob2);
        this.eveyDayStatList.add(ob3);
        this.eveyDayStatList.add(ob4);
    }

    @Override
    public ArrayList<EveryDayStat> getEveryDayStat(int siteId, int personId, Date start, Date end) {
        ArrayList tempL = new ArrayList<EveryDayStat>();
        for (EveryDayStat d: this.eveyDayStatList) {
            if (siteId == d.getSiteId() && personId == d.getPersonId()){
                if ((start.compareTo(d.getFoundDate()) <= 0) && (end.compareTo(d.getFoundDate()) >= 0)){
                    tempL.add(d);
                }
            }
        }
        return tempL;
    }

    @Override
    public ArrayList<PersonRank> getTotalStat(int siteId) {

        return totalStatMap.get(siteId);
    }

    @Override
    public List<Person> getAllPersons() {
        return personList;
    }

    @Override
    public boolean createPerson(Person person) {
        personList.add(person);
        return true;
    }

    @Override
    public boolean updatePerson(int personId, Person newPersonData) {
        personList.set(personId - 1, newPersonData);
        return true;
    }

    @Override
    public Person getPerson(int personId) {
        return personList.get(personId-1);
    }

    @Override
    public boolean deletePerson(int personId) {
        Person tempP = getPerson(personId);
        personList.remove(tempP);
        return true;
    }

    @Override
    public List<Keyword> getKeywordsByPersonId(int personId) {
        return personIdKeywordsMap.get(personId);
    }

    @Override
    public boolean createKeywordByPersonId(int personId, Keyword keyword) {
        personIdKeywordsMap.get(personId).add(keyword);
        return true;
    }

    @Override
    public boolean updateKeywordByPersonId(int personId, int keywordId, Keyword newKeyword) {
        personIdKeywordsMap.get(personId).set(keywordId - 1, newKeyword);
        return true;
    }

    @Override
    public boolean deleteKeywordByPersonId(int personId, int keywordId) {
        Keyword tempK = personIdKeywordsMap.get(personId).get(keywordId);
        personIdKeywordsMap.get(personId).remove(tempK);
        return true;
    }

    @Override
    public boolean createSite(Site site) {
        siteList.add(site);
        return true;
    }

    @Override
    public boolean updateSite(int siteId, Site newDataSite) {
        siteList.set(siteId - 1, newDataSite);
        return true;
    }

    @Override
    public Site getSite(int siteId) {
        return siteList.get(siteId - 1);
    }

    @Override
    public boolean deleteSite(int siteId) {
        Site tempS = getSite(siteId);
        siteList.remove(tempS);
        return true;
    }

    @Override
    public List<Site> getAllSites() {
        return siteList;
    }
}
