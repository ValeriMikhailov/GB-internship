package ru.geekbrains.rest.model;

public class PersonRank {
    private int siteId;
    private String personName;
    private int rank;

    public PersonRank() {
    }

    public PersonRank(int siteId, String personName, int rank) {
        this.siteId = siteId;
        this.personName = personName;
        this.rank = rank;
    }

    public int getSiteId() {
        return siteId;
    }

    public void setSiteId(int siteId) {
        this.siteId = siteId;
    }

    public String getPersonName() {
        return personName;
    }

    public void setPersonName(String personName) {
        this.personName = personName;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
