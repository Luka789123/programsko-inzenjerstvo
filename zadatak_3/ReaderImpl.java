import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;

import contracts.Reader;

public class ReaderImpl extends Reader {
    final private File file;

    public ReaderImpl(String filePath) {
        super(filePath);
        file = new File(filePath);

    }

    @Override
    protected String read() throws IOException, FileNotFoundException {
        FileReader fileReader = new FileReader(file);
        BufferedReader reader = new BufferedReader(fileReader);
        if (file.exists() && file.canRead()) {
            String line = "";
            String data = "";
            while ((line = reader.readLine()) != null) {
                data += line;
            }
            reader.close();
            return data;
        }
        file.createNewFile();
        reader.close();
        throw new IOException("File cannot be found or read!");

    }

}
