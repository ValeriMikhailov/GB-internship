package DB;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class PagesHandler extends DBHandler {
    private static PreparedStatement ps;

    public void insert(String url) {
        try {
            ps = conn.prepareStatement("INSERT INTO pages VALUES (null, ?, ?, null, " +
                    "(select ID from sites where Name = 'somewhere1.com'));");
            ps.setString(1, url);
            ps.setString(2, getCurrentDate());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void changeLastScanDate(String newLastScanDate) {
        try {
            ps = conn.prepareStatement("update pages set LastScanDate = ?;");
            ps.setString(1, newLastScanDate);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private static String getCurrentDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("dd.mm.yy HH:mm:ss");
        return sdf.format(new Date());
    }
}

