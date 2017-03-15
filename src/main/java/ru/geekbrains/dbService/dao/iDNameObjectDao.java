package ru.geekbrains.dbService.dao;

import ru.geekbrains.dbService.Executor;
import ru.geekbrains.dbService.dataSets.DateNewPages;
import ru.geekbrains.dbService.dataSets.PersonSiteRank;
import ru.geekbrains.dbService.dataSets.iDNameObject;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;


public class iDNameObjectDao {
    private Executor executor;

    public iDNameObjectDao(Connection connection) {
        this.executor = new Executor(connection);
    }

    public iDNameObject get(String tableName,String itemId) throws SQLException {
        return executor.execQuery("select * from " + tableName + " where id=" + itemId, result -> {
            result.next();
            return new iDNameObject(result.getInt("id"), result.getString("name"));
        });
    }

    public  ArrayList<iDNameObject> getAll(String tableName) throws SQLException {
        ArrayList<iDNameObject> array = new ArrayList<>();
        return executor.execQuery("select * from " + tableName, result -> {
           while(result.next()) {
               array.add(new iDNameObject(result.getInt("id"), result.getString("name")));
           }
            return array;
        });
    }

    public String insertObject(String tableName , String objectName) throws SQLException {
        executor.execUpdate("insert into " + tableName +" values (null,'" + objectName + "')");
        return executor.execQuery("select id from " + tableName + " where name='" + objectName  + "'", result -> {
            result.next();
            return result.getString("id");
        });
    }

    public void updateObject(String tableName , String id, String objectName) throws SQLException {
        executor.execUpdate("update " + tableName +" set name='" + objectName + "' where id =" + id);
    }

    public void deleteObject(String tableName , String id) throws SQLException {
        executor.execUpdate("delete from " + tableName +" where id =" + id);
    }

    public  ArrayList<iDNameObject> getAll(String tableName, String personId) throws SQLException {
        ArrayList<iDNameObject> array = new ArrayList<>();
        return executor.execQuery("select * from " + tableName + " where personId =" + personId, result -> {
            while(result.next()) {
                array.add(new iDNameObject(result.getInt("id"), result.getString("name")));
            }
            return array;
        });
    }

    public String insertObject(String tableName , String objectName, String personId ) throws SQLException {
        executor.execUpdate("insert into " + tableName +" values (null,'" + objectName + "'," + personId +")");
        return executor.execQuery("select id from " + tableName + " where name='" + objectName  + "'", result -> {
            result.next();
            return result.getString("id");
        });
    }

    public ArrayList<PersonSiteRank> getTotalStatistics(String siteId)throws SQLException{
        ArrayList<PersonSiteRank> array = new ArrayList<>();
        return executor.execQuery("select s.id, p.name, sum(ppr.rank) from persons p" +
                " inner join person_page_rank ppr on p.id=ppr.personId" +
                " inner join pages pg on ppr.pageId=pg.id" +
                " inner join sites s on s.id=pg.siteId where s.id=" + siteId +
                " group by p.name", result -> {
            while(result.next()) {
                array.add(new PersonSiteRank(result.getInt(1),result.getString(2), result.getInt(3)));
            }
            return array;
        });
    }

    public ArrayList<DateNewPages> getEveryDayStatistics(String siteId, String personId,
                                                            String start, String end)throws SQLException{
        ArrayList<DateNewPages> array = new ArrayList<>();
        return executor.execQuery("select pg.foundDateTime, count(*)  from pages pg" +
                " inner join sites s on s.id=pg.siteId inner join person_page_rank ppr on ppr.pageId=pg.id" +
                " inner join persons p on p.id = ppr.personId where (p.id="+ personId + ") and (s.id="+ siteId +
                ") and (pg.FoundDateTime between '"+ start + "' and '" + end + "') group by pg.foundDateTime",
                result -> {
            while(result.next()) {
                array.add(new DateNewPages(result.getString(1), result.getInt(2)));
            }
            return array;
        });
    }
}
