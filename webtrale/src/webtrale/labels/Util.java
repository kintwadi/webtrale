package webtrale.labels;

import java.util.HashSet;
import java.util.Random;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 *
 * @author Niko
 */
public class Util {

    public boolean isInteger(String s) {
        try {
            Integer.parseInt(s);
        } catch (NumberFormatException e) {
            return false;
        } catch (NullPointerException e) {
            return false;
        }
        // only got here if we didn't return false
        return true;
    }

    /**
     * Substitute an individual synsem by a new tag.
     *
     * @param rowElement
     * @param doc
     * @param structId
     * @param tagsCollected
     */
    public void substituteSynsemByTag(Element rowElement, Document doc, String structId, HashSet<Integer> tagsCollected, String label) {

        // Substitute it by a new tag.
        // and create a new reentrancy.
        //System.out.println("-> " + rowElement);

        // Make a new reentrancy.
        Element reentrancies = doc.select("div[id=reentrancies]").first();
        int rand = getRandomTag(tagsCollected);
        // make a new reentrancy for this synsem element (or whatever...).
        reentrancies.append("<div id=\"reentr-" + structId + "-" + rand + "\">" + rowElement + "</div>");
        // replace the row element by a tag.

        rowElement.html("<td class=\"f-value\"> \n"
                + " <table> \n"
                + "  <tbody>\n"
                + "   <tr> \n"
                + "    <td> \n" + handleUnderscore(label.toUpperCase()) + ""
                + "     <div class=\"tag\" onclick=\"expand_collapse_tag(this)\">\n"
                + "      " + rand + "\n"
                + "     </div> </td>\n"
                + "    <td></td> \n"
                + "   </tr> \n"
                + "  </tbody>\n"
                + " </table> </td>");
    }

    /**
     * Processes each SUBCAT tag sequentially. i.e., opens it and iterates from
     * left bracket "<" to synstem1, comma, synsem2, comma... until ">" closing
     * bracket.
     *
     */
    public void substituteSynsemsInListByTag(Element subcatContent, Document doc, String structId, HashSet<Integer> tagsCollected) {
        // We found a list structure.
        if (subcatContent == null) {
            System.out.println("Subcat content is null");
            return;
        }
        Element leftBracket = subcatContent.select("td.ls-bra").first();
        if (leftBracket == null) {
            System.out.println("Left bracket is null");
            return;
        }

        Elements siblingOfLeftBracket = leftBracket.siblingElements();
        for (Element rowElement : siblingOfLeftBracket) {
            // Skip commata in the subcat list which separates elements.
            // Also, skip already existent tags!
            if (rowElement.text().equals(",") || rowElement.text().equals(">") || isInteger(rowElement.text())) {
                // Do nothing.
            } else {
                // Substitute it by a new tag.
                // and create a new reentrancy.
                //System.out.println("-> " + rowElement);

                // Make a new reentrancy.
                Element reentrancies = doc.select("div[id=reentrancies]").first();
                int rand = getRandomTag(tagsCollected);
                // make a new reentrancy for this synsem element (or whatever...).
                reentrancies.append("<div id=\"reentr-" + structId + "-" + rand + "\">" + rowElement + "</div>");
                // replace the row element by a tag.
                rowElement.html("<td class=\"f-value\"> \n"
                        + " <table> \n"
                        + "  <tbody>\n"
                        + "   <tr> \n"
                        + "    <td> \n"
                        + "     <div class=\"tag\" onclick=\"expand_collapse_tag(this)\">\n"
                        + "      " + rand + "\n"
                        + "     </div> </td>\n"
                        + "    <td></td> \n"
                        + "   </tr> \n"
                        + "  </tbody>\n"
                        + " </table> </td>");

            }
        }
    }

    public int getRandomTag(HashSet<Integer> alreadyCollected) {
        while (true) {
            Random rand = new Random();
            int randomNum = rand.nextInt((120 - 60) + 1) + 60;
            if (!alreadyCollected.contains(randomNum)) {
                //System.out.println("Adding tag: " + randomNum);
                alreadyCollected.add(randomNum);
                return randomNum;
            } else {
                //System.out.println("Tag: " + randomNum + " is already there...");
            }
        }
    }

    public void labelSubcat(Element subcatContent, Document doc, String structId, String[] partsOfSpeechByGert) {
        //System.out.print("Trying to add subcat labels: ");

        // We found a list structure.
        // 1.) Check if we have an empty list.
        if (subcatContent == null) {
            return;
        }
        Element leftBracket = subcatContent.select("td.ls-bra").first();
        if (leftBracket == null) {
            return;
        }
        Element siblingOfLeftBracket = leftBracket.siblingElements().first();
        if (siblingOfLeftBracket.toString().contains("&gt;")) {
            // Do nothing. We have an empty list.
        } else {
            // 2.) Check if we have a tag in the list.
            Elements tagsOnThisSubcatList = subcatContent.select("div.tag");
            //System.out.println("Tags on this subcat list: " + tagsOnThisSubcatList);
            int posIdx = 0;
            for (Element aTagOnSubcat : tagsOnThisSubcatList) {
                //System.out.println(" - >> " + aTagOnSubcat + " << - ");
                //Set part of speech information before the div tag.
                //System.out.println("Adding: " + partsOfSpeechByGert[posIdx]);
                if (posIdx < partsOfSpeechByGert.length) {
                    String partOfSpeechByGert = partsOfSpeechByGert[posIdx].toUpperCase();
                    partOfSpeechByGert = handleUnderscore(partOfSpeechByGert);
                    //System.out.print(partOfSpeechByGert + ", ");
                    aTagOnSubcat.before(partOfSpeechByGert);
                    posIdx++;
                }
            }
            //System.out.println();
        }
    }

    public void removeGertsAnnotation(Document doc, String what) {
        Elements labels = doc.select("td.f-name");
        for (Element aLabel : labels) {
            if (aLabel.text().equalsIgnoreCase(what)) {
                // Go one up.
                Element oneUp = aLabel.parent();
                oneUp.remove();
            }
        }
    }

    public String handleUnderscore(String input) {
       
        
        if (input.contains("_")) {
            String first = input.substring(0, input.indexOf("_"));
            String rest = input.substring(input.indexOf("_") + 1);
            input = first + "[" + rest.toLowerCase() + "]";
            
        }
        
        input = input.replace("det", "d").replace("DET", "D");
        //if (input.startsWith("DET") || input.startsWith("det")) {
        //    input = "D";
        //}
        


        if (input.contains(":")) {
            // new for "NP[nom:0]" to be converted to "NP[nom]:0"
            if (input.endsWith("]")) {
                String first = input.substring(0, input.indexOf(":")) + "]:";
                String rest = input.substring(input.indexOf(":") + 1, input.length() - 1);
                input = first + "<div class=\"boxed\">" + rest + "</div>";
            } else {
                // NP:1 -> NP box around 1
                String first = input.substring(0, input.indexOf(":")) + ":";
                String rest = input.substring(input.indexOf(":") + 1, input.length());
                input = first + "<div class=\"boxed\">" + rest + "</div>";
            }
        }
        return input;
    }

    public String handleSignLabel(String signLabel) {
        String rval = signLabel;
        if (!signLabel.contains("[") && signLabel.length() > 1 && !signLabel.equals("PP")) {
            if (signLabel.equalsIgnoreCase("ADVB")) {
                rval = "Adv";
            } else if (signLabel.equalsIgnoreCase("CP")) {
                rval = "CP";
            } else if (signLabel.equalsIgnoreCase("ADJ")) {
                rval = "A";
            } else if (signLabel.equalsIgnoreCase("AP")) { // very hungry.
                rval = "AP";
            } else {
                rval = signLabel.substring(0, 1);
            }
        }
        return rval;
    }

    String resolveContentRecursively(Document doc, String structId, String content, StringBuilder sb) {
        String[] spl = content.split("\\s+");
        for (int i = 0; i < spl.length; i++) {
            if(isInteger(spl[i])) {
                Element contentTag = doc.select("div[id=reentr-" + structId + "-" + spl[i] + "]").first();
                if(contentTag!=null) {
                    content = contentTag.text().trim();
                    sb.append(spl[i] + "-");
                    resolveContentRecursively(doc, structId, content, sb);
                    sb.append("");
                }
            }
            else {
                sb.append( spl[i] + " ");
            }
        }
        // hungry_rel arg1 0-index degree normal 
        // there_is_rel index 0-index restr 3-and_rel arg1 4-hungry_rel arg1 0-index degree normal arg2 7-cat_rel arg1 0-index 
        // restr_index index 0-index restr 3-and_rel arg1 4-hungry_rel arg1 0-index degree normal arg2 7-cat_rel arg1 0-index 
        return sb.toString().replace("\\s+", " ").replace("  ", "");
    }
}
