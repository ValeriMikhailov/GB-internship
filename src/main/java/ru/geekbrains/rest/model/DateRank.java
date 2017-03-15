package ru.geekbrains.rest.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

public class DateRank {

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    private int rank;

    public DateRank() {
    }

    public DateRank(LocalDate date, int rank) {
        this.date = date;
        this.rank = rank;
    }

    public LocalDate getDate() {
        return date;
    }

    public void setDate(LocalDate date) {
        this.date = date;
    }

    public int getRank() {
        return rank;
    }

    public void setRank(int rank) {
        this.rank = rank;
    }
}
