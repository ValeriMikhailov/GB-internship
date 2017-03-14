package ru.geekbrains.rest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.geekbrains.rest.model.Keyword;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.repository.AdminRepository;

import java.util.List;

@Service
public class AdminServiceImpl implements AdminService {

    @Autowired
    private AdminRepository repository;

    @Override
    public int createPerson(String name) {
        return repository.createPerson(name);
    }

    @Override
    public void updatePerson(int personId, String name) {
        repository.updatePerson(personId, name);
    }

    @Override
    public Person getPerson(int personId) {
        return repository.getPerson(personId);
    }

    @Override
    public void deletePerson(int personId) {
        repository.deletePerson(personId);
    }

    @Override
    public List<Keyword> getKeywords(int personId) {
        return repository.getKeywords(personId);
    }

    @Override
    public int createKeyword(int personId, String name) {
        return repository.createKeyword(personId, name);
    }

    @Override
    public void updateKeyword(int personId, int keywordId, String name) {
        repository.updateKeyword(personId, keywordId, name);
    }

    @Override
    public void deleteKeyword(int personId, int keywordId) {
        repository.deleteKeyword(personId, keywordId);
    }

    @Override
    public Site getSite(int siteId) {
        return repository.getSite(siteId);
    }

    @Override
    public int createSite(String name) {
        return repository.createSite(name);
    }

    @Override
    public void updateSite(int siteId, String name) {
        repository.updateSite(siteId, name);
    }

    @Override
    public void deleteSite(int siteId) {
        repository.deleteSite(siteId);
    }
}
