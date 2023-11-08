package JsonImplementation;

import java.util.Map;

import contracts.Handler;
import contracts.Writer;

public class JsonWriter extends Writer {

    public JsonWriter(Handler handler, String filePath) {
        super(handler, filePath);
    }

    @Override
    protected String translateToFormat(Map<String, String> map) {
        StringBuilder stringBuilder = new StringBuilder();
        stringBuilder.append("{");

        for (Map.Entry<String, String> entry : map.entrySet()) {
            if (stringBuilder.length() > 1) {
                stringBuilder.append(",");
            }
            stringBuilder.append("\"")
                    .append(entry.getKey())
                    .append("\":\"")
                    .append(entry.getValue())
                    .append("\"");
        }

        stringBuilder.append("}");
        String jsonString = stringBuilder.toString();

        return jsonString;
    }

}
