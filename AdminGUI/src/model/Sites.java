package model;

import javafx.beans.property.IntegerProperty;
import javafx.beans.property.StringProperty;

/**
 * Created by Alexey Shein on 04.03.2017.
 */
@SuppressWarnings("ALL")
public class Sites {
    private IntegerProperty ID;
    private StringProperty name;

    public Sites(IntegerProperty ID, StringProperty name) {
        this.ID = ID;
        this.name = name;
    }

    public int getID() {
        return ID.get();
    }

    public IntegerProperty IDProperty() {
        return ID;
    }

    public void setID(int ID) {
        this.ID.set(ID);
    }

    public String getName() {
        return name.get();
    }

    public StringProperty nameProperty() {
        return name;
    }

    public void setName(String name) {
        this.name.set(name);
    }
}
