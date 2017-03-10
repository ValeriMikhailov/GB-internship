package ru.geekbrains.rest.service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.repository.UserRepository;

import java.time.LocalDate;
import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository repository;

    @Override
    public JSONObject getStats(int siteId) {
       return repository.getStats(siteId);
    }

    @Override
    public JSONObject statsByDate(int siteId, int personId, LocalDate start, LocalDate end) {
        return repository.statsByDate(siteId, personId, start, end);
    }

    @Override
    public Set<Person> getPersons() {
        return repository.getPersons();
    }

    @Override
    public Set<Site> getSites() {
        return repository.getSites();
    }
}
