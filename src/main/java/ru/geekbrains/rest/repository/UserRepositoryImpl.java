package ru.geekbrains.rest.repository;

import org.json.JSONObject;
import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import java.util.Set;

@Repository
public class UserRepositoryImpl implements UserRepository {
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
