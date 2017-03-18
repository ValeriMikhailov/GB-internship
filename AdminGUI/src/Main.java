import javafx.application.Application;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.fxml.FXMLLoader;
import javafx.scene.Scene;
import javafx.scene.layout.AnchorPane;
import javafx.scene.layout.BorderPane;
import javafx.stage.Stage;
import model.Persons;

import java.io.IOException;

public class Main extends Application {

    private Stage primaryStage;
    private BorderPane rootLayout;
    private ObservableList<Persons> personsData = FXCollections.observableArrayList();
    //private ObservableList<model.Sites> sitesData = FXCollections.observableArrayList();
    //private ObservableList<model.Keywords> keywordsData = FXCollections.observableArrayList();

    public Main() {
        personsData.add(new Persons(1, "Petrov"));
        personsData.add(new Persons(2, "Smirnov"));
        personsData.add(new Persons(3, "Vasilev"));
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        this.primaryStage = primaryStage;
        this.primaryStage.setTitle("AdminGUI");

        initRootLayout();

        showPersons();
    }

    private void initRootLayout() {
        try{
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(Main.class.getResource("views/RootLayout.fxml"));
            rootLayout = loader.load();

            Scene scene = new Scene(rootLayout);
            primaryStage.setScene(scene);
            primaryStage.show();

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public ObservableList<Persons> getPersonsData() {
        return personsData;
    }

    private void showPersons() {
        try {
            FXMLLoader loader = new FXMLLoader();
            loader.setLocation(Main.class.getResource("views/AdminGUI.fxml"));
            AnchorPane Persons = loader.load();

            rootLayout.setCenter(Persons);

            PersonsController controller = loader.getController();
            controller.setMain(this);

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Stage getPrimaryStage(){
        return primaryStage;
    }

    public static void main(String[] args) {
        launch(args);
    }
}
