package ru.geekbrains.rest.repository;

import ru.geekbrains.rest.model.*;

import java.time.LocalDate;
import java.util.List;

public interface UserRepository {

    List<PersonRank> getStats(int siteId);

    List<DateRank> statsByDate(int siteId, int personId, LocalDate start, LocalDate end);

    List<Person> getPersons();

    List<Site> getSites();

    void registerUser(User user);
}
