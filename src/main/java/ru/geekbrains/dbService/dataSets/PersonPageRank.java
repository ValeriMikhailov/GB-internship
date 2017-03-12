package ru.geekbrains.dbService.dataSets;

public class PersonPageRank {
    private int personId;
    private int pageId;
    private int rank;

    public PersonPageRank(int personId, int pageId, int rank) {
        this.personId = personId;
        this.pageId = pageId;
        this.rank = rank;
    }

    public int getPersonId() {
        return personId;
    }

    public int getPageId() {
        return pageId;
    }

    public int getRank() {
        return rank;
    }

    @Override
    public String toString() {
        return "PersonPageRank{" +
                "personId=" + personId +
                ", pageId=" + pageId  +
                ", rank=" + rank + '}';
    }
}
