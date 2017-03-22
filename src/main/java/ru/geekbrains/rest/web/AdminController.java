package ru.geekbrains.rest.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.*;
import ru.geekbrains.rest.model.Keyword;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;
import ru.geekbrains.rest.model.UserDto;
import ru.geekbrains.rest.service.AdminService;

import javax.validation.Valid;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping(AdminController.ADMIN_REST_URL)
public class AdminController {
    static final String ADMIN_REST_URL = "/admin";

    @Autowired
    private AdminService service;

    @PostMapping(value = "/person", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public int createPerson(@RequestParam(value = "name") String name) {
        return service.createPerson(name);
    }

    @GetMapping(value = "/person/{personId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Person getPerson(@PathVariable(value = "personId") int personId) {
        return service.getPerson(personId);
    }

    @DeleteMapping(value = "/person/{personId}")
    public void deletePerson(@PathVariable(value = "personId") int personId) {
        service.deletePerson(personId);
    }

    @PutMapping(value = "/person/{personId}")
    public void updatePerson(@PathVariable(value = "personId") int personId, @RequestParam("name") String name) {
        service.updatePerson(personId, name);
    }

    @GetMapping(value = "/person/{personId}/keywords", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public List<Keyword> getKeywords(@PathVariable(value = "personId") int personId) {
        return service.getKeywords(personId);
    }

    @DeleteMapping(value = "/person/{personId}/keywords/{keywordId}")
    public void deleteKeyword(@PathVariable(value = "personId") int personId,
                              @PathVariable(value = "keywordId") int keywordId) {
        service.deleteKeyword(personId, keywordId);
    }

    @PostMapping(value = "/person/{personId}/keywords")
    public int createKeyword(@PathVariable(value = "personId") int personId,
                             @RequestParam(value = "name") String name) {
        return service.createKeyword(personId, name);
    }

    @PutMapping(value = "/person/{personId}/keywords/{keywordId}")
    public void updateKeyword(@PathVariable(value = "personId") int personId,
                              @PathVariable(value = "keywordId") int keywordId,
                              @RequestParam(value = "name") String name) {
        service.updateKeyword(personId, keywordId, name);
    }

    @GetMapping(value = "/sites/{siteId}", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public Site getSite(@PathVariable(value = "siteId") int siteId) {
        return service.getSite(siteId);
    }

    @DeleteMapping(value = "/sites/{siteId}")
    public void deleteSite(@PathVariable(value = "siteId") int siteId) {
        service.deleteSite(siteId);
    }

    @PostMapping(value = "/sites", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public int createSite(@RequestParam(value = "name") String name) {
        return service.createSite(name);
    }

    @PutMapping(value = "/sites/{siteId}")
    public void updateSite(@PathVariable(value = "siteId") int siteId, @RequestParam(value = "name") String name) {
        service.updateSite(siteId, name);
    }

    @PostMapping(value = "/signup", consumes = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity registerAdmin(@Valid @RequestBody UserDto userDto, Errors errors) {
        if (errors.hasErrors()) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).contentType(MediaType.APPLICATION_JSON_UTF8)
                    .body(errors.getAllErrors()
                            .stream()
                            .map(x -> x.getDefaultMessage())
                            .collect(Collectors.joining(", ")));
        }
        service.registerAdmin(userDto);
        return ResponseEntity.status(HttpStatus.CREATED).build();
    }

}
