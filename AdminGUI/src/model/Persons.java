package model;

import javafx.beans.property.IntegerProperty;
import javafx.beans.property.SimpleIntegerProperty;
import javafx.beans.property.SimpleStringProperty;
import javafx.beans.property.StringProperty;

/**
 * Created by Alexey Shein on 04.03.2017.
 */

@SuppressWarnings("ALL")
public class Persons {
    private static IntegerProperty ID;
    private static StringProperty name;

    public Persons(int ID, String name) {
        this.ID = new SimpleIntegerProperty(ID);
        this.name = new SimpleStringProperty(name);
    }

    public static int getId() {
        return ID.get();
    }

    public void setId(int ID) {
        this.ID.set(ID);
    }

    public IntegerProperty IdProperty() {
        return ID;
    }

    public static String getName() {
        return name.get();
    }

    public StringProperty nameProperty() {
        return name;
    }

    public void setName(String name) {
        this.name.set(name);
    }
}
