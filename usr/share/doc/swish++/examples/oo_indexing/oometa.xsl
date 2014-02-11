<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:office="http://openoffice.org/2000/office"
 xmlns:meta="http://openoffice.org/2000/meta"
 xmlns:dc="http://purl.org/dc/elements/1.1/">
<!-- 
 Copyright (C) 2004 Bastian Kleineidam <calvin@debian.org>
 The contents of this file are released in the Public Domain
-->
<xsl:output
 method="text"
 encoding="latin1"
/>

<xsl:template match="office:meta">
<xsl:apply-templates select="dc:title"/>
<xsl:apply-templates select="dc:subject"/>
<xsl:apply-templates select="dc:description"/>
<xsl:apply-templates select="dc:language"/>
<xsl:apply-templates select="meta:keywords"/>
<xsl:apply-templates select="meta:user-defined"/>
</xsl:template>

<xsl:template match="dc:title">
<xsl:value-of select="."/>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template match="dc:subject">
<xsl:value-of select="."/>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template match="dc:description">
<xsl:value-of select="."/>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template match="dc:language">
<xsl:text>Lang: </xsl:text>
<xsl:value-of select="."/>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template match="meta:keywords">
<xsl:for-each select="meta:keyword">
  <xsl:value-of select="."/>
  <xsl:text> </xsl:text>
</xsl:for-each>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template match="meta:user-defined">
<xsl:if test="text()">
  <xsl:value-of select="@meta:name"/>
  <xsl:text>: </xsl:text>
  <xsl:value-of select="."/>
  <xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:if>
</xsl:template>

</xsl:stylesheet>
