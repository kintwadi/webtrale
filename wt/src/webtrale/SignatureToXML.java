package webtrale;

import java.io.File;
import java.io.FileNotFoundException;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.Scanner;

/**
 *
 * @author Niko
 */
public class SignatureToXML {
    
    public static String SIGNATURE = "signature";
    
    public static void main(String[] args) throws FileNotFoundException {
        
        SignatureToXML r = new SignatureToXML();
        String xml = r.getSignatureXML(SIGNATURE);
        System.out.println(xml);
        
    }
    
    public String getSignatureXML(String aSignatureFile) throws FileNotFoundException {
        
        ArrayList<String> lines = new ArrayList<String>();
        Scanner s = new Scanner(new File(aSignatureFile));
        while (s.hasNextLine()) {
            String aLine = s.nextLine();
            int indent = 0;
            for (int c = 0; c < aLine.length(); c++) {
                if (aLine.charAt(c) == ' ') {
                    indent++;
                } else {
                    break;
                }
            }
            String toAdd = indent + "<->" + aLine.trim();
            // Replace optional comments.
            if(toAdd.contains("%")) {
                int indexOfComment = toAdd.indexOf("%");
                toAdd = toAdd.substring(0, indexOfComment).trim();
            }
            if (aLine.trim().length() > 0 && !aLine.trim().equals(".")) {
                //System.out.println(toAdd);
                // Workaround to ignore those items which start with a "&"
                // Needs to be removed in JSON as well!
                lines.add(toAdd);
                
            }
        }
        s.close();
        
        for (int l = 0; l < lines.size(); l++) {
            String aLine = lines.get(l);
            int currentIndent = Integer.parseInt(aLine.substring(0, aLine.indexOf("<->")));
            // 
            if (aLine.trim().contains(" ")) {
                // Get feature:value pairs.
                String featvals = aLine.trim().substring(aLine.trim().indexOf(" ")).trim();
                // Add this fvp line to all child noded.
                for (int k = l + 1; k < lines.size(); k++) {
                    String nextLine = lines.get(k);
                    //System.out.println("next line: " + nextLine);
                    // get indentation.
                    int nextIndent = Integer.parseInt(nextLine.substring(0, nextLine.indexOf("<->")));
                    if (nextIndent > currentIndent) {
                        if (!nextLine.contains(featvals)) {
                            nextLine = nextLine + " " + featvals;
                            lines.set(k, nextLine);
                        }
                    }
                    if (nextIndent == currentIndent) {
                        //System.out.println("breaking.");
                        break;
                    }
                }
            }
        }

        // Remove duplicates.
        LinkedHashMap<Integer, LinkedHashMap<String, LinkedHashSet<String>>> oneLineInSignatureToTypeToFeatvalsMap = new LinkedHashMap<>();
        int idx = 0; // line num in the signature file.
        for (String l : lines) {
            //System.out.println(l);
            LinkedHashMap<String, LinkedHashSet<String>> m = new LinkedHashMap<>();
            LinkedHashSet<String> featvalsset = new LinkedHashSet<>();
            //System.out.println(l);
            String type = l.substring(l.indexOf("<->") + 3).trim();
            if (type.contains(" ")) {
                // It contains feature value pairs.
                type = l.substring(l.indexOf("<->") + 3, l.indexOf(" ")).trim();
                String[] featvals = l.substring(l.indexOf(" ")).trim().split("\\s+");
                for (String fv : featvals) {
                    featvalsset.add(fv);
                }
                m.put(type, featvalsset);
            } else {
                m.put(type, null);
            }
            oneLineInSignatureToTypeToFeatvalsMap.put(idx, m);
            idx++;
        }

        //// GENERATE XML.
        StringBuilder sbO = new StringBuilder();
        
        //sbO.append("<?xml-stylesheet href='__fs-tree-to-html.xsl' type='text/xsl' ?>\n");
        sbO.append("<root>\n");
        
        sbO.append("<results count=\"" + oneLineInSignatureToTypeToFeatvalsMap.size() + "\">\n");
        
        int resultCounter = 1;
        for (Integer lidx : oneLineInSignatureToTypeToFeatvalsMap.keySet()) {
            LinkedHashMap<String, LinkedHashSet<String>> m = oneLineInSignatureToTypeToFeatvalsMap.get(lidx);
            for(String key : m.keySet()) {
                
            
            key = key.toLowerCase().replace("&", ""); // replace illegal xml chars!
            // Export to <fs <f XML format.
            LinkedHashSet<String> featvalpairs = m.get(key);
            // System.out.println(type);
            StringBuilder sb = new StringBuilder();
            sb.append("<result id=\"" + resultCounter + "\">\n");
            sb.append("<view>\n");
            sb.append("<title>" + key + "</title>\n");
            
            sb.append("<fs type=\"" + key + "\">\n");

            // For all feature value pairs.
            if (featvalpairs != null) {
                for (String aFeatValPair : featvalpairs) {
                    String feature = aFeatValPair.split(":")[0];
                    String value = aFeatValPair.split(":")[1];
                    sb.append("<f name=\"" + feature + "\">\n");
                    if (value.equals("list")) {
                        sb.append("<ls><items /><tail /></ls>\n");
                    } else {
                        sb.append("<fs type=\"" + value + "\" />\n");
                    }
                    sb.append("</f>\n");
                }
            } else {
                // No feature value pair.
                sb.append("<f />");
            }
            sb.append("</fs>");
            sb.append("<reentrancies />\n");
            sb.append("</view>\n");
            sb.append("</result>\n\n\n");
            
            sbO.append(sb.toString());
            resultCounter++;
            
        
            }
        }
        
        sbO.append("</results></root>");
        
        return sbO.toString();
    }
    
}
