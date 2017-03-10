package ru.geekbrains.rest.repository;


import org.json.JSONObject;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import java.time.LocalDate;
import java.util.Set;

public interface UserRepository {

    JSONObject getStats(int siteId);
    JSONObject statsByDate(int siteId, int personId, LocalDate start, LocalDate end);
    Set<Person> getPersons();
    Set<Site> getSites();
}
