package webtrale;

import java.io.*;
import java.net.URISyntaxException;
import java.net.URL;
import java.net.URLDecoder;
import java.util.*;

import java.nio.charset.Charset;
import java.util.jar.JarEntry;
import java.util.jar.JarFile;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletContext;

import javax.xml.transform.TransformerFactory;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.sax.SAXSource;

import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.dom.DOMResult;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class WebTrale {

    final static String RESOURCE_PATH = "/webtrale/resources";
    Trale _trale;
    TraleMsgParser _traleMsgParser;
    Transformer _trans1, _trans2;

    public WebTrale() throws Exception {
        this(7788);
    }

    public WebTrale(int port) throws Exception {
        this("localhost", port);
    }

    public WebTrale(String host, int port) throws Exception {
        _trale = new Trale(host, port);

        _traleMsgParser = new TraleMsgParser(
                new InputStreamReader(
                WebTrale.class.getResourceAsStream(RESOURCE_PATH + "/_trale-msg.g")));
        _trans1 = loadStylesheet(
                TransformerFactory.newInstance(), "/__trale-msg-to-fs-tree.xsl");
    }

    public static Transformer loadStylesheet(TransformerFactory tf, String path)
            throws Exception {
        try {
            return tf.newTransformer(new SAXSource(new InputSource(
                    WebTrale.class.getResourceAsStream(RESOURCE_PATH + path))));
        } catch (TransformerException e) {
            throw new TransformerException("stylesheet: " + path, e);
        }
    }

    byte[] wordsToXmlByteArray() {
        StringBuilder sb = new StringBuilder();

        sb.append("<?xml-stylesheet href='__lexicon.xsl' type='text/xsl'?>\n");
        sb.append("<words>\n");

        for (String s : new TreeSet<String>(Arrays.asList(_trale.words()))) {
            sb.append("\t<word uri-encoded-utf8='");
            try {
                sb.append(java.net.URLEncoder.encode(s, "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                sb.append("UnsupportedEncodingException");
            }
            sb.append("'>")
                    .append(s)
                    .append("</word>\n");
        }

        sb.append("</words>");
        

        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream(sb.length());
            PrintWriter out = new PrintWriter(new OutputStreamWriter(baos, "UTF-8"));
            out.print(sb.toString());
            out.close();
            return baos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    /**
     * Reads the content from a file and displays it into a frame in HTML.
     * 
     * 
     * Idea: generate <div>'s which contain the rules on mouse pressed, the
     * content gets printed to the viewpan frame.
     *
     * @return
     */
    byte[] rulesToHtmlByteArray() {
        ArrayList<String> lines = readFileIntoLines("rules.pl", false);
        ArrayList<String> rules = new ArrayList<String>();
        StringBuilder ruleBuilder = new StringBuilder();
        for (int l = 0; l < lines.size(); l++) {
            if (lines.get(l).startsWith("%")) {
                continue;
            }
            if (lines.get(l).trim().endsWith(".")) {
                ruleBuilder.append(lines.get(l).replace(" ", "&nbsp;") + "<br>");
                // rule done.
                String rule = ruleBuilder.toString().trim();
                if (rule.length() > 0) {
                    rules.add(rule);
                }
                ruleBuilder = new StringBuilder();
            } else {
                ruleBuilder.append(lines.get(l).replace(" ", "&nbsp;") + "<br>");
            }
        }
        // Rules collected.

        //for (String r : rules) {
            //System.out.println(r);
        //}

        String header = "<html>\n"
                + "  <head>\n"
                + "      <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>\n"
                + "      <link href=\"__wt.css\" rel=\"stylesheet\" type=\"text/css\"/>\n"
                + "      <base target=\"viewpan\">\n"
                + "      <script type=\"text/javascript\">\n"
                + "      \n"
                + "      function clickdiv(content) {\n"
                + "          window.parent.frames[\"viewpan\"].document.body.innerHTML = \"<h2>\" + content + \"</h2>\";\n"
                + "          return true;\n"
                + "      }\n"
                + "    </script>\n"
                + "    </head>\n"
                + "    <body>\n"
                + "      <div id=\"rule-block\">\n"
                + "<div class=\"rulelabel\">Rules</div>"
                + "<ul class=\"circle\"> \n";


        String footer = "</ul>\n"
                + "      </div>\n"
                + "    </body>\n"
                + "</html>";



        StringBuilder sb = new StringBuilder();
        sb.append(header);
        for (int r = 0; r < rules.size(); r++) {
            String ruleName = rules.get(r).substring(0, rules.get(r).indexOf("&nbsp;"));
            sb.append("<li><div onclick=\"clickdiv(document.getElementById('div" + r + "').innerHTML)\">" + ruleName + "</div>\n");
            sb.append("<div id=\"div" + r + "\" style=\"display: none;\">\n");
            sb.append(rules.get(r)
                    // Do some very simple syntax highlighting.
                    .replace(ruleName, "<font color=\"#ff1a1a\">" + ruleName + "</font>")
                    .replace("cat", "<font color=\"#ff1a1a\">" + "cat" + "</font>")
                    .replace("[", "<font color=\"#000033\">" + "[" + "</font>")
                    .replace("]", "<font color=\"#000033\">" + "]" + "</font>")
                    
                    );
            sb.append("</div></li>\n");
        }
        sb.append(footer);

       
        return sb.toString().getBytes();

    }

//    synchronized byte[] signatureToHtmlByteArray() {
//
//        ArrayList<String> lines = readFileIntoLines("signature", false);
//        StringBuilder sb = new StringBuilder();
//
//        String header = "<html>\n"
//                + "  <head>\n"
//                + "      <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>\n"
//                + "      <link href=\"__wt.css\" rel=\"stylesheet\" type=\"text/css\"/>\n"
//                // Do NOT redirect results to viewpan.
//                //+ "      <base target=\"viewpan\"/>\n"
//                + "    </head>\n"
//                + "    <body>\n"
//                + "      <div id=\"signature-block\">\n"
//                + "              <div class=\"label\">Signature</div>\n";
//
//        String footer = ""
//                + "</div>\n"
//                + "</div>\n"
//                + "</body>\n"
//                + "</html>";
//
//        sb.append(header);
//        for (String l : lines) {
//            l = l.replace(" ", "&nbsp;"); // keep original indentation.
//            sb.append(l + "<br>");
//        }
//        sb.append(footer);
//
//        return sb.toString().getBytes();
//
//    }

    
    
    
    
    synchronized byte[] typeHierarchyD3ToHtmlByteArray() throws FileNotFoundException {

        String jarStartPath = System.getProperty("user.dir");
        
        if(!jarStartPath.contains("tomcat7")) {
            jarStartPath = jarStartPath + "/../grammars/example_grammar/";
        }
        
        // Generate JSON from signature and 
        SignatureToJSON j = new SignatureToJSON();
        String json = j.getJSONFromSignature(jarStartPath + "/signature");
        
        String d3HTML = "<!DOCTYPE html>\n" +
"<meta charset=\"utf-8\">\n" +
"\n" +
"\n" +
"<style>\n" +
"\n" +
".node {\n" +
"  cursor: pointer;\n" +
"}\n" +
"\n" +
".node circle {\n" +
"  fill: #fff;\n" +
"  stroke: steelblue;\n" +
"  stroke-width: 1.5px;\n" +
"}\n" +
"\n" +
".node text {\n" +
"  font: 10px sans-serif;\n" +
"}\n" +
"\n" +
".link {\n" +
"  fill: none;\n" +
"  stroke: #ccc;\n" +
"  stroke-width: 1.5px;\n" +
"}\n" +
"\n" +
"</style>\n" +
"<body>\n" +
"\n" +
"\n" +
"<div>\n" +
"\n" +
                // Careful! This requires the script from the internet. Test to include it locally!
"<script src=\"https://d3js.org/d3.v3.min.js\"></script>\n" +
"<script>\n" +
"\n" +
"var myjson = '"
                + ""
                + json // adding JSON object here, generated from the signature.
                + ""
                + "';\n" +
"\n" +
"  \n" +
"\n" +
"var margin = {top: 20, right: 20, bottom: 20, left: 40},\n" +
"    width = 960 - margin.right - margin.left,\n" +
"    height = 800 - margin.top - margin.bottom;\n" +
"\n" +
"var i = 0,\n" +
"    duration = 750,\n" +
"    root;\n" +
"\n" +
"var tree = d3.layout.tree()\n" +
"    .size([height, width]);\n" +
"\n" +
"var diagonal = d3.svg.diagonal()\n" +
"    .projection(function(d) { return [d.y, d.x]; });\n" +
"\n" +
"var svg = d3.select(\"body\").append(\"svg\")\n" +
"    .attr(\"width\", width + margin.right + margin.left)\n" +
"    .attr(\"height\", height + margin.top + margin.bottom)\n" +
"  .append(\"g\")\n" +
"    .attr(\"transform\", \"translate(\" + margin.left + \",\" + margin.top + \")\");\n" +
"\n" +
"  root = JSON.parse( myjson ); \n" +
"  \n" +
"  root.x0 = height / 2;\n" +
"  root.y0 = 0;\n" +
"\n" +
"  function collapse(d) {\n" +
"    if (d.children) {\n" +
"      d._children = d.children;\n" +
"      d._children.forEach(collapse);\n" +
"      d.children = null;\n" +
"    }\n" +
"  }\n" +
"\n" +
"  root.children.forEach(collapse);\n" +
"  update(root);\n" +
"\n" +
"d3.select(self.frameElement).style(\"height\", \"800px\");\n" +
"\n" +
"function update(source) {\n" +
"\n" +
"\n" +
"\n" +
"  // Compute the new tree layout.\n" +
"  var nodes = tree.nodes(root).reverse(),\n" +
"      links = tree.links(nodes);\n" +
"\n" +
"  // Normalize for fixed-depth.\n" +
"  nodes.forEach(function(d) { d.y = d.depth * 180; });\n" +
"\n" +
"  // Update the nodes\n" +
"  var node = svg.selectAll(\"g.node\")\n" +
"	  .data(nodes, function(d) { return d.id || (d.id = ++i); });\n" +
"		\n" +
"	\n" +
"	  \n" +
"	  \n" +
"  // Enter any new nodes at the parent's previous position.\n" +
"  var nodeEnter = node.enter().append(\"g\")\n" +
"      .attr(\"class\", \"node\")\n" +
"      .attr(\"transform\", function(d) { return \"translate(\" + source.y0 + \",\" + source.x0 + \")\"; })\n" +
"	  .on(\"click\", click)\n" +
"	  .on(\"dblclick\", dblclick);\n" +
"\n" +
"  nodeEnter.append(\"circle\")\n" +
"      .attr(\"r\", 1e-6)\n" +
"      .style(\"fill\", function(d) { return d._children ? \"lightsteelblue\" : \"#fff\"; });\n" +
"\n" +
"  nodeEnter.append(\"text\")\n" +
"      .attr(\"x\", function(d) { return d.children || d._children ? -10 : 10; })\n" +
"      .attr(\"dy\", \".35em\")\n" +
"      .attr(\"text-anchor\", function(d) { return d.children || d._children ? \"end\" : \"start\"; })\n" +
"      .text(function(d) { return d.name; })\n" +
"      .style(\"fill-opacity\", 1e-6);\n" +
"\n" +
"  // Transition nodes to their new position.\n" +
"  var nodeUpdate = node.transition()\n" +
"      .duration(duration)\n" +
"      .attr(\"transform\", function(d) { return \"translate(\" + d.y + \",\" + d.x + \")\"; });\n" +
"\n" +
"  nodeUpdate.select(\"circle\")\n" +
"      .attr(\"r\", 8.5)\n" +
"      .style(\"fill\", function(d) { return d._children ? \"lightsteelblue\" : \"#fff\"; });\n" +
"\n" +
"  nodeUpdate.select(\"text\")\n" +
"      .style(\"fill-opacity\", 1);\n" +
"\n" +
"  // Transition exiting nodes to the parent's new position.\n" +
"  var nodeExit = node.exit().transition()\n" +
"      .duration(duration)\n" +
"      .attr(\"transform\", function(d) { return \"translate(\" + source.y + \",\" + source.x + \")\"; })\n" +
"      .remove();\n" +
"\n" +
"  nodeExit.select(\"circle\")\n" +
"      .attr(\"r\", 1e-6);\n" +
"\n" +
"  nodeExit.select(\"text\")\n" +
"      .style(\"fill-opacity\", 1e-6);\n" +
"\n" +
"  // Update the links\n" +
"  var link = svg.selectAll(\"path.link\")\n" +
"      .data(links, function(d) { return d.target.id; });\n" +
"\n" +
"  // Enter any new links at the parent's previous position.\n" +
"  link.enter().insert(\"path\", \"g\")\n" +
"      .attr(\"class\", \"link\")\n" +
"      .attr(\"d\", function(d) {\n" +
"        var o = {x: source.x0, y: source.y0};\n" +
"        return diagonal({source: o, target: o});\n" +
"      });\n" +
"\n" +
"  // Transition links to their new position.\n" +
"  link.transition()\n" +
"      .duration(duration)\n" +
"      .attr(\"d\", diagonal);\n" +
"\n" +
"  // Transition exiting nodes to the parent's new position.\n" +
"  link.exit().transition()\n" +
"      .duration(duration)\n" +
"      .attr(\"d\", function(d) {\n" +
"        var o = {x: source.x, y: source.y};\n" +
"        return diagonal({source: o, target: o});\n" +
"      })\n" +
"      .remove();\n" +
"\n" +
"  // Stash the old positions for transition.\n" +
"  nodes.forEach(function(d) {\n" +
"    d.x0 = d.x;\n" +
"    d.y0 = d.y;\n" +
"  });\n" +
"  \n" +
"}\n" +
"\n" +
"\n" +
"function dblclick(d) {\n" +
"   // do nothing.\n" +
"\n" +
"  }\n" +
"  \n" +
"// Toggle children on click.\n" +
"function click(d) {\n" +
"  if (d.children) {\n" +
"    d._children = d.children;\n" +
"    d.children = null;\n" +
"  } else {\n" +
"    d.children = d._children;\n" +
"    d._children = null;\n" +
"  }\n" +
                // This is the place where we control what
                // happens when we click on a bubble in the generated D3 tree.
                // In this case, we want to show the AVM structure 
                // displayed in the corresponding right frame.
                // +2 is a hack. TODO: fix this.
"  // niko. show AVM in the right frame.\n" +
"  window.parent.frames[\"signatureavms\"].show_struct((d.typeNumber+1));\n" +
"  update(d);\n" +
"}\n" +
"\n" +
"</script>\n" +
"\n" +
"</div>\n" +
"\n" +
"<div>\n" +
"</div>\n" +
"\n" +
"</html>";
        
        StringBuilder sb = new StringBuilder();
        sb.append(d3HTML);
        return sb.toString().getBytes();

    }
    
    
    
    
    synchronized byte[] signatureToHtmlByteArray() throws FileNotFoundException {
        // Convert signature to xml for each type.
        String jarStartPath = System.getProperty("user.dir");
         if(!jarStartPath.contains("tomcat7")) {
            jarStartPath = jarStartPath + "/../grammars/example_grammar/";
        }
        String signaturePath = jarStartPath + "/signature";
        SignatureToXML r = new SignatureToXML();
        String xml = r.getSignatureXML(signaturePath);
        //String path1 = WebTrale.class.getProtectionDomain().getCodeSource().getLocation().getPath();
        //System.out.println("path1: " + path1);
        //InputStream path2 = WebTrale.class.getResourceAsStream(RESOURCE_PATH + "/__fs-tree-to-html.xsl");
        //System.out.println("path2: " + path2);
        //String filename = path1;
        // Convert xml types to HTML.
        Stylizer st = new Stylizer();
        //File f = new File(filename); // "/webtrale/resources/__fs-tree-to-html.xsl"
//        if(f.exists()) System.out.println("File exists!");
//        else System.out.println("File does not exist!");
        //File f = new File("__fs-tree-to-html.xsl");
        String html = st.convertXMLviaXSLTtoHTML(xml);
        StringBuilder sb = new StringBuilder();
        sb.append(html);
        return sb.toString().getBytes();

    }

    
    
    
    private ArrayList<String> readFileIntoLines(String fileName, boolean trim) {
        // This is the path from which the jar file is started!
        String jarStartPath = System.getProperty("user.dir");
        System.out.println("Jar started from: " + jarStartPath);

        ArrayList<String> lines = new ArrayList<>();
        Scanner s = null;
        try {
            File file = new File(jarStartPath + "/" + fileName);
            if (!file.exists()) {
                System.out.println("File " + jarStartPath + "/" + fileName + " "
                        + "cannot be found!");
            }
            s = new Scanner(file, "UTF-8");
            System.out.println("Scanning file " + fileName + "...");
            while (s.hasNextLine()) {
                String aLine = "";
                if (trim) {
                    aLine = s.nextLine().trim();
                } else {
                    aLine = s.nextLine();
                }
                if (aLine.length() > 0) {
                    lines.add(aLine);
                }
            }
        } catch (FileNotFoundException ex) {
            Logger.getLogger(WebTrale.class.getName()).log(Level.SEVERE, null, ex);
        }

        s.close();
        return lines;
    }

    // synchronyzed?
    byte[] testitemsToHtmlByteArray() {

        
        String testitemspath =  "test_items.pl";
        
        String jarStartPath = System.getProperty("user.dir");
         if(!jarStartPath.contains("tomcat7")) {
            testitemspath = "/../grammars/example_grammar/test_items.pl";
        }
        
       
        
        ArrayList<String> tiLines = readFileIntoLines(testitemspath, true);

        // all lines collected.

        String header = "<html>\n"
                + "  <head>\n"
                + "      <meta http-equiv=\"content-type\" content=\"text/html; charset=UTF-8\"/>\n"
                + "      <link href=\"__wt.css\" rel=\"stylesheet\" type=\"text/css\"/>\n"
                + "      <base target=\"viewpan\"/>\n"
                + "    </head>\n"
                + "    <body>\n"
                + "      <div id=\"testitem-block\">\n"
                + "              <div class=\"label\">Test Items</div>\n"
                + "<table border=\"1\" width=\"100%\">\n"
                + "\n"
                + "<tbody>\n"
                + "\n"
                + "<tr>\n"
                + "<td>#</td>\n"
                + "<td><b>Test Item</b></td>\n"
                + "<td>Constraint</td>\n"
                + "<td>Number of expected results</td>\n"
                + "<td>Comment</td>\n"
                + "</tr>";

        String footer = "</tbody>\n"
                + "</table>\n"
                + "\n"
                + "</div>\n"
                + "</div>\n"
                + "</body>\n"
                + "</html>";


        StringBuilder sb = new StringBuilder();
        sb.append(header);

        // skip first four lines.
        for (int l = 4; l < tiLines.size(); l++) {
            String line = tiLines.get(l);
            // a test item comment.
            if (line.startsWith("%")) {
                String write =
                        "<tr>\n"
                        + "<td bgcolor=\"#ffffcc\"><i>" + line.replace("%", "") + "</i></td>\n"
                        + "</tr>";
                sb.append(write);
            } // a test item.
            // E.g., 
            // t(453,"kim persuaded robin to smoke",@root,1,'object control verb "persuade"').
            else if (line.startsWith("t(")) {

                line = line.replace("\",\\s+", "\",");

                String numAndString = line.split("\",")[0];
                String rest = line.split("\",")[1];

                //System.out.println(numAndString);
                //System.out.println(rest);

                //  System.out.println(line);

                String num = numAndString.substring(2, numAndString.indexOf(","));
                String string = numAndString.substring(num.length() + 4);

                //  System.out.println("num: " + num);
                //  System.out.println("string: " + string);

                String[] restSplit = rest.split(",");
                String description = restSplit[0];
                String numExpectedResults = restSplit[1].trim();
                String comment = rest.substring(rest.indexOf(numExpectedResults) + numExpectedResults.length() + 1, rest.length() - 2);

                //  System.out.println("description: " + description);
                //  System.out.println("numExpRes: " + numExpectedResults);
                //  System.out.println("comment: " + comment);

                
                String numExpectedResultsEntry = "<td>" + numExpectedResults + "</td>\n";
                // red.
                if(numExpectedResults.equals("0")) {
                    numExpectedResultsEntry = "<td bgcolor=\"#ff6666\">" + numExpectedResults + "</td>\n";
                }
                // green.
                else {
                    numExpectedResultsEntry = "<td bgcolor=\"#e5ffe5\">" + numExpectedResults + "</td>\n";
                }
                
                sb.append("<tr>\n"
                        + "<td>" + num + "</td>\n"
                        //<!-- rec?q=kim smokes&constraint=phrase -->
                        + "<td><a href=\"rec?q=" + string + "&constraint=" + description + "\">" + string + "</a></td> \n"
                        + "<td>" + description + "</td>\n"
                        + numExpectedResultsEntry 
                        + "<td>" + comment + "</td>\n"
                        + "</tr>");
            } else {
                System.out.println("Cannot read test items line: " + line);
            }

        }

        sb.append(footer);
        return sb.toString().getBytes();
    }

    byte[] wordsToHtmlByteArray() {
        System.out.println("Words to HTML byte array called.");
        StringBuilder sb = new StringBuilder();

        //sb.append("<?xml-stylesheet href='__lexicon.xsl' type='text/xsl'?>\n");
        sb.append("<words>\n");

        for (String s : new TreeSet<String>(Arrays.asList(_trale.words()))) {
            sb.append("\t<word uri-encoded-utf8='");
            try {
                sb.append(java.net.URLEncoder.encode(s, "UTF-8"));
            } catch (UnsupportedEncodingException e) {
                sb.append("UnsupportedEncodingException");
            }
            sb.append("'>")
                    .append(s)
                    .append("</word>\n");
        }

        sb.append("</words>");
        System.out.println("aquiii");
        System.out.println(sb.toString());

        try {
            Transformer t = loadStylesheet(TransformerFactory.newInstance(),
                    "/__lexicon.xsl");
            ByteArrayOutputStream baos = new ByteArrayOutputStream(sb.length());
            t.transform(
                    new SAXSource(new InputSource(new StringReader(sb.toString()))),
                    new StreamResult(baos));
            
            return baos.toByteArray();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    byte[] lexToXmlByteArray(String q) throws Exception {
        String[] ss = _trale.lex(q);
        return wrapTraleResult(ss, null);
    }

    String[] rec(String q, int maxResults, int maxWords, String description) throws Exception {
        //long start = System.nanoTime();
        String[] ss = _trale.rec(q, maxResults, maxWords, description);
        //long end = System.nanoTime();
        //System.err.println("-- parsed '" + q + "' in " + ((double)(end - start) / 1000000000) + " secs");
        return ss;
    }

    String[] words() {
        return new TreeSet<String>(Arrays.asList(_trale.words())).toArray(new String[0]);
    }

    String[] lex(String q) throws Exception {
        return _trale.lex(q);
    }

    byte[] parseToXmlByteArray(String q, String description) throws Exception {
        return parseToXmlByteArray(q, Integer.MAX_VALUE, description);
    }

    byte[] parseToXmlByteArray(String q, int maxParses, String description) throws Exception {
        return parseToXmlByteArray(q, maxParses, Integer.MAX_VALUE, description);
    }

    byte[] parseToXmlByteArray(String q, int maxParses, int maxWords, String description) throws Exception {
        String[] ss;
        Trale.TraleException ex;
        try {
            ss = _trale.rec(q, maxParses, maxWords, description);
            ex = null;
        } catch (Trale.TraleException tex) {
            ex = tex;
            ss = new String[0];
        }

        // niko.
//    System.out.println("ss content:");
//    for(String s  : ss) {
//        System.out.print(s + "<-");
//    }
//    System.out.println();
//    
        return wrapTraleResult(ss, ex);
    }

    byte[] wrapTraleResult(String[] ss, Trale.TraleException tex) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();

        baos.write(
                "<?xml-stylesheet href='__fs-tree-to-html.xsl' type='text/xsl'?>\n"
                .getBytes());
        baos.write((""
                // niko.
                + "<root>\n"
                + "<parsechart> no parse chart </parsechart>\n"
                // end niko.
                + "<results count='" + ss.length + "'>\n").getBytes());

        int pos = 1;
        for (String s : ss) {
            baos.write(("<result id='" + pos + "'>\n").getBytes());
            traleMsgToXml(s, baos);
            baos.write("</result>\n".getBytes());
            ++pos;
        }


        if (tex != null) {
            baos.write("<exception>".getBytes());
            baos.write(_traleMsgParser.escapeXml(tex.getMessage().replace("ale(unk_words(",
                    "These words are not in our lexicon: (")).getBytes());
            baos.write("</exception>".getBytes());
        }

        baos.write("</results>".getBytes());
        // niko.
        baos.write("</root>".getBytes());

        // niko.
        //System.out.println("Byte output stream:");
        //System.out.println(baos.toString());

        return baos.toByteArray();
    }

    byte[] traleMsgToXml(String s) throws Exception {
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        traleMsgToXml(s, baos);
        return baos.toByteArray();
    }

    void traleMsgToXml(String s, OutputStream xmlStream) throws Exception {
        s = _traleMsgParser.parse(s);

        synchronized (_trans1) {
            _trans1.transform(
                    new SAXSource(new InputSource(new StringReader(s))),
                    new StreamResult(xmlStream));
        }
    }

    byte[] traleMsgToHtml(String s) throws Exception {
        if (_trans2 == null) {
            _trans2 = loadStylesheet(TransformerFactory.newInstance(),
                    "/__fs-tree-to-html.xsl");
        }
        s = _traleMsgParser.parse(s);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        DOMResult domResult = new DOMResult();

        synchronized (_trans1) {
            _trans1.transform(
                    new SAXSource(new InputSource(new StringReader(s))),
                    domResult);
        }
        synchronized (_trans2) {
            _trans2.transform(
                    new DOMSource(domResult.getNode()),
                    new StreamResult(baos));
        }

        return baos.toByteArray();
    }

    public void close() {
        _trale.close();
    }

    public static void main(String[] args) throws Exception {
        //String sentence = "peter has been walking";

        String sentence = "Kim smokes.";
        String description = "bot";
        Charset cs = Charset.forName("UTF-8");
        if (args.length > 0) {
            sentence = "";
            for (String s : args) {
                sentence += s + " ";
            }
        }
        WebTrale t = new WebTrale();
        byte[] xml = t.parseToXmlByteArray(sentence, description);
        System.out.println(
                cs.decode(java.nio.ByteBuffer.wrap(xml)));
        /*
         for (String s : t.parse(sentence)) { 
         byte[] html = t.traleMsgToHtml(s);
         System.out.println(
         cs.decode(java.nio.ByteBuffer.wrap(html))
         );
         }
         */
        t.close();
    }

    /**
     * No results are found. Try to return individual analyses for substrings of
     * the query.
     *
     * @param q
     * @return
     * @throws IOException
     */
    byte[] parseChartToXMLByteArray(String q, String description) throws IOException, Exception {
        
        // Gert's requirement.
        // A parse chart should * always * return partial analyses.
        // Do not pass the "constraint"/description from the complete sentence to the partial results
        // i.e. parse the partial phrases as "bot".
        description = "bot"; // Comment this if necessary.
        
        
        
        System.out.println("The given query \"" + q + "\" is not recognized.\n"
                + "We try to deliver partial analyses for it.\n");
        // Check if subcomponents can be analyzed and deliver a result:
        Utils util = new Utils();
        TreeSet<String> partialQueries = util.getPartialQueries(q);

        ArrayList<String> successfullPartialAnalyses = new ArrayList<>();

        // For all partial queries.
        int resultViewCounter = 1;
        for (String partialQ : partialQueries) {
            //System.out.println("Analyzing partial query: " + partialQ);
            byte[] bytes = parseToXmlByteArray(
                    partialQ,
                    WebTraleServer.__MAX_RESULTS,
                    WebTraleServer.__MAX_WORDS,
                    description);
            // Check if this delivers an analysis.

            String aPartialResult = util.getStringFromBytes(bytes);
           // System.out.println("Result for partial query: \"" + partialQ + "\":\n" + aPartialResult);
           // System.out.println();

            // We found a partial analysis.
            if (!aPartialResult.contains("count='0'")) {
                ArrayList<String> resultViews = util.getResultViews(aPartialResult, "view");

               // System.out.println(resultViews);
                for (String rV : resultViews) {
                    successfullPartialAnalyses.add("<result id='" + resultViewCounter + "'>" + rV + "</result>");
                    resultViewCounter++;
                }
            }
        }


        String parseChartHTMLTable = util.generateParseChartHTMLTable(q, successfullPartialAnalyses);

        StringBuilder sb = new StringBuilder();
        sb.append("<?xml-stylesheet href='__fs-tree-to-html.xsl' type='text/xsl'?>\n");
        sb.append("<root>\n");
        sb.append("<parsechart>\n" + parseChartHTMLTable + "\n</parsechart>\n");
        // Append the query as well.
        sb.append("<results count='" + successfullPartialAnalyses.size() + "' parseChart='1' query='" + q + "'>\n");
        for (String successfulPartialAnalysis : successfullPartialAnalyses) {
            //System.out.println(successfulPartialAnalysis);
            sb.append(successfulPartialAnalysis + "\n");
        }
        sb.append("</results>\n");
        sb.append("</root>");

        System.out.println();

        String xmlOutputString = sb.toString();


        //System.out.println("SuccessfullPartialAnalyses: ");
        //System.out.println(xmlOutputString);



        ByteArrayOutputStream bOS = new ByteArrayOutputStream();
        bOS.write((xmlOutputString).getBytes());

        return bOS.toByteArray();

    }
}
