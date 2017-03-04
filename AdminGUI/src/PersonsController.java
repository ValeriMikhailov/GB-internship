import javafx.fxml.FXML;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;


public class PersonsController {
    @FXML
    private TableView<Persons> personsTable;
    @FXML
    private TableColumn<Persons, Integer> idColumn;
    @FXML
    private TableColumn<Persons, String> nameColumn;

    public PersonsController(){
    }

    @FXML
    public void initialize(){
        idColumn.setCellValueFactory(cellData -> cellData.getValue().IdProperty().asObject());
        nameColumn.setCellValueFactory(cellData -> cellData.getValue().nameProperty());
    }

    public void setMain(Main main){
        Main main1 = main;
        personsTable.setItems(main.getPersonsData());
    }


}
