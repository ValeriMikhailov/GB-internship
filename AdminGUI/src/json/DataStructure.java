package json;

/**
 * Created by Alexey Shein on 15/03/2017.
 * Describing of JSON fields
 */

public class DataStructure {

    private String id;
    private String name;
    private String date;
    private String personName;
    private String count;
    private String countNewPages;

    public DataStructure() {
    }

    public DataStructure(String id, String name, String date, String personName, String count, String countNewPages) {
        this.id = id;
        this.name = name;
        this.date = date;
        this.personName = personName;
        this.count = count;
        this.countNewPages = countNewPages;
    }

    public String getId() {
        return id;
    }

    public String getName() {
        return name;
    }

    public String getDate() {
        return date;
    }

    public String getPersonName() {
        return personName;
    }

    public String getCount() {
        return count;
    }

    public String getCountNewPages() {
        return countNewPages;
    }

    public void setId(String id) {
        this.id = id;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public void setCount(String count) {
        this.count = count;
    }

    public void setCountNewPages(String countNewPages) {
        this.countNewPages = countNewPages;
    }
}
