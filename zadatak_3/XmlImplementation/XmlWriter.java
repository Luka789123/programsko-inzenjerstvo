package XmlImplementation;

import java.util.Map;
import contracts.Handler;
import contracts.Writer;

public class XmlWriter extends Writer {

    public XmlWriter(Handler handler, String filePath) {
        super(handler, filePath);
    }

    @Override
    protected String translateToFormat(Map<String, String> data) {

        StringBuilder xmlString = new StringBuilder();
        xmlString.append("<root>");
        for (String key : data.keySet()) {
            xmlString.append("<").append(key).append(">").append(data.get(key)).append("</").append(key)
                    .append(">");
        }
        xmlString.append("</root>");
        return xmlString.toString();

    }

}
