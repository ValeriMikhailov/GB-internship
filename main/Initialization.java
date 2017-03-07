package main;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;

import download.Downloader;
import queues.ForParsing;
import queues.ForUpload;
import sources.Site;
import sources.storages.URLStorage;
import upload.DBConnector;

public class Initialization {
	public static ForParsing parsQueue;
	public static ForUpload uploadQueue;
	private File config = new File("crawler.properties");
	private BufferedReader br;
	private URLStorage urls = new URLStorage();
	private Downloader dw;
	private Thread dwThread;
	
	public Initialization() {
		parsQueue = new ForParsing();
		uploadQueue = new ForUpload();
		for (String url : DBConnector.getURLs()){
			urls.listURLs.add(new Site(url));
		}
		dw = new Downloader(urls);
		dwThread = new Thread(dw);
		dwThread.start();
	}
	
}
