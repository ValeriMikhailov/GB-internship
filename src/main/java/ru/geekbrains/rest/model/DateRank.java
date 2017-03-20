package ru.geekbrains.rest.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

public class DateRank {

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    private int countNewPages;

    public DateRank() {
    }

    public DateRank(LocalDate date, int rank) {
        this.date = date;
        this.countNewPages = rank;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getCountNewPages() {
        return countNewPages;
    }

    public void setCountNewPages(int countNewPages) {
        this.countNewPages = countNewPages;
    }
}
