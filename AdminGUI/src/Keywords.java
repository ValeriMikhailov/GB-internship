import javafx.beans.property.IntegerProperty;
import javafx.beans.property.StringProperty;

/**
 * Created by StrategDZR on 04.03.2017.
 */
@SuppressWarnings("ALL")
class Keywords {
    private IntegerProperty ID;
    private StringProperty name;
    private IntegerProperty PersonsID;

    public Keywords(IntegerProperty ID, StringProperty name, IntegerProperty personsID) {
        this.ID = ID;
        this.name = name;
        PersonsID = personsID;
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

    public int getPersonsID() {
        return PersonsID.get();
    }

    public IntegerProperty personsIDProperty() {
        return PersonsID;
    }

    public void setPersonsID(int personsID) {
        this.PersonsID.set(personsID);
    }
}
