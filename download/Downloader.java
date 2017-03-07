package download;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;

import main.Initialization;
import sources.Pages;
import sources.Site;
import sources.storages.URLStorage;

public class Downloader implements Runnable{
	
	private URLStorage urls;
	private BufferedReader br;
	private Pages pages;
	
	public Downloader(URLStorage urls) {
		this.urls = urls;		
	}
	
	@Override
	public void run() {
		
		for (Site site : urls.listURLs) {
			try {
				URL url = new URL(site.getSiteURL());
				
				InputStream is = url.openStream();
				br = new BufferedReader(new InputStreamReader(is, "UTF8"));
				pages = new Pages();
				for (String respString; (respString = br.readLine()) != null;){
					pages.add(respString);
				}
				Initialization.parsQueue.add(pages);
			} catch (MalformedURLException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		}
	}
	
}
