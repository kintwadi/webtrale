package webtrale;

import java.io.*;
import java.util.zip.GZIPOutputStream;
import java.util.*;
import java.lang.reflect.*;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.OutputKeys;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.InputSource;

public class Utils {

    public static void main(String[] args) throws Exception {
//        Utils u = new Utils();
//        u.getSubstringIndices("12345");
//
//        TreeSet<String> partialQs = u.getPartialAnalyses("Kim smokes Robin");
//        System.out.println(partialQs);
//        
//        partialQs = u.getPartialAnalyses("This is really interesting");
//        System.out.println(partialQs);
//      

//
//        String xml = "<?xml-stylesheet href='__fs-tree-to-html.xsl' type='text/xsl'?>\n"
//                + "<results count='1'>\n"
//                + " <result id='1'>\n"
//                + " <view><title>kim smokes</title><tree label=\"sentence_rule:kim smokes\"><content><fs type=\"phrase\"><ls><items><t refid=\"0\"/><t refid=\"1\"/></items><tail/></ls><f name=\"syntax\"><fs type=\"sentence\"/></f></fs></content><tree label=\"lexicon:kim\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></content></tree><tree label=\"lexicon:smokes\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></content></tree></tree><reentrancies><reentr tag=\"0\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></reentr></reentrancies></view>"
//                + " </result>\n"
//                
//                + " <result id='2'>\n"
//                + " <view><title>kimbla smokesbla</title><tree label=\"sentence_rule:kim smokes\"><content><fs type=\"phrase\"><ls><items><t refid=\"0\"/><t refid=\"1\"/></items><tail/></ls><f name=\"syntax\"><fs type=\"sentence\"/></f></fs></content><tree label=\"lexicon:kim\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></content></tree><tree label=\"lexicon:smokes\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></content></tree></tree><reentrancies><reentr tag=\"0\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></reentr></reentrancies></view>"
//                + " </result>\n"
//                
//                + " <result id='3'>\n"
//                + " <view><title>kimfasel smokesbla</title><tree label=\"sentence_rule:kim smokes\"><content><fs type=\"phrase\"><ls><items><t refid=\"0\"/><t refid=\"1\"/></items><tail/></ls><f name=\"syntax\"><fs type=\"sentence\"/></f></fs></content><tree label=\"lexicon:kim\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></content></tree><tree label=\"lexicon:smokes\"><content><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></content></tree></tree><reentrancies><reentr tag=\"0\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"noun\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"word\"><f name=\"syntax\"><fs type=\"verb\"/></f></fs></reentr></reentrancies></view>"
//                + " </result>\n"
//                
//                
//                + "</results>";
//
//        
//        Utils u = new Utils();
//        ArrayList<String> resultingViews = u.getResultViews(xml, "view");
//        for(String r : resultingViews) {
//            System.out.println(r);
//        }
//        
        ArrayList<String> spa = new ArrayList<>();

        spa.add("<result id='1'><view><title>an</title><tree label=\"lexicon:an\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"determiner\"><f name=\"determiner_agreement\"><fs type=\"third_singular\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='2'><view><title>an apple</title><tree label=\"head_specifier_rule:an apple\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"3\"/><t refid=\"2\"/></items><tail/></ls><t refid=\"2\"/><ls><items><t refid=\"3\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:an\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"1\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"1\"><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"4\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"2\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"1\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"3\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='3'><view><title>an apple</title><tree label=\"head_specifier_rule:an apple\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"3\"/><t refid=\"2\"/></items><tail/></ls><t refid=\"2\"/><ls><items><t refid=\"3\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:an\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"1\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"1\"><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"4\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"2\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"1\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"3\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='4'><view><title>apple</title><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr></reentrancies></view></result>");
        spa.add("<result id='5'><view><title>apple</title><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr></reentrancies></view></result>");
        spa.add("<result id='6'><view><title>eats</title><tree label=\"lexicon:eats\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></f><f name=\"complements\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"agreement\"/></f></fs></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr></reentrancies></view></result>");
        spa.add("<result id='7'><view><title>eats an apple</title><tree label=\"head_complement_rule//0:eats an apple\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"6\"/><t refid=\"7\"/></items><tail/></ls><t refid=\"6\"/><ls><items><t refid=\"7\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:eats\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_specifier_rule:an apple\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"5\"/><t refid=\"4\"/></items><tail/></ls><t refid=\"4\"/><ls><items><t refid=\"5\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:an\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"3\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree></tree><reentrancies><reentr tag=\"1\"><fs type=\"third_singular\"/></reentr><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"3\"><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"1\"/></f></fs></reentr><reentr tag=\"9\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></reentr><reentr tag=\"2\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><t refid=\"1\"/></f></fs></reentr><reentr tag=\"8\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></reentr><reentr tag=\"7\"><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"5\"/><t refid=\"4\"/></items><tail/></ls><t refid=\"4\"/><ls><items><t refid=\"5\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"6\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"4\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"3\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"5\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='8'><view><title>hessen</title><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='9'><view><title>hessen</title><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='10'><view><title>hessen eats an apple</title><tree label=\"head_specifier_rule:hessen eats an apple\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"12\"/><t refid=\"11\"/></items><tail/></ls><t refid=\"11\"/><ls><items><t refid=\"12\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_complement_rule//0:eats an apple\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"7\"/><t refid=\"8\"/></items><tail/></ls><t refid=\"7\"/><ls><items><t refid=\"8\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:eats\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items><t refid=\"3\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_specifier_rule:an apple\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"6\"/><t refid=\"5\"/></items><tail/></ls><t refid=\"5\"/><ls><items><t refid=\"6\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:an\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:apple\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"4\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree></tree></tree><reentrancies><reentr tag=\"2\"><fs type=\"third_singular\"/></reentr><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"4\"><fs type=\"determiner\"><f name=\"determiner_agreement\"><t refid=\"2\"/></f></fs></reentr><reentr tag=\"10\"><ls><items><t refid=\"1\"/></items><tail/></ls></reentr><reentr tag=\"3\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><t refid=\"2\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"9\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></reentr><reentr tag=\"11\"><fs type=\"head_complement_phrase\"><ls><items><t refid=\"7\"/><t refid=\"8\"/></items><tail/></ls><t refid=\"7\"/><ls><items><t refid=\"8\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"8\"><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"6\"/><t refid=\"5\"/></items><tail/></ls><t refid=\"5\"/><ls><items><t refid=\"6\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"7\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items><t refid=\"3\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"5\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><t refid=\"4\"/></items><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"6\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"4\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"12\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='11'><view><title>in</title><tree label=\"lexicon:in\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"preposition\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"agreement\"/></f></fs></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='12'><view><title>in hessen</title><tree label=\"head_complement_rule//0:in hessen\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"1\"/><t refid=\"2\"/></items><tail/></ls><t refid=\"1\"/><ls><items><t refid=\"2\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"4\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:in\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"4\"/></f><f name=\"complements\"><ls><items><t refid=\"0\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"0\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree><reentrancies><reentr tag=\"4\"><ls><items/><tail/></ls></reentr><reentr tag=\"3\"><fs type=\"preposition\"/></reentr><reentr tag=\"0\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"4\"/></f><f name=\"complements\"><ls><items><t refid=\"0\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"2\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"0\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='13'><view><title>kim</title><tree label=\"lexicon:kim\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='14'><view><title>kim</title><tree label=\"lexicon:kim\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies/></view></result>");
        spa.add("<result id='15'><view><title>kim lives in hessen</title><tree label=\"head_specifier_rule:kim lives in hessen\"><content><fs type=\"head_specifier_phrase\"><ls><items><t refid=\"12\"/><t refid=\"11\"/></items><tail/></ls><t refid=\"11\"/><ls><items><t refid=\"12\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:kim\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_complement_rule//0:lives in hessen\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"7\"/><t refid=\"8\"/></items><tail/></ls><t refid=\"7\"/><ls><items><t refid=\"8\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:lives\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_complement_rule//0:in hessen\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"4\"/><t refid=\"5\"/></items><tail/></ls><t refid=\"4\"/><ls><items><t refid=\"5\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"6\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:in\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"6\"/></f><f name=\"complements\"><ls><items><t refid=\"3\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree></tree></tree><reentrancies><reentr tag=\"6\"><ls><items/><tail/></ls></reentr><reentr tag=\"2\"><fs type=\"preposition\"/></reentr><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"10\"><ls><items><t refid=\"1\"/></items><tail/></ls></reentr><reentr tag=\"3\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></reentr><reentr tag=\"1\"><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></reentr><reentr tag=\"9\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></reentr><reentr tag=\"8\"><fs type=\"head_complement_phrase\"><ls><items><t refid=\"4\"/><t refid=\"5\"/></items><tail/></ls><t refid=\"4\"/><ls><items><t refid=\"5\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"6\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"11\"><fs type=\"head_complement_phrase\"><ls><items><t refid=\"7\"/><t refid=\"8\"/></items><tail/></ls><t refid=\"7\"/><ls><items><t refid=\"8\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"7\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"9\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"10\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"4\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"6\"/></f><f name=\"complements\"><ls><items><t refid=\"3\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"5\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"3\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"12\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");
        spa.add("<result id='16'><view><title>lives</title><tree label=\"lexicon:lives\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></f><f name=\"complements\"><ls><items><fs type=\"preposition\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><reentrancies><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr></reentrancies></view></result>");
        spa.add("<result id='17'><view><title>lives in hessen</title><tree label=\"head_complement_rule//0:lives in hessen\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"6\"/><t refid=\"7\"/></items><tail/></ls><t refid=\"6\"/><ls><items><t refid=\"7\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:lives\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items><t refid=\"1\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"head_complement_rule//0:in hessen\"><content><fs type=\"head_complement_phrase\"><ls><items><t refid=\"3\"/><t refid=\"4\"/></items><tail/></ls><t refid=\"3\"/><ls><items><t refid=\"4\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"5\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content><tree label=\"lexicon:in\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"5\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></content></tree><tree label=\"lexicon:hessen\"><content><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></content></tree></tree></tree><reentrancies><reentr tag=\"5\"><ls><items/><tail/></ls></reentr><reentr tag=\"1\"><fs type=\"preposition\"/></reentr><reentr tag=\"0\"><fs type=\"third_singular\"/></reentr><reentr tag=\"9\"><ls><items><fs type=\"noun\"><f name=\"case\"><fs type=\"nominative\"/></f><f name=\"noun_agreement\"><t refid=\"0\"/></f></fs></items><tail/></ls></reentr><reentr tag=\"2\"><fs type=\"noun\"><f name=\"case\"><fs type=\"accusative\"/></f><f name=\"noun_agreement\"><fs type=\"third_singular\"/></f></fs></reentr><reentr tag=\"8\"><fs type=\"verb\"><f name=\"auxiliary\"><fs type=\"minus\"/></f><f name=\"verb_agreement\"><t refid=\"0\"/></f><f name=\"verb_form\"><fs type=\"finite\"/></f></fs></reentr><reentr tag=\"7\"><fs type=\"head_complement_phrase\"><ls><items><t refid=\"3\"/><t refid=\"4\"/></items><tail/></ls><t refid=\"3\"/><ls><items><t refid=\"4\"/></items><tail/></ls><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"5\"/></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"6\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"8\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"9\"/></f><f name=\"complements\"><ls><items><t refid=\"1\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"3\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"1\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><t refid=\"5\"/></f><f name=\"complements\"><ls><items><t refid=\"2\"/></items><tail/></ls></f></fs></f></fs></f></fs></reentr><reentr tag=\"4\"><fs type=\"word\"><fs type=\"list\"/><f name=\"syntax\"><fs type=\"syntax\"><f name=\"head\"><t refid=\"2\"/></f><f name=\"valence\"><fs type=\"valence\"><f name=\"specifier\"><ls><items/><tail/></ls></f><f name=\"complements\"><ls><items/><tail/></ls></f></fs></f></fs></f></fs></reentr></reentrancies></view></result>");

        Utils u = new Utils();
        u.generateParseChartHTMLTable("kim lives in hessen eats an apple an apple", spa);

    }

    public static byte[] asciiToBytes(String s) {
        byte[] bs = new byte[s.length()];
        for (int i = 0; i < s.length(); ++i) {
            if (Character.codePointAt(s, i) > 127) {
                throw new IllegalArgumentException("Not an ASCII string: " + s);
            }
            bs[i] = (byte) s.charAt(i);
        }
        return bs;
    }

    public static void printOptionsForClass(Class clazz, PrintStream out) throws IOException {
        out.println("Options for " + clazz + ":");
        Map<String, Field> m = getOptionFields(clazz);
        for (String opt : m.keySet()) {
            Field f = m.get(opt);
            out.print("  ");
            out.print(opt);
            String t = f.getType().toString();
            if (t.startsWith("class java.lang.")) {
                t = t.substring("class java.lang.".length());
            } else if (t.startsWith("class ")) {
                t = t.substring("class ".length());
            }
            if (f.getType() == boolean.class) {
                out.print("[="); // mark booleans as optional
            } else {
                out.print('=');
            }
            out.print("<" + t + ">");
            if (f.getType() == boolean.class) {
                out.print(']');
            }
            out.print(" (");
            try {
                out.print(f.get(null));
            } catch (IllegalAccessException e) {
            }
            out.println(")");
        }
        out.flush();
    }

    public static void configureClass(Class clazz, String[] args) {
        Map<String, Field> m = getOptionFields(clazz);
        for (int i = 0; i < args.length; ++i) {
            String arg = args[i];
            String opt = null;
            String val = null;
            int eqpos = arg.indexOf('=');
            if (eqpos == -1) {
                opt = arg;
            } else {
                opt = arg.substring(0, eqpos);
                val = arg.substring(eqpos + 1);
            }
            Field f = m.get(opt);
            if (f == null) {
                throw new RuntimeException("Unknown option: " + arg);
            }
            Class<?> t = f.getType();

            if (eqpos == -1) {
                if (t == boolean.class) {
                    try {
                        f.setBoolean(null, true);
                        continue;
                    } catch (IllegalAccessException e) {
                        throw new RuntimeException(e);
                    }
                } else {
                    throw new RuntimeException("Bad option format: " + arg);
                }
            } else if (val.length() == 0 && t != String.class) {
                throw new RuntimeException("Bad option format: " + arg);
            }

            try {
                if (boolean.class == t) {
                    f.setBoolean(null, Boolean.parseBoolean(val));
                } else if (int.class == t) {
                    f.setInt(null, Integer.parseInt(val));
                } else {
                    f.set(null, val);
                }
            } catch (Exception e) {
                throw new RuntimeException("A problem occured while processing this option: " + arg, e);
            }
        }
    }

    public static boolean configureClass(Class clazz, String[] args, PrintStream err) {
        try {
            configureClass(clazz, args);
            return true;
        } catch (Exception e) {
            err.println("<<<<<<<<<<");
            err.println("-- " + e);
            err.println("-- cause: " + e.getCause());
            err.println(">>>>>>>>>>");
            try {
                printOptionsForClass(clazz, err);
            } catch (Exception ex) {
                throw new RuntimeException(ex);
            }
            return false;
        }
    }

    static Map<String, Field> getOptionFields(Class clazz) {
        Map<String, Field> m = new TreeMap<String, Field>();
        for (Field f : clazz.getFields()) {
            if ((f.getModifiers() & (Modifier.PUBLIC | Modifier.STATIC)) == 0) {
                continue;
            }
            if (!f.getName().startsWith("_")) {
                continue;
            }
            Class<?> t = f.getType();
            if (boolean.class != t && int.class != t && String.class != t) {
                continue;
            }
            m.put(f.getName().toLowerCase().replace('_', '-'), f);
        }
        return m;
    }

    static byte[] gzipBytes(byte[] data) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream((int) (0.1 * data.length));
            GZIPOutputStream zos = new GZIPOutputStream(baos);
            zos.write(data, 0, data.length);
            zos.finish();
            return baos.toByteArray();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
    }

    public static byte[] encodeStrings(String[] ss) {
        return encodeStrings(ss, "\n", "UTF-8");
    }

    public static byte[] encodeStrings(String[] ss, String delimiter, String encoding) {
        if (ss == null || ss.length == 0) {
            return new byte[0];
        }
        ByteArrayOutputStream baos = new ByteArrayOutputStream(ss.length * 0x1000);
        try {
            Writer writer = new OutputStreamWriter(baos, encoding);
            for (String s : ss) {
                writer.append(s);
                writer.append(delimiter);
            }
            writer.close();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return baos.toByteArray();
    }

    public static String millisToTimeString(long ms) {
        long dd = ms / (3600000 * 24);
        long hh = (ms - dd * (3600000 * 24)) / 3600000;
        long mm = (ms - dd * (3600000 * 24) - hh * 3600000) / 60000;
        long ss = (ms - dd * (3600000 * 24) - hh * 3600000 - mm * 60000) / 1000;

        StringBuilder sb = new StringBuilder(50);
        if (dd == 1) {
            sb.append("1 day, ");
        } else if (dd > 1) {
            sb.append(dd).append(" days, ");
        }

        if (hh == 1) {
            sb.append("1 hour, ");
        } else if (hh > 1) {
            sb.append(hh).append(" hours, ");
        }

        if (mm == 1) {
            sb.append("1 minute and ");
        } else if (mm > 1) {
            sb.append(mm).append(" minutes and ");
        }

        if (ss == 1) {
            sb.append("1 second");
        } else {
            sb.append(ss).append(" seconds");
        }

        return sb.toString();
    }

    private Document loadXMLFromString(String xml) throws Exception {
        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
        DocumentBuilder builder = factory.newDocumentBuilder();
        InputSource is = new InputSource(new StringReader(xml));
        return builder.parse(is);
    }

    public ArrayList<String> getResultViews(String xml, String elementName) throws TransformerConfigurationException, TransformerException, Exception {

        // System.out.println("Loading: " + xml);
        Document loadedXml = loadXMLFromString(xml);

        ArrayList<String> resultViews = new ArrayList<String>();
        NodeList results = loadedXml.getElementsByTagName(elementName);
        for (int i = 0; i < results.getLength(); i++) {
            Node n = results.item(i);

            // Use a Transformer for output
            TransformerFactory tFactory
                    = TransformerFactory.newInstance();
            Transformer transformer
                    = tFactory.newTransformer();

            transformer.setOutputProperty(OutputKeys.OMIT_XML_DECLARATION, "yes");
            StringWriter writer = new StringWriter();
            transformer.transform(new DOMSource(n), new StreamResult(writer));
            String output = writer.getBuffer().toString().replaceAll("\n|\r", "");
            //System.out.println("-> " + output);
            resultViews.add(output);
        }
        return resultViews;
    }

    /**
     *
     * @param bytes
     * @return
     */
    public String getStringFromBytes(byte[] bytes) {
        // niko. 
        // Convert byte array into ByteArrayOutputStream.
        // Cf. stackoverflow.com
        ByteArrayOutputStream baos = new ByteArrayOutputStream(bytes.length);
        baos.write(bytes, 0, bytes.length);
        String rval = baos.toString();
        return rval;
    }

    public TreeSet<String> getPartialQueries(String q) {
        TreeSet<String> rval = new TreeSet<String>();
        String[] splitQ = q.split("\\s+");
        int length = splitQ.length;
        for (int c = 0; c < length; c++) {
            for (int i = 1; i <= length - c; i++) {

                StringBuilder sb = new StringBuilder();
                for (int j = c; j < c + i; j++) {
                    sb.append(splitQ[j] + " ");
                }
                String sub = sb.toString().trim();
                //System.out.println(sub);
                rval.add(sub);
            }
        }
        return rval;
    }

    String generateParseChartHTMLTable(String q, ArrayList<String> successfullPartialAnalyses) {

        String[] tokens = q.split("\\s+");
        int numTokens = tokens.length;
        //System.out.println(numTokens);
        LinkedHashMap<Integer, String> tokIdxMap = new LinkedHashMap<>();
        for (int t = 0; t < tokens.length; t++) {
            tokIdxMap.put(t, tokens[t]);
        }

        ArrayList<Span> spans = getSpans(successfullPartialAnalyses, q);
        Collections.sort(spans, Span.getCompByName());
        //for(Span sp : spans) System.out.println(sp);
        //System.out.println(spans.size());

        // Generate table.
        StringBuilder table = new StringBuilder();
        table.append("<table id=\"parseChartTable\">\n");

        StringBuilder nonTerminals = new StringBuilder();

        // Generate non-terminals layer.
        for (Span aSpan : spans) {

            StringBuilder aNonTerminal = new StringBuilder();
            int queryLength = numTokens;
            int spanLength = aSpan.getLength();

            // Do not include the terminal labels in the parse chart.
            if (spanLength > 1) {
                ArrayList<Integer> beginIndices = aSpan.getBeginIdxs();
                aNonTerminal.append("<tr>\n");

                int offset = 0;
                int lastPositionFilled = -1;
                for (int begIdxIdx = 0; begIdxIdx < beginIndices.size(); begIdxIdx++) {

                    int prevBegIdx = begIdxIdx - 1;
                    if (prevBegIdx >= 0) {
                        offset = beginIndices.get(prevBegIdx) + spanLength;
                    }

                    // Fill the left hand side of the span with dummy content.
                    for (int i = offset; i < beginIndices.get(begIdxIdx); i++) {
                        aNonTerminal.append("<td class=\"other\"> </td>\n");
                    }
                    // Add the first span.
                    String phrase = getPhrase(aSpan.getTokens());
                    aNonTerminal.append("<td class=\"phrase\" colspan=\"" + spanLength + "\">"
                            + "<a href=\"rec?q=" + phrase + "\">  " + aSpan.getRuleName()
                            + " </a> "
                            + "<span class=\"tbutton\" onclick=\"show_struct(" + aSpan.getResultId() + ")\">" + aSpan.getResultId() + "</span>"
                            + "</td>\n");

                    lastPositionFilled = beginIndices.get(begIdxIdx) + spanLength;
                }

                // Fill the right context as well if there is some.
                for (int i = lastPositionFilled; i < queryLength; i++) {
                    aNonTerminal.append("<td class=\"other\"> </td>\n");
                }

                aNonTerminal.append("</tr>\n\n");
                nonTerminals.append(aNonTerminal);
            }
        }

        // Generate tokens layer.
        StringBuilder lexEntries = new StringBuilder();

        lexEntries.append("<tr>\n");
        // TODO: Count how often.
        for (int t = 0; t < tokens.length; t++) {
            lexEntries.append("<td class=\"lex\">lex</td>\n");
        }
        lexEntries.append("</tr>\n");

        lexEntries.append("<tr>\n");
        lexEntries.append("<td colspan=\"" + numTokens + "\"> </td>\n");
        lexEntries.append("</tr>\n");

        lexEntries.append("<tr>\n");

        for (int t = 0; t < tokens.length; t++) {
            lexEntries.append("<td class=\"bold\"><a href=\"lex?q=" + tokIdxMap.get(t) + "\">" + tokIdxMap.get(t) + "</a></td>\n");
        }
        lexEntries.append("</tr>\n");

        table.append(nonTerminals.toString());
        table.append(lexEntries.toString());
        table.append("</table>\n");

        // System.out.println(table.toString());
        return table.toString();
    }

    private ArrayList<Span> getSpans(ArrayList<String> successfullPartialAnalyses, String q) {
        ArrayList<Span> spans = new ArrayList<>();

        //System.out.println("q: " + q);
        for (String anAnalysis : successfullPartialAnalyses) {

            //System.out.println("spa: " + anAnalysis);
            String tokenSpanString = anAnalysis.substring(anAnalysis.indexOf("<title>") + 7, anAnalysis.indexOf("</title>")).trim();
            String[] spanTokens = tokenSpanString.split("\\s+");
            int numSpanTokens = spanTokens.length;

            // Regarding the query, extract all spans that match the tokens.
            ArrayList<Integer> beginIndices = new ArrayList<>();

            String[] queryTokens = q.split("\\s+");
            //System.out.println("Query length: " + queryTokens.length);

            for (int i = 0; i < queryTokens.length; i++) {
                String aQueryTok = queryTokens[i];
                // Check if query starts with span.
                if (aQueryTok.equals(spanTokens[0])) {
                    // Compare the rest of them.
                    boolean match = true;
                    for (int j = 1; j < spanTokens.length; j++) {

                        if ((i + j) < queryTokens.length) {
                            String nextQueryToken = queryTokens[(i + j)];
                            String nextSpanToken = spanTokens[j];
                            if (!(nextQueryToken.equals(nextSpanToken))) {
                                match = false;
                            }
                        }

                    }

                    if (match) {
                        //System.out.println("Found a match from: " + i + " to " + (i + numSpanTokens) + " for: " + tokenSpanString);
                        beginIndices.add(i);
                    }
                }
            }

            String ruleName = anAnalysis.substring(anAnalysis.indexOf("<tree label=\"") + 13, anAnalysis.indexOf(":"));
            //System.out.println("Rule name: " +ruleName);
            int resultId = Integer.parseInt(anAnalysis.substring(anAnalysis.indexOf("result id='") + 11, anAnalysis.indexOf(">") - 1));

            Span span = new Span(spanTokens, numSpanTokens, beginIndices, ruleName, resultId);
            spans.add(span);

        }

        return spans;
    }

    private String getPhrase(String[] tokens) {
        StringBuilder sb = new StringBuilder();
        for (String s : tokens) {
            if (s.length() > 0) {
                sb.append(s + " ");
            }
        }
        return sb.toString().trim();
    }
}
