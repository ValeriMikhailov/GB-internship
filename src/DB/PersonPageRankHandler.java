package DB;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;

public class PersonPageRankHandler extends DBHandler {
    private static Statement stmt = null;
    private static PreparedStatement ps;

    public PersonPageRankHandler() {
        super();
        connect();
    }

    public void insert(int rank, String pageUrl) {
        try {
            ps = conn.prepareStatement("INSERT INTO personpagerank VALUES (" +
                    " (select ID from persons where Name = 'Путин'), " +
                    " (select ID from pages where Url = ?), " +
                    "?);");
            ps.setString(1, pageUrl);
            ps.setInt(2, rank);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}

