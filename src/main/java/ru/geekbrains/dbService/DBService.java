package ru.geekbrains.dbService;

import ru.geekbrains.dbService.dao.iDNameObjectDao;
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
        printConnectInfo();
    }

    public void printConnectInfo() throws SQLException{

            StringBuilder infoString = new StringBuilder();
            infoString.append("DB name: " + connection.getMetaData().getDatabaseProductName() + "\n");
            infoString.append("DB version: " + connection.getMetaData().getDatabaseProductVersion() + "\n");
            infoString.append("Driver: " + connection.getMetaData().getDriverName() + "\n");
            infoString.append("Autocommit: " + connection.getAutoCommit() + "\n");
            Main.logger.info(infoString.toString());
    }


    public static Connection getMysqlConnection() throws Exception {
        try {
            DriverManager.registerDriver((Driver) Class.forName("com.mysql.jdbc.Driver").newInstance());

            StringBuilder url = new StringBuilder();

            url.
                    append("jdbc:mysql://").                       //db type
                    append("localhost:").                          //host name
                    append("3306/").                               //port
                    append("gbrains?").                            //db name
                    append("user=remote_brain&").                  //login
                    append("password=JKh9mMdH3EiVCLmf43sF");       //password


            Connection connection = DriverManager.getConnection(url.toString());
            return connection;
        } catch (SQLException | InstantiationException | IllegalAccessException | ClassNotFoundException e) {
            throw new Exception(e);
        }
    }

    @Override
    public ArrayList<PersonSiteRank> getTotalStat(String siteId) {
        try {
            return (new iDNameObjectDao(connection).getTotalStatistics(siteId));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public ArrayList<DateNewPages> getEveryDayStat(String siteId, String personId, String startDate, String endDate) {
        try {
            return (new iDNameObjectDao(connection).getEveryDayStatistics(siteId,personId,startDate,endDate));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public List<iDNameObject> getAllPersons() {
        try {
            return (new iDNameObjectDao(connection).getAll("persons"));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public iDNameObject getPerson(String personId)  {
            try {
                return (new iDNameObjectDao(connection).get("persons",personId));
            } catch (SQLException e) {
                Main.logger.error(e);
            }
            return null;
    }

    @Override
    public String createPerson(String name) {
        try {
            return (new iDNameObjectDao(connection).insertObject("persons",name));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public void updatePerson(String personId, String name) {
        try {
            new iDNameObjectDao(connection).updateObject("persons",personId,name);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }

    @Override
    public void deletePerson(String personId) {
        try {
            new iDNameObjectDao(connection).deleteObject("persons",personId);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }

    @Override
    public List<iDNameObject> getKeywordsByPersonId(String personId) {
        try {
            return (new iDNameObjectDao(connection).getAll("keywords",personId));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public String createKeywordByPersonId(String personId, String name) {
        try {
            return (new iDNameObjectDao(connection).insertObject("keywords",name, personId));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public void updateKeywordByPersonId(String personId, String keywordId, String name) {
        try {
            new iDNameObjectDao(connection).updateObject("keywords",keywordId,name);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }

    @Override
    public void deleteKeywordByPersonId(String personId, String keywordId) {
        try {
            new iDNameObjectDao(connection).deleteObject("keywords",keywordId);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }

    @Override
    public List<iDNameObject> getAllSites() {
        try {
            return (new iDNameObjectDao(connection).getAll("sites"));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public iDNameObject getSite(String siteId) {
        try {
            return (new iDNameObjectDao(connection).get("sites",siteId));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public String createSite(String name) {
        try {
            return (new iDNameObjectDao(connection).insertObject("sites",name));
        } catch (SQLException e) {
            Main.logger.error(e);
        }
        return null;
    }

    @Override
    public void updateSite(String siteId, String siteName) {
        try {
             new iDNameObjectDao(connection).updateObject("sites",siteId,siteName);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }

    @Override
    public void deleteSite(String siteId) {
        try {
            new iDNameObjectDao(connection).deleteObject("sites",siteId);
        } catch (SQLException e) {
            Main.logger.error(e);
        }
    }
}
