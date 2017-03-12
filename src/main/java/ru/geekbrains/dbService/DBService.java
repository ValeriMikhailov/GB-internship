package ru.geekbrains.dbService;

import ru.geekbrains.dbService.dataSets.*;
import ru.geekbrains.main.Main;

import java.sql.Connection;
import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class DBService implements Repository {
    private final Connection connection;

    public DBService() throws Exception{
        this.connection = getMysqlConnection();
    }

    public void printConnectInfo() throws SQLException{

            StringBuilder infoString = new StringBuilder();
            infoString.append("DB name: " + connection.getMetaData().getDatabaseProductName() + "\n");
            infoString.append("DB version: " + connection.getMetaData().getDatabaseProductVersion() + "\n");
            infoString.append("Driver: " + connection.getMetaData().getDriverName() + "\n");
            infoString.append("Autocommit: " + connection.getAutoCommit() + "\n");
            Main.logger.info(infoString.toString());
    }

    @SuppressWarnings("UnusedDeclaration")
    public static Connection getMysqlConnection() throws Exception {
        try {
            DriverManager.registerDriver((Driver) Class.forName("com.mysql.jdbc.Driver").newInstance());

            StringBuilder url = new StringBuilder();

            url.
                    append("jdbc:mysql://").        //db type
                    append("localhost:").           //host name
                    append("3306/").                //port
                    append("db_example?").          //db name
                    append("user=tully&").          //login
                    append("password=tully");       //password

            System.out.println("URL: " + url + "\n");

            Connection connection = DriverManager.getConnection(url.toString());
            return connection;
        } catch (SQLException | InstantiationException | IllegalAccessException | ClassNotFoundException e) {
            throw new Exception(e);
        }
    }

    @Override
    public ArrayList<EveryDayStat> getEveryDayStat(int siteId, int personId, Date start, Date end) {
        return null;
    }

    @Override
    public ArrayList<PersonRank> getTotalStat(int siteId) {
        return null;
    }

    @Override
    public boolean createPerson(Person person) {
        return false;
    }

    @Override
    public List<Person> getAllPersons() {
        return null;
    }

    @Override
    public boolean updatePerson(int personId, Person newPersonData) {
        return false;
    }

    @Override
    public Person getPerson(int personId) {
        return null;
    }

    @Override
    public boolean deletePerson(int personId) {
        return false;
    }

    @Override
    public List<Keyword> getKeywordsByPersonId(int personId) {
        return null;
    }

    @Override
    public boolean createKeywordByPersonId(int personId, Keyword keyword) {
        return false;
    }

    @Override
    public boolean updateKeywordByPersonId(int personId, int keywordId, Keyword newKeyword) {
        return false;
    }

    @Override
    public boolean deleteKeywordByPersonId(int personId, int keywordId) {
        return false;
    }

    @Override
    public boolean createSite(Site site) {
        return false;
    }

    @Override
    public boolean updateSite(int siteId, Site newDataSite) {
        return false;
    }

    @Override
    public Site getSite(int siteId) {
        return null;
    }

    @Override
    public boolean deleteSite(int siteId) {
        return false;
    }

    @Override
    public List<Site> getAllSites() {
        return null;
    }
}
