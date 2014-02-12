<?xml version='1.0'?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                version="1.0">

<xsl:import href="http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl"/>

<xsl:output method="html"
            indent="yes"
            encoding="utf-8"
            doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN"
            doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:param name="callouts.extension" select="'1'"/>
<xsl:param name="callout.graphics.path" select="'http://docbook.sourceforge.net/release/xsl/current/images/callouts/'"/>
<xsl:param name="graphicsize.extension" select="'1'"/>
<xsl:param name="linenumbering.extension" select="'1'"/>
<!-- <xsl:param name="linenumbering.everyNth" select="'1'"/> -->
<xsl:param name="tablecolumns.extension" select="'1'"/>
<xsl:param name="textinsert.extension" select="'1'"/>

</xsl:stylesheet>

