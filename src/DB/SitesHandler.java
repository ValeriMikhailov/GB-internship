package DB;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class SitesHandler extends  DBHandler {
    private static PreparedStatement ps;

    public SitesHandler() {
        super();
        connect();
    }

    public void insert(String siteName) {
        try {
            ps = conn.prepareStatement("INSERT INTO sites (id, Name) VALUES (null, ?)");
            ps.setString(1, siteName);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
