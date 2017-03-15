package ru.geekbrains.rest.repository;

import ru.geekbrains.rest.model.DateRank;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.PersonRank;
import ru.geekbrains.rest.model.Site;

import java.time.LocalDate;
import java.util.List;

public interface UserRepository {

    List<PersonRank> getStats(int siteId);

    List<DateRank> statsByDate(int siteId, int personId, LocalDate start, LocalDate end);

    List<Person> getPersons();

    List<Site> getSites();
}
