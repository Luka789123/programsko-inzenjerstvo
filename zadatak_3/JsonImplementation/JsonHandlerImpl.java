package JsonImplementation;

import java.util.Map;

import contracts.Handler;
import contracts.Reader;
import java.util.HashMap;

public class JsonHandlerImpl extends Handler {

    public JsonHandlerImpl(Reader reader) {
        super(reader);
    }

    @Override
    protected Map<String, String> translateString() {

        String[] keyValuePairs = getReadString().replaceAll("[{}\"]", "").split(",");

        Map<String, String> map = new HashMap<>();
        for (String pair : keyValuePairs) {
            String[] entry = pair.split(":");
            map.put(entry[0], entry[1]);
        }

        return map;

    }

}
