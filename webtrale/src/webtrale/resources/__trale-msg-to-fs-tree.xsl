<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
<xsl:output method="xml" indent="no" encoding="utf-8" omit-xml-declaration="yes"/>

<xsl:template match="/">
  <!-- <xsl:processing-instruction name="xml-stylesheet">href="__fs-tree-to-html.xsl"  type="text/xml"</xsl:processing-instruction> -->
  <view>
    <title><xsl:value-of select="datapackage/windowtitle"/></title>
    <xsl:apply-templates select="//structure/tree"/>
    <xsl:if test="not(//structure/tree)">
      <xsl:apply-templates select="//structure/struct/struc"/>
    </xsl:if>
    <reentrancies>
      <xsl:apply-templates select="//structure/reentr"/>
    </reentrancies>
  </view>
</xsl:template>

<xsl:template match="text()"></xsl:template>

<xsl:template match="featval[not(flags/flag/hidden)]">
  <f name="{feature}">
    <xsl:apply-templates select="struct"/>
  </f>
</xsl:template>

<xsl:template match="function">
  <fun>TODO</fun>
</xsl:template>

<xsl:template match="relation">
  <rel>TODO</rel>
</xsl:template>

<xsl:template match="list">
  <ls>
    <items>
        <xsl:apply-templates select="structs"/>
    </items>
    <tail><xsl:apply-templates select="tail"/></tail>
  </ls>
</xsl:template>

<xsl:template match="tail[struct]">
  <tail>
    <xsl:apply-templates select="struct"/>
  </tail>
</xsl:template>

<xsl:template match="set">
  <set>TODO</set>
</xsl:template>

<xsl:template match="any">
  <a><xsl:value-of select="value"/></a>
</xsl:template>

<xsl:template match="disjunction">
  <or>TODO</or>
</xsl:template>

<xsl:template match="conjunction">
  <and>TODO</and>
</xsl:template>

<xsl:template match="ref">
  <!-- <ref target="{target}"/> -->
  <xsl:variable name="tag-id" select="target"/>
  <t refid="{$tag-id}">
  <!-- <xsl:apply-templates select="//reentr[tag=$tag-id]/struct/*"/> -->
  </t>
</xsl:template>

<xsl:template match="struc">
  <fs type="{type/name}">
    <xsl:apply-templates select="featvals"/>
  </fs>
</xsl:template>

<xsl:template match="reentr">
  <reentr tag="{tag}">
    <xsl:apply-templates select="struct/*"/>
  </reentr>
</xsl:template>

<xsl:template match="tree">
  <tree label="{label}">
    <content>
      <xsl:variable name="linkid" select="linkid"/>
      <xsl:apply-templates select="//*[id=$linkid]"/>
    </content>
    <xsl:apply-templates select="trees"/>
  </tree>
</xsl:template>

</xsl:stylesheet>
