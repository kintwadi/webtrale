<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:output method="html" encoding="utf-8"/>

    
    <xsl:template match="/root/parsechart/table">
        <xsl:copy-of select="node() | @*"/>
    </xsl:template>


    <xsl:template match="/root">

       
        <xsl:if test="results/@count &gt; 0">
            <html>
                <head>
                    <title>
                        <xsl:value-of select="results/result[1]/view/title"/>
                    </title>
                    <link href="__fs.css" rel="stylesheet" type="text/css"/>
                    <script type="text/javascript" src="__fs.js"/>
                    <script type="text/javascript" src="__wz_jsgraphics.js"/>
                </head>
                <body onload="init_view()" ondblclick="body_ondblclick()">
        
        
                    <xsl:if test="results/@parseChart = 1">
                        <script type="text/javascript">   
                            //alert("Unfortunately, there is no complete parse found for this input. Here are all the * partial * results.");
                        </script>
                        
                        <div id="parsechartdiv">
                            <table id="parseChartTable">
                                 
                                <xsl:apply-templates select="/root/parsechart/table"/>
                            </table>
                        
                        </div>
                        
                        
                        
                        <div id="hideparsechartbuttondiv">
                        <span class="tbutton" onclick="showhide_parsechart()">
                            hide parse chart
                        </span>
                        </div>
                        
                        
                        
                    </xsl:if>
    
    
                    <div id="viewSelectorHolder" >
                        <div id="viewSelector">
                            <span id="tbuttons">
                                <xsl:call-template name="insert-tb-button">
                                    <xsl:with-param name="i" select="1"/>
                                    <xsl:with-param name="n" select="results/@count"/>
                                </xsl:call-template>
                            </span>
                            <span>
                                <span id="tbVisibilityControlButton" class="tbutton" 
                                      onclick="tb_show_hide(event)" style="color:black;">&#x00D7;
                                </span>
                            </span>
                            
                        
                        </div>
                    </div>
      
                    <div id="structureViewHolder"></div>
      
                    <div id="canvas"/>
      
                    <div id="structures" style="display:none">
                        <xsl:for-each select="results/result">
                            <div id="struct-{@id}">
                                <xsl:apply-templates select="view/tree"/>
                                <!-- xor -->
                                <xsl:apply-templates select="view/fs"/>
                            </div>
                        </xsl:for-each>
                    </div>
      
                    <div id="reentrancies" style="display:none">
                        <xsl:for-each select="results/result">
                            <xsl:variable name="struct-id" select="@id"/>
          
                            <xsl:for-each select="view/reentrancies/reentr">
                                <xsl:call-template name="insert-reentr">
                                    <xsl:with-param name="reentr" select="."/>
                                    <xsl:with-param name="struct-id" select="$struct-id"/>
                                </xsl:call-template>
                            </xsl:for-each>
                        </xsl:for-each>
                    </div>
      
      
      
        
      
                </body>
    
    
            </html>    
    
    
        
        
    
        </xsl:if> <!-- successful parse -->
    
        <xsl:if test="results/@count = 0">
            <html>
                <head>
                    <title>Not recognized</title>
                </head>
                <body>
                    <h2>The given sentence is not recognized.</h2>
                    <xsl:if test="results/exception">
                        <hr/>Exception: <i>
                            <xsl:value-of select="results/exception"/>
                        </i>
                    </xsl:if>
                </body>
            </html>
        </xsl:if>
        
        
        
  
  
        
        
        
    </xsl:template>



    <!-- niko -->



    <xsl:template name="insert-reentr">
        <xsl:param name="reentr"/>
        <xsl:param name="struct-id"/>
  
        <div id="reentr-{$struct-id}-{$reentr/@tag}">
            <xsl:apply-templates select="$reentr/*"/>
        </div>
    </xsl:template>

    <xsl:template name="insert-tb-button">
        <xsl:param name="i"/>
        <xsl:param name="n"/>
  
        <span class="tbutton" onclick="tb_select(this)">
            <xsl:value-of select="$i"/>
        </span>
        <xsl:if test="$i &lt; $n">
            <xsl:call-template name="insert-tb-button">
                <xsl:with-param name="i" select="$i + 1"/>
                <xsl:with-param name="n" select="$n"/>
            </xsl:call-template>
        </xsl:if>
    </xsl:template>

    <!--
    <xsl:template match="reentr">
      <div id="reentr-{@tag}">
        <xsl:apply-templates select="*"/>
      </div>
    </xsl:template>
    -->

    <xsl:template match="tree">
        <div class="tree-node">
            <table class="tree-node-table">
                <tr>
                    <td onclick="expand_collapse_node(this)" nowrap="nowrap">
          
                        <xsl:attribute name="class">
                            <xsl:choose>
                                <xsl:when test="tree">nonterminal-node-label</xsl:when>
                                <xsl:otherwise>terminal-node-label</xsl:otherwise>
                            </xsl:choose>
                        </xsl:attribute>
          
                        <xsl:value-of select="@label"/>
                    </td>
                </tr>
                <tr>
                    <td class="tree-node-content" align="center">
                        <xsl:apply-templates select="content/*"/>
                    </td>
                </tr>
            </table>
            <xsl:apply-templates select="tree"/>
        </div>
    </xsl:template>

    <xsl:template match="fs[f]">
        <table class="fs-otab">
            <tr>
                <td class="fs-otab-lbracket">&#x00A0;</td>
                <td class="fs-otab-m">
                    <table class="fs-itab">
                        <tr>
                            <td class="fs-type" onclick="expand_collapse_fs(this)">
                                <xsl:value-of select="@type"/>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <table>
                                    <xsl:for-each select="f">
                                        <tr>
                                            <td class="f-name" onclick="expand_collapse_feat(this)">
                                                <xsl:value-of select="@name"/>
                                            </td>
                                            <td class="f-value">
                                                <xsl:apply-templates select="*"/>
                                            </td>
                                        </tr>
                                    </xsl:for-each>
                                </table>
                            </td>
                        </tr>
                    </table>
                </td>
                <td class="fs-otab-rbracket">&#x00A0;</td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="fs[not(f)]">
        <!-- species: a typed fs without features -->
        <span class="species">
            <xsl:value-of select="@type"/>
        </span>
    </xsl:template>

    <xsl:template match="a">
        <span class="atom">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <xsl:template match="lrs">
        <span class="lrs">
            <xsl:value-of select="."/>
        </span>
    </xsl:template>

    <xsl:template match="ls">
        <table>
            <tr>
                <!-- <td class="ls-bra">&#x27E8;</td> -->
                <!-- <td class="ls-bra">&#x2039;</td> -->
                <td class="ls-bra">&lt;</td>
                <xsl:for-each select="items/*[1]">
                    <td>
                        <xsl:apply-templates select="."/>
                    </td>
                </xsl:for-each>
                <xsl:for-each select="items/*[position() &gt; 1]">
                    <td>,</td>
                    <td>
                        <xsl:apply-templates select="."/>
                    </td>
                </xsl:for-each>
                <xsl:if test="tail/*">
                    <td>|</td>
                    <td>
                        <xsl:apply-templates select="tail/*"/>
                    </td>
                </xsl:if>
                <!-- <td class="ls-ket">&#x27E9;</td> -->
                <!-- <td class="ls-ket">&#x203A;</td> -->
                <td class="ls-ket">&gt;</td>
            </tr>
        </table>
    </xsl:template>

    <xsl:template match="t">
  
        <table>
            <tr>
                <td>
                    <div class="tag" onclick="expand_collapse_tag(this)">  
                        <xsl:value-of select="@refid"/>
                    </div>
      
                    <!--
                    <table class="tag-table">
                      <tr>
                        <td class="tag-filler">&#x00A0;</td>
                        <td class="tag-filler">&#x00A0;</td>
                        <td class="tag-filler">&#x00A0;</td>
                      </tr>
                      <tr>
                        <td class="tag-filler">&#x00A0;</td>
                        <td>
                          <xsl:attribute name="class">tag</xsl:attribute>
                          <xsl:attribute name="onclick">expand_collapse_tag(this);</xsl:attribute>
                          <xsl:value-of select="@refid"/>
                        </td>
                        <td class="tag-filler">&#x00A0;</td>
                      </tr>
                      <tr>
                        <td class="tag-filler">&#x00A0;</td>
                        <td class="tag-filler">&#x00A0;</td>
                        <td class="tag-filler">&#x00A0;</td>
                      </tr>
                    </table>
                    -->
                </td>
    
                <!-- a placeholder for the reentrancy -->
                <!-- <td>&#x00A0;</td> -->
                <td></td>
  
            </tr>
        </table>
  
  
  
  
  
  
    </xsl:template>
    
    
    
    

</xsl:stylesheet>
