package ru.geekbrains.rest.model;

import com.fasterxml.jackson.annotation.JsonFormat;

import java.time.LocalDate;

public class PersonRank {
    private int siteId;
    private String personName;
    private int rank;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate startDate;

    public PersonRank() {
    }

    public PersonRank(int siteId, String personName, int rank, LocalDate date) {
        this.siteId = siteId;
        this.personName = personName;
        this.rank = rank;
        this.startDate = date;
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

    public LocalDate getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDate startDate) {
        this.startDate = startDate;
    }
}
