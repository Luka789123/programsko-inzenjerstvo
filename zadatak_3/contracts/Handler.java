package contracts;

import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public abstract class Handler {
    private final Reader reader;

    public Handler(Reader reader) {
        this.reader = reader;
    }

    public String getReadString() {
        return reader.getData();
    }

    private Map<String, String> dataToManipulate = new HashMap<String, String>();

    protected abstract Map<String, String> translateString();

    public Map<String, String> execute() {
        dataToManipulate = translateString();
        dataToManipulate = manipulateData(dataToManipulate);
        return dataToManipulate;
    }

    private Map<String, String> manipulateData(Map<String, String> data) {
        System.out.print("Please input some data:\n");
        Scanner scanner = new Scanner(System.in);
        String note = "";
        int i = 0;
        while (true) {
            note = scanner.nextLine();
            if (note.isBlank()) {
                break;
            }
            data.put("data" + i, note);
            i++;
        }
        scanner.close();
        return data;
    }

}
