/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package webtrale.labels;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Scanner;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 * Script to modify the html visualization with label information.
 *
 * Steps: 1.) Read information from "COMPS_LABELS" 2.) Read information from
 * "COMPS_INDICES"
 *
 * go upwards and...
 *
 * 3.) Detect the "COMPS" field and add the information to that sub AVM. a.)
 * Take care of AVMS hidden by tags, containing lists, etc.
 *
 *
 * The script requires the information to be present in the order:
 *
 * COMPS COMPS_INDICES COMPS_LABELS
 *
 *
 * process struct ids separately.
 *
 * @author Niko
 */
public class SubjSprCompsArgstModLabeler {

    private static HashMap<String, Integer> labelsMap;

    static {
        labelsMap = new HashMap<>();
        labelsMap.put("arg_st_labels", 1);
        labelsMap.put("comps_labels", 2);
        labelsMap.put("subj_label", 3);
        labelsMap.put("spr_label", 4);
        labelsMap.put("slash_label", 5);
        labelsMap.put("mod_label", 6);

    }
    public static String INPUT_HTML = "/home/niko/Desktop/toConvert/input.html";
    public static String OUTPUT_HTML = "/home/niko/Desktop/toConvert/output.html";

    public static void main(String[] args) throws FileNotFoundException {
        StringBuilder sb = new StringBuilder();
        Scanner s = new Scanner(new File(INPUT_HTML));
        while (s.hasNextLine()) {
            String aLine = s.nextLine().trim();
            sb.append(aLine + "\n");
        }
        s.close();
        String html = sb.toString();
        SubjSprCompsArgstModLabeler labeler = new SubjSprCompsArgstModLabeler();
        html = labeler.labelIt(html);
        PrintWriter w = new PrintWriter(new File(OUTPUT_HTML));
        w.write(html);
        w.flush();
        w.close();

    }

    public String labelIt(String html) {

        Util util = new Util();

        HashSet<Integer> tagsCollected = new HashSet<>();
        HashSet<String> tofillTagsLabeled = new HashSet<>();
        Document doc = Jsoup.parse(html);


        ArrayList<HashMap<Element, String>> elementsToStructIDs = new ArrayList<>();
        Element structs = doc.select("div[id=structures]").first();
        if (structs == null) {
            System.out.println("No structures found!");
            return html;
        }
        // Collect all structures + IDs.
        for (Element aStruct : structs.children()) {
            String structId = aStruct.attr("id").split("-")[1]; // <div id="struct-1">
            HashMap<Element, String> pair = new HashMap<>();
            pair.put(aStruct, structId);
            elementsToStructIDs.add(pair);
        }
        // Collect all reentrancies + IDs.
        Element reentrancies = doc.select("div[id=reentrancies]").first();
        for (Element aStruct : reentrancies.children()) {
            String structId = aStruct.attr("id").split("-")[1]; // <div id="reentr-1-5">
            String tagId = aStruct.attr("id").split("-")[2];
            HashMap<Element, String> pair = new HashMap<>();
            pair.put(aStruct, structId);
            elementsToStructIDs.add(pair);
        }

        //System.out.println("Collected " + elementsToStructIDs.size() + " elements to process (structures and reentrancies).");

        for (HashMap<Element, String> elementToStructId : elementsToStructIDs) {
            Element el = null;
            String structId = "";
            for (Element e : elementToStructId.keySet()) {
                el = e;
                structId = elementToStructId.get(e);
            }

            //System.out.println("Analyzing struct id: " + structId);



            // Get all Gert specified subcat labels.
            Elements tds = el.select("td.f-name");

            for (Element td : tds) {

                // A potential "comps_labels"
                // e.g., "subj_label", "spr_label", "comps_labels", "arg_st_labels", "slash_label"
                String x_labelS = td.text();

                // We found an instance of the label we need to add to the visualization
                // to a different location.
                if (labelsMap.containsKey(x_labelS)) {
                    // Get it's type, i.e. an ID.
                    int type = labelsMap.get(x_labelS);

                    ///////////////////////////////////////////////
                    // 1.) Get the label information.
                    String labelsStr = td.siblingElements().first().text().replace("<", "").replace(">", "").trim().replace(" ", "");
                    //System.out.println("labelsStr:" + labelsStr);

                    // It's just a single tag on the list ;- )
                    Util u = new Util();
                    // Check if the comps labels are hidden by a tag.
                    if (u.isInteger(labelsStr)) {
                        // Its a tag. Resolve it and find the labels!
                        //System.out.println("finding labels...");
                        labelsStr = doc.select("div[id=reentr-" + structId + "-" + labelsStr + "]").first().text().replace("<", "").replace(">", "").trim().replace(" ", "");

                        // Check if we again have a tag!
                        if (u.isInteger(labelsStr)) {
                            labelsStr = doc.select("div[id=reentr-" + structId + "-" + labelsStr + "]").first().text().replace("<", "").replace(">", "").trim().replace(" ", "");
                        }
                    }

                    // Check if we have multiple tags on the list ;- )
                    //System.out.println("labelsStr: " + labelsStr);
                    if (labelsStr.contains(",")) {
                        String[] split = labelsStr.split("\\,");
                        StringBuilder sb = new StringBuilder();
                        for (String tag : split) {
                            if (u.isInteger(tag)) {
                                String alabelsStr = doc.select("div[id=reentr-" + structId + "-" + tag + "]").first().text().replace("<", "").replace(">", "").trim().replace(" ", "");;
                                sb.append(alabelsStr + ",");

                            }
                        }
                        if (sb.toString().length() > 0) {
                            labelsStr = sb.toString().substring(0, sb.toString().length() - 1);
                        }
                    }

                    //System.out.println("-> x_labelS " + x_labelS + " : " + labelsStr);

                    //System.out.println(td);
                    //System.out.println("Grandparent: " + td.parent().parent());
                    Element subAVM = td.parent().parent();
                    Elements tdsSecondRound = subAVM.select("td.f-name");

                    ///////////////////////////////////////////////////////////////////////////////////////////////
                    // 2.) Now search for the INDEX information in THAT!! sub AVM only!
                    String[] indices = null;
                    // Make a second round of iteration over all elements.
                    for (Element tdSecondRound : tdsSecondRound) {
                        // spr_index, subj_index, comps_indices, arg_indices
                        String x_indexS = tdSecondRound.text();
                        // We found a pattern of the form "indices".
                        if (x_indexS.contains("_indices") || x_indexS.contains("_index")) {

                            String indicesStr = tdSecondRound.siblingElements().first().text().replace("<", "").replace(">", "").trim().replace(" ", "");

                            // Check if the arg indices are hidden by a tag.
                            if (u.isInteger(indicesStr)) {
                                // Its a tag. Resolve it and find the labels!
                                String newIndicesStr = doc.select("div[id=reentr-" + structId + "-" + indicesStr + "]").first().text().replace("<", "").replace(">", "").trim().replace(" ", "");
                                if (newIndicesStr.equalsIgnoreCase("ref") || !u.isInteger(newIndicesStr)) {
                                    // do nothing.. keep the tag on the list.
                                } else {
                                    //System.out.println("First: "+ newIndicesStr);
                                    indicesStr = newIndicesStr;
                                }
                                // Check if we again have a tag!
                                if (u.isInteger(indicesStr)) {
                                    newIndicesStr = doc.select("div[id=reentr-" + structId + "-" + indicesStr + "]").first().text().replace("<", "").replace(">", "").trim().replace(" ", "");
                                    // Only add a digit as index, not "the cat".
                                    if (newIndicesStr.equalsIgnoreCase("ref") || !u.isInteger(newIndicesStr)) {
                                        // do nothing.. keep the tag on the list.
                                    } else {
                                        //System.out.println("Second: "+ newIndicesStr);

                                        indicesStr = newIndicesStr;
                                    }
                                }

                                // maybe todo:
                                // Detect multiple tags on list of the form: "0,14".


                            }

                            // Collect information on the indices!
                            if (indicesStr.length() > 0 && !indicesStr.equals("index_or_none") && !indicesStr.equals("list") && !indicesStr.equals("none")) {
                                // Check if we found TWO PATTERNS that match, e.g.
                                // "spr_label" and "spr_index" or
                                // "comps_labels" and "comps_indices"!
                                if (x_labelS.substring(0, x_labelS.indexOf("_")).equals(x_indexS.substring(0, x_indexS.indexOf("_")))) {
                                    //System.out.println("FOUND INDICES STRING in sub AVM: " + x_indexS + " -- " + indicesStr + "!");
                                    indices = indicesStr.split("\\,");
                                }
                            }
                        }
                    }
                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////
                    ////////////////////////////////////////////////////////////////


                    // No labels.
                    if (labelsStr.length() == 0 || labelsStr.equals("list") || labelsStr.equalsIgnoreCase("sem_obj")) {
                        // Nothing to do.
                    } else {
                        //System.out.println(td);
                        String[] labels = labelsStr.split(",");
                        // String[] indices = indices.split(",");
                        // TODO: marry the two.

                        // 
                        //  Go X steps up in the AVM and get the entry.

                        Element tofill = null;
                        // 
                        tofill = td.parent().previousElementSibling();
                        String tdText = tofill.text();
                        // System.out.println("Type: " + type);
                        // System.out.println("tdText: --->" + tdText + "<---");

                        //////////////////////////////////////////////////////////////////////////
                        // 3.) Find a match of "COMPS" for the collected information of labels and indices.
                        // Changed from "contains" to "startsWith".
                        while (true) {
                            if (tdText.startsWith("arg_st ") && type == 1) {
                                //  System.out.println("1!");
                                break;
                            } else if (tdText.startsWith("comps ") && type == 2) {
                                //  System.out.println("2!");
                                break;
                            } else if (tdText.startsWith("subj ") && type == 3) {
                                //  System.out.println("3!");
                                break;
                            } else if (tdText.startsWith("spr ") && type == 4) {
                                //  System.out.println("4!");
                                break;
                            } else if (tdText.startsWith("slash ") && type == 5) {
                                //  System.out.println("5!");
                                break;
                            } else if (tdText.startsWith("mod ") && type == 6) {
                                //System.out.println("6!");
                                break;
                            } else {
                                //  System.out.println("One up!");
                                tofill = tofill.previousElementSibling();
                                tdText = tofill.text();
                                //  System.out.println("new tdText: " + tdText);
                            }
                        }


                        // And add the index information.
                        if (indices != null) {
                            for (int i = 0; i < labels.length; i++) {
                                if (i < labels.length && i < indices.length && (labels.length == indices.length)) {
                                    //System.out.println("~" + labels[i] + " vs. " + argIndices[i]);
                                    labels[i] = labels[i] + ":" + indices[i];
                                }
                            }
                        }


                        //System.out.println(comps);
                        // Check if we find a direct "<" , ">" list pattern.
                        if (tofill.toString().contains("&lt;") && tofill.toString().contains("&gt;")) {
                            // Found tofill right away.
                            // substitute each system by a tag.
                            //System.out.println("structid: " + structId + " Substituting1 with labels: " + Arrays.asList(labels)  + "\n" + tofill);
                            util.substituteSynsemsInListByTag(tofill, doc, structId, tagsCollected);
                            // Put a label on top of each tag in the HTML visualization.
                            util.labelSubcat(tofill, doc, structId, labels);

                        } // Check if we have a tag which stands for this tofill list.
                        else {



                            // Handle MOD_LABEL.            
                            if (type == 6) {
                                String label = labels[0];
                                if (label.length() == 0 || label.contains("sem_obj") ||
                                        label.contains("none") || label.endsWith("label")) {
                                    // Nothing to do.
                                    
                                } else {

                                    // We have an explicit "MOD" attribute. 
                                    if (tofill.child(0).text().equals("mod")) {
                                        // Check if have a tag for this "MOD" or "SPEC" IMMETIATELY following.
                                        String potentialTagText = tofill.text().replace("mod", "").trim();
                                        // It is only one tag which expands this MOD or SPEC feature.
                                        if (util.isInteger(potentialTagText)) {
                                            label = util.handleUnderscore(label.toUpperCase());
                                            Elements potentialTag = tofill.select("div.tag");
                                            potentialTag.before(label);
                                        } else {
                                            // It's a whole AVM content with more stuff.
                                            // Substitute it by a new tag.
                                            
                                            util.substituteSynsemByTag(tofill, doc, structId, tagsCollected, label);
                                        }
                                    } else {
                                        // Check if we have a tag which stands for this mod/spec element.
                                        Elements tagsForThisModOrSpec = tofill.select("div.tag");
                                        if (tagsForThisModOrSpec != null) {
                                            label = util.handleUnderscore(label.toUpperCase());
                                            tagsForThisModOrSpec.before(label);
                                        }
                                    }
                                }
                            }

                            //System.out.println("There must be a tag for this tofill list.");
                            Elements tagsForThisTofillList = tofill.select("div.tag");
                            String tagNumber = tagsForThisTofillList.text();
                            // Subcat is now the tag.
                            tofill = doc.select("div[id=reentr-" + structId + "-" + tagNumber + "]").first();
                            // substitute each system by a tag.
                            if (!tofillTagsLabeled.contains(tagNumber + "-" + structId)) {
                                //System.out.println("structid: " + structId + " Substituting2 with labels: " + Arrays.asList(labels)  + "\n" + tofill);
                                util.substituteSynsemsInListByTag(tofill, doc, structId, tagsCollected);
                                // Put a label on top of each tag in the HTML visualization.
                                util.labelSubcat(tofill, doc, structId, labels);
                            }
                            // Keep track of tofill tags which have already been equiped with Gert's labels.
                            tofillTagsLabeled.add(tagNumber + "-" + structId);
                        }
                    }
                }

            }
        }

        // Remove Gert's annotations.
        // They are just there to read the information.
        // (and should not be displayed).



         util.removeGertsAnnotation(doc, "comps_labels");
         util.removeGertsAnnotation(doc, "subj_label");
         util.removeGertsAnnotation(doc, "spr_label");
         util.removeGertsAnnotation(doc, "arg_st_labels");
         util.removeGertsAnnotation(doc, "mod_label");
        
         util.removeGertsAnnotation(doc, "spr_index");
         util.removeGertsAnnotation(doc, "subj_index");
         util.removeGertsAnnotation(doc, "comps_indices");
         util.removeGertsAnnotation(doc, "arg_indices");
        
         util.removeGertsAnnotation(doc, "slash_label");
        

         
        NodeLabelsChanger nlc = new NodeLabelsChanger();
        String rval = nlc.changeNodeLabels(doc.html());


        return rval;
    }
}
