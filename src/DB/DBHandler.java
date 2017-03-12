package DB;

import java.sql.*;

class DBHandler implements DBConnector{
    public static Connection conn = null;
    private static Statement stmt = null;
    static final String JDBC_DRIVER = "com.mysql.jdbc.Driver";
    static final String DB_URL = "jdbc:mysql://localhost:3306/gbrains";

    static final String USER = "root";
    static final String PASS = "351235";

    public DBHandler() { connect(); }

    @Override
    public void connect() {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("Connecting to database...");
            conn = DriverManager.getConnection(DB_URL, USER, PASS);
            stmt = conn.createStatement();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    @Override
    public void disconnect() {
        try {
            conn.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public void query(String newQuery) {
        try {
            stmt.executeUpdate(newQuery);
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
