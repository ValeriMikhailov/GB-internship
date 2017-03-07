package util;

import org.joda.time.DateTime;

public class LinkDate {
	public static String getLinkDate(String date){
		return DateTime.parse(date).toString("yyyymmdd");
	}
}
