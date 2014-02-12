SRCS = saxon.ext.001.xml

DESTDIR = .

all: html

html: openlogo.png $(SRCS:.xml=.noext.html) $(SRCS:.xml=.html)

%.png : %.png.uu
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	uudecode -o /dev/stdout < $< > ${DESTDIR}/$@

%.html : %.xml
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	java -cp "/usr/share/java/saxon.jar:/usr/share/java/xml-commons-resolver-1.1.jar:/usr/share/java/docbook-xsl-saxon.jar:/usr/share/java/xercesImpl.jar:/etc/xml/resolver" \
	  -Djavax.xml.parsers.DocumentBuilderFactory=org.apache.xerces.jaxp.DocumentBuilderFactoryImpl \
	  -Djavax.xml.parsers.SAXParserFactory=org.apache.xerces.jaxp.SAXParserFactoryImpl \
	  -Dorg.apache.xerces.xni.parser.XMLParserConfiguration=org.apache.xerces.parsers.XIncludeParserConfiguration \
	  com.icl.saxon.StyleSheet \
	  -x org.apache.xml.resolver.tools.ResolvingXMLReader \
	  -y org.apache.xml.resolver.tools.ResolvingXMLReader \
	  -r org.apache.xml.resolver.tools.CatalogResolver \
	  -u -o ${DESTDIR}/$@ $< db2html.xsl \
	  use.extensions=1

%.noext.html : %.xml
	[ -d ${DESTDIR} ] || mkdir -p ${DESTDIR}
	xsltproc --xinclude --nonet -o ${DESTDIR}/$@ \
	         --param use.extensions 0 \
	         db2html.xsl $<

validate: check

check:
	xmllint --xinclude --nonet --noout --postvalid $(SRCS)

clean:
	rm -f ${DESTDIR}/*.html ${DESTDIR}/*.png

.PHONY: all check clean html validate
