package ru.geekbrains.rest.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.support.DataAccessUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.Keyword;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.Site;

import javax.sql.DataSource;
import java.util.*;

import static ru.geekbrains.rest.repository.UserRepositoryImpl.*;

@Repository
public class AdminRepositoryImpl implements AdminRepository {
    private static final RowMapper<Keyword> KEYWORD_ROW_MAPPER = BeanPropertyRowMapper.newInstance(Keyword.class);

    @Autowired
    private NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    private JdbcTemplate jdbcTemplate;

    private SimpleJdbcInsert personInsert;
    private SimpleJdbcInsert siteInsert;
    private SimpleJdbcInsert keywordInsert;

    @Autowired
    public AdminRepositoryImpl(DataSource dataSource) {
        this.personInsert = new SimpleJdbcInsert(dataSource).withTableName("persons").usingGeneratedKeyColumns("id");
        this.siteInsert = new SimpleJdbcInsert(dataSource).withTableName("sites").usingGeneratedKeyColumns("id");
        this.keywordInsert = new SimpleJdbcInsert(dataSource).withTableName("keywords").usingGeneratedKeyColumns("id");
    }

    @Override
    public int createPerson(String name) {
        Map<String, String> map = new HashMap<>();
        map.put("name", name);
        Number newKey = personInsert.executeAndReturnKey(map);
        return newKey.intValue();
    }

    @Override
    public void updatePerson(int personId, String name) {
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("personId", personId);
        parameterSource.addValue("name", name);
        namedParameterJdbcTemplate.update("UPDATE persons SET name=:name WHERE id=:personId", parameterSource);
    }

    @Override
    public Person getPerson(int personId) {
        List<Person> persons = jdbcTemplate.query("SELECT * FROM persons WHERE id=?", PERSON_ROW_MAPPER, personId);
        return DataAccessUtils.singleResult(persons);
    }

    @Override
    public void deletePerson(int personId) {
        jdbcTemplate.update("DELETE FROM persons WHERE id=?", personId);
    }

    @Override
    public List<Keyword> getKeywords(int personId) {
        return jdbcTemplate.query("SELECT id, name FROM keywords WHERE personId=?", KEYWORD_ROW_MAPPER, personId);
    }

    @Override
    public int createKeyword(int personId, String name) {
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("personId", personId);
        parameterSource.addValue("name", name);
        Number newKey = keywordInsert.executeAndReturnKey(parameterSource);
        return newKey.intValue();
    }

    @Override
    public void updateKeyword(int personId, int keywordId, String name) {
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("keywordId", keywordId);
        parameterSource.addValue("personId", personId);
        parameterSource.addValue("name", name);
        namedParameterJdbcTemplate.update("UPDATE keywords SET name=:name WHERE id=:keywordId AND personId=:personId", parameterSource);
    }

    @Override
    public void deleteKeyword(int personId, int keywordId) {
        jdbcTemplate.update("DELETE FROM keywords WHERE personId=? AND id=?", personId, keywordId);
    }

    @Override
    public Site getSite(int siteId) {
        List<Site> sites = jdbcTemplate.query("SELECT * FROM sites WHERE id=?", SITE_ROW_MAPPER, siteId);
        return DataAccessUtils.singleResult(sites);
    }

    @Override
    public int createSite(String name) {
        Map<String, String> map = new HashMap<>();
        map.put("name", name);
        Number newKey = siteInsert.executeAndReturnKey(map);
        return newKey.intValue();
    }

    @Override
    public void updateSite(int siteId, String name) {
        MapSqlParameterSource parameterSource = new MapSqlParameterSource();
        parameterSource.addValue("siteId", siteId);
        parameterSource.addValue("name", name);
        namedParameterJdbcTemplate.update("UPDATE sites SET name=:name WHERE id=:siteId", parameterSource);
    }

    @Override
    public void deleteSite(int siteId) {
        jdbcTemplate.update("DELETE FROM sites WHERE id=?", siteId);
    }
}
