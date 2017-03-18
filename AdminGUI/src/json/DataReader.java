package json;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

/**
 * Created by Alexey Shein
 * on 15/03/2017.
 * Class for converting JSON into POJO(DataStructure)
 */

public class DataReader {

    public DataReader() {
    }

    private static String findValueByParameterInJson(String response, String parameter) {
        JsonParser parser = new JsonParser();
        JsonObject obj = parser.parse(response).getAsJsonObject();
        return obj.get(parameter).getAsString();

    }
}