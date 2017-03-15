/**
 * Created by Alexey Shein on 15/03/2017.
 * Describing of JSON fields
 */

public class JsonElement {

    private String id;
    private String name;
    private String date;
    private String personName;
    private String count;
    private String countNewPages;

//TODO http://stackoverflow.com/questions/443499/convert-json-to-map

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

//    void set(String parameter, String newValue);
//    void get(String parameter);
//    void find(String parameter);

}
