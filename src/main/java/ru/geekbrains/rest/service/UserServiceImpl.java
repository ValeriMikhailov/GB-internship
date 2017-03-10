package ru.geekbrains.rest.service;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.repository.UserRepository;

import java.util.Set;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository repository;

    @Override
    public JSONObject getStats() {
        return null;
    }

    @Override
    public JSONObject statsByDate() {
        return null;
    }

    @Override
    public Set<Person> getPersons() {
        return null;
    }

    @Override
    public Set<Site> getSites() {
        return null;
    }
}
