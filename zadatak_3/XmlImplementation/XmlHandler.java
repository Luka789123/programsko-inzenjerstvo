package XmlImplementation;

import java.io.ByteArrayInputStream;
import java.util.HashMap;
import java.util.Map;
import org.w3c.dom.Document;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import contracts.Handler;
import contracts.Reader;

import org.w3c.dom.Element;

public class XmlHandler extends Handler {

    public XmlHandler(Reader reader) {
        super(reader);
    }

    @Override
    protected Map<String, String> translateString() {
        try {
            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            if (getReadString().isEmpty() || getReadString().isBlank()) {
                return new HashMap<String, String>();
            }

            Document document = builder.parse(new ByteArrayInputStream(getReadString().getBytes()));

            Element root = document.getDocumentElement();
            Map<String, String> translatedMap = new HashMap<String, String>();
            NodeList nodeList = root.getChildNodes();

            for (int i = 0; i < nodeList.getLength(); i++) {
                Node node = nodeList.item(i);
                if (node.getNodeType() == Node.ELEMENT_NODE) {
                    Element element = (Element) node;
                    String key = element.getNodeName();
                    translatedMap.put(key, element.getTextContent());
                }
            }

            return translatedMap;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return new HashMap<>();
    }

}
