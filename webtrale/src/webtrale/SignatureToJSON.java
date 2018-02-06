package webtrale;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Scanner;

/**
 *
 * @author Niko
 */
public class SignatureToJSON {
    
    public static int NUM_WHITESPACES_FOR_INDENT = 3;

    public static String SIGNATURE = "signature";

    public static void main(String[] args) throws FileNotFoundException, IOException {
        SignatureToJSON s = new SignatureToJSON();
        String json = s.getJSONFromSignature(SIGNATURE);
        System.out.println(json);
    }
    
    
    public String getJSONFromSignature(String signatureFile) throws FileNotFoundException {
        Scanner s = new Scanner(new File(signatureFile));
        ArrayList<HashMap<String, Integer>> lines = new ArrayList<HashMap<String, Integer>>();
        while (s.hasNextLine()) {
            String aLine = s.nextLine();
            if (aLine.trim().length() > 0 && !aLine.trim().equals(".")) {
                int indent = 0;
                for (int c = 0; c < aLine.length(); c++) {
                    if (aLine.charAt(c) == ' ') {
                        indent++;
                    } else {
                        break;
                    }
                }
                String type;
                if (aLine.trim().contains(" ")) {
                    type = aLine.trim().substring(0, aLine.trim().indexOf(" "));
                } else {
                    type = aLine.trim();
                }
                HashMap<String, Integer> m = new HashMap<>();
                m.put(type, indent);
                lines.add(m);
                
            }
        }
        s.close();

        
        StringBuilder json = new StringBuilder();
        
        int lastIndent = 0;
        // Skip the first type "type_hierarchy".
        for (int l = 1; l < lines.size(); l++) {
            HashMap<String, Integer> m = lines.get(l);
            String typeCur = getType(m);
            int indentCur = getIndent(m);

            if (indentCur > lastIndent) {
                json.append(",\"children\": [{\"name\": \"" + typeCur + "\", \"typeNumber\": " + l + "\n");
            }
            if (indentCur < lastIndent) {
                // TODO: Check how often and close as many ]} brackets.
                int numBracketsToClose = (lastIndent - indentCur) / NUM_WHITESPACES_FOR_INDENT;
                json.append("} ");
                for(int i = 0; i < numBracketsToClose; i++) json.append(" ]} ");
                json.append(", {\"name\": \"" + typeCur + "\", \"typeNumber\": " + l + "\n");
            }
            if (indentCur == lastIndent) {
                // They are on the same level.
                json.append("}, {\"name\": \"" + typeCur + "\", \"typeNumber\": " + l + "\n");
            }

            lastIndent = indentCur;

        }
        
        // close JSON!
        json.append("} ");
        int numBracketsToClose = lastIndent / NUM_WHITESPACES_FOR_INDENT;
        for(int i = 0; i < numBracketsToClose; i++) json.append(" ]} ");

        String jsonString = json.toString().substring(3).trim();
        //System.out.println(jsonString);
        return jsonString.replace("\n", "");
    }

    private static String getType(HashMap<String, Integer> m) {
        for (String k : m.keySet()) {
            return k;
        }
        return "nulli";
    }

    private static int getIndent(HashMap<String, Integer> m) {
        for (int k : m.values()) {
            return k;
        }
        return -1;
    }
}
