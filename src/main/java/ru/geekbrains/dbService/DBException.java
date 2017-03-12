package ru.geekbrains.dbService;

public class DBException extends Exception {
    public DBException(Throwable throwable) {
        super(throwable);
    }
}
