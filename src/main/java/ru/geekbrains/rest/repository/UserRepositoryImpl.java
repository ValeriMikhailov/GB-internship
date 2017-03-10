package ru.geekbrains.rest.repository;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Repository
public class UserRepositoryImpl implements UserRepository {

    @Override
    public JSONObject getStats(int siteId) {
        JSONObject object = new JSONObject();
        object.put("Путин", 25);
        object.put("Медведев", 10);
        object.put("Навальный", 35);
        return object;
    }

    @Override
    public JSONObject statsByDate(int siteId, int personId, LocalDate start, LocalDate end) {
        JSONObject object = new JSONObject();
        object.put("2017-03-08", 1);
        object.put("2017-03-09", 3);
        object.put("2017-03-10", 8);
        return object;
    }

    @Override
    public Set<Person> getPersons() {
        Set<Person> sample = new HashSet<>();
        sample.add(new Person(1, "Медведев"));
        sample.add(new Person(2, "Путин"));
        sample.add(new Person(3, "Навальный"));
        return sample;
    }

    @Override
    public Set<Site> getSites() {
        Set<Site> sample = new HashSet<>();
        sample.add(new Site(1, "newsland.ru"));
        sample.add(new Site(2, "rbc.ru"));
        sample.add(new Site(3, "echo.ru"));
        return sample;
    }
}
