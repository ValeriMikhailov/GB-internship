import com.google.gson.Gson;

/**
 * Created by Alexey Shein
 * on 15/03/2017.
 * Class for converting JSON into POJO
 */

public class DataReader {

    public static void findParameterInJson(String parameter, String json) {

        Gson gson = new Gson();
        JsonObject jsonObject = new Gson().fromJson(json, JsonObject.class);

        //TODO вытащить из объекта стринг с именем parameter


    }
}

