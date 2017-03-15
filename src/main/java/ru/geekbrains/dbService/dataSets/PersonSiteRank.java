package ru.geekbrains.dbService.dataSets;

public class PersonSiteRank {
    private int siteId;
    private String personName;
    private int rank;

    public PersonSiteRank(int siteId, String personName, int rank) {
        this.siteId = siteId;
        this.personName = personName;
        this.rank = rank;
    }

    public int getSiteId() {
        return siteId;
    }

    public String getPersonName() {
        return personName;
    }

    public int getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return "PersonSiteRank{" +
                "siteId=" + siteId +
                ", personName=" + personName  +
                ", rank=" + rank + '}';
    }
}
