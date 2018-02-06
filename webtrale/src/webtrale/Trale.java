package webtrale;

import java.io.*;
import java.net.*;
import java.util.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class Trale {

  private static String ioEncodingName = "ISO-8859-1";
  static {
    String SP_CTYPE = System.getenv("SP_CTYPE");
    if (SP_CTYPE == null) {
      SP_CTYPE = System.getProperty("SP_CTYPE");
    }
    if (SP_CTYPE != null) {
      ioEncodingName = SP_CTYPE;
    }
  }

  BufferedReader _traleIn;
  PrintWriter _traleOut;
  Socket _traleSocket;
  
  static class TraleException extends RuntimeException {
    TraleException(Throwable cause) { super(cause); }
    TraleException(String msg) { super(msg); }
  }
  
  public Trale() {
    this(7788);
  }
  
  public Trale(int port) {
    this("localhost", port);
  }
  
  public Trale(String host, int port) {
    try {
      _traleSocket = new Socket(host, port);
      
      _traleIn = new BufferedReader(
        new InputStreamReader(
          _traleSocket.getInputStream(),
          ioEncodingName
          )
        );
      
      _traleOut = new PrintWriter(
        new OutputStreamWriter(
          _traleSocket.getOutputStream(),
          ioEncodingName
          )
        );
      
      Thread.sleep(2000);
    }
    catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }
  
  synchronized public String[] words() {
    writeLine("words.");
    return readLines();
  }
  
  synchronized public String[] rec(String q, int maxParses, int maxWords, String description) {
    // niko. so wars frueher.
      //String query = "rec(\"" + prepareQuery(q) + "\", " + maxParses + ", " + maxWords + ").";
      // description could be some constraint like: @root, word, phrase, bot, syntax:head:verb
      String query = "rec(\"" + prepareQuery(q) + "\", " + maxParses + ", " + maxWords + ", " + description + ").";
    System.out.println("Query: " + query);
    writeLine(query);
    try {
      _traleIn.mark(4);
      int ch = _traleIn.read();
      if (ch == '*') {
        String[] ex = readLines();
        StringBuilder sb = new StringBuilder();
        for (String s : ex)
          sb.append(s).append("\n");
        throw new TraleException(sb.toString());
      }
      _traleIn.reset();
    }
    catch (IOException ex) {
      throw new RuntimeException(ex);
    }
    return readLines();
  }
  
  
  // niko
  synchronized public String[] communicateWithTrale(String q) {
      System.out.println("Query: " + q);
    writeLine(q);
    try {
      _traleIn.mark(4);
      int ch = _traleIn.read();
      if (ch == '*') {
        String[] ex = readLines();
        StringBuilder sb = new StringBuilder();
        for (String s : ex)
          sb.append(s).append("\n");
        System.out.println("-> " + sb.toString());
        throw new TraleException(sb.toString());
        
        
      }
      else {
          System.out.println(ch);
          //System.out.println("something else.");
      }
        
      _traleIn.reset();
    }
    catch (IOException ex) {
      throw new RuntimeException(ex);
    }
    return readLines();
  }
  
  
  
  public String[] rec(String q) {
    return rec(q, Integer.MAX_VALUE, Integer.MAX_VALUE, "bot"); // niko.
  }
  
  public synchronized String[] lex(String q) {
    writeLine("lex(\"" + prepareQuery(q) + "\").");
    return readLines();
  }
  
  public synchronized boolean close() {
    try {
      writeLine("quit.");
      _traleSocket.close();
    }
    catch (Exception e) {
      return false;
    }
    return true;
  }
  
  private void writeLine(String line) {
    _traleOut.println(line);
    _traleOut.flush();
  }
  
  private String[] readLines() {
    List<String> ls = new LinkedList<String>();
    while (true) {
      String line = null;
      line = readLine();
      if (line == null || line.equals("."))
        break;
      ls.add(line);
    }
    return ls.toArray(new String[ls.size()]);
  }
  
  
  
  private String[] readLinesNiko() {
    List<String> ls = new LinkedList<String>();
    while (true) {
      String line = null;
        try {
            line = readLineNiko();
        } catch (UnsupportedEncodingException ex) {
            Logger.getLogger(Trale.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IOException ex) {
            Logger.getLogger(Trale.class.getName()).log(Level.SEVERE, null, ex);
        }
      if (line == null || line.equals("."))
        break;
      ls.add(line);
    }
    return ls.toArray(new String[ls.size()]);
  }
  
  
  private String readLineNiko() throws UnsupportedEncodingException, IOException {
    ByteArrayOutputStream baos = new ByteArrayOutputStream();
    int b;
    while ((b = _traleIn.read()) != -1) {
      if (b == (int) '\r') continue;
      if (b == (int) '\n') break;
      baos.write(b);
    }
    if (b == -1)
      throw new EOFException();
    return baos.toString(ioEncodingName);
//    try {
//      String s = _traleIn.readLine();
//      //System.err.println("read line: >" + s + "<");
//      return s;
//    }
//    catch (Exception ex) {
//      throw new RuntimeException(ex);
//    }
  }
  
  
  private String readLine() {
    //ByteArrayOutputStream baos = new ByteArrayOutputStream();
    //int b;
    //while ((b = _traleIn.read()) != -1) {
    //  if (b == (int) '\r') continue;
    //  if (b == (int) '\n') break;
    //  baos.write(b);
    //}
    //if (b == -1)
    //  throw new EOFException();
    //return baos.toString(ioEncodingName);
    try {
      String s = _traleIn.readLine();
      //System.err.println("read line: >" + s + "<");
      return s;
    }
    catch (Exception ex) {
      throw new RuntimeException(ex);
    }
  }
  
  static String prepareQuery(String s) {
    if (s.indexOf('"') == -1)
      return s;
    
    StringBuilder sb = new StringBuilder();
    for (int i = 0; i < s.length(); ++i) {
      char c = s.charAt(i);
      if (c == '"')
        sb.append('\\');
      sb.append(c);
    }
    return sb.toString();
  }
  
  public static void mainWebTrale(String[] args) throws Exception {
    int port = 7890;
    String host = "localhost";
    if (args.length > 0)
      port = Integer.parseInt(args[0]);
    if (args.length > 1)
      host = args[1];
    Trale t = new Trale(host, port);
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    String q;
    while ((q = in.readLine()) != null) {
      String[] ss = null;
      try {
        long t1 = System.currentTimeMillis();
        ss = t.rec(q);
        long t2 = System.currentTimeMillis();
        System.err.println("-- " + (t2 - t1) + " ms for '" + q + "'");
        
        for (String s : ss)
          System.out.println(s);
      }
      catch (Exception e) {
        e.printStackTrace(System.err);
      }
    }
    t.close();
  }
  
  
  public static void main(String[] args) throws Exception {
      
    int port = 3333; // trale port
    if(args.length == 1) {
        port = Integer.parseInt(args[0]);
    }
    
    String host = "localhost";
    if (args.length > 0)
      port = Integer.parseInt(args[0]);
    if (args.length > 1)
      host = args[1];
    Trale t = new Trale(host, port);
    System.out.println("Your query:");
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    String q;
    while ((q = in.readLine()) != null) {
      String[] ss = null;
      try {
        long t1 = System.currentTimeMillis();
        ss = t.communicateWithTrale(q);
        long t2 = System.currentTimeMillis();
        System.err.println("-- " + (t2 - t1) + " ms for '" + q + "'");
        
        for (String s : ss)
          System.out.println("--> " + s);
      }
      catch (Exception e) {
        e.printStackTrace(System.err);
      }
    }
    t.close();
  }
  
  
  
}
