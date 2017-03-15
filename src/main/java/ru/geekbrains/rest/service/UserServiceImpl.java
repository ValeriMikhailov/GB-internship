package ru.geekbrains.rest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import ru.geekbrains.rest.model.DateRank;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.PersonRank;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.repository.UserRepository;

import java.time.LocalDate;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository repository;

    @Override
    public List<PersonRank> getStats(int siteId) {
        return repository.getStats(siteId);
    }

    @Override
    public List<DateRank> statsByDate(int siteId, int personId, LocalDate start, LocalDate end) {
        return repository.statsByDate(siteId, personId, start, end);
    }

    @Override
    public List<Person> getPersons() {
        return repository.getPersons();
    }

    @Override
    public List<Site> getSites() {
        return repository.getSites();
    }
}
