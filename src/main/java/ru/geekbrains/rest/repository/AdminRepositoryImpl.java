package ru.geekbrains.rest.repository;

import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.Keyword;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import java.util.HashSet;
import java.util.Set;

@Repository
public class AdminRepositoryImpl implements AdminRepository {
    @Override
    public int createPerson(String name) {
        if ("Navalniy".equals(name)) return 10;
        else return 1;
    }

    @Override
    public void updatePerson(int personId, String name) {

    }

    @Override
    public Person getPerson(int personId) {
        return new Person(personId, "Medvedev");
    }

    @Override
    public void deletePerson(int personId) {

    }

    @Override
    public Set<Keyword> getKeywords(int personId) {
        Set<Keyword> keywords = new HashSet<>();
        keywords.add(new Keyword(1, "Medvedev"));
        keywords.add(new Keyword(2, "Medvedeva"));
        keywords.add(new Keyword(3, "Medvedevy"));
        return keywords;
    }

    @Override
    public int createKeyword(int personId, String name) {
        return 15;
    }

    @Override
    public void updateKeyword(int personId, int keywordId, String name) {

    }

    @Override
    public void deleteKeyword(int personId, int keywordId) {

    }

    @Override
    public Site getSite(int siteId) {
        return new Site(siteId, "newsland.ru");
    }

    @Override
    public int createSite(String name) {
        return 21;
    }

    @Override
    public void updateSite(int siteId, String name) {

    }

    @Override
    public void deleteSite(int siteId) {

    }
}
