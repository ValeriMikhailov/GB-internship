package ru.geekbrains.rest.service;

import org.json.JSONObject;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import java.util.Set;

public interface UserService {

    JSONObject getStats();
    JSONObject statsByDate();
    Set<Person> getPersons();
    Set<Site> getSites();
}
