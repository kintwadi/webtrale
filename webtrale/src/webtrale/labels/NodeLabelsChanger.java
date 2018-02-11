package webtrale.labels;

import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;

/**
 *
 * Reads in an HTML TRALE parse and changes the Terminal and Non-Terminal node
 * names from rule names to Gert's specified labels.
 *
 *
 * @author Niko
 */
public class NodeLabelsChanger {

    public String changeNodeLabels(String inputHTML) {

        Util util = new Util();

        Document doc = Jsoup.parse(inputHTML);
        // For all struct IDs.
        Element structs = doc.select("div[id=structures]").first();
        if (structs == null) {
            return inputHTML;
        }
        for (Element aStruct : structs.children()) {
            String structId = aStruct.attr("id").split("-")[1];
            // Collect terminal nodes.
            Elements terminalNodes = aStruct.select("td.terminal-node-label");
            // Collect non-terminal nodes.
            Elements nonTerminalNodes = aStruct.select("td.nonterminal-node-label");
            Elements both = new Elements();
            both.addAll(terminalNodes);
            both.addAll(nonTerminalNodes);

            // For all terminal and non-terminal nodes.
            for (Element tOrNTNode : both) {
                boolean isTerminalNode = false;


                if (tOrNTNode.text().contains("lexicon") || tOrNTNode.text().contains("empty]")) {
                    isTerminalNode = true;
                }

                //System.out.println(tOrNTNode.text() + " <-");

                String[] split = tOrNTNode.text().split("\\s\\|\\|\\s*");

                String lexOrRuleAndTokens = split[0].replace("[lexicon,", "").replace("[lexicon", "").replace("]", "");
                //System.out.println("lex or rule and tokens: " + lexOrRuleAndTokens);

                String syn = "-";
                if (split.length > 1) {
                    syn = split[1];
                    //System.out.println("syn: " + split[1]);
                }

                String sem = "-";
                if (split.length > 2) {
                    sem = split[2];
                    //System.out.println("sem: " + split[2]);
                }


                // Add a new vertical line to the end and add the terminal string.
                if (isTerminalNode) {

                    String nodeText = lexOrRuleAndTokens.replace("empty", "___").replace("[", "").replace("]", "");

                    Element parentParent = tOrNTNode.parent().parent();

                    // Add a new line in between the colon.

                    // Append child to siblings.
                    parentParent.append("<tr>\n"
                            + "        <td onclick=\"expand_collapse_node(this)\" nowrap class=\"terminal-node-label\">"
                            + "        <hr style=\"width: 1px; height: 10px; display: inline; margin-left: 2px; margin-right: 2px;\" />"
                            + "        <br>" + nodeText
                            + "</td>\n"
                            + "        </tr>");

                } else {
                    // It's a non-terminal node.
                }


                tOrNTNode.text(syn);

                if (sem.contains("ø") || sem.equals("-")) {
                    // do nothing.
                } else {
                    tOrNTNode.append("<br>");
                    // hide it by default.
                    tOrNTNode.append("<div class=\"semanticlabel\" style=\"display:none\">" + sem + "</div>");
                    tOrNTNode.append("</div>");
                }
            }
        }

        String rval = doc.html();
        return rval;
    }
}
