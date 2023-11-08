import JsonImplementation.JsonHandlerImpl;
import JsonImplementation.JsonWriter;
import XmlImplementation.XmlHandler;
import XmlImplementation.XmlWriter;
import contracts.Handler;
import contracts.Reader;
import contracts.Writer;

public class Template {

    public static void main(String args[]) {
        Reader reader = new ReaderImpl("json_dataset.json");
        Handler handler = new JsonHandlerImpl(reader);
        Writer writer = new JsonWriter(handler, "json_dataset.json");
        writer.write();
    }

}
