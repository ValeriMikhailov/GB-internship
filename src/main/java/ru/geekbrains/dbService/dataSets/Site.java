package ru.geekbrains.dbService.dataSets;

public class Site {
    private int id;
    private String name;

    public Site(int id, String name) {
        this.id = id;
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public int getId() {
        return id;
    }

    @Override
    public String toString() {
        return "Site{" +
                "id=" + id +
                ", name='" + name + '\'' + '}';
    }
}
