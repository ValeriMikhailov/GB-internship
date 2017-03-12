package ru.geekbrains.dbService.dataSets;

public class Keyword {
    private int id;
    private String name;
    private int personId;

    public Keyword(int id, String name, int personId) {
        this.id = id;
        this.name = name;
        this.personId = personId;
    }

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    public int getPersonId() {
        return personId;
    }

    @Override
    public String toString() {
        return "Keyword{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", personId=" + personId + '}';
    }
}
