package ru.geekbrains.rest.repository;

import ru.geekbrains.rest.model.Keyword;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import java.util.List;

public interface AdminRepository {

    int createPerson(String name);

    void updatePerson(int personId, String name);

    Person getPerson(int personId);

    void deletePerson(int personId);

    List<Keyword> getKeywords(int personId);

    int createKeyword(int personId, String name);

    void updateKeyword(int personId, int keywordId, String name);

    void deleteKeyword(int personId, int keywordId);

    Site getSite(int siteId);

    int createSite(String name);

    void updateSite(int siteId, String name);

    void deleteSite(int siteId);
}
