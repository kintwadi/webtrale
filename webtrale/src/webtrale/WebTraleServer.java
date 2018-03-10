package webtrale;

import java.io.*;
import java.net.URL;
import java.net.URLDecoder;
import java.nio.charset.Charset;
import java.util.*;

import java.text.NumberFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.zip.GZIPInputStream;
import javax.servlet.ServletContext;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.mortbay.jetty.Server;
import org.mortbay.jetty.servlet.Context;
import org.mortbay.jetty.servlet.ServletHolder;
import org.mortbay.jetty.security.HashUserRealm;

import org.mortbay.log.Log;
import webtrale.labels.SubjSprCompsArgstModLabeler;

public class WebTraleServer {
 
    

    public static String __WEBTRALE_HOME = System.getenv("WEBTRALE_HOME");
    // Set to localhost if you have the sicstus and trale installation locally on your machine.
    //public static String __TRALE_SERVER_HOST = "localhost";
    // Specify the server domain here if sicstus and trale run elsewhere.
    // The following URL points to trale.server.uni-frankfurt.de
    public static String __TRALE_SERVER_HOST = "141.2.159.95";
    public static int __TRALE_SERVER_PORT = 3333;
    
    // interface URL: e.g., http://127.0.0.1:9999/wt/
    public static int __SERVER_PORT = 9999;
    public static boolean __ALLOW_REMOTE_CONNECTIONS;
    public static boolean __MULTIUSER;
    public static boolean __NO_AUTH;
    public static int __MAX_WORDS = Integer.MAX_VALUE;
    public static int __MAX_RESULTS = Integer.MAX_VALUE;
    public static int __MAX_QUERY_STRING_LENGTH = Integer.MAX_VALUE;
    public static int __MAX_CACHE_ITEMS = 1000;
    public static int __REQ_HISTORY_SIZE = 100;
    public static String __BROWSER = "firefox";
    public static boolean __START_BROWSER = false;
    public static String __USER = "hola";
    public static String __PASS = "lola";
    public static String __ADMIN_PASS;
    public static String __USER_REALM_NAME = "WebTRALE";
    public static boolean __TESTING;
   
    
    final static String _ADMIN_USER = "admin";
    static Server _server;

    static class Statistics {

        Map<String, Long> statsMap = new TreeMap<String, Long>();
        final Calendar whenStarted = Calendar.getInstance(); // now
        final long startTimeMillis;
        final Date startTimeAsDate;

        Statistics() {
            whenStarted.set(Calendar.MILLISECOND, 0);
            startTimeMillis = whenStarted.getTimeInMillis();
            startTimeAsDate = whenStarted.getTime();
        }

        synchronized void add(String statId, long value) {
            Long oldValue = getStat(statId);
            statsMap.put(statId, oldValue.longValue() + value);
        }

        synchronized void set(String statId, long value) {
            statsMap.put(statId, value);
        }

        void inc(String statId) {
            add(statId, 1);
        }

        private Long getStat(String statId) {
            Long value = statsMap.get(statId);
            if (value == null) {
                value = Long.valueOf(0);
            }
            return value;
        }
    }
    static Statistics stats = new Statistics();

    public static void main(String[] args) throws Exception {
        if (!Utils.configureClass(WebTraleServer.class, args, System.err)) {
            System.exit(1);
            return;
        }

        if (__WEBTRALE_HOME == null) {
            __WEBTRALE_HOME = ".";
        }

        final WebTrale wt = new WebTrale(
                __TRALE_SERVER_HOST,
                __TRALE_SERVER_PORT);

        Log.info("WebTRALE started successfully");

        _server = new Server(__SERVER_PORT);
        int contextOptions = Context.SESSIONS;
        if (!__TESTING) {
            contextOptions |= Context.SECURITY;
        }
        Context context = new Context(_server, "/", contextOptions);

        if (!__TESTING && !__NO_AUTH) {
            initSecurity(context);
        }

        context.addServlet(new ServletHolder(new WebTraleServlet(wt)), "/*");

        _server.start();

        String interfaceURL = "http://127.0.0.1:" + __SERVER_PORT + "/wt/";

        Log.info("WebTraleServer is running; press Ctrl+C to shutdown.");
        Log.info("interface URL: " + interfaceURL);

        if (__START_BROWSER) {
            Log.info("Starting browser (" + __BROWSER + ")");
            try {
                Runtime.getRuntime().exec(__BROWSER + " " + interfaceURL);
            } catch (Exception e) {
                Log.warn(e);
                Log.ignore(e);
            }
        }

        Runtime.getRuntime().addShutdownHook(new Thread(new Runnable() {
            public void run() {
                Log.info("Stopping WebTraleServer... ");
                wt.close();
                Log.info("WebTraleServer stopped successfully");
            }
        }));

        _server.join();
    }

    static void initSecurity(Context ctx) {
        Log.debug("Initializing security...");
        HashUserRealm realm = new HashUserRealm(__USER_REALM_NAME);
        realm.put(__USER, __PASS);
        if (!_ADMIN_USER.equals(__USER)) {
            if (__ADMIN_PASS == null) {
                __ADMIN_PASS = __PASS;
            }
            realm.put(_ADMIN_USER, __ADMIN_PASS);
        }
        ctx.getSecurityHandler().setUserRealm(realm);
    }

    static void stop() throws Exception {
        _server.stop();
    }
}

class WebTraleServlet extends HttpServlet {

    WebTrale _wt;
    String _sessionId;
    Cache _cache = new Cache(WebTraleServer.__MAX_CACHE_ITEMS);
    TreeSet<String> typesFromSignature = getTypesFromSignature("signature");
    private boolean MODIFY_NODE_LABELS_ACCORDING_TO_GERTS_REQUIREMENTS = false;
    private boolean PRINT_HTML = false;

    // Read in all signature types which are allowed to be constraints.
    synchronized TreeSet<String> getTypesFromSignature(String fileName) {
        TreeSet<String> rval = new TreeSet<>();
        // This is the path from which the jar file is started!
        String jarStartPath = System.getProperty("user.dir");
        System.out.println(jarStartPath);
         if(!jarStartPath.contains("tomcat7")) {
             jarStartPath = jarStartPath + "/../grammars/example_grammar/";
         }
        
        

        Scanner s = null;
        File signatureFile = new File(jarStartPath + "/" + fileName);
        if (!signatureFile.exists()) {
            System.err.println("File " + jarStartPath + "/" + fileName + " "
                    + "cannot be found!");
        }
       
        try {
            s = new Scanner(signatureFile, "UTF-8");
        } catch (FileNotFoundException ex) {
            Logger.getLogger(WebTraleServlet.class.getName()).log(Level.SEVERE, null, ex);
        } 
        System.err.println("Scanning file " + fileName + "; getting types.");
        // skip one line.
        s.nextLine();
        while (s.hasNextLine()) {
            String aLine = s.nextLine().trim();
            if (aLine.length() > 0) {
                if (aLine.contains(" ")) {
                    rval.add(aLine.split("\\s+")[0]);
                } else {
                    rval.add(aLine);
                }

            }
        }

        s.close();
        // Manually add some macros.
        // TODO: read from file!
        rval.add("@scoped");
        rval.add("@root");
        rval.add("@ap");
        rval.add("@xp");
        rval.add("@s");
//        for(String type1 : rval) {
//            for(String type2 : rval) {
//            rval.add("@aux_non_fin(" + type1 + "," + type2 + ")");
//            }
//        }
        rval.add("@modal_aux");
        rval.add("@rain_3sg");
        rval.add("@rain_past");
        rval.add("@rain_bare");
        rval.add("@rain_perf");
        rval.add("@rain_prog");
        rval.add("@rais_pred");
        // TODO: more...


        return rval;
    }
    static String _notFoundFmt = loadResource("/_not-found.html");

    static String loadResource(String path) {
        try {
            Reader r = new BufferedReader(
                    new InputStreamReader(
                    WebTraleServlet.class.getResourceAsStream(
                    WebTrale.RESOURCE_PATH + path)));
            int c;
            StringBuilder sb = new StringBuilder();
            while ((c = r.read()) != -1) {
                sb.append((char) c);
            }
            r.close();
            return sb.toString();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    WebTraleServlet(WebTrale wt) {
        _wt = wt;
    }

    private void incStat(String statId) {
        WebTraleServer.stats.inc(statId);
    }

    private void addStat(String statId, long value) {
        WebTraleServer.stats.add(statId, value);
    }

    private static String getRequestIp(HttpServletRequest req) {
        String ip = req.getHeader("X-Forwarded-For");
        if (ip == null || ip.equals("")) {
            ip = req.getRemoteAddr();
        }
        return ip;
    }

    private static String getUserAgent(HttpServletRequest req) {
        String ua = req.getHeader("user-agent");
        if (ua == null) {
            return "--unspecified--";
        }
        //if (ua.length() > 60)
        //ua = ua.substring(0, 60) + "[...]";
        return ua;
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        incStat("-num-requests");
        incStat("x-reqs-from-ip: " + getRequestIp(request));
        incStat("y-user-agent: " + getUserAgent(request));

        logRequest(request);

        String path = request.getPathInfo();
        if (path == null) {
            path = "";
        }
        if (!path.startsWith("/wt")) {
            try {
                if (path.equals("/favicon.ico")) {
                    sendResource("/__favicon.png", response);
                } else {
                    sendNotFound(path, response);
                }
            } catch (Exception e) {
                throw new ServletException(e);
            }
            return;
        }

        if (!checkSecurity(request)) {
            incStat("sec-forbidden");
            response.setStatus(HttpServletResponse.SC_FORBIDDEN);
            return;
        }

        // niko.
        //System.err.println("user: " + request.getRemoteUser());

        if (!WebTraleServer.__TESTING && !WebTraleServer.__NO_AUTH
                && (request.getRemoteUser() == null
                || (path.startsWith("/wt/00") && !request.getRemoteUser().equals(WebTraleServer._ADMIN_USER)))) {
            incStat("sec-noauth");
            response.setHeader("WWW-Authenticate", "Basic realm=\"" + WebTraleServer.__USER_REALM_NAME + "\"");
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            return;
        }

        boolean ok = false;
        //String path = request.getPathInfo();
        // path starts with "/wt"
        path = path.substring(3);

        try {
            if (path == null || path.length() == 0) {
                response.sendRedirect("/wt/");
                return;
            }
            if (path.equals("/applet/")) {
                response.sendRedirect("/wt/applet");
                return;
            }
            if (path.equals("/applet")) {
                path = "/__applet.html";
            }
            
            
            // This maps URLS to content that is being generated.
            // E.g., http://localhost:8888/wt/__rules.html -> write to <frame src="__rules.html"/> in index.html
            // Currently they are all sent to separate frames.
            // What we need is a way to replace these frames by interactive (mouse hover) show/hide functionality.
            // Probably they can still be kept in frames, but there needs to be some additional functionality 
            // encoded into the old-school, static _index.html.
            
            // Add more page contents if necessary here.
            if (path.equals("/rec") || path.equals("/lex")
                    || path.equals("/words.html") || path.equals("/words")
                    || path.equals("/__testitems.html") // niko.
                    || path.equals("/__signature.html") // niko.
                    || path.equals("/__rules.html") // niko. 
                    || path.equals("/__type_hierarchy_d3.html") // niko.
                    || path.equals("/__signature.html") // niko.

                    || path.equals("/rec-raw") || path.equals("/lex-raw") || path.equals("/words-raw")) {
                String method = path.substring(1);
                processQuery(method, request, response);
                ok = true;
            } else if (path.startsWith("/__") || path.startsWith("/lib/")) {
                if (!WebTraleServer.__TESTING
                        && request.getDateHeader("if-modified-since")
                        == WebTraleServer.stats.startTimeMillis) {
                    incStat("num-not-modified");
                    response.setStatus(response.SC_NOT_MODIFIED);
                    Log.debug("Not modified: " + path);
                    return;
                }
                ok = sendResource(path, response, isGzipSupported(request));
            } else if (path.equals("/")) {
                ok = sendIndex(response);
            } else if (path.equals("/quit")) {
                if (WebTraleServer.__MULTIUSER) {
                    // Niko deactivated.
                    //response.setStatus(HttpServletResponse.SC_FORBIDDEN);
                    //return;
                }
                new Thread(new Runnable() {
                    public void run() {
                        try {
                            Thread.sleep(1000);
                            WebTraleServer.stop();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }
                    }
                }).start();
                response.setContentType("text/html");
                ok = sendResource("/_bye.html", response);
            } else if (path.equals("/00stats")) {
                sendStatistics(response);
                ok = true;
            } else if (path.equals("/00last")) {
                sendLast(response);
                ok = true;
            } else if (path.equals("/00cache")) {
                sendCache(response);
                ok = true;
            } else {
                incStat("sec-not-found");
                sendNotFound(path, response);
                Log.warn("Not found: " + path);
            }
        } catch (Trale.TraleException e) {
            response.setContentType("text/plain");
            response.getWriter().write("WebTrale: " + e.getMessage());
        } catch (Exception e) {
            incStat("num-exceptions");
            throw new ServletException(e);
        }

        response.setStatus(
                ok ? HttpServletResponse.SC_OK : HttpServletResponse.SC_NOT_FOUND);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    static boolean isGzipSupported(HttpServletRequest req) {
        String accenc = req.getHeader("Accept-Encoding");
        return accenc != null && accenc.toUpperCase().indexOf("GZIP") != -1;
    }

    private String labelNodesAccordingToGertsRequirements(String html) {
        // Label according to PS94.
        //SubcatModSpecLabeler labeler = new SubcatModSpecLabeler();
        //html = labeler.labelSubcatModAndSpec(html);
        // Label Gert's new April 2017 grammar.
        SubjSprCompsArgstModLabeler labeler = new SubjSprCompsArgstModLabeler();
        html = labeler.labelIt(html);
        return html;
    }

    enum ContentType {

        XML,
        HTML,
        TEXT
    }

    void processQuery(String method, HttpServletRequest req, HttpServletResponse res)
            throws Exception {


        String q = "";
        // niko.
        // constraint field.
        String description = "bot"; // default.

        if (!method.startsWith("words")
                && !method.contains("testitems")
                && !method.contains("signature")
                && !method.contains("rules")
                && !method.contains("type_hierarchy")) {
            q = getNormalizedQueryString(req);
            //System.out.println("req: " + req);
            System.out.println("q: " + q);

            // System.out.println("types from signature: " + typesFromSignature);

            //niko.
            String constraint = req.getParameter("constraint");
            if (constraint != null) {
                constraint = constraint.trim();
                if (constraint.length() > 0) {
                    // TODO: Read from file!
                    // This is only a hack to prevent the user from 
                    // typing in just anything.

                    if (typesFromSignature.contains(constraint)) {
                        description = constraint;
                        System.out.println("Description: " + description);
                    } else {
                        // Constraint unknown.
                        System.out.println("Description \"" + constraint + "\" unknown!");
                    }
                }
            }


            if (q == null) {
                throw new IllegalArgumentException("Missing parameter: q");
            }
        }
        boolean isGzipped = false;

        boolean sendHTMLrightAway = false;

        ContentType contentType = ContentType.XML;
        if (method.endsWith("-raw")) {
            contentType = ContentType.TEXT;
        } else if (method.endsWith(".html")) {
            contentType = ContentType.HTML;
        }

        String cacheKey;
        String accenc = req.getHeader("Accept-Encoding");
        if (isGzipSupported(req)) {
            cacheKey = "Z";
            isGzipped = true;
        } else {
            cacheKey = "-";
        }
        cacheKey += "[" + method + "]";
        cacheKey += q;
        // niko.
        cacheKey += description;
        byte[] bytes = (byte[]) _cache.getData(cacheKey);
        if (bytes != null) {

            // niko.
            // Some parses are already in the cache.
            ByteArrayInputStream bais = new ByteArrayInputStream(bytes);
            GZIPInputStream gzis = new GZIPInputStream(bais);
            InputStreamReader reader = new InputStreamReader(gzis);
            BufferedReader in = new BufferedReader(reader);

            StringBuilder sb = new StringBuilder();
            String readed;
            while ((readed = in.readLine()) != null) {
                sb.append(readed + "\n");
            }

            System.out.println("Parse retrieved from cache.");
            //System.out.println("Parse is retrieved from cache:\n" + sb.toString());

            Log.debug("Cache hit: " + cacheKey);
            sendBytes(res, bytes, contentType, isGzipped);
            return;
        } else {
            Log.debug("Cache miss: " + cacheKey);
        }

        incStat("num-req-" + method);

        System.out.println(method + " <<<");

        // Antonio:
        // niko. called if user enters something into the text field.
        if ("rec".equals(method)) {

            System.out.println("New parse query.");

            bytes = _wt.parseToXmlByteArray(
                    q,
                    WebTraleServer.__MAX_RESULTS,
                    WebTraleServer.__MAX_WORDS,
                    description);

            // niko.
            Utils util = new Utils();
            String stringFromBytes = util.getStringFromBytes(bytes);
            //System.out.println("string from bytes: " + stringFromBytes);

            // Parse chart for query with no results.
            // But only do this if we don't have unknown words.
            if (stringFromBytes.contains("<results count='0'>")
                    && !stringFromBytes.contains("<exception")) {
                bytes = _wt.parseChartToXMLByteArray(q, description);
                stringFromBytes = util.getStringFromBytes(bytes);
            }

            //System.out.println(stringFromBytes);

            // Try to apply the transformation on the XML!
            Stylizer st = new Stylizer();
            //System.out.println("String from bytes: " + stringFromBytes);
            String html = st.convertXMLviaXSLTtoHTML(stringFromBytes);
            if (PRINT_HTML) {
                System.out.println(html);
            }
            // Convert HTML and produce pretty print output
            // with labels for non-terminal nodes, etc.

            //System.out.println(html);
            if (MODIFY_NODE_LABELS_ACCORDING_TO_GERTS_REQUIREMENTS) {
                html = labelNodesAccordingToGertsRequirements(html);
            }


            //System.out.println("bytes (1): ");
            res.getOutputStream().print(html);
            // ignore the send bytes at the end.
            sendHTMLrightAway = true;


        } 
        // Antonio:
        // Called if user clicks on a lex entry on the left-hand side.
        else if ("lex".equals(method)) {
            System.out.println("Lexicon entry clicked.");

            // That's how it was in the original webtrale code !!
            //bytes = _wt.lexToXmlByteArray(q);

            // New Gert requirement:
            // parse the lexicon entry as a single word
            // using the constraint "word".
            bytes = _wt.parseToXmlByteArray(
                    q,
                    WebTraleServer.__MAX_RESULTS,
                    WebTraleServer.__MAX_WORDS,
                    "word");


            Utils util = new Utils();
            String stringFromBytes = util.getStringFromBytes(bytes);
            Stylizer st = new Stylizer();
            //System.out.println("String from bytes: " + stringFromBytes);
            String html = st.convertXMLviaXSLTtoHTML(stringFromBytes);
            if (PRINT_HTML) {
                System.out.println(html);
            }

            // That's how it was before!
            //System.out.println("lexhtml: " + html);
            // Simplify lexicon entries.
            //SubcatListLabelerForLexiconEntries sll = new SubcatListLabelerForLexiconEntries();
            //html = sll.putLabelsIntoSubcatList(html);

            if (MODIFY_NODE_LABELS_ACCORDING_TO_GERTS_REQUIREMENTS) {
                html = labelNodesAccordingToGertsRequirements(html);
            }


            bytes = html.getBytes();
            res.getOutputStream().print(html);
            // ignore the send bytes at the end.
            sendHTMLrightAway = true;
            //Charset cs = Charset.forName("UTF-8");
            //System.out.println("--> " + 
            //cs.decode(java.nio.ByteBuffer.wrap(bytes)));

            

        } else if ("words".equals(method)) {
            bytes = _wt.wordsToXmlByteArray();
            //System.out.println("bytes (3): ");
        } // Called when the program is initialized. (loaded at the beginning?) yes.
        else if ("words.html".equals(method)) {
            bytes = _wt.wordsToHtmlByteArray();
            //System.out.println("bytes (4): ");
        } else if ("__testitems.html".equals(method)) {
            bytes = _wt.testitemsToHtmlByteArray();
            //System.out.println("bytes (4_testitems)");
        } else if ("__signature.html".equals(method)) {
            bytes = _wt.signatureToHtmlByteArray();
            //System.out.println("bytes (4_signature)");
        } else if ("__type_hierarchy_d3.html".equals(method)) {
            bytes = _wt.typeHierarchyD3ToHtmlByteArray();
            //System.out.println("bytes (5_d3 type hierarchy)");
        } else if ("__rules.html".equals(method)) {
            bytes = _wt.rulesToHtmlByteArray();
            //System.out.println("bytes (4_rules)");
        } else if ("rec-raw".equals(method)) {
            bytes = Utils.encodeStrings(
                    _wt.rec(q, WebTraleServer.__MAX_RESULTS, WebTraleServer.__MAX_WORDS, description));
            //System.out.println("bytes (5): " + bytes);
        } else if ("lex-raw".equals(method)) {
            bytes = Utils.encodeStrings(_wt.lex(q));
        } else if ("words-raw".equals(method)) {
            bytes = Utils.encodeStrings(_wt.words());
        } else {
            throw new Trale.TraleException("Unknown method: " + method);
        }

        if (bytes.length == 0) {
            throw new Trale.TraleException("not recognized");
        }

        if (isGzipped) {
            bytes = Utils.gzipBytes(bytes);
        }



        if (!sendHTMLrightAway) {
            _cache.insert(cacheKey, bytes);
            sendBytes(res, bytes, contentType, isGzipped);
        }




    }

    void sendBytes(
            HttpServletResponse response,
            byte[] bytes,
            ContentType contentType,
            boolean isGzipped)
            throws Exception {
        switch (contentType) {
            case XML:
                response.setContentType("text/xml");
                break;
            case HTML:
                response.setContentType("text/html; charset=UTF-8");
                break;
            case TEXT:
            default:
                response.setContentType("text/plain; charset=UTF-8");
        }

        if (isGzipped) {
            response.setHeader("Content-Encoding", "gzip");
        }

        response.getOutputStream().write(bytes);

        if (contentType == ContentType.XML) {
            addStat("num-bytes-sent-xml", bytes.length);
        } else {
            addStat("num-bytes-sent-raw", bytes.length);
        }
    }

    String getNormalizedQueryString(HttpServletRequest request) {
        String q = normalize(request.getParameter("q"));

        if (q == null) {
            return null;
        }
        Log.info("[" + request.getRemoteAddr() + "] Query: " + q);
        if (q.length() > WebTraleServer.__MAX_QUERY_STRING_LENGTH) {
            throw new Trale.TraleException("Input too long");
        }
        return q;
    }

    boolean sendIndex(HttpServletResponse response)
            throws Exception {
        if (WebTraleServer.__MULTIUSER) {
            return sendResource("/_index.html", response);
        }
        return sendResource("/_index-local.html", response);
    }

    static String normalize(String s) {
        if (s == null) {
            return null;
        }
        s = s.trim();
        if (s.length() == 0) {
            return null;
        }
        String[] ss = s.split("\\s+");
        StringBuilder sb = new StringBuilder().append(ss[0]);
        for (int i = 1; i < ss.length; ++i) {
            sb.append(' ').append(ss[i]);
        }
        return sb.toString();
    }
    static Map<String, String> ext2MimeType;

    static {
        ext2MimeType = new TreeMap<String, String>();
        ext2MimeType.put("xsl", "text/xml; charset=UTF-8");
        ext2MimeType.put("css", "text/css");
        ext2MimeType.put("js", "text/javascript");
        ext2MimeType.put("html", "text/html; charset=UTF-8");
        ext2MimeType.put("xml", "text/xml");
        ext2MimeType.put("txt", "text/plain");
        ext2MimeType.put("jar", "application/x-java-archive");
        ext2MimeType.put("png", "image/png");
    }

    boolean sendResource(String res, HttpServletResponse resp)
            throws Exception {
        return sendResource(res, resp, false);
    }

    InputStream getResourceStream(String name) throws FileNotFoundException {
        File f = new File(WebTraleServer.__WEBTRALE_HOME + WebTrale.RESOURCE_PATH + name);
        if (f.canRead()) {
            Log.debug("Sending file resource: " + f);
            return new FileInputStream(f);
        }
        return WebTraleServlet.class.getResourceAsStream(
                WebTrale.RESOURCE_PATH + name);
    }

    boolean sendResource(String resource, HttpServletResponse response, boolean canZip)
            throws Exception {
        InputStream is = null;
        boolean gzipped = false;

        if (canZip) {
            is = getResourceStream(resource + ".gz");
            gzipped = is != null;
        }
        if (is == null) {
            is = getResourceStream(resource);
        }

        if (is == null) {
            Log.warn("Resource not found: " + resource);
            return false;
        }

        int p = resource.lastIndexOf('.');
        if (p != -1 && p != resource.length()) {
            String mimeType = ext2MimeType.get(resource.substring(p + 1));
            if (mimeType != null) {
                response.setContentType(mimeType);
            }
        }

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        int b;
        byte[] buf = new byte[0x1000];
        try {
            while ((b = is.read(buf)) != -1) {
                baos.write(buf, 0, b);
            }
        } finally {
            is.close();
        }

        if (!WebTraleServer.__TESTING) {
            response.setDateHeader(
                    "Last-modified", WebTraleServer.stats.startTimeMillis);
        }
        response.setContentLength(baos.size());
        if (gzipped) {
            response.setHeader("Content-Encoding", "gzip");
        }
        baos.writeTo(response.getOutputStream());

        addStat("num-bytes-sent-res", baos.size());

        Log.debug("Resource sent: " + resource);

        return true;
    }

    void sendNotFound(String resource, HttpServletResponse response)
            throws Exception {
        response.setStatus(HttpServletResponse.SC_NOT_FOUND);
        incStat("sec-not-found");
        sendHtmlString(String.format(_notFoundFmt, resource), response);
    }

    void sendHtmlString(String html, HttpServletResponse response)
            throws Exception {
        response.setContentType("text/html");
        response.getWriter().write(html);
    }

    void sendStatistics(HttpServletResponse response)
            throws Exception {
        incStat("num-req-stats");
        NumberFormat nfmt = NumberFormat.getInstance();
        nfmt.setGroupingUsed(true);

        Runtime rt = Runtime.getRuntime();
        WebTraleServer.stats.set("mem-bytes-allocated", rt.totalMemory());
        WebTraleServer.stats.set("mem-bytes-limit", rt.maxMemory());
        WebTraleServer.stats.set("mem-bytes-free", rt.freeMemory());
        WebTraleServer.stats.set("num-cached-items", _cache.getSize());

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        out.println("<html><head><title>WebTRALE server statistics</title>");
        out.println("<style type='text/css'>tr:hover{background-color:gray;color:lightblue}td{padding-right:5px;padding-left:5px}</style>");
        out.println("</head><body>");

        synchronized (WebTraleServer.stats) {
            Date now = new Date();
            long timeRunning = now.getTime() - WebTraleServer.stats.startTimeMillis;
            out.println("<table>");
            out.println("<tr><td align='right'><b>Started on:&nbsp;</b></td><td><i>" + WebTraleServer.stats.whenStarted.getTime() + "</i></td></tr>");
            out.println("<tr><td align='right'><b>Now is:&nbsp;</b></td><td><i>" + now + "</i></td></tr>");
            out.println("<tr><td align='right'><b>Time running:&nbsp;</b></td><td><i>" + Utils.millisToTimeString(timeRunning) + "</i></td></tr>");
            out.print("</table>");
            out.println("<hr/>");

            out.println("<table>");
            for (String statId : WebTraleServer.stats.statsMap.keySet()) {
                Long value = WebTraleServer.stats.statsMap.get(statId);
                out.println("<tr><td width='400px'><b>" + statId
                        + "</b></td><td align='right'>&nbsp;&nbsp;&nbsp;<i>"
                        + nfmt.format(value) + "</i></td></tr>");
            }
        }
        out.println("</table></body></html>");
    }

    boolean checkSession(HttpServletRequest request) {
        if (WebTraleServer.__MULTIUSER) {
            return true;
        }

        if (_sessionId == null) {
            _sessionId = request.getSession(true).getId();
            // the first client is the only one
            return true;
        }

        HttpSession session = request.getSession(true);
        if (_sessionId.equals(session.getId())) {
            return true;
        }

        session.invalidate();
        return false;
    }

    boolean checkSecurity(HttpServletRequest request) {
        if ("127.0.0.1".equals(request.getRemoteAddr())) {
            // a local call
            return checkSession(request);
        }

        // remote call
        if (!WebTraleServer.__ALLOW_REMOTE_CONNECTIONS) {
            return false;
        }

        return checkSession(request);
    }
    LinkedList<String> _reqHistory = new LinkedList<String>();

    void logRequest(HttpServletRequest request) {
        StringBuilder s = new StringBuilder(1024);
        s.append(Calendar.getInstance().getTime()).append("\n");
        s.append(request.getRequestURL()).append("|");
        s.append(request.getQueryString()).append("\n");
        for (Enumeration e1 = request.getHeaderNames(); e1.hasMoreElements();) {
            String name = (String) e1.nextElement();
            for (Enumeration e2 = request.getHeaders(name); e2.hasMoreElements();) {
                s.append(name).append(":").append(e2.nextElement()).append("\n");
            }
        }
        synchronized (_reqHistory) {
            _reqHistory.addLast(s.toString());
            if (_reqHistory.size() > WebTraleServer.__REQ_HISTORY_SIZE) {
                _reqHistory.removeFirst();
            }
        }
    }

    void sendLast(HttpServletResponse response)
            throws Exception {
        incStat("num-req-last");
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        synchronized (_reqHistory) {
            for (String req : _reqHistory) {
                out.print(req);
                out.println();
            }
        }
        out.flush();
    }

    void sendCache(HttpServletResponse response)
            throws Exception {
        incStat("num-req-cache");
        response.setContentType("text/plain");
        PrintWriter out = response.getWriter();
        synchronized (_cache) {
            for (String key : _cache._key2Item.keySet()) {
                out.print(key);
                out.println();
            }
        }
        out.flush();
    }
}
