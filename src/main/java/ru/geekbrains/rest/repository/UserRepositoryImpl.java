package ru.geekbrains.rest.repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.stereotype.Repository;
import ru.geekbrains.rest.model.*;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

@Repository
public class UserRepositoryImpl implements UserRepository {
    static final RowMapper<Person> PERSON_ROW_MAPPER = BeanPropertyRowMapper.newInstance(Person.class);
    static final RowMapper<Site> SITE_ROW_MAPPER = BeanPropertyRowMapper.newInstance(Site.class);

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<PersonRank> getStats(int siteId) {
        List<PersonRank> personRanks = new ArrayList<>();
        SqlRowSet rowSet = jdbcTemplate.queryForRowSet("SELECT pages.siteId, name, sum(rank), DATE(min(foundDateTime)) FROM persons " +
                "INNER JOIN person_page_rank AS ppr ON persons.id=ppr.personId " +
                "INNER JOIN pages ON ppr.pageId=pages.id WHERE pages.siteId=? GROUP BY name", siteId);
        while (rowSet.next()) {
            PersonRank personRank = new PersonRank();
            personRank.setSiteId(rowSet.getInt(1));
            personRank.setPersonName(rowSet.getString(2));
            personRank.setRank(rowSet.getInt(3));
            personRank.setStartDate(rowSet.getDate(4).toLocalDate());
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
            dateRank.setCountNewPages(rowSet.getInt(2));
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

    @Override
    public void registerUser(User user) {
        jdbcTemplate.update("INSERT INTO users (username, password) VALUES (?, ?)", user.getName(), user.getPassword());
        insertRoles(user);
    }

    private void insertRoles(User user) {
        Set<Role> roles = user.getRoles();
        Iterator<Role> iterator = roles.iterator();

        jdbcTemplate.batchUpdate("INSERT INTO user_roles (username, role) VALUES (?, ?)",
                new BatchPreparedStatementSetter() {
                    @Override
                    public void setValues(PreparedStatement ps, int i) throws SQLException {
                        ps.setString(1, user.getName());
                        ps.setString(2, iterator.next().name());
                    }

                    @Override
                    public int getBatchSize() {
                        return roles.size();
                    }
                });
    }
}
