<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="html" encoding="utf-8"/>

<xsl:template match="/">

<html>
  <head>
      <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
      <link href="__wt.css" rel="stylesheet" type="text/css"/>
      <base target="viewpan"/>
    </head>
    <body>
      <div id="lexicon-block">
        <div class="label">Lexicon</div>
        <ul class="circle">
          <xsl:for-each select="//word">
            <li><a href="lex?q={@uri-encoded-utf8}"><xsl:value-of select="."/></a></li>
          </xsl:for-each>
        </ul>
      </div>
    </body>
  </html>

</xsl:template>
</xsl:stylesheet>
