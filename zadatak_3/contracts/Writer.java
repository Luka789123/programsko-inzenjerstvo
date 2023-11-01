package contracts;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Map;

public abstract class Writer {
    private final Handler handler;
    private final File file;

    public Writer(Handler handler, String filePath) {
        this.handler = handler;
        this.file = new File(filePath);
    }

    protected abstract String translateToFormat(Map<String, String> map);

    public void write() {
        final String translatedString = translateToFormat(handler.execute());
        System.out.print("Writing...\n");
        try {
            if (!file.exists()) {
                file.createNewFile();
            }
            if (file.canWrite()) {
                FileWriter fileWriter = new FileWriter(file);
                BufferedWriter bufferedWriter = new BufferedWriter(fileWriter);
                bufferedWriter.write(translatedString);
                bufferedWriter.close();
                System.out.print("Writing to file success!");
            } else {
                throw new IOException("You cannot write to this file!");
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

}
