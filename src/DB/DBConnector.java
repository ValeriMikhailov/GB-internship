package DB;
public interface DBConnector {
    void connect();
    void disconnect();
    void query(String newQuery);
}
