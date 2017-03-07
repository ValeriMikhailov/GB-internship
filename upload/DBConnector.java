package upload;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

public class DBConnector {

	private final static String url = "jdbc:mysql://DB_host:3306/test";
	private final static String user = "user";
	private final static String password = "password";
	private final static String db = "myDB.mySchema.";
	private static ArrayList<String> siteList = new ArrayList<>();
	private static Connection conn = null;
	private static Statement stmt = null;
	private static ResultSet rs = null;
	
	static {
		try {
			conn = DriverManager.getConnection(url, user, password);
			stmt = conn.createStatement();
			rs = stmt.executeQuery("SELECT * FROM " + db + "Sites");
			while (rs.next()){
				addUrl(rs.getString("url"));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	private static void addUrl(String url){
		if (url.endsWith("/"))siteList.add(url.substring(0, url.length()-1));
		else siteList.add(url);
	}
	public static ArrayList<String> getURLs(){
		return siteList;
	}
}
