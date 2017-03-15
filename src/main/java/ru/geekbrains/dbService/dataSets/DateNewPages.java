package ru.geekbrains.dbService.dataSets;

import java.util.Date;

public class DateNewPages {
    private String date;
    private int countNewPages;

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getCountNewPages() {
        return countNewPages;
    }

    public void setCountNewPages(int countNewPages) {
        this.countNewPages = countNewPages;
    }

    public DateNewPages(String date, int countNewPages) {
        this.date = date;
        this.countNewPages = countNewPages;
    }

    @Override
    public String toString() {
        return "DateNewPages{" +
                "date=" + date +
                ", countNewPages=" + countNewPages + '}';
    }
}
