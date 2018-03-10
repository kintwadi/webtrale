<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8"/>

<xsl:template match="/">

<html>
  <head>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
      <link href="__wt.css" rel="stylesheet" type="text/css"/>
      <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css"/>
      <link href='https://fonts.googleapis.com/css?family=Balthazar' rel='stylesheet'/>
      <!-- jQuery library -->
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

        <!-- Latest compiled JavaScript -->
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script> 
      <base target="viewpan"/>
      <style>
        .list{
          background-color: #02111b;
          height: 100%;
          } 
          li a{
            color:white;
          font-family: 'Arsenal';font-size: 22px;
            
          } 
          div{
            height: 100%;
          }
          
          ::-webkit-scrollbar {width: 8px; height: 1px; background: #CD5C5C;}
          ::-webkit-scrollbar-thumb {background-color:#ffffff ; border: 8px solid black;border-radius: 45px;}
 
 
            body::-webkit-scrollbar-track {
                -webkit-box-shadow: inset 0 0 6px rgba(0,0,0,0.3);
            }
 

          
          
      </style>
      
    </head>
    <body class="list">
      <div  >
        <!--<div class="label">Lexicon</div>-->
        <ul >
          <xsl:for-each select="//word">
            <li><a href="lex?q={@uri-encoded-utf8}"><xsl:value-of select="."/></a></li>
           
          </xsl:for-each>
        </ul>
      </div>
    </body>
  </html>

</xsl:template>
</xsl:stylesheet>
