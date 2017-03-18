import json.DataReader;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

/**
 * Created by StrategDZR on 18.03.2017.
 * Tests for DataReader
 */
class DataReaderTest {

    private DataReader dataReader = new DataReader();
    private String result = dataReader.findValueByParameterInJson("{\n" +
            "  \"id\" : \"1\",\n" +
            "  \"name\" : \"name_value\",\n" +
            "  \"date\" : \"some date\",\n" +
            "  \"personName\" : \"Путин\",\n" +
            "  \"count\" : \"count_value\",\n" +
            "  \"countNewPages\" : \"countNewPages_value\"\n" +
            "}", "date");

    @Test
    public void testDataReaderOnCorrectJson() {
        assertEquals(result, "some date");
    }
}