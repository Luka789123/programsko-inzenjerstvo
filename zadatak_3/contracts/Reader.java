package contracts;

import java.io.IOException;

public abstract class Reader {
    private final String filePath;

    public Reader(String filePath) {
        this.filePath = filePath;
    }

    protected abstract String read() throws IOException;

    public String getData() {
        System.out.print("Reading...\n");
        String readData = "";
        try {
            readData = read();

        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.print("Read Success!\n");
        return readData;
    }

}
