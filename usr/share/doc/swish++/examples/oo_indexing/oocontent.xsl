<xsl:stylesheet version="1.0"
 xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
 xmlns:text="http://openoffice.org/2000/text">
<!--
 Copyright (C) 2004 Bastian Kleineidam <calvin@debian.org>
 The contents of this file are released in the Public Domain
-->
<xsl:output 
 method="text"
 encoding="latin1"
/>

<xsl:template match="text:tab-stop">
<xsl:text>&#x09;</xsl:text> <!-- emit a Unicode tab -->
</xsl:template>

<xsl:template match="text:line-break">
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:variable name="spaces" xml:space="preserve">                              </xsl:variable>

<xsl:template match="text:s">
<xsl:choose>
    <xsl:when test="@text:c">
        <xsl:call-template name="insert-spaces">
            <xsl:with-param name="n" select="@text:c"/>
        </xsl:call-template>
    </xsl:when>
    <xsl:otherwise>
        <xsl:text> </xsl:text>
    </xsl:otherwise>
</xsl:choose>
</xsl:template>

<xsl:template match="text:p">
<xsl:value-of select="."/>
<xsl:text>&#x0a;</xsl:text> <!-- emit a Unicode line feed -->
</xsl:template>

<xsl:template name="insert-spaces">
<xsl:param name="n"/>
<xsl:choose>
    <xsl:when test="$n &lt;= 30">
        <xsl:value-of select="substring($spaces, 1, $n)"/>
    </xsl:when>
    
    <xsl:otherwise>
        <xsl:value-of select="$spaces"/>
        <xsl:call-template name="insert-spaces">
            <xsl:with-param name="n">
                <xsl:value-of select="$n - 30"/>
            </xsl:with-param>
        </xsl:call-template>
    </xsl:otherwise>
</xsl:choose>
</xsl:template>
</xsl:stylesheet>
