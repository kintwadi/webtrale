package webtrale;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import org.xml.sax.SAXException;
import org.w3c.dom.Document;

// For write operation
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamSource;
import javax.xml.transform.stream.StreamResult;
import java.io.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import org.xml.sax.InputSource;
import static webtrale.WebTrale.loadStylesheet;

public class Stylizer {

    public static String SIGNATURE = "C:\\Users\\niko\\Desktop\\d3\\signature1";
    public static String STYLESHEET = "C:\\Users\\niko\\Desktop\\d3\\__fs-tree-to-html.xsl";
    public static String HTML_OUTPUT_FILE = "C:\\Users\\niko\\Desktop\\d3\\types.html";

    public static void main(String[] argv) throws FileNotFoundException, SAXException, ParserConfigurationException, IOException, TransformerException {

        // Convert signature to xml for each type.
        SignatureToXML r = new SignatureToXML();
        String xml = r.getSignatureXML(SIGNATURE);

        // Convert xml types to HTML.
        Stylizer st = new Stylizer();
        String html = st.convertXMLviaXSLTtoHTML(xml);
        
        // Write HTML file.
        PrintWriter w = new PrintWriter(new File(HTML_OUTPUT_FILE));
        w.write(html);
        w.flush();
        w.close();
    }

    public String convertXMLviaXSLTtoHTML(String xmlString)  {

        //System.out.println("first 100 chars of xml: " + xmlString.substring(0, 100));
        
        String output = "no_html_output";
        Document document = null;

        DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();

        //factory.setNamespaceAware(true);
        //factory.setValidating(true);
        

            DocumentBuilder builder = null;
        try {
            builder = factory.newDocumentBuilder();
        } catch (ParserConfigurationException ex) {
            Logger.getLogger(Stylizer.class.getName()).log(Level.SEVERE, null, ex);
        }
            InputSource is = new InputSource(new StringReader(xmlString));
        try {
            document = builder.parse(is);
        } catch (SAXException ex) {
            Logger.getLogger(Stylizer.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Stylizer.class.getName()).log(Level.SEVERE, null, ex);
        }

            Transformer transformer = null;
            // niko.
            // neu.
        try {            
            transformer = loadStylesheet(
                TransformerFactory.newInstance(), "/__fs-tree-to-html.xsl");
            
            
        } catch (Exception ex) {
            Logger.getLogger(Stylizer.class.getName()).log(Level.SEVERE, null, ex);
        }
            
            
            //System.out.println(stylesource.toString());
            //transformer = tFactory.newTransformer(stylesource);
        

           // DOMSource source = new DOMSource(document);
            //StreamResult result = new StreamResult(System.out);
            // transformer.transform(source, result);
            StringWriter writer = new StringWriter();
        try {
            transformer.transform(new DOMSource(document), new StreamResult(writer));
        } catch (TransformerException ex) {
            Logger.getLogger(Stylizer.class.getName()).log(Level.SEVERE, null, ex);
        }
            output = writer.getBuffer().toString();
            
        return output;
    } 
}
