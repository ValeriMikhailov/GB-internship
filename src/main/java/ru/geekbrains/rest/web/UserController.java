package ru.geekbrains.rest.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import ru.geekbrains.rest.model.*;
import ru.geekbrains.rest.service.UserService;

import javax.validation.Valid;
import java.time.LocalDate;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(UserController.USER_REST_URL)
public class UserController {

    static final String USER_REST_URL = "/user";

    @Autowired
    private UserService service;

    @GetMapping(value = "/persons", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public List<Person> getPersons() {
        return service.getPersons();
    }

    @GetMapping(value = "/sites", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public List<Site> getSites() {
        return service.getSites();
    }

    @GetMapping(value = "/{siteId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public List<PersonRank> getStats(@PathVariable(value = "siteId") int siteId) {
        return service.getStats(siteId);
    }

    @GetMapping(value = "/{siteId}/{personId}/between", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public List<DateRank> getStatsByDate(@PathVariable(value = "siteId") int siteId, @PathVariable(value = "personId") int personId,
                                         @RequestParam(value = "start") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate start,
                                         @RequestParam(value = "end") @DateTimeFormat(iso = DateTimeFormat.ISO.DATE) LocalDate end) {
        return service.statsByDate(siteId, personId, start, end);
    }

    @PostMapping(value = "/signup", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity registerUser(@Valid @RequestBody UserDto userDto, Errors errors) {
        if (errors.hasErrors()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body(errors.getAllErrors()
                    .stream()
                    .map(x -> x.getDefaultMessage())
                    .collect(Collectors.joining(", ")));
        }
        service.registerUser(userDto);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }
}
