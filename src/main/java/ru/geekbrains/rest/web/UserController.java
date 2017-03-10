package ru.geekbrains.rest.web;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.service.UserService;

import java.util.Set;

@RestController
@RequestMapping(UserController.USER_REST_URL)
public class UserController {
    static final String USER_REST_URL = "/user";

    @Autowired
    private UserService service;

    public Set<Person> getPersons() {
        return null;
    }

    public Set<Site> getSites() {
        return null;
    }

    public ResponseEntity getStats() {
        return null;
    }

    public ResponseEntity getStatsByDate() {
        return null;
    }
}
