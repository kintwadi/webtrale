package webtrale;

import java.util.*;
import java.io.*;

public class TraleMsgParser {
  tomato.LRParser _parser;
  
  final static String[] _tokenTypes = {
    "_BEGIN_ANY",
    "_BEGIN_CONJ",
    "_BEGIN_DISJ",
    "_BEGIN_FEATVAL",
    "_BEGIN_FUNCT",
    "_BEGIN_LIST",
    "_BEGIN_REENTR",
    "_BEGIN_REF",
    "_BEGIN_REL",
    "_BEGIN_REST",
    "_BEGIN_SET",
    "_BEGIN_STRUC",
    "_BEGIN_TAIL",
    "_BEGIN_TREE",
    "_INT",
    "_LPAR",
    "_LT",
    "_MINUS",
    "_NEWDATA",
    "_PIPE",
    "_PLUS",
    "_RPAR",
    "_STAR",
    "_STRING",
    "{eof}"
  };
  
  final static String[] _begins = {
    "A", "_BEGIN_ANY",
    "C", "_BEGIN_CONJ",
    "O", "_BEGIN_DISJ",
    "V", "_BEGIN_FEATVAL",
    "F", "_BEGIN_FUNCT",
    "L", "_BEGIN_LIST",
    "R", "_BEGIN_REENTR",
    "#", "_BEGIN_REF",
    "D", "_BEGIN_REL",
    "Y", "_BEGIN_REST",
    "M", "_BEGIN_SET",
    "S", "_BEGIN_STRUC",
    "Z", "_BEGIN_TAIL",
    "T", "_BEGIN_TREE"
  };
  
  final static String[] _singleCharTokens = {
    // "(", "_LPAR", handled in a special way
    ")", "_RPAR",
    "*", "_STAR",
    "<", "_LT",
    "-", "_MINUS",
    "|", "_PIPE",
    "+", "_PLUS"
  };
  
  
  
  
  static String searchStringPairArray(String[] arr, char c) {
    for (int i = 0; i < arr.length; i += 2) {
      if (arr[i].charAt(0) == c)
        return arr[i + 1];
    }
    return null;
  }
  
  Map<String,tomato.Terminal> _tt2term = new TreeMap<String,tomato.Terminal>();
  
  public TraleMsgParser(String grammarFilename) throws Exception {
    this(new FileReader(grammarFilename));
  }
  
  public TraleMsgParser(Reader grammarReader) throws Exception {
    _parser = new tomato.LRParser(grammarReader);
    for (String tt : _tokenTypes) {
      tomato.Terminal term = _parser.grammar().lookupTerminal(tt);
      if (term == null)
        throw new RuntimeException("the LR parser does not know about this terminal: " +
          tt);
      _tt2term.put(tt, term);
    }
  }
  
  tomato.Terminal terminal(String key) {
    tomato.Terminal t = _tt2term.get(key);
    if (t == null)
      throw new RuntimeException("unknown terminal: " + key);
    return t;
  }
  
  static class ParserException extends Exception {
    ParserException() {}
    ParserException(String msg) { super(msg); }
  }
  
  static class TokenizerException extends ParserException {
    TokenizerException() {}
    TokenizerException(String msg) { super(msg); }
  }
  
  static class Token {
    Token() { }
    Token(String s, tomato.Terminal t) { content = s; terminal = t; }
    String content;
    tomato.Terminal terminal;
  }
  
  
  
  public String parse(String s) throws ParserException {
    Token[] tokens = null;
    try {
      tokens = tokenize(new StringReader(s));
    }
    catch (TokenizerException e) {
      throw new TokenizerException("for sentence [" + s + "]: " + e);
    }
    tomato.Terminal[] terminals = new tomato.Terminal[tokens.length];
    for (int i = 0; i < tokens.length; ++i) {
      terminals[i] = tokens[i].terminal;
      //if (true) {
      if (false) {
      Token t = tokens[i];
      System.out.print(t.terminal);
      if (t.content != null) System.out.print(" : \"" + t.content + "\"");
      System.out.println();
      }
    }
    //long start = System.currentTimeMillis();
    Iterator it = _parser.parse(terminals);
    //long end = System.currentTimeMillis();
    //System.err.println("-- parsing done in " + (end - start) + " ms.");
    if (!it.hasNext())
      throw new ParserException(
        "trale-msg grammar does not cover the input");
    tomato.Node tree = (tomato.Node) it.next();
    if (it.hasNext())
      throw new ParserException("the input is ambiguous");
    
    return toXmlString(tree, tokens);
  }
  
  String toXmlString(tomato.Node tree, Token[] tokens) {
    StringBuilder sb = new StringBuilder();
    toXmlString(null, tree, tokens, 0, sb);
    //System.out.println("XML: " + sb.toString());
    return sb.toString();
  }
  
  int toXmlString(tomato.Node parent, tomato.Node node, Token[] tokens, int pos, StringBuilder sb) {
    tomato.Node u = node.firstChild();
    String elementName = node.getObject().toString();
    if (u == null) {
      if (node.getObject() instanceof tomato.Terminal) {
        String s = node.getObject().toString();
        if (s.equals("_INT")) {
          sb.append(tokens[pos].content);
        }
        else if (s.equals("_STRING")) {
          sb.append(escapeXml(tokens[pos].content));
        }
        pos++;
      }
      else {
        sb.append("<").append(elementName).append("/>");
      }
    }
    else {
      sb.append("<").append(elementName).append(">");
      do {
        pos = toXmlString(node, u, tokens, pos, sb);
        u = u.nextSibling();
      }
      while (u != null);
      sb.append("</").append(elementName).append(">");
    }
    
    return pos;
  }
  
  public static String escapeXml(String s) {
    StringBuilder sb = new StringBuilder();
    for (Character c : s.toCharArray()) {
      if (c == '&')
        sb.append("&amp;");
      else if (c == '<')
        sb.append("&lt;");
      else if (c == '>')
        sb.append("&gt;");
      else
        sb.append(c);
    }
    return sb.toString();
  }
  

  Token[] tokenize(StringReader in0) throws TokenizerException {
    PushbackReader in = new PushbackReader(in0);
    ArrayList<Token> tokens = new ArrayList<Token>();
    int pos = 0;
    try {
      while (true) {
        int b = in.read();
        if (b == -1)
          break;
        char c = (char) b;
        pos++;
        
        if (Character.isWhitespace(c))
          continue; // skip whitespace
        
        Token t = new Token();
        
        switch (c) {
          case '"': // string
            {
              StringBuilder s = new StringBuilder();
              while ((b = in.read()) != -1) {
                pos++;
                c = (char) b;
                if (c == '"')
                  break;
                s.append(c);
              }
              if (b == -1)
                throw new TokenizerException("unterminated string");
              t.content  = s.toString();
              t.terminal = terminal("_STRING");
            }
            break;
          
          case '!': //newdata
            {
              String s = "newdata";
              for (int i = 0; i < s.length(); ++i) {
                if (s.charAt(i) != (char) in.read())
                  throw new TokenizerException("expected 'newdata' after '!'");
                pos++;
              }
            }
            t.terminal = terminal("_NEWDATA");
            break;
          
          case '(': // a begin or just an _LPAR?
            {
              b = in.read();
              String tt = "_LPAR";
              if (b != -1) {
                String tt2 = searchStringPairArray(_begins, (char) b);
                if (tt2 != null) {
                  pos++;
                  tt = tt2;
                }
                else
                  in.unread(b);
              }
              t.terminal = terminal(tt);
            }
            break;
          
          default:
            if (Character.isDigit(c)) { // integer
              StringBuilder s = new StringBuilder().append(c);
              while ((b = in.read()) != -1) {
                c = (char) b;
                if (!Character.isDigit(c)) {
                  in.unread(b);
                  break;
                }
                pos++;
                s.append(c);
              }
              t.content  = s.toString();
              t.terminal = terminal("_INT");
            }
            else {
              // single char token?
              String tt = searchStringPairArray(_singleCharTokens, c);
              if (tt == null) {
                throw new TokenizerException("@" + pos
                  + ": invalid token: '" + c + "'");
              }
              t.terminal = terminal(tt);
            }
        }
        tokens.add(t);
      }
    }
    catch (IOException e) {
      // StringReader never throws
    }
    tokens.add(new Token(null, _parser.grammar().eofSymbol()));
    return tokens.toArray(new Token[0]);
  }
  
//  public static void main(String[] args) throws Exception {
//      
//      
//    
//    TraleMsgParser p = new TraleMsgParser(args[0]);
//    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
//    String s;
//    while ((s = in.readLine()) != null) {
//      System.out.println(
//        p.parse(s)
//        );
//    }
//  }
  
  
  public static void main(String[] args) throws Exception {
        
      // Läuft so:
      // tomato parser liest eine grammatik ein, z.b. "_trale-msg.g"
      // hier wird trale input von der art "!newdata ..." geparst
      // und es wird ein xml format davon zurückgeliefert.
      
      // Input:
      //!newdata "(lex):kim" (S0(1"word")(V2"phon"(L3(A4"kim")))(V5"synsem"(S6(7"synsem")(V8"loc"(S9(10"loc")(V11"cat"(S12(13"cat")(V14"head"(S15(16"noun")(V+17"case"(S+18(+19"mgsat case")))(V+20"mod"(S+21(+22"none")))(V23"pred"(S24(25"minus")))))(V26"marking"(S27(28"unmarked")))(V29"subcat"(#30 0))))(V31"cont"(S32(33"npro")(V34"index"(#35 1))(V36"restr"(L37))))(V38"context"(S39(40"conx")(V41"background"(L42(S43(44"naming_rel")(V45"bearer"(#46 1))(V47"name"(S48(49"kim"))))))))))(V+50"nonloc"(S+51(+52"mgsat nonloc")))))(V53"arg_st"(#54 0))(V55"qstore"(L56))(V57"retr"(L58)))(R59 0(L60))(R61 1(S62(63"ref")(V+64"gen"(S+65(+66"mgsat (gen)")))(V67"num"(S68(69"sg")))(V70"pers"(S71(72"third")))))
      // Output:
      //<datapackage><windowtitle>(lex):kim</windowtitle><structures><structure><struct><struc><flags/><id>0</id><type><flags/><id>1</id><name>word</name></type><featvals><featval><flags/><id>2</id><feature>phon</feature><struct><list><flags/><id>3</id><structs><struct><any><flags/><id>4</id><value>kim</value></any></struct><structs/></structs><tail/></list></struct></featval><featvals><featval><flags/><id>5</id><feature>synsem</feature><struct><struc><flags/><id>6</id><type><flags/><id>7</id><name>synsem</name></type><featvals><featval><flags/><id>8</id><feature>loc</feature><struct><struc><flags/><id>9</id><type><flags/><id>10</id><name>loc</name></type><featvals><featval><flags/><id>11</id><feature>cat</feature><struct><struc><flags/><id>12</id><type><flags/><id>13</id><name>cat</name></type><featvals><featval><flags/><id>14</id><feature>head</feature><struct><struc><flags/><id>15</id><type><flags/><id>16</id><name>noun</name></type><featvals><featval><flags><flag><hidden></hidden></flag><flags/></flags><id>17</id><feature>case</feature><struct><struc><flags><flag><hidden></hidden></flag><flags/></flags><id>18</id><type><flags><flag><hidden></hidden></flag><flags/></flags><id>19</id><name>mgsat case</name></type><featvals/></struc></struct></featval><featvals><featval><flags><flag><hidden></hidden></flag><flags/></flags><id>20</id><feature>mod</feature><struct><struc><flags><flag><hidden></hidden></flag><flags/></flags><id>21</id><type><flags><flag><hidden></hidden></flag><flags/></flags><id>22</id><name>none</name></type><featvals/></struc></struct></featval><featvals><featval><flags/><id>23</id><feature>pred</feature><struct><struc><flags/><id>24</id><type><flags/><id>25</id><name>minus</name></type><featvals/></struc></struct></featval><featvals/></featvals></featvals></featvals></struc></struct></featval><featvals><featval><flags/><id>26</id><feature>marking</feature><struct><struc><flags/><id>27</id><type><flags/><id>28</id><name>unmarked</name></type><featvals/></struc></struct></featval><featvals><featval><flags/><id>29</id><feature>subcat</feature><struct><ref><flags/><id>30</id><target>0</target></ref></struct></featval><featvals/></featvals></featvals></featvals></struc></struct></featval><featvals><featval><flags/><id>31</id><feature>cont</feature><struct><struc><flags/><id>32</id><type><flags/><id>33</id><name>npro</name></type><featvals><featval><flags/><id>34</id><feature>index</feature><struct><ref><flags/><id>35</id><target>1</target></ref></struct></featval><featvals><featval><flags/><id>36</id><feature>restr</feature><struct><list><flags/><id>37</id><structs/><tail/></list></struct></featval><featvals/></featvals></featvals></struc></struct></featval><featvals><featval><flags/><id>38</id><feature>context</feature><struct><struc><flags/><id>39</id><type><flags/><id>40</id><name>conx</name></type><featvals><featval><flags/><id>41</id><feature>background</feature><struct><list><flags/><id>42</id><structs><struct><struc><flags/><id>43</id><type><flags/><id>44</id><name>naming_rel</name></type><featvals><featval><flags/><id>45</id><feature>bearer</feature><struct><ref><flags/><id>46</id><target>1</target></ref></struct></featval><featvals><featval><flags/><id>47</id><feature>name</feature><struct><struc><flags/><id>48</id><type><flags/><id>49</id><name>kim</name></type><featvals/></struc></struct></featval><featvals/></featvals></featvals></struc></struct><structs/></structs><tail/></list></struct></featval><featvals/></featvals></struc></struct></featval><featvals/></featvals></featvals></featvals></struc></struct></featval><featvals><featval><flags><flag><hidden></hidden></flag><flags/></flags><id>50</id><feature>nonloc</feature><struct><struc><flags><flag><hidden></hidden></flag><flags/></flags><id>51</id><type><flags><flag><hidden></hidden></flag><flags/></flags><id>52</id><name>mgsat nonloc</name></type><featvals/></struc></struct></featval><featvals/></featvals></featvals></struc></struct></featval><featvals><featval><flags/><id>53</id><feature>arg_st</feature><struct><ref><flags/><id>54</id><target>0</target></ref></struct></featval><featvals><featval><flags/><id>55</id><feature>qstore</feature><struct><list><flags/><id>56</id><structs/><tail/></list></struct></featval><featvals><featval><flags/><id>57</id><feature>retr</feature><struct><list><flags/><id>58</id><structs/><tail/></list></struct></featval><featvals/></featvals></featvals></featvals></featvals></featvals></struc></struct></structure><structures><structure><reentr><flags/><id>59</id><tag>0</tag><struct><list><flags/><id>60</id><structs/><tail/></list></struct></reentr></structure><structures><structure><reentr><flags/><id>61</id><tag>1</tag><struct><struc><flags/><id>62</id><type><flags/><id>63</id><name>ref</name></type><featvals><featval><flags><flag><hidden></hidden></flag><flags/></flags><id>64</id><feature>gen</feature><struct><struc><flags><flag><hidden></hidden></flag><flags/></flags><id>65</id><type><flags><flag><hidden></hidden></flag><flags/></flags><id>66</id><name>mgsat (gen)</name></type><featvals/></struc></struct></featval><featvals><featval><flags/><id>67</id><feature>num</feature><struct><struc><flags/><id>68</id><type><flags/><id>69</id><name>sg</name></type><featvals/></struc></struct></featval><featvals><featval><flags/><id>70</id><feature>pers</feature><struct><struc><flags/><id>71</id><type><flags/><id>72</id><name>third</name></type><featvals/></struc></struct></featval><featvals/></featvals></featvals></featvals></struc></struct></reentr></structure></structures></structures></structures></datapackage>

      
      
    TraleMsgParser p = new TraleMsgParser("src/webtrale/resources/_trale-msg.g");
    BufferedReader in = new BufferedReader(new InputStreamReader(System.in));
    String s;
    while ((s = in.readLine()) != null) {
      System.out.println(
        p.parse(s)
        );
    }
  }
  
}
