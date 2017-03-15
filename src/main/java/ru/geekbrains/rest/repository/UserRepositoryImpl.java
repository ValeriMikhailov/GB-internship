package ru.geekbrains.rest.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.DateRank;
import ru.geekbrains.rest.model.Person;
import ru.geekbrains.rest.model.PersonRank;
import ru.geekbrains.rest.model.Site;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Repository
public class UserRepositoryImpl implements UserRepository {
    static final RowMapper<Person> PERSON_ROW_MAPPER = BeanPropertyRowMapper.newInstance(Person.class);
    static final RowMapper<Site> SITE_ROW_MAPPER = BeanPropertyRowMapper.newInstance(Site.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<PersonRank> getStats(int siteId) {
        List<PersonRank> personRanks = new ArrayList<>();
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet("SELECT pages.siteId, name, sum(rank) FROM persons " +
                "INNER JOIN person_page_rank AS ppr ON persons.id=ppr.personId " +
                "INNER JOIN pages ON ppr.pageId=pages.id WHERE pages.siteId=? GROUP BY name", siteId);
        while (rowSet.next()) {
            PersonRank personRank = new PersonRank();
            personRank.setSiteId(rowSet.getInt(1));
            personRank.setPersonName(rowSet.getString(2));
            personRank.setRank(rowSet.getInt(3));
            personRanks.add(personRank);
        }
        return personRanks;
    }

    @Override
    public List<DateRank> statsByDate(int siteId, int personId, LocalDate start, LocalDate end) {
        List<DateRank> dateRanks = new ArrayList<>();
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet("SELECT DATE(foundDateTime), COUNT(*) FROM pages " +
                "INNER JOIN sites ON pages.siteId=sites.id " +
                "INNER JOIN person_page_rank AS ppr ON ppr.pageId=pages.id " +
                "INNER JOIN persons ON ppr.personId=persons.id " +
                "WHERE sites.id=? AND persons.id=? AND DATE(foundDateTime) BETWEEN ? AND ? " +
                "GROUP BY DATE(foundDateTime);", siteId, personId, start, end);
        while (rowSet.next()) {
            DateRank dateRank = new DateRank();
            dateRank.setDate(rowSet.getDate(1).toLocalDate());
            dateRank.setRank(rowSet.getInt(2));
            dateRanks.add(dateRank);
        }
        return dateRanks;
    }

    @Override
    public List<Person> getPersons() {
        return jdbcTemplate.query("SELECT * FROM persons", PERSON_ROW_MAPPER);
    }

    @Override
    public List<Site> getSites() {
        return jdbcTemplate.query("SELECT * FROM sites", SITE_ROW_MAPPER);
    }
}
