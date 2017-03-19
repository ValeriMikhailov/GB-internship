package ru.geekbrains.rest.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import ru.geekbrains.rest.model.*;
import ru.geekbrains.rest.repository.UserRepository;

import java.time.LocalDate;
import java.util.*;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private BCryptPasswordEncoder encoder;

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

    @Override
    public void registerUser(UserDto user) {
        User u = new User();
        u.setName(user.getUserName());
        Set<Role> roles = new HashSet<>(Collections.singletonList(Role.ROLE_USER));
        u.setRoles(roles);
        u.setPassword(encoder.encode(user.getPassword()));
        repository.registerUser(u);
    }


}
