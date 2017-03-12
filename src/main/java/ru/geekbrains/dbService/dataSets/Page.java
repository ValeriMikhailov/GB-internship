package ru.geekbrains.dbService.dataSets;

import java.util.Date;

public class Page {
    private int id;
    private String url;
    private int siteId;
    private Date foundDateTime;
    private Date lastScanDate;

    public Page(int id, String url, int siteId,
        Date foundDateTime, Date lastScanDate) {
        this.id = id;
        this.url = url;
        this.siteId = siteId;
        this.foundDateTime = foundDateTime;
        this.lastScanDate = lastScanDate;
    }

    public int getId() {
        return id;
    }

    public String getUrl() {
        return url;
    }

    public int getSiteId() {
        return siteId;
    }


    public Date getFoundDateTime(){
        return foundDateTime;
    }

    public Date getLastScanDate(){
        return lastScanDate;
    }

    @Override
    public String toString() {
        return "Page{" +
                "id=" + id +
                ", url='" + url + '\'' +
                ", foundDateTime: " + foundDateTime +
                ", lastScanDate: " + lastScanDate + '}';
    }
}
