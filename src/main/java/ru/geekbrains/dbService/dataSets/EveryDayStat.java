package ru.geekbrains.dbService.dataSets;

import java.util.Date;

public class EveryDayStat {
    private int personId;
    private String personName;
    private int siteId;
    private String siteName;
    private Date foundDate;
    private int quantaty;


    public EveryDayStat(int personId, String personName, int siteId, String siteName, Date foundDate, int quantaty) {
        this.personId = personId;
        this.personName = personName;
        this.siteId = siteId;
        this.siteName = siteName;
        this.foundDate = foundDate;
        this.quantaty = quantaty;
    }

    public int getPersonId() {
        return personId;
    }

    public int getSiteId() {
        return siteId;
    }

    public String getPersonName() {
        return personName;
    }

    public String getSiteName() {
        return siteName;
    }

    public Date getFoundDate() {
        return foundDate;
    }

    public int getQuantaty() {
        return quantaty;
    }

    @Override
    public String toString() {
        return "EveryDayStat{" +
                "personId=" + personId +
                "personName=" + personName +
                ", siteId=" + siteId +
                ", siteName=" + siteName +
                ", Date=" + foundDate +
                ", quantaty=" + quantaty +'}';
    }
}
