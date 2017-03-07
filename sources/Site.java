package sources;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

public class Site {
	
	private String siteURL;
	private ArrayList<String> allows;
	private ArrayList<String> disallows;
	public boolean robots;
	public boolean sitemap;
	
	public Site(String siteURL) {
		this.siteURL = siteURL;
		try {
			robot();
			siteMap();
		} catch (IOException e) {
			if (e.getMessage().equals("Not Found")) robots = false;
			else e.printStackTrace();
		}
	}
	
	public String getSiteURL() {
		return siteURL;
	}
	
	public void robot() throws IOException{
		
		URL url = new URL(siteURL + "robots.txt");
		BufferedReader br = new BufferedReader(new InputStreamReader(url.openStream(), "UTF8"));
		
		if (br.readLine().equals("Not Found"))
			throw new IOException("Not Found");
		
		robots = true;
		for (String respString; (respString = br.readLine()) != null;){
			if (respString.startsWith("User"))
				if (!respString.split(" ")[1].equals("*")) continue;
				else {
					String uaRule;
					while ((uaRule = br.readLine()) != null && !uaRule.equals(System.getProperty("line.separator"))){
						if (uaRule.startsWith("Allow: "))allows.add(uaRule.split(" ")[1]);
						if (uaRule.startsWith("Disallow: "))disallows.add(uaRule.split(" ")[1]);
					}					
				}
		}
	}
	
	public void siteMap() throws IOException{
		System.out.println("Заглушка");
		sitemap = false;
	}
}
