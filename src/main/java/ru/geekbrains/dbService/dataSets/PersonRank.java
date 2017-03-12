package ru.geekbrains.dbService.dataSets;

public class PersonRank {
    private int siteId;
    private String personName;
    private int rank;

    public PersonRank(int siteId, String name, int rank) {
        this.siteId = siteId;
        this.personName = name;
        this.rank = rank;
    }

    public int getSiteId() {
        return siteId;
    }

    public String getName() {
        return personName;
    }

    public int getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return "PersonRank{" +
                "personId=" + siteId +
                ", name=" + personName +
                ", rank=" + rank + '}';
    }
}

