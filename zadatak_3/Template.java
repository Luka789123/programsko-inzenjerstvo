import XmlImplementation.XmlHandler;
import XmlImplementation.XmlWriter;
import contracts.Handler;
import contracts.Reader;
import contracts.Writer;

public class Template {

    public static void main(String args[]) {
        Reader reader = new ReaderImpl("test.xml");
        Handler handler = new XmlHandler(reader);
        Writer writer = new XmlWriter(handler, "test.xml");
        writer.write();
    }

}
